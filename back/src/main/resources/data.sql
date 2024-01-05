/*

insert into users
(user_id, email, password, nickname, connected_id, organization_code, card_number, user_type, balance)
values
('100001', 'test@naver.com', '$2a$10$KWa2GxJjM79nA7lDzr.8mectx6knAbmwjftSN2..MDN6j/oTCRTaK', '테스트1', 'abc123', '0301', '1234567890123456', 'ROLE_USER', '1000'),
('100000', 'dd39@naver.com', '$2a$10$KWa2GxJjM79nA7lDzr.8mectx6knAbmwjftSN2..MDN6j/oTCRTaK', '관리자윤영', 'dd39', '0301', '1111222233334444', 'ROLE_ADMIN', '10000000');

insert into  clothing
(clothing_id, clothing_name, clothing_type, clothing_img, clothing_apply_img, clothing_info, price)
values ('100','공주룩', '파티', 'party_image.jpg', 'party_image_apply1.jpg', '파티나 특별한 날에 어울리는 공주룩 원피스', '2000'),
       ('101','싸피복', '일상', 'sample_pants.jpg', 'sample_pants_apply.jpg', '일상 생활에서 편안하게 착용 가능한 싸피 바지', '2500'),
       ('102','스튜어디스', '직업', 'work_shirt.jpg', 'work_shirt_apply.jpg', '항공 승무원을 위한 전용 스튜어디스 유니폼', '3000');



insert into user_clothing
(user_clothing_id, clothing_id, user_id)
values
    ('100000', '100', '100001'),
    ('100001', '101', '100001'),
    ('100002', '101', '100000');


insert into item
(item_id, item_name, item_type, item_img, item_info, price)
values
('100', '기본 벽지장판', '벽지장판', 'url', '가입시 기본으로 적용되는 벽지장판입니다.', '100'),
('101', '공주 벽지장판', '벽지장판', 'url', '공주 컨셉의 벽지장판입니다. 주희가 좋아하겠네요.', '200'),
('201', '요술램프', '가구', 'url', '요술램프입니다. 벽지, 장판은 제외입니다.', '500'),
('100000', '기본', '벽지장판', 'url', '기본', '500'),
('100001', '기본', '가구', 'url', '기본', '500'),
('100002', '기본', '러그', 'url', '기본', '500')
;

insert into user_item
(user_item_id, item_id, user_id)
values
('1000', '100', '100001'),
('1001', '100', '100000'),
('1002', '201', '100000'),
('100000', '100000', '100000'),
('100001', '100001', '100000'),
('100002', '100002', '100000');

insert into room (room_id, user_id,item_id)
values ('101','100001','100'),('102','100001','101'),('103','100001','201');


insert into feedback
(feedback_id, feedback_type, content)
values
('101', '긍정피드백', '통장 지출 목록이 깨끗하잖아? 짝짝!'),
('102', '긍정피드백', '오! 이렇게 아꼈어? (박수 박수)'),
('103', '긍정피드백', '지출 줄이는 게 스킬이라면, 넌 거의 마스터야.'),
('104', '긍정피드백', '이대로만 하면 모아서 너 하고 싶은 거 할 수 있어!!!'),
('105', '긍정피드백', '네 저축 습관 주목받아야 해!'),
('601', '부정피드백', '통장 잔고 봐봐. 우냐?'),
('602', '부정피드백', '제발 멈춰...'),
('603', '부정피드백', '또 많이 썼어? 정신 차려.'),
('604', '부정피드백', '이거 보면 망한 거임.'),
('605', '부정피드백', '요즘 금리 올랐는데 너 월급은? 이대로 쓸래?');


insert into bank_book
(bank_book_id, amount, balance, date, summary, transaction_type, user_id)
values
    ('1000', '2000', '48000', '2023-09-26', '파티나 특별한 날에 어울리는 공주룩 원피스', '구매', '100001'),
    ('1001', '2500', '45500', '2023-09-26', '일상 생활에서 편안하게 착용 가능한 싸피 바지', '구매', '100001'),
    ('1002', '2500', '47500', '2023-09-26', '항공 승무원을 위한 전용 스튜어디스 유니폼', '구매', '100000');


*/