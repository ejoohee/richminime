package com.richminime.domain.user.service;

import com.richminime.domain.spending.service.SpendingService;
import com.richminime.domain.user.domain.LogoutAccessToken;
import com.richminime.domain.user.domain.RefreshToken;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.dto.request.*;
import com.richminime.domain.user.dto.response.*;
import com.richminime.domain.user.exception.UserExceptionMessage;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.LogoutAccessTokenRedisRepository;
import com.richminime.domain.user.repository.RefreshTokenRedisRepository;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.CodefWebClient;
import com.richminime.global.common.codef.dto.request.FindSpendingListReqDto;
import com.richminime.global.common.jwt.JwtExpirationEnums;
import com.richminime.global.exception.NotFoundException;
import com.richminime.global.exception.TokenException;
import com.richminime.global.util.jwt.JWTUtil;
import com.richminime.global.util.rsa.RSAUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService {

    private final SpendingService spendingService;
    private final PasswordEncoder passwordEncoder;
    private final JWTUtil jwtUtil;
    private final CodefWebClient codefWebClient;
    private final UserRepository userRepository;
    private final RefreshTokenRedisRepository refreshTokenRepository;
    private final LogoutAccessTokenRedisRepository logoutAccessTokenRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final JavaMailSender javaMailSender;

    @Value("${rsa.public-key}")
    private String publicKey;


    private Map<UUID, String> connectedIdMap = new HashMap<>();

    @Scheduled(cron = "0 0 1 * * *") // 매달 1일 자정에 실행
    public void updateUsersMonthSpending() {
        // codef로 전 달 소비내역 모두 불러오기
        // date로 캘린더 생성
        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        // 해당 년 월의 마지막 날을 가져오기
        YearMonth yearMonth = YearMonth.of(year, month);
        int lastDay = yearMonth.lengthOfMonth();
        StringBuilder startDate = new StringBuilder();
        StringBuilder endDate = new StringBuilder();
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            startDate.append(year).append(0).append(month).append("01");
            endDate.append(year).append(0).append(month).append(lastDay);
        }else {
            startDate.append(year).append(month).append("01");
            endDate.append(year).append(month).append(lastDay);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        List<User> userList = userRepository.findAll();
        for (User user : userList) {
            try {
                spendingService.updateMonthSpending(user, month, sdf.parse(startDate.toString()), sdf.parse(endDate.toString()));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }

    }

    /**
     * 매일 자정마다 실행됨
     * 회원 목록을 순회하면서 각 회원의 전날 소비내역을 불러옴
     */
    @Scheduled(cron = "0 0 0 * * *")
    public void addUsersDaySpending(){
        // 오늘 날짜 확인
        // date로 캘린더 생성
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -1);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        StringBuilder startDate = new StringBuilder();
        StringBuilder endDate = new StringBuilder();
        startDate.append(year);
        endDate.append(year);
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            startDate.append(0).append(month);
            endDate.append(0).append(month);
        }else {
            startDate.append(month);
            endDate.append(month);
        }
        // 일이 10 미만이라면 앞에 0을 붙여줘야 함
        if(day < 10) {
            startDate.append(0).append(day);
            endDate.append(0).append(day);
        }else {
            startDate.append(day);
            endDate.append(day);
        }

        List<User> userList = userRepository.findAll();
        for (User user : userList) {
            spendingService.addSpending(user, startDate.toString(), endDate.toString());
        }
    }

    /**
     * 회원이 회원가입 할 때에는 저장된 소비내역 데이터가 존재하지 않으므로
     * 회원가입 날짜 기준 전달의 소비내역을 모두 불러와 DB에 저장
     */
    public void addUserMonthSpending(User user){
        // codef로 전 달 소비내역 모두 불러오기
        // date로 캘린더 생성
        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        // 해당 년 월의 마지막 날을 가져오기
        YearMonth yearMonth = YearMonth.of(year, month);
        int lastDay = yearMonth.lengthOfMonth();
        StringBuilder startDate = new StringBuilder();
        StringBuilder endDate = new StringBuilder();
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            startDate.append(year).append(0).append(month).append("01");
            endDate.append(year).append(0).append(month).append(lastDay);
        }else {
            startDate.append(year).append(month).append("01");
            endDate.append(year).append(month).append(lastDay);
        }
        log.info("startDate-------------------------->{}", startDate.toString());
        log.info("endDate-------------------------->{}", endDate.toString());
        spendingService.addSpending(user, startDate.toString(), endDate.toString());
    }

    @Transactional(readOnly = true)
    @Override
    public CheckEmailResDto checkEmail(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return CheckEmailResDto.builder()
                // 존재하면 false, 존재하지 않으면 true 반환
                .success(!user.isPresent())
                .build();
    }

    @Override
    public GenerateConnectedIdResDto generateConnectedId(GenerateConnectedIdReqDto generateConnectedIdRequest) {
        String organizationCode = generateConnectedIdRequest.getOrganization();
        String id = generateConnectedIdRequest.getId();
        String password = generateConnectedIdRequest.getPassword();
        //외부 API 호출
        try {
            String connectedId = codefWebClient.createConnectedId(organizationCode, id, password);
            // uuid 생성
            UUID uuid = UUID.randomUUID();
            // uuid를 키로 생성된 커넥티드 아이디 저장
            connectedIdMap.put(uuid, connectedId);
            return GenerateConnectedIdResDto.builder()
                    .uuid(uuid)
                    .build();
        } catch (NoSuchPaddingException e) {
            throw new RuntimeException(e);
        } catch (IllegalBlockSizeException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        } catch (BadPaddingException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeyException e) {
            throw new RuntimeException(e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void logout(String email, String accessToken) {
        // 로그아웃 여부 redis에 넣어서 accessToken가 유효한지 확인
        long remainMilliSeconds = jwtUtil.getRemainMilliSeconds((accessToken));
        refreshTokenRepository.deleteById(email);
        logoutAccessTokenRepository.save(LogoutAccessToken.builder()
                .email(email)
                .accessToken(accessToken)
                .expiration(remainMilliSeconds / 1000)
                .build());
    }

    @Override
    public void sendEmailCode(String email) {
        // 임의의 authKey 생성
        Random random = new Random();
        String authKey = String.valueOf(random.nextInt(888888) + 111111);

        String subject = "리치미니미 회원가입 인증번호";
        String text = "회원 가입을 위한 인증번호는 " + authKey + "입니다. <br/>";

        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "utf-8");
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(text, true); // HTML이라는 의미로 true.
            javaMailSender.send(mimeMessage);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        ValueOperations<String, Object> valueOperations = redisTemplate.opsForValue();

        // 유효 시간(5분)동안 {email, authKey} 저장
        valueOperations.set(email, authKey, 60 * 5L, TimeUnit.SECONDS);
    }

    @Override
    public CheckEmailResDto checkEmailCode(CheckEmailCodeReqDto checkEmailCodeReqDto) {
        ValueOperations<String, Object> valueOperations= redisTemplate.opsForValue();
        String originCode = (String) valueOperations.get(checkEmailCodeReqDto.getEmail());
        if(originCode == null)
            throw new NotFoundException("해당 이메일로 유효한 인증 코드가 존재하지 않습니다");
        Boolean result = false;
        if(originCode.equals(checkEmailCodeReqDto.getCode())) {
            result = true;
            // 코드를 확인했으므로 redis 에서 삭제
            valueOperations.getOperations().delete(checkEmailCodeReqDto.getEmail());
        }
        return CheckEmailResDto.builder()
                // 존재하면 false, 존재하지 않으면 true 반환
                .success(result)
                .build();
    }

    @Override
    public Map<String, Object> reissueToken(String accessToken, String refreshToken) {
        // accessToken에서 email 가져오기
        String email = jwtUtil.getUsername(accessToken);
        // refresh 토큰 redis 레포지토리에서 가져와서 일치 여부 검사
        String originRefreshToken = refreshTokenRepository.findById(email).orElseThrow(() -> new NotFoundException("해당 이메일에 대한 토큰이 존재하지 않습니다.")).getRefreshToken();
        if(!originRefreshToken.equals(refreshToken)) {
            // 토큰 재발급 불가능
            throw new TokenException("토큰이 일치하지 않습니다.");
        }
        // access & refresh 토큰 재발급
        accessToken = jwtUtil.generateAccessToken(email);
        refreshToken = jwtUtil.generateRefreshToken(email);
        // Redis에 refresh 토큰 저장 필요
        // 회원의 이메일 아이디를 키로 저장
        // 기존에 저장된 refresh 토큰 삭제
        refreshTokenRepository.deleteById(email);
        refreshTokenRepository.save(RefreshToken.builder()
                .email(email)
                .refreshToken(refreshToken)
                .expiration(JwtExpirationEnums.REFRESH_TOKEN_EXPIRATION_TIME.getValue() / 1000)
                .build());
        Map<String, Object> map = new HashMap<>();
        map.put("accessToken", ReissueTokenResDto.builder()
                .accessToken(accessToken)
                .build());
        map.put("refreshToken", refreshToken);
        return map;
    }

    @Override
    public void updateUser(UpdateUserReqDto updateUserReqDto) {
        String email = getLoginId();
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        user.updateUser(updateUserReqDto);
    }

    @Override
    public void deleteUser() {
        String email = getLoginId();
        userRepository.deleteByEmail(email);
    }

    @Transactional(readOnly = true)
    @Override
    public FindUserResDto findUser() {
        String email = getLoginId();
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        return FindUserResDto.builder()
                .email(email)
                .nickname(user.getNickname())
                .balance(user.getBalance())
                .build();
    }

    @Transactional(readOnly = true)
    @Override
    public FindBalanceResDto findBalance() {
        String email = getLoginId();
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        return FindBalanceResDto.builder()
                .balance(user.getBalance())
                .build();
    }

    @Override
    public void updateBalance(Long balance) {
        String email = getLoginId();
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        user.updateBalance(balance);
    }

    @Transactional(readOnly = true)
    @Override
    public List<FindUserResDto> findUserList() {
        return userRepository.findAll().stream().map((user) -> FindUserResDto.builder()
                .email(user.getEmail())
                .nickname(user.getNickname())
                .balance(user.getBalance())
                .build())
                .collect(Collectors.toList());
    }

    @Override
    public void deleteUser(String email) {
        deleteUser(email);
    }

    @Override
    public void updatePassword(UpdatePasswordReqDto updatePasswordReqDto) {
        // 패스워드 암호화
        String encrypted = passwordEncoder.encode(updatePasswordReqDto.getPassword());
        // 현재 로그인 계정 가져오기
        String email = getLoginId();
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        user.updatePassowrd(encrypted);
    }

    @Override
    public void addUser(AddUserReqDto addUserRequest) {
        // 회원가입 정보 유효성 확인
        if(addUserRequest.getEmail() == null || addUserRequest.getEmail().equals("") ||
            addUserRequest.getPassword() == null || addUserRequest.getPassword().equals("") ||
            addUserRequest.getNickname() == null || addUserRequest.getNickname().equals(""))
            throw new IllegalArgumentException(UserExceptionMessage.SIGN_UP_NOT_VALID.getMessage());
        // uuid에 해당하는 커넥티드 아이디 가져오기
        String connectedId = connectedIdMap.remove(addUserRequest.getUuid());
//        String connectedId = "1234";
        if(connectedId == null) throw new UserNotFoundException(UserExceptionMessage.CONNECTED_ID_NOT_CREATED.getMessage());
        String organizationCode = addUserRequest.getOrganization();
        // 패스워드 암호화
        addUserRequest.setPassword(passwordEncoder.encode(addUserRequest.getPassword()));
        // 카드 번호 RSA 공개키로 암호화
        try {
            addUserRequest.setCardNumber(RSAUtil.encryptRSA(addUserRequest.getCardNumber(), RSAUtil.publicKeyFromString(publicKey)));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        User user = userRepository.save(addUserRequest.toEntity(connectedId, organizationCode));

        // 회원가입 성공하면 월 소비내역 초기값 저장하는 메서드 호출
        addUserMonthSpending(user);
        // 월 소비내역 분석해서 redis에 저장하는 메서드 호출
    }

    @Override
    public Map<String, Object> login(LoginReqDto loginRequest) {
        // 이메일 인증 후 로그인 가능하게 변경해야 함
        // 해당 이메일 아이디의 회원이 존재하지 않으면 예외처리
        User user = userRepository.findByEmail(loginRequest.getEmail()).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        // 패스워드 일치 비교
        if (!passwordEncoder.matches(loginRequest.getPassword(), user.getPassword()))
            throw new IllegalArgumentException(UserExceptionMessage.LOGIN_PASSWORD_ERROR.getMessage());
        // 로그인 성공
        // 토큰 생성
        String accessToken = jwtUtil.generateAccessToken(loginRequest.getEmail());
        String refreshToken = jwtUtil.generateRefreshToken(loginRequest.getEmail());
        // Redis에 refresh 토큰 저장 필요
        // 회원의 이메일 아이디를 키로 저장
        refreshTokenRepository.save(RefreshToken.builder()
                .email(user.getEmail())
                .refreshToken(refreshToken)
                .expiration(JwtExpirationEnums.REFRESH_TOKEN_EXPIRATION_TIME.getValue() / 1000)
                .build());
        Map<String, Object> map = new HashMap<>();
        map.put("accessToken", LoginResDto.builder()
                .accessToken(accessToken)
                .nickname(user.getNickname())
                .balance(user.getBalance())
                .build());
        map.put("refreshToken", refreshToken);
        return map;
    }

    /**
     * 현재 로그인한 회원 아이디(이메일)을 반환
     */
    private String getLoginId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails principal = (UserDetails) authentication.getPrincipal();
        return principal.getUsername();
    }

}
