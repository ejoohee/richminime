package com.richminime.domain.gpt.service;

import com.richminime.domain.gpt.dao.PromptRepository;
import com.richminime.domain.gpt.domain.Prompt;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PromptServiceImpl implements PromptService {

    private final PromptRepository promptRepository;
    @Value("${gpt.api-key}")
    private String apikey;

    private String gptUrl = "https://api.openai.com/v1/chat/completions";
    @Override
    public Mono<String> findChatbotReply(String request) {
        WebClient webClient = WebClient.create(gptUrl);
        HttpHeaders httpheaders = new HttpHeaders();
        httpheaders.setContentType(MediaType.APPLICATION_JSON);
        httpheaders.set("Authorization","Bearer " + apikey);
        //추후 시큐리티 완료 되면 getUser()로 대체
        List<Prompt> prompts = promptRepository.findByUser_UserId(1L);
        List<MultiValueMap<String,String>> message = new ArrayList<>();
        MultiValueMap<String,String> systemMessage = new LinkedMultiValueMap<>();
        systemMessage.add("role","system");
        systemMessage.add("content","너는 은행 상담원이야");
        MultiValueMap<String,String> userMessage;
        MultiValueMap<String,String> assistantMessage;
        if(prompts != null){
            for(Prompt prompt : prompts){
                userMessage = new LinkedMultiValueMap<>();
                userMessage.add("role","user");
                userMessage.add("content",prompt.getRoleUser());
                message.add(userMessage);
                assistantMessage = new LinkedMultiValueMap<>();
                assistantMessage.add("role","assistant");
                assistantMessage.add("content",prompt.getRoleContent());
                message.add(assistantMessage);
            }
        }
        userMessage = new LinkedMultiValueMap<>();
        userMessage.add("role","user");
        userMessage.add("content",request);
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model","gpt-3.5-turbo");
        requestBody.put("messages",message);

/*        String reply = "";
        Mono mono = webClient.post()
                .headers(headers -> headers.addAll(httpheaders)) //헤더 설정(콜백 함수로 headers를 받아 headers에 Httpheaders 설정
                .bodyValue(requestBody)//requestbody 설정
                .retrieve()
                .bodyToMono(String.class) //응답을 string으로 받겠다는 설정
                .map(
                        result ->{
                            System.out.println(result);
                            System.out.println("성공");
                            return result;
                });
        mono.subscribe(
                item -> System.out.println(item)
        );*/

        return webClient.post()
                .headers(headers -> headers.addAll(httpheaders)) //헤더 설정(콜백 함수로 headers를 받아 headers에 Httpheaders 설정
                .bodyValue(requestBody)//requestbody 설정
                .retrieve()
                .bodyToMono(String.class) //응답을 string으로 받겠다는 설정
                .map(
                        result ->{
                            System.out.println(result);
                            System.out.println("성공");
                            return result;
                        });
    }
}
