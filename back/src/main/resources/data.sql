alter table users
    add constraint ck_item_cnt check ( item_count <= 20 ),
    add constraint ck_clothing_cnt check ( clothing_count <= 20);

insert into users
(user_id, email, password, nickname, connected_id, organization_code, card_number, user_type)
values
('100001', 'test@naver.com', '$2a$10$KWa2GxJjM79nA7lDzr.8mectx6knAbmwjftSN2..MDN6j/oTCRTaK', '테스트1', 'abc123', '0301', '1234567890123456', 'ROLE_USER'),
('100000', 'dd39@naver.com', '$2a$10$KWa2GxJjM79nA7lDzr.8mectx6knAbmwjftSN2..MDN6j/oTCRTaK', '관리자윤영', 'dd39', '0301', '1111222233334444', 'ROLE_ADMIN');

insert into item
(item_id, item_name, item_type, item_img, item_info, price)
values
('100', '기본테마', 'ITEM_THEME_SET', 'url', '가입시 기본으로 적용되는 개평범한 테마입니다. 옷장과 주전자가 있습니다.', '10'),
('101', '공주테마', 'ITEM_THEME_SET', 'url', '공주 컨셉의 테마입니다. 주희가 좋아하겠네요.', '9837000'),
('201', '알라딘 가구세트', 'ITEM_FURNITURE_SET', 'url', '알라딘 컨셉의 가구 세트입니다. 벽지, 장판은 제외입니다.', '50000');

insert into user_item
(user_item_id, item_id, user_id)
values
('100000', '100', '100001'),
('100001', '100', '100000');

insert into feedback
(feedback_id, feedback_type, content)
values
('100', 'POSITIVE', '저번주보다 소비를 적게 했구나! 너 정말 야물딱지다!'),
('101', 'POSITIVE', '오늘은 평소보다 돈을 조금 썼구나! 너 정말 알뜰하다!'),
('102', 'POSITIVE', '요즘 절약을 잘하고 있구나. 아주 훌륭해!'),
('200', 'NEGATIVE', '최근들어 돈을 점점 많이 쓰는구나. 좋은 일이 있나보다? 그래도 적당히 써야지?'),
('201', 'NEGATIVE', '사치가 심하구나! 소비를 줄일 필요가 있어 보여.'),
('202', 'NEGATIVE', '로또라도 당첨됐니? 요즘 낭비가 왜이리 심하니?'),
('300', 'RANDOM', '랜덤 피드백 1'),
('301', 'RANDOM', '랜덤 피드백 2'),
('302', 'RANDOM', '랜덤 피드백 3');
