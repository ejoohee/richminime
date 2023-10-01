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
(item_id, item_name, item_type, item_img, item_apply_img, item_info, price)
values
('100', '기본 벽지장판', '벽지장판', 'url', 'apply_url', '가입시 기본으로 적용되는 벽지장판입니다.', '100'),
('101', '공주 벽지장판', '벽지장판', 'url', 'apply_url', '공주 컨셉의 벽지장판입니다. 주희가 좋아하겠네요.', '200'),
('201', '요술램프', '가구', 'url', 'apply_url', '요술램프입니다. 벽지, 장판은 제외입니다.', '500');

insert into user_item
(user_item_id, item_id, user_id)
values
('1000', '100', '100001'),
('1001', '100', '100000'),
('1002', '201', '100000');

insert into feedback
(feedback_id, feedback_type, content)
values
('100', '긍정피드백', '전날보다 소비를 적게 했구나! 너 정말 야물딱지다!'),
('101', '긍정피드백', '어제는 평소보다 돈을 조금 썼구나! 너 정말 알뜰하다!'),
('102', '긍정피드백', '요즘 절약을 잘하고 있구나. 아주 훌륭해!'),
('103', '긍정피드백', '요즘 소비패턴이 매우 좋아졌어 앞으로도 계속 유지해보자.'),
('104', '긍정피드백', '엊그제에 비해 어제는 상대적으로 절약을 했네!'),
('200', '부정피드백', '최근들어 돈을 점점 많이 쓰는구나. 좋은 일이 있나보다? 그래도 적당히 써야지?'),
('201', '부정피드백', '사치가 심하구나! 소비를 줄일 필요가 있어 보여.'),
('202', '부정피드백', '로또라도 당첨됐니? 요즘 낭비가 왜이리 심하니?'),
('203', '부정피드백', '요즘 과소비를 하는 것 같아 걱정이야..'),
('204', '부정피드백', '어제는 평소보다 돈을 많이 쓴 것 같네. 오늘은 절약을 해보는게 어떨까?');

insert into bank_book
(bank_book_id, amount, balance, date, summary, transaction_type, user_id)
values
    ('1000', '2000', '48000', '2023-09-26', '파티나 특별한 날에 어울리는 공주룩 원피스', '구매', '100001'),
    ('1001', '2500', '45500', '2023-09-26', '일상 생활에서 편안하게 착용 가능한 싸피 바지', '구매', '100001'),
    ('1002', '2500', '47500', '2023-09-26', '항공 승무원을 위한 전용 스튜어디스 유니폼', '구매', '100000');

*/
