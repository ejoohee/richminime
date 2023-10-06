-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bank_book`
--

DROP TABLE IF EXISTS `bank_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_book` (
  `bank_book_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` bigint(20) DEFAULT 0,
  `balance` bigint(20) DEFAULT 0,
  `date` date DEFAULT NULL,
  `summary` varchar(100) NOT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`bank_book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_book`
--

LOCK TABLES `bank_book` WRITE;
/*!40000 ALTER TABLE `bank_book` DISABLE KEYS */;
INSERT INTO `bank_book` VALUES (1000,2000,48000,'2023-09-26','파티나 특별한 날에 어울리는 공주룩 원피스','구매',100001),(1001,2500,45500,'2023-09-26','일상 생활에서 편안하게 착용 가능한 싸피 바지','구매',100001),(1002,2500,47500,'2023-09-26','항공 승무원을 위한 전용 스튜어디스 유니폼','구매',100000),(1003,0,0,'2023-09-27','string','판매',100000),(1004,20,80,'2023-10-03','노란장판 감성의 벽지장판 세트입니다.','구매',100001),(1005,20,60,'2023-10-03','흔해빠진 평범한 가정집 느낌의 벽지장판 세트입니다.','구매',100001),(1006,20,980,'2023-10-03','러블리핑크 벽지 구매','구매',100001),(1007,20,960,'2023-10-03','연못 벽지 구매','구매',100001),(1008,20,940,'2023-10-03','팬티룩 구매','구매',100001),(1009,20,920,'2023-10-03','노말 보이룩 구매','구매',100001),(1010,20,900,'2023-10-03','노말 걸룩 구매','구매',100001),(1011,20,880,'2023-10-03','피자 러그 구매','구매',100001),(1012,20,860,'2023-10-03','연꽃잎 러그 구매','구매',100001),(1013,20,840,'2023-10-03','노말 옷장 구매','구매',100001),(1014,20,820,'2023-10-03','아기자기한 잠옷 구매','구매',100001),(1015,20,800,'2023-10-03','짱구 코스프레 구매','구매',100001),(1016,0,0,'2023-10-04','코인 적립','적립',100010),(1017,20,780,'2023-10-04','피자 러그 구매','구매',100001),(1018,20,760,'2023-10-04','이웃나라 왕자룩1 구매','구매',100001),(1019,8,768,'2023-10-04','아기자기한 잠옷 판매','판매',100001),(1020,8,776,'2023-10-04','노란 장판 판매','판매',100001),(1021,20,756,'2023-10-04','뽀송한 목욕가운 구매','구매',100001),(1022,0,0,'2023-10-05','코인 적립','적립',100015),(1023,8,764,'2023-10-05','이웃나라 왕자룩1 판매','판매',100001);
/*!40000 ALTER TABLE `bank_book` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clothing`
--

DROP TABLE IF EXISTS `clothing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clothing` (
  `clothing_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `clothing_apply_img` varchar(255) NOT NULL,
  `clothing_img` varchar(255) NOT NULL,
  `clothing_info` varchar(100) DEFAULT NULL,
  `clothing_name` varchar(40) NOT NULL,
  `clothing_type` varchar(255) NOT NULL,
  `price` bigint(20) DEFAULT 0,
  PRIMARY KEY (`clothing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothing`
--

LOCK TABLES `clothing` WRITE;
/*!40000 ALTER TABLE `clothing` DISABLE KEYS */;
INSERT INTO `clothing` VALUES (100,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/01팬티룩_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/01팬티룩.png','오직 팬티만 입고있습니다.','팬티룩','일상',20),(101,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/02노말보이룩_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/02노말보이룩.png','완전 흔해빠진 뽀이 전용 옷','노말 보이룩','일상',20),(102,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/03노말걸룩_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/03노말걸룩.png','완전 흔해빠진 걸 전용 옷','노말 걸룩','일상',20),(103,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/04아기자기한잠옷_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/04아기자기한잠옷.png','아기자기한 잠옷을 입고 자면 꿈나라에서 행복하게 뛰어놀 수 있어요. 못믿겠으면 일단 사보시고 테스트해보시죠!','아기자기한 잠옷','일상',20),(104,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/05팔딱팔딱개구리_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/05팔딱팔딱개구리.png','개울가에 올챙이 한마리 꼬물꼬물 헤엄치다 뒷다리가 쏙 앞다리가 쏙 팔딱팔딱 개구리됐네','팔딱팔딱 개구리','동물잠옷',20),(105,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/06인어공주_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/06인어공주.png','언더더씨 언더더씨','인어공주','코스프레',20),(106,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/07보헤미안랩소디_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/07보헤미안랩소디.png','에오!','보헤미안 랩소디','코스프레',20),(107,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/08귀농의아들_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/08귀농의아들.png','나 없으면 너네 다 쌀밥 못먹어','귀농의 아들','직업',20),(108,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/09전설의요리사_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/09전설의요리사.png','『이 옷에는 전설이 있대... 』 기원전부터 전해지는 이 옷에는 아주 무서운 전설이 전해지고 있어요. 이 옷을 입은 자는 세계 최고의 요리사가 될 수 있다는 소문이…','전설의 요리사','직업',20),(109,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/10뽀송한목욕가운_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/10뽀송한목욕가운.png','목욕 후엔 역시 바나나 우유지! 뽀송뽀송해서 기분이 아주 좋아!','뽀송한 목욕가운','일상',20),(110,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/11짱구코스프레_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/11짱구코스프레.png','오징어는 말려도 짱구는 못말려~','짱구 코스프레','코스프레',20),(111,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/12이웃나라왕자룩1_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/12이웃나라왕자룩1.png','근처의 한 이웃나라에 사는 왕자를 위한 의상입니다. 이걸 입으면 당신도 이웃나라 왕자1이 될 수 있어요!','이웃나라 왕자룩1','코스프레',20),(112,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/13이웃나라공주룩1_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/13이웃나라공주룩1.png','근처의 한 이웃나라에 사는 공주를 위한 의상입니다. 이걸 입으면 당신도 이웃나라 공주1이 될 수 있어요!','이웃나라 공주룩1','코스프레',20),(113,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/14섹시비키니_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/14섹시비키니.png','내 앞에선 아무도 섹시를 논하지마! 섹시한 비키니를 입고 태닝을 해서 피부가 빨개졌어요.','섹시 비키니','코스프레',20),(114,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/15토깽이룩_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/15토깽이룩.png','이것만 입으면 나도 귀여운 토깽이가 될 수 있어요.','토깽이룩','동물잠옷',20),(115,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/16꿀꿀돼지룩_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/16꿀꿀돼지룩.png','식비에 많은 돈을 소비하는 당신! 당신에게 딱 적합한 의상을 준비했어요. 꿀꿀 돼지룩을 입으면 당신은 그냥 돼지에서 꽤나 귀여운 돼지로 진화할거에요.','꿀꿀돼지룩','동물잠옷',20),(116,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/17짱구친구철수_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/17짱구친구철수.png','짱구가 제일 좋아하는 친구인 철수에요. 철수의 취미는 마법소녀 마리를 친구들 몰래 덕질하기에요.','짱구친구 철수','코스프레',20),(117,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/18요술램프지니_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/18요술램프지니.png','소원을 세가지 들어주는 지니를 아세요? 요술램프 지니 의상을 구매하고 마음속으로 소원 세가지를 빌어보세요. 혹시 알아요? 지니가 들어줄지도 모르죠!','요술램프 지니','코스프레',20),(118,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/19수련중인궁녀_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/19수련중인궁녀.png','대한민국 최고의 궁녀가 되기 위해 수련중이던 궁녀. 귀여워서 잠깐 납치해왔어요!','수련중인 궁녀','코스프레',20),(119,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/20캐리비안베이의해적_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/20캐리비안베이의해적.png','케리비안베이에서 활동중인 대장 해적입니다. 까불면 위험해요!','캐리비안베이의 해적','코스프레',20),(220,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/21짱구친구훈이_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/21짱구친구훈이.png','짱구 친구 중 한명인 훈이는 맨날 질질 짜고 있어요. 민트초코를 좋아해서 민트초코색 머리를 가지고 있어요.','짱구친구 훈이','코스프레',10),(221,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/22짱구친구맹구_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/22짱구친구맹구.png','짱구 친구 중 한명인 맹구는 맨날 콧물을 흘리고 있어요. 맹구는 엄청난 돌 수집가에요.','짱구친구 맹구','코스프레',20),(222,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/23짱구친구유리_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/23짱구친구유리.png','짱구 친구 중 한명인 유리는 소꿉놀이를 좋아해요. 분노조절을 잘 못해서 토끼인형과 항상 함께 다닌답니다.','짱구친구 유리','코스프레',20),(223,'https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/24짱구여친수지_착용.png','https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/24짱구여친수지.png','짱구 여자친구 수지입니다. 수지는 아주아주 부잣집 외동딸입니다. 귀여운 외모와 인품을 겸비했어요.','짱구여친 수지','코스프레',20),(100000,'','','','','일상',0);
/*!40000 ALTER TABLE `clothing` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `character_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `clothing_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  KEY `FK_USER` (`user_id`),
  KEY `FK_CLOTHING` (`clothing_id`),
  CONSTRAINT `FK_CLOTHING` FOREIGN KEY (`clothing_id`) REFERENCES `clothing` (`clothing_id`),
  CONSTRAINT `FK_USER` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (2,100002,100000),(25,100010,100000),(26,100001,101),(27,100000,100000),(30,100015,100000);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` bigint(20) NOT NULL,
  `content` varchar(255) NOT NULL,
  `feedback_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (101,'통장 지출 목록이 깨끗하잖아? 짝짝!','긍정피드백'),(102,'오! 이렇게 아꼈어? (박수 박수)','긍정피드백'),(103,'지출 줄이는 게 스킬이라면, 넌 거의 마스터야.','긍정피드백'),(104,'이대로만 하면 모아서 너 하고 싶은 거 할 수 있어!!!','긍정피드백'),(105,'네 저축 습관 주목받아야 해!','긍정피드백'),(106,'봐봐, 이대로라면 곧 저축 전문가!','긍정피드백'),(107,'이 속도로 가면, 미래의 백만장자 될지도?','긍정피드백'),(108,'이대로면 너의 통장은 무한 확장 중!','긍정피드백'),(109,'정말 계획적으로 쓰는 모습 멋져!','긍정피드백'),(110,'매번 이런 식이면, 통장이 널 웃으며 환영할 걸?','긍정피드백'),(111,'이 돈 모아서 어디로 가고 싶니? 꿈꾸던 여행지도 가까워져!','긍정피드백'),(112,'선생님? 저축법은 어디서 배우신 건가요?','긍정피드백'),(113,'선.생.님! 절약하는 꿀팁 가르쳐주세요~','긍정피드백'),(114,'지출 전에 한 번 더 생각한 거지? 대단해!','긍정피드백'),(115,'너는 돈을 아끼면서 사는구나. 정말 멋있다~','긍정피드백'),(116,'절약정신이 아주 훌륭한데? 나도 한 수 배우고 싶어!','긍정피드백'),(117,'들린다 들려~~ 통장에 돈이 한가득 쌓이는 소리가.','긍정피드백'),(118,'넌 현명한 소비습관을 가지고 있는 것 같아. 미래에 돈 걱정은 안 해도 되겠다.','긍정피드백'),(119,'착실하게 아끼며 살고 있구나. 나는 네가 정말로 자랑스러워!','긍정피드백'),(120,'사고 싶은 것을 참는 건 쉽지 않은데 생각보다 잘 해내고 있구나.','긍정피드백'),(121,'어제는 많이 절약했네? 잘했어. 네가 돈을 모아서 하고 싶은게 뭔지 궁금해~','긍정피드백'),(122,'소비 욕망을 참고 인내하는 모습 참 대단한 것 같아.','긍정피드백'),(123,'이렇게 계속 절약하다 보면 언젠가 뿌듯함을 느낄 때가 올 거야. 힘내!','긍정피드백'),(124,'네가 이렇게 착실하게 돈을 아낄 수 있을 줄 몰랐어. 내가 칭찬해줄게! 최고!','긍정피드백'),(125,'올 한해 절약왕 대상을 드립니다!','긍정피드백'),(126,'전날보다 소비를 적게 했구나! 너 정말 야물딱지다!','긍정피드백'),(127,'어제는 평소보다 돈을 조금 썼구나! 너 정말 알뜰하다!','긍정피드백'),(128,'요즘 절약을 잘하고 있구나. 아주 훌륭해!','긍정피드백'),(129,'요즘 소비패턴이 매우 좋아졌어 앞으로도 계속 유지해보자.','긍정피드백'),(130,'엊그제에 비해 어제는 상대적으로 절약을 했네!','긍정피드백'),(131,'너 발전했구나 !!!','긍정피드백'),(132,'이제 정신차린거야??','긍정피드백'),(133,'그래 절약해서 나쁠게 없어','긍정피드백'),(134,'내가 거지라도 너만 행복하다면 난 괜찮아. . .','긍정피드백'),(135,'넌 최고의 절약가야','긍정피드백'),(136,'오, 이 통장 내역 뭐야? 저축마법사?','긍정피드백'),(137,'헐, 넌 어떻게 이렇게 잘 아껴?!','긍정피드백'),(138,'뭐야, 이 속도면 통장이 곧 무한모드 들어가겠네!','긍정피드백'),(139,'아껴서 얻는 건 뭘까? 너의 꿈을 위한 여유!','긍정피드백'),(140,'이건 뭐... 저축의 여신님이신가요?','긍정피드백'),(141,'오늘의 MVP는 너의 통장! 클라쓰 있어~','긍정피드백'),(142,'누가 너에게 이런 저축 스킬을...? 아, 너 자신이군!','긍정피드백'),(143,'선생님, 이렇게 아끼는 비법 좀 전수해주세요~','긍정피드백'),(144,'너무 잘하고 있어! 통장이 널 행복하게 바라보고 있어.','긍정피드백'),(145,'돈 지출 전에 마음의 스톱! 넌 진짜 대단한 것 같아.','긍정피드백'),(146,'저축의 달인! 통장 지출 목록이 깨끗하잖아?','긍정피드백'),(147,'와, 이렇게 아끼는 거 대단해! (박수 박수)','긍정피드백'),(148,'지출을 줄이는 건 정말 중요한 미래 투자야.','긍정피드백'),(149,'네 저축 습관은 정말 주목받아야 해!','긍정피드백'),(150,'모아서 너 하고 싶은 걸 이루는 게 얼마나 멋진 일일까요!','긍정피드백'),(151,'봐봐, 이대로라면 곧 저축 전문가!','긍정피드백'),(152,'이 속도로 가면 곧 미래의 백만장자 될지도?','긍정피드백'),(153,'통장이 무한 확장 중인 것 같아!','긍정피드백'),(154,'계획적인 소비 모습 멋져요!','긍정피드백'),(155,'매번 이런 식이면 통장이 널 웃으며 환영할 거예요.','긍정피드백'),(156,'너의 돈 모아서 어디로 가고 싶은데요?','긍정피드백'),(157,'선생님? 네 저축법은 어디서 배우셨나요?','긍정피드백'),(158,'선.생.님! 절약하는 꿀팁 가르쳐주세요~','긍정피드백'),(159,'지출 전에 한 번 더 생각하고 결정하는 거 진짜 대단하네요!','긍정피드백'),(160,'돈을 아끼면서 살다 보니 정말 멋지게 적립되네요.','긍정피드백'),(161,'절약 정신이 아주 훌륭한데요? 배우고 싶어요!','긍정피드백'),(162,'들린다 들려~~ 통장에 돈이 한가득 쌓이는 소리가 좋네요.','긍정피드백'),(163,'너의 현명한 소비 습관은 미래에 돈 걱정 안 해도 되겠어요.','긍정피드백'),(164,'착실하게 돈을 아끼면서 살고 계시네요. 자랑스럽습니다!','긍정피드백'),(165,'사고 싶은 걸 참는 건 어려운데, 잘 해내고 계시네요.','긍정피드백'),(166,'이런 식으로 계속 절약하다 보면 언젠가 뿌듯함을 느낄 거예요. 힘내세요!','긍정피드백'),(167,'너무 잘 아끼고 계시네요. 제가 칭찬해줄게요! 최고에요!','긍정피드백'),(168,'올 한해 절약왕 대상은 여기 있어요!','긍정피드백'),(169,'전날보다 소비를 적게 하다니! 정말 대단하시네요.','긍정피드백'),(170,'어제는 평소보다 돈을 조금 쓰셨군요! 야물딱지!','긍정피드백'),(171,'요즘 절약 습관이 매우 좋아졌어요. 계속 유지해보세요.','긍정피드백'),(172,'엊그제에 비해 어제는 상대적으로 절약을 했네요!','긍정피드백'),(173,'너 발전 중이에요! 정말 대단해요!','긍정피드백'),(174,'이제 정신 차리셨어요? 절약하면 좋은 일 있을 거에요.','긍정피드백'),(175,'그래도 절약해서 나쁠 게 없어요!','긍정피드백'),(176,'내가 거지라도 너만 행복하다면 난 괜찮아요...','긍정피드백'),(177,'넌 최고의 절약가에요!','긍정피드백'),(178,'이 통장 내역은 뭐야? 저축의 마법사?','긍정피드백'),(179,'헐, 어떻게 이렇게 잘 아껴요?!','긍정피드백'),(180,'뭐야, 이 속도면 통장이 곧 무한모드 들어가겠네요!','긍정피드백'),(181,'아껴서 얻는 건 뭘까요? 너의 꿈을 위한 여유!','긍정피드백'),(182,'이건 뭐... 저축의 여신님이신가요?','긍정피드백'),(183,'오늘의 MVP는 통장이네요! 클라쓰 있어~','긍정피드백'),(184,'누가 너에게 이런 저축 스킬을 가르쳐줬어요?','긍정피드백'),(185,'선생님, 이렇게 아끼는 비법 좀 전수해주세요~','긍정피드백'),(186,'너무 잘하고 있어요! 통장이 널 행복하게 바라보고 있어요.','긍정피드백'),(187,'돈 지출 전에 마음의 스톱! 넌 진짜 대단한 거 같아요.','긍정피드백'),(188,'이대로만 하면 통장이 미래에도 웃겠어!','긍정피드백'),(189,'지출을 줄이는 미래 투자, 너 정말 잘하고 있어!','긍정피드백'),(190,'돈 모아서 네 꿈을 이루는 게 멋져!','긍정피드백'),(191,'네 저축 습관을 주목받을 때가 올 거야!','긍정피드백'),(192,'너의 통장은 계속해서 무한 확장 중이야!','긍정피드백'),(193,'돈을 아끼면서 살면 어디든 갈 수 있어!','긍정피드백'),(194,'통장이 널 행복하게 바라보고 있어요!','긍정피드백'),(195,'돈 모으는 습관으로 백만장자 목표를 향해!','긍정피드백'),(196,'정말 계획적으로 쓰는 모습이 멋져요!','긍정피드백'),(197,'뿌듯한 미래를 위해 지출을 줄이는 게 탁월해요!','긍정피드백'),(198,'네 저축 스킬은 정말 대단하고 인상적이에요!','긍정피드백'),(199,'이 세계에서 거지였던 내가 현실에선 백만장자?','긍정피드백'),(200,'어머... 이제 좀 아낄 기미가 보이는구나!','긍정피드백'),(201,'전날보다 덜 썼어! 힘내보자구!','긍정피드백'),(202,'아낀 돈 == 미래의 자산','긍정피드백'),(203,'금연하니? 헤어졌니? 다이어트하니? 좀 덜 썼네...','긍정피드백'),(204,'이대로만 가면 좋겠어요 :)','긍정피드백'),(601,'통장 잔고 봐봐. 우냐?','부정피드백'),(602,'제발 멈춰...','부정피드백'),(603,'또 많이 썼어? 정신 차려.','부정피드백'),(604,'이거 보면 망한 거임.','부정피드백'),(605,'요즘 금리 올랐는데 너 월급은? 이대로 쓸래?','부정피드백'),(606,'돈 좀 아끼라고 했잖아?','부정피드백'),(607,'이제 좀 절약해 볼 생각이야?','부정피드백'),(608,'이대로면 빚만 키울 것 같은데?','부정피드백'),(609,'정말 생각 없이 쓰는 구나.','부정피드백'),(610,'매번 이런 식이면 문제 생길 것 같은데?','부정피드백'),(611,'이 돈이면 모아서 여행 가겠는데.','부정피드백'),(612,'선생님??? 이 금액은 뭐죠? 계획적인 소비 모르시나요?','부정피드백'),(613,'선.생.님?~ 한도라는 게 있어요 ^^','부정피드백'),(614,'결제하기 전에 생각은 해봤니?','부정피드백'),(615,'절약좀 하고 살아라…이 인간아!','부정피드백'),(616,'네가 돈 많이 쓰면 나야 좋은데 이렇게 막 써도 괜찮은 거 맞아?','부정피드백'),(617,'펑펑 쓰는 거 보니 통장에 돈 많나 보네. 부럽다~~','부정피드백'),(618,'어제 평소보다 좀 많이 소비했네? 네가 여유롭다면 뭐 괜찮겠지…는 무슨 절약 좀 해.','부정피드백'),(619,'도대체 뭘 샀길래 이렇게 많이 쓴 거야? 나한테도 좀 보여줘~','부정피드백'),(620,'들린다 들려~~ 흥청망청 돈 쓰는 소리가.','부정피드백'),(621,'내가 마술 하나 보여줄까? 통장 잔고가 사라지는 마술! 어라, 네가 먼저 해버렸네.','부정피드백'),(622,'어제도 꽤 썼구나? 네가 재력이 있다면 이렇게 소비해도 괜찮겠지만 말이야. 아니라면..당장 절약해.','부정피드백'),(623,'어제 지출이 상당히 많은데 네 통장 정말 괜찮긴 하니?','부정피드백'),(624,'친구야, 네 사전에 절약이란 단어는 없나 봐?','부정피드백'),(625,'최근들어 돈을 점점 많이 쓰는구나. 좋은 일이 있나보다? 그래도 적당히 써야지?','부정피드백'),(626,'사치가 심하구나! 소비를 줄일 필요가 있어 보여.','부정피드백'),(627,'로또라도 당첨됐니? 요즘 낭비가 왜이리 심하니?','부정피드백'),(628,'요즘 과소비를 하는 것 같아 걱정이야..','부정피드백'),(629,'어제는 평소보다 돈을 많이 쓴 것 같네. 오늘은 절약을 해보는게 어떨까?','부정피드백'),(630,'너 돈 많냐?','부정피드백'),(631,'나라도 부자가 돼서 다행이야','부정피드백'),(632,'소비가 과하다고 생각하지 않니?','부정피드백'),(633,'돈 좀 적당히 써','부정피드백'),(634,'현실에선 거지인 니가 이세계에선 부자~~~~','부정피드백'),(635,'너 덕분에 내가 살맛난다야','부정피드백'),(636,'이 통장 내역... 무슨 일 있었어?','부정피드백'),(637,'또? 진짜 이젠 조금만 아껴봐.','부정피드백'),(638,'통장이 소리내서 울고 있어...','부정피드백'),(639,'쓸 때마다 숨곳이 있나 보지?','부정피드백'),(640,'어휴, 또 지출 대박이네. 조절 좀!','부정피드백'),(641,'뭔가 구매 전에 스톱! 생각 좀 해봐야겠다.','부정피드백'),(642,'이런 속도면, 통장이 곧 슬슬 퇴사할 것 같아...','부정피드백'),(643,'돈도 휴식 필요해! 쉬게 해줘!','부정피드백'),(644,'이 돈으로 뭘 하려고 했는지 기억나?','부정피드백'),(645,'선생님, 이 금액... 계획서에 있었나요?','부정피드백'),(646,'돈은 쓰는 건 중요하지만, 절약도 생각해봐야 해.','부정피드백'),(647,'잔고가 줄면 불안해지지 않아?','부정피드백'),(648,'소비 패턴을 조금 바꿔봐. 미래를 위해.','부정피드백'),(649,'오늘은 소비를 자제해보는 건 어때?','부정피드백'),(650,'돈을 모으는 습관을 들이면 좋을 거야.','부정피드백'),(651,'미래를 위한 목표를 세우면 지출을 조절하기 쉬워질 거야.','부정피드백'),(652,'한 번 소비하기 전에 심호흡을 해보는 건 어때요?','부정피드백'),(653,'목표를 가지고 돈을 모으면 미래가 밝아질 거야.','부정피드백'),(654,'지출 내역을 분석해봐서 무엇을 줄일 수 있을지 고민해봐.','부정피드백'),(655,'돈을 효율적으로 운용하는 방법을 찾아보자.','부정피드백'),(656,'소비의 이유와 필요성을 다시 생각해봐.','부정피드백'),(657,'미래를 위해 저축을 시작해보는 건 어때요?','부정피드백'),(658,'목표 달성을 위한 노력이 돈을 절약하는 데 도움이 될 거야.','부정피드백'),(659,'소비할 때 항상 \"왜?\"라는 질문을 던져봐.','부정피드백'),(660,'지출 내역을 기록해보면 어디서 돈을 절약할 수 있을지 알게 될 거야.','부정피드백'),(661,'절약 습관을 들이면 재정 상황이 나아질 거야.','부정피드백'),(662,'돈을 모아서 미래에 더 큰 즐거움을 누릴 수 있어.','부정피드백'),(663,'소비를 줄이면 금융 안정을 가져다줄 거야.','부정피드백'),(664,'돈을 아껴서 미래에 편안한 삶을 누리자.','부정피드백'),(665,'지출을 줄이면 더 많은 것을 얻을 수 있어.','부정피드백'),(666,'돈을 효율적으로 사용하면 더 많은 목표를 달성할 수 있어.','부정피드백'),(667,'소비 습관을 바꾸면 미래를 위한 투자가 가능해져.','부정피드백'),(668,'돈을 아껴서 더 나은 미래가 기다린다.','부정피드백'),(669,'목표를 위해 조금만 더 아껴보자.','부정피드백'),(670,'재정 상황을 개선하려면 소비 습관을 조절해야 해.','부정피드백'),(671,'돈을 모으면 더 많은 가능성이 열릴 거야.','부정피드백'),(672,'미래를 위해 지출을 줄여보는 건 어때요?','부정피드백'),(673,'돈을 아껴서 더 많은 것을 얻을 수 있어.','부정피드백'),(674,'목표를 위해 소비를 자제하면 미래가 밝아질 거야.','부정피드백'),(675,'돈을 모으는 습관을 들이면 재정 상황이 나아질 거야.','부정피드백'),(676,'소비 습관을 바꾸면 더 나은 미래가 기다릴 거야.','부정피드백'),(677,'돈을 아껴서 더 큰 목표를 향해 나아가보자.','부정피드백'),(678,'미래에 대비해서 소비를 조금 더 절약해봐.','부정피드백'),(679,'목표를 향한 노력으로 소비를 절약하면 미래가 밝아질 거야.','부정피드백'),(680,'그렇게 낭비할 바에 차라리 부모님께 효도를 하는게 어떻겠니?','부정피드백'),(681,'사람은 소비생활을 해야 살아요, 그렇지만 조금 더 현명하게 쓰면 좋겠어요.','부정피드백'),(682,'소비에는 즐거움이 있지만, 절약도 중요한 부분이에요.','부정피드백'),(683,'통장 잔고를 키우면 미래에 더 큰 자유를 누릴 수 있어요.','부정피드백'),(684,'소비를 조금 더 계획적으로 하면 재정 상황이 개선될 거예요.','부정피드백'),(685,'돈을 아껴서 더 큰 목표를 향해 나아가요.','부정피드백'),(686,'재정 상황을 개선하려면 소비를 줄이는 것이 중요해.','부정피드백'),(687,'재정 상황을 개선하기 위해 소비 습관을 변화시켜보자.','부정피드백'),(688,'목표를 향한 첫 걸음은 지출을 자제하는 것부터 시작해.','부정피드백'),(689,'돈을 모으는 습관을 들이면 미래가 밝아질 거야.','부정피드백'),(690,'소비 습관을 바꾸면 더 나은 미래가 기다릴 거야.','부정피드백'),(691,'돈을 아껴서 더 큰 목표를 향해 나아가보자.','부정피드백'),(692,'미래에 대비해서 소비를 조금 더 절약해봐.','부정피드백'),(693,'목표를 향한 노력으로 소비를 절약하면 미래가 밝아질 거야.','부정피드백'),(694,'그렇게 낭비할 바에 차라리 부모님께 효도를 하는게 어떻겠니?','부정피드백'),(695,'사람은 소비생활을 해야 살아요, 그렇지만 조금 더 현명하게 쓰면 좋겠어요.','부정피드백'),(696,'소비에는 즐거움이 있지만, 절약도 중요한 부분이에요.','부정피드백'),(697,'통장 잔고를 키우면 미래에 더 큰 자유를 누릴 수 있어요.','부정피드백'),(698,'소비를 조금 더 계획적으로 하면 재정 상황이 개선될 거예요.','부정피드백'),(699,'돈을 아끼면 미래에 더 큰 목표를 달성할 수 있어요.','부정피드백'),(700,'마이너스 통장 만들 생각이구나?','부정피드백'),(701,'그 돈... 부디 좋은 곳에 쓴 것이길 바라...','부정피드백'),(702,'돈을 막 쓰는걸 보아하니 어디 이사라도 가시나요?','부정피드백'),(703,'미래를 생각해서 소비를 줄여보는 건 어떨까요?','부정피드백'),(704,'어제 용돈 받았니? 꽤 썼네...','부정피드백');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` bigint(20) NOT NULL,
  `item_img` varchar(255) NOT NULL,
  `item_info` varchar(255) DEFAULT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `price` bigint(20) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (101,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/러블리핑크러그.png','정말 사랑스러운 핑크색 러그네요. 이 러그만 있으면 당신도 공주가 된 기분을 느낄 수 있을거에요.','러블리핑크 러그','러그',20),(102,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/연꽃잎러그.png','감성있는 연꽃잎 모양 러그입니다. 방을 연못 느낌으로 꾸미는 데 필요할 거에요!','연꽃잎 러그','러그',20),(103,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/피자러그.png','맛있는 콤비네이션 파지를 닮은 러그입니다. 아무리 맛있어 보여도 먹으면 안돼요!','피자 러그','러그',20),(104,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/팬케이크러그.png','맛있는 팬케이크를 똑닮은 러그입니다. 메이플 시럽이 뿌려져 있으며 딸기맛, 초코맛, 민트초코맛도 출시될 예정입니다.','팬케이크 러그','러그',20),(105,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/수제버거러그.png','한땀한땀 직접 만든 수제버거 러그입니다. 참깨빵 위에 순쇠고기 패티, 치즈 두장, 양상추, 특별한 소스, 양파까지. 거기에다 토마토까지 추가로 들어갔어요.','수제버거 러그','러그',20),(106,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/수박러그.png','여름하면 생각나는 과일은 무엇인가요? 바로 수박이죠. 시원한 수박 모양 러그입니다.','수박 러그','러그',20),(201,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/노말옷장.png','흔해빠진 평범한 옷장입니다.','노말 옷장','가구',20),(202,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/러블리핑크옷장.png','정말 사랑스러운 핑크색 옷장이네요. 이 옷장만 있으면 당신도 공주가 된 기분을 느낄 수 있을거에요.','러블리핑크 옷장','가구',20),(203,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/저주받은옷장.png','전세계를 뒤흔들었던 1944년 4월 4일 희대의 미스테리 옷장 사건. 이 옷장을 소유한 자는 영원히 풀 수 없는 저주에 걸린다고 하는데...','저주받은 옷장','가구',20),(204,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/교실청소함.png','교실마다 구석탱이를 차지하던 청소도구함입니다. 옷장대신 사용해보세요!','교실 청소함','가구',20),(205,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/이삿짐박스.png','아직 정리하지 않은 이삿짐 박스입니다.','이삿짐 박스','가구',20),(206,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/나는치킨.png','치킨 가루를 둘러싼 귀여운 모형입니다! 항상 치킨을 먹는 것을 꿈꾸며, 집 안에서도 튀긴 치킨처럼 따뜻하게 있고 싶어해요.','나는 치킨','가구',20),(207,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/놀란닭.png','놀라서 큰 눈을 뜬 모습의 닭입니다. 그 놀란 표정이 사랑스러워 많은 사람들의 관심을 받아요.','놀란 닭','가구',20),(208,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/조개.png','바닷가에서 온 조개에요. 그 안에는 아름다운 진주가 숨겨져 있습니다. ','조개','가구',20),(209,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/나무.png','푸르른 잎사귀와 뭉툭한 몸통을 가진 나무입니다. 항상 신선하고 상쾌한 공기를 공급해줄거에요.','나무','가구',20),(301,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/노란장판.jpg','노란장판 감성의 벽지장판 세트입니다.','노란 장판','벽지장판',20),(302,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/평범한가정집.jpg','흔해빠진 평범한 가정집 느낌의 벽지장판 세트입니다.','평범한 가정집','벽지장판',20),(303,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/러블리핑크벽지.jpg','정말 사랑스러운 핑크색 벽지장판이네요. 이것만 있으면 당신도 공주가 된 기분을 느낄 수 있을거에요.','러블리핑크 벽지','벽지장판',20),(304,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/연못벽지.jpg','연못 위에서 뛰어노는 기분이 드는 듯한 벽지장판 세트입니다.','연못 벽지','벽지장판',20),(305,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/피자박스.jpg','피자박스 안에 들어가있는 느낌이 드는 듯한 벽지장판 세트입니다.','피자 박스','벽지장판',20),(306,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/눈에해로운벽지.jpg','알록달록 착시현상이 일어나는 듯한 눈에 해로운 벽지입니다. ','눈에해로운 벽지','벽지장판',20),(307,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/벼농사벽지.jpg','맑고 높은 하늘의 계절인 가을, 추수를 시작할 계절이 시작되었어요! 마치 벼농사 체험에 온 듯 한 느낌을 낼 수 있습니다.','벼농사 벽지','벽지장판',20),(308,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/차원적인벽지.jpg','새로운 차원에 들어가있는 듯 한 느낌을 주는 모던한 느낌의 차원적인 벽지장판 세트입니다.','차원적인 벽지','벽지장판',20),(309,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/귀신의집.jpg','미스테리한 느낌의 집이 바로 이곳! 빨간 느낌의 벽지장판으로, 방안에서는 신비롭고 무서운 분위기를 만끽할 수 있어요.','귀신의 집','벽지장판',20),(310,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/기본노란벽지.jpg','기본 노란 벽지입니다. 하지만 평범하지 않은 살구색이죠.','기본 노란 벽지','벽지장판',20),(311,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/모던벽지.jpg','체크무늬가 포인트인 컬러감있는 디자인의 벽지장판입니다. ','모던 벽지','벽지장판',20),(312,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/바다벽지.jpg','시원한 바다의 느낌이 드는 벽지장판입니다. 이것만 있으면 방 안이 바다로 변할 것 같은 상쾌함을 느낄 수 있어요.','바다 벽지','벽지장판',20),(313,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/유럽풍벽지.jpg','클래식하고 고급스러운 유럽 스타일의 벽지장판입니다.','유럽풍 벽지','벽지장판',20),(314,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/레드카펫벽지.jpg','헤이 모두들 안녕 내가 누군지 아니? 오늘 난 레드카펫에서 가장 빛나는 걸 어때 섹시하니?','레드카펫 벽지','벽지장판',500),(315,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/눈이편안한벽지.jpg','눈이 가장 편안한 컬러를 적용한 벽지장판입니다.','눈이편안한 벽지','벽지장판',20),(316,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/코랄벽지.jpg','리치미니미 창시자 조윤영이 가장 좋아하는 컬러인 코랄색을 입힌 벽지장판입니다. 예쁘죠?','코랄 벽지','벽지장판',20),(317,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/노란체크벽지.jpg','짱구네 원장선생님이 떠오르는 노란 체크무늬 벽지입니다. 이름을 짱구네 원장선생님 벽지로 바꿔볼까 고민중이에요.','노란체크 벽지','벽지장판',20),(318,'https://richminime.s3.ap-northeast-2.amazonaws.com/item/교도소벽지.jpg','쇠창살 창문 하나 달랑있는 교도소 컨셉의 벽지입니다. 수감된 죄수는 항상 탈옥각을 보겠지만 어림도 없어요.','교도소 벽지','벽지장판',20),(100000,'기본url','기본정보','기본아이템','벽지장판',0),(100001,'url','기본','기본','가구',500),(100002,'url','기본','기본','러그',500);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `prompt`
--

DROP TABLE IF EXISTS `prompt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prompt` (
  `prompt_id` bigint(20) NOT NULL,
  `role_content` varchar(255) NOT NULL,
  `role_user` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`prompt_id`),
  KEY `FK6a2l6kyql90nb92gim071joeq` (`user_id`),
  CONSTRAINT `FK6a2l6kyql90nb92gim071joeq` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prompt`
--

LOCK TABLES `prompt` WRITE;
/*!40000 ALTER TABLE `prompt` DISABLE KEYS */;
/*!40000 ALTER TABLE `prompt` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `item_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `item_id` (`item_id`,`user_id`,`item_type`),
  KEY `FKrsc9pb9h33996lww769sk8s6x` (`user_id`),
  CONSTRAINT `FKkqh3vgwcy6y36qbncmt3rm3f9` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FKrsc9pb9h33996lww769sk8s6x` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (30,102,100001,'러그'),(28,304,100001,'벽지장판'),(27,100000,100000,'벽지장판'),(3,100000,100002,'벽지장판'),(26,100000,100010,'벽지장판'),(31,100000,100015,'벽지장판'),(29,100001,100001,'가구'),(32,100001,100015,'가구'),(33,100002,100015,'러그');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;


-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `spending`
--

DROP TABLE IF EXISTS `spending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spending` (
  `spending_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `cost` bigint(20) DEFAULT NULL,
  `spent_date` datetime(6) DEFAULT NULL,
  `store_no` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`spending_id`),
  KEY `idx_spent_date` (`spent_date`)
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spending`
--

LOCK TABLES `spending` WRITE;
/*!40000 ALTER TABLE `spending` DISABLE KEYS */;
INSERT INTO `spending` VALUES (1,'',1160,'2023-08-04 00:00:00.000000',0,100002),(2,'RF대중교통',3600,'2023-08-06 00:00:00.000000',94010476,100002),(3,'RF대중교통',71600,'2023-08-06 00:00:00.000000',94011844,100002),(4,'한식',24000,'2023-08-07 00:00:00.000000',95011566,100002),(5,'편의점',3900,'2023-08-08 00:00:00.000000',60860228,100002),(6,'전자상거래PG',4990,'2023-08-08 00:00:00.000000',89179260,100002),(7,'전자상거래PG상품권',10000,'2023-08-09 00:00:00.000000',74536874,100002),(8,'전자상거래PG상품권',10000,'2023-08-09 00:00:00.000000',74536874,100002),(9,'기타 용역서비스',7900,'2023-08-16 00:00:00.000000',74812383,100002),(10,'전자상거래PG',4800,'2023-08-17 00:00:00.000000',54243233,100002),(11,'일반잡화판매점',6000,'2023-08-19 00:00:00.000000',48153964,100002),(12,'편의점',1500,'2023-08-19 00:00:00.000000',92668521,100002),(13,'일반음식점 기타',7500,'2023-08-19 00:00:00.000000',83578151,100002),(14,'전자상거래PG',27520,'2023-08-19 00:00:00.000000',74178599,100002),(15,'편의점',3200,'2023-08-19 00:00:00.000000',92107554,100002),(16,'슈퍼마켓',7980,'2023-08-20 00:00:00.000000',85593984,100002),(17,'일반잡화판매점',7000,'2023-08-20 00:00:00.000000',48153964,100002),(18,'전자상거래PG',5400,'2023-08-21 00:00:00.000000',106385984,100002),(19,'휴게음식점',13000,'2023-08-21 00:00:00.000000',86427973,100002),(20,'커피/음료전문점',9000,'2023-08-21 00:00:00.000000',79715298,100002),(21,'편의점',2200,'2023-08-22 00:00:00.000000',82514506,100002),(22,'택시',9400,'2023-08-22 00:00:00.000000',94011873,100002),(23,'편의점',5300,'2023-08-22 00:00:00.000000',103954656,100002),(24,'당구장',8000,'2023-08-22 00:00:00.000000',88749601,100002),(25,'일식/생선회집',3500,'2023-08-22 00:00:00.000000',106134302,100002),(26,'커피/음료전문점',12500,'2023-08-22 00:00:00.000000',87686977,100002),(27,'전자상거래PG',5600,'2023-08-24 00:00:00.000000',54243233,100002),(28,'택시',18000,'2023-08-24 00:00:00.000000',94011873,100002),(29,'전자상거래PG',1324,'2023-08-24 00:00:00.000000',106385984,100002),(30,'패스트푸드점',22700,'2023-08-24 00:00:00.000000',89703680,100002),(31,'패스트푸드점',7800,'2023-08-24 00:00:00.000000',89703680,100002),(32,'전자상거래PG',41340,'2023-08-25 00:00:00.000000',99012641,100002),(33,'일반주점',16000,'2023-08-25 00:00:00.000000',31512153,100002),(34,'일반음식점 기타',28500,'2023-08-26 00:00:00.000000',94180731,100002),(35,'농.수.축산물점',5890,'2023-08-26 00:00:00.000000',68289001,100002),(36,'일반잡화판매점',4000,'2023-08-27 00:00:00.000000',48153964,100002),(37,'중식',19000,'2023-08-27 00:00:00.000000',104648350,100002),(38,'전자상거래PG',7300,'2023-08-28 00:00:00.000000',54243233,100002),(39,'전자상거래오픈마켓',56232,'2023-08-28 00:00:00.000000',83581513,100002),(40,'편의점',1700,'2023-08-28 00:00:00.000000',82514506,100002),(41,'약국',8000,'2023-08-28 00:00:00.000000',91918798,100002),(42,'전자상거래PG',46710,'2023-08-30 00:00:00.000000',89226357,100002),(43,'전자상거래PG상품권',282000,'2023-09-01 00:00:00.000000',94526518,100002),(44,'전자상거래PG상품권',94500,'2023-09-05 00:00:00.000000',94526518,100002),(45,'RF대중교통',66350,'2023-09-06 00:00:00.000000',94011844,100002),(46,'편의점',3900,'2023-09-08 00:00:00.000000',60860228,100002),(47,'전자상거래PG',4990,'2023-09-08 00:00:00.000000',89179260,100002),(48,'전자상거래PG',6580,'2023-09-08 00:00:00.000000',87277782,100002),(49,'전자상거래PG',4600,'2023-09-12 00:00:00.000000',54243233,100002),(50,'전자상거래PG',6800,'2023-09-14 00:00:00.000000',54243233,100002),(51,'전자상거래PG',3000,'2023-09-14 00:00:00.000000',54243233,100002),(52,'기타 용역서비스',7900,'2023-09-15 00:00:00.000000',74812383,100002),(53,'전자상거래PG',1600,'2023-09-21 00:00:00.000000',106385984,100002),(54,'커피/음료전문점',11000,'2023-09-21 00:00:00.000000',87686977,100002),(55,'전자상거래PG',6490,'2023-09-23 00:00:00.000000',82418262,100002),(56,'전자상거래PG',4600,'2023-09-25 00:00:00.000000',54243233,100002),(57,'놀이공원',22500,'2023-09-27 00:00:00.000000',3659652,100002),(58,'전자상거래PG',2300,'2023-09-29 00:00:00.000000',54243233,100002),(167,'전자상거래PG상품권',282000,'2023-09-01 00:00:00.000000',94526518,100010),(168,'전자상거래PG상품권',94500,'2023-09-05 00:00:00.000000',94526518,100010),(169,'RF대중교통',66350,'2023-09-06 00:00:00.000000',94011844,100010),(170,'편의점',3900,'2023-09-08 00:00:00.000000',60860228,100010),(171,'전자상거래PG',4990,'2023-09-08 00:00:00.000000',89179260,100010),(172,'전자상거래PG',6580,'2023-09-08 00:00:00.000000',87277782,100010),(173,'전자상거래PG',4600,'2023-09-12 00:00:00.000000',54243233,100010),(174,'전자상거래PG',6800,'2023-09-14 00:00:00.000000',54243233,100010),(175,'전자상거래PG',3000,'2023-09-14 00:00:00.000000',54243233,100010),(176,'기타 용역서비스',7900,'2023-09-15 00:00:00.000000',74812383,100010),(177,'전자상거래PG',1600,'2023-09-21 00:00:00.000000',106385984,100010),(178,'커피/음료전문점',11000,'2023-09-21 00:00:00.000000',87686977,100010),(179,'전자상거래PG',6490,'2023-09-23 00:00:00.000000',82418262,100010),(180,'전자상거래PG',4600,'2023-09-25 00:00:00.000000',54243233,100010),(181,'놀이공원',22500,'2023-09-27 00:00:00.000000',3659652,100010),(182,'전자상거래PG',2300,'2023-09-29 00:00:00.000000',54243233,100010),(183,'전자상거래PG',36540,'2023-10-01 00:00:00.000000',89226357,100010),(184,'전자상거래PG',20000,'2023-10-02 00:00:00.000000',89226357,100010),(185,'',1160,'2023-08-04 00:00:00.000000',0,100001),(186,'RF대중교통',3600,'2023-08-06 00:00:00.000000',94010476,100001),(187,'RF대중교통',71600,'2023-08-06 00:00:00.000000',94011844,100001),(188,'한식',24000,'2023-08-07 00:00:00.000000',95011566,100001),(189,'편의점',3900,'2023-08-08 00:00:00.000000',60860228,100001),(190,'전자상거래PG',4990,'2023-08-08 00:00:00.000000',89179260,100001),(191,'전자상거래PG상품권',10000,'2023-08-09 00:00:00.000000',74536874,100001),(192,'전자상거래PG상품권',10000,'2023-08-09 00:00:00.000000',74536874,100001),(193,'기타 용역서비스',7900,'2023-08-16 00:00:00.000000',74812383,100001),(194,'전자상거래PG',4800,'2023-08-17 00:00:00.000000',54243233,100001),(195,'일반잡화판매점',6000,'2023-08-19 00:00:00.000000',48153964,100001),(196,'편의점',1500,'2023-08-19 00:00:00.000000',92668521,100001),(197,'일반음식점 기타',7500,'2023-08-19 00:00:00.000000',83578151,100001),(198,'전자상거래PG',27520,'2023-08-19 00:00:00.000000',74178599,100001),(199,'편의점',3200,'2023-08-19 00:00:00.000000',92107554,100001),(200,'슈퍼마켓',7980,'2023-08-20 00:00:00.000000',85593984,100001),(201,'일반잡화판매점',7000,'2023-08-20 00:00:00.000000',48153964,100001),(202,'전자상거래PG',5400,'2023-08-21 00:00:00.000000',106385984,100001),(203,'휴게음식점',13000,'2023-08-21 00:00:00.000000',86427973,100001),(204,'커피/음료전문점',9000,'2023-08-21 00:00:00.000000',79715298,100001),(205,'편의점',2200,'2023-08-22 00:00:00.000000',82514506,100001),(206,'택시',9400,'2023-08-22 00:00:00.000000',94011873,100001),(207,'편의점',5300,'2023-08-22 00:00:00.000000',103954656,100001),(208,'당구장',8000,'2023-08-22 00:00:00.000000',88749601,100001),(209,'일식/생선회집',3500,'2023-08-22 00:00:00.000000',106134302,100001),(210,'커피/음료전문점',12500,'2023-08-22 00:00:00.000000',87686977,100001),(211,'전자상거래PG',5600,'2023-08-24 00:00:00.000000',54243233,100001),(212,'택시',18000,'2023-08-24 00:00:00.000000',94011873,100001),(213,'전자상거래PG',1324,'2023-08-24 00:00:00.000000',106385984,100001),(214,'패스트푸드점',22700,'2023-08-24 00:00:00.000000',89703680,100001),(215,'패스트푸드점',7800,'2023-08-24 00:00:00.000000',89703680,100001),(216,'전자상거래PG',41340,'2023-08-25 00:00:00.000000',99012641,100001),(217,'일반주점',16000,'2023-08-25 00:00:00.000000',31512153,100001),(218,'일반음식점 기타',28500,'2023-08-26 00:00:00.000000',94180731,100001),(219,'농.수.축산물점',5890,'2023-08-26 00:00:00.000000',68289001,100001),(220,'일반잡화판매점',4000,'2023-08-27 00:00:00.000000',48153964,100001),(221,'중식',19000,'2023-08-27 00:00:00.000000',104648350,100001),(222,'전자상거래PG',7300,'2023-08-28 00:00:00.000000',54243233,100001),(223,'전자상거래오픈마켓',56232,'2023-08-28 00:00:00.000000',83581513,100001),(224,'편의점',1700,'2023-08-28 00:00:00.000000',82514506,100001),(225,'약국',8000,'2023-08-28 00:00:00.000000',91918798,100001),(226,'전자상거래PG',46710,'2023-08-30 00:00:00.000000',89226357,100001),(227,'전자상거래PG상품권',282000,'2023-09-01 00:00:00.000000',94526518,100001),(228,'전자상거래PG상품권',94500,'2023-09-05 00:00:00.000000',94526518,100001),(229,'RF대중교통',66350,'2023-09-06 00:00:00.000000',94011844,100001),(230,'편의점',3900,'2023-09-08 00:00:00.000000',60860228,100001),(231,'전자상거래PG',4990,'2023-09-08 00:00:00.000000',89179260,100001),(232,'전자상거래PG',6580,'2023-09-08 00:00:00.000000',87277782,100001),(233,'전자상거래PG',4600,'2023-09-12 00:00:00.000000',54243233,100001),(234,'전자상거래PG',6800,'2023-09-14 00:00:00.000000',54243233,100001),(235,'전자상거래PG',3000,'2023-09-14 00:00:00.000000',54243233,100001),(236,'기타 용역서비스',7900,'2023-09-15 00:00:00.000000',74812383,100001),(237,'전자상거래PG',1600,'2023-09-21 00:00:00.000000',106385984,100001),(238,'커피/음료전문점',11000,'2023-09-21 00:00:00.000000',87686977,100001),(239,'전자상거래PG',6490,'2023-09-23 00:00:00.000000',82418262,100001),(240,'전자상거래PG',4600,'2023-09-25 00:00:00.000000',54243233,100001),(241,'놀이공원',22500,'2023-09-27 00:00:00.000000',3659652,100001),(242,'전자상거래PG',2300,'2023-09-29 00:00:00.000000',54243233,100001),(243,'전자상거래PG상품권',282000,'2023-09-01 00:00:00.000000',94526518,100001),(244,'전자상거래PG상품권',94500,'2023-09-05 00:00:00.000000',94526518,100001),(245,'RF대중교통',66350,'2023-09-06 00:00:00.000000',94011844,100001),(246,'편의점',3900,'2023-09-08 00:00:00.000000',60860228,100001),(247,'전자상거래PG',4990,'2023-09-08 00:00:00.000000',89179260,100001),(248,'전자상거래PG',6580,'2023-09-08 00:00:00.000000',87277782,100001),(249,'전자상거래PG',4600,'2023-09-12 00:00:00.000000',54243233,100001),(250,'전자상거래PG',6800,'2023-09-14 00:00:00.000000',54243233,100001),(251,'전자상거래PG',3000,'2023-09-14 00:00:00.000000',54243233,100001),(252,'기타 용역서비스',7900,'2023-09-15 00:00:00.000000',74812383,100001),(253,'전자상거래PG',1600,'2023-09-21 00:00:00.000000',106385984,100001),(254,'커피/음료전문점',11000,'2023-09-21 00:00:00.000000',87686977,100001),(255,'전자상거래PG',6490,'2023-09-23 00:00:00.000000',82418262,100001),(256,'전자상거래PG',4600,'2023-09-25 00:00:00.000000',54243233,100001),(257,'놀이공원',22500,'2023-09-27 00:00:00.000000',3659652,100001),(258,'전자상거래PG',2300,'2023-09-29 00:00:00.000000',54243233,100001),(259,'전자상거래PG',36540,'2023-10-01 00:00:00.000000',89226357,100001),(260,'전자상거래PG',20000,'2023-10-02 00:00:00.000000',89226357,100001),(312,'전자상거래PG',4000,'2023-09-01 00:00:00.000000',54243233,100015),(313,'전자상거래PG',3500,'2023-09-01 00:00:00.000000',106385984,100015),(314,'제과점/아이스크림점',3680,'2023-09-01 00:00:00.000000',70791479,100015),(315,'편의점',4150,'2023-09-01 00:00:00.000000',107294721,100015),(316,'전자상거래PG',11000,'2023-09-02 00:00:00.000000',74178599,100015),(317,'편의점',2000,'2023-09-02 00:00:00.000000',107294721,100015),(318,'전자상거래PG',11000,'2023-09-03 00:00:00.000000',76337316,100015),(319,'전자상거래PG',55000,'2023-09-03 00:00:00.000000',76337316,100015),(320,'전자상거래PG',99000,'2023-09-03 00:00:00.000000',13980940,100015),(321,'일반.치과.한의원',8100,'2023-09-04 00:00:00.000000',99533987,100015),(322,'약국',4500,'2023-09-04 00:00:00.000000',93539233,100015),(323,'한식',7000,'2023-09-04 00:00:00.000000',81466456,100015),(324,'편의점',7500,'2023-09-05 00:00:00.000000',31560697,100015),(325,'커피/음료전문점',3900,'2023-09-05 00:00:00.000000',93684740,100015),(326,'커피/음료전문점',4500,'2023-09-06 00:00:00.000000',108646516,100015),(327,'전자상거래PG',3900,'2023-09-07 00:00:00.000000',76337316,100015),(328,'전자상거래PG',9900,'2023-09-07 00:00:00.000000',76337316,100015),(329,'전자상거래PG',19900,'2023-09-07 00:00:00.000000',76337316,100015),(330,'전자상거래PG',29900,'2023-09-07 00:00:00.000000',76337316,100015),(331,'커피/음료전문점',3400,'2023-09-08 00:00:00.000000',97598561,100015),(332,'커피/음료전문점',4500,'2023-09-08 00:00:00.000000',108646516,100015),(333,'전자상거래PG',10200,'2023-09-09 00:00:00.000000',80439892,100015),(334,'전자상거래PG',14500,'2023-09-10 00:00:00.000000',80439892,100015),(335,'전자상거래PG',2900,'2023-09-11 00:00:00.000000',54243233,100015),(336,'전자상거래PG',1402,'2023-09-11 00:00:00.000000',106385984,100015),(337,'전자상거래PG',1600,'2023-09-12 00:00:00.000000',106385984,100015),(338,'전자상거래PG',11000,'2023-09-12 00:00:00.000000',74178599,100015),(339,'커피/음료전문점',3100,'2023-09-13 00:00:00.000000',97598561,100015),(340,'커피/음료전문점',3500,'2023-09-14 00:00:00.000000',97598561,100015),(341,'커피/음료전문점',4400,'2023-09-14 00:00:00.000000',109160365,100015),(342,'편의점',1700,'2023-09-14 00:00:00.000000',103954656,100015),(343,'전자상거래PG',3500,'2023-09-15 00:00:00.000000',54243233,100015),(344,'편의점',1700,'2023-09-15 00:00:00.000000',96944299,100015),(345,'전자상거래PG',37800,'2023-09-16 00:00:00.000000',13980940,100015),(346,'전자상거래PG',11000,'2023-09-16 00:00:00.000000',74178599,100015),(347,'편의점',1700,'2023-09-16 00:00:00.000000',104434301,100015),(348,'편의점',1700,'2023-09-16 00:00:00.000000',111652655,100015),(349,'전자상거래PG',3500,'2023-09-16 00:00:00.000000',13219101,100015),(350,'전자상거래PG',14300,'2023-09-17 00:00:00.000000',80439892,100015),(351,'커피/음료전문점',3800,'2023-09-18 00:00:00.000000',93684740,100015),(352,'편의점',1700,'2023-09-18 00:00:00.000000',104434301,100015),(353,'커피/음료전문점',3500,'2023-09-19 00:00:00.000000',97598561,100015),(354,'편의점',3700,'2023-09-20 00:00:00.000000',96944299,100015),(355,'일반음식점 기타',13000,'2023-09-20 00:00:00.000000',73768549,100015),(356,'전자상거래PG',2950,'2023-09-21 00:00:00.000000',13980940,100015),(357,'커피/음료전문점',3500,'2023-09-21 00:00:00.000000',97598561,100015),(358,'제과점/아이스크림점',3300,'2023-09-21 00:00:00.000000',109644648,100015),(359,'전자상거래PG',95200,'2023-09-21 00:00:00.000000',76337316,100015),(360,'전자상거래PG',4900,'2023-09-21 00:00:00.000000',76337316,100015),(361,'전자상거래PG',9900,'2023-09-21 00:00:00.000000',76337316,100015),(362,'커피/음료전문점',2600,'2023-09-22 00:00:00.000000',97598561,100015),(363,'휴게음식점',3000,'2023-09-22 00:00:00.000000',79266498,100015),(364,'전자상거래PG',18900,'2023-09-23 00:00:00.000000',76337316,100015),(365,'전자상거래PG',26910,'2023-09-23 00:00:00.000000',13980940,100015),(366,'일반음식점 기타',4500,'2023-09-23 00:00:00.000000',73768549,100015),(367,'편의점',1700,'2023-09-23 00:00:00.000000',103954656,100015),(368,'커피/음료전문점',1600,'2023-09-25 00:00:00.000000',97598561,100015),(369,'커피/음료전문점',4500,'2023-09-25 00:00:00.000000',91423750,100015),(370,'RF대중교통',56350,'2023-09-26 00:00:00.000000',42522093,100015),(371,'전자상거래PG',3500,'2023-09-26 00:00:00.000000',106385984,100015),(372,'전자상거래PG',4750,'2023-09-26 00:00:00.000000',13980940,100015),(373,'커피/음료전문점',1600,'2023-09-27 00:00:00.000000',97598561,100015),(374,'전자상거래PG',9350,'2023-09-29 00:00:00.000000',13980940,100015),(375,'전자상거래PG',53130,'2023-09-29 00:00:00.000000',13980940,100015),(376,'전자상거래PG',21900,'2023-09-29 00:00:00.000000',74178599,100015),(377,'전자상거래PG',46750,'2023-09-30 00:00:00.000000',13980940,100015),(378,'전자상거래PG',12900,'2023-09-30 00:00:00.000000',102109972,100015),(379,'전자상거래PG',500,'2023-10-01 00:00:00.000000',13980940,100015),(380,'편의점',2800,'2023-10-01 00:00:00.000000',104434301,100015),(381,'커피/음료전문점',1600,'2023-10-04 00:00:00.000000',97598561,100015),(382,'편의점',800,'2023-10-04 00:00:00.000000',90299718,100015);
/*!40000 ALTER TABLE `spending` ENABLE KEYS */;
UNLOCK TABLES;


-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user_clothing`
--

DROP TABLE IF EXISTS `user_clothing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_clothing` (
  `user_clothing_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `clothing_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_clothing_id`),
  KEY `FKs9rpk3n9bmphovw12gtapnwme` (`clothing_id`),
  KEY `FKibtqqreyxi7eqvwf3s1we932e` (`user_id`),
  CONSTRAINT `FKibtqqreyxi7eqvwf3s1we932e` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKs9rpk3n9bmphovw12gtapnwme` FOREIGN KEY (`clothing_id`) REFERENCES `clothing` (`clothing_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100010 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_clothing`
--

LOCK TABLES `user_clothing` WRITE;
/*!40000 ALTER TABLE `user_clothing` DISABLE KEYS */;
INSERT INTO `user_clothing` VALUES (100003,100,100001),(100004,101,100001),(100005,102,100001),(100007,110,100001),(100009,109,100001);
/*!40000 ALTER TABLE `user_clothing` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user_item`
--

DROP TABLE IF EXISTS `user_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_item` (
  `user_item_id` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_item_id`),
  KEY `FKdcjo77iqbb0cwvcgvu5vh1qxi` (`user_id`),
  KEY `FKpnf7ma2ql912dg92xna4y89ix` (`item_id`),
  CONSTRAINT `FKdcjo77iqbb0cwvcgvu5vh1qxi` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKpnf7ma2ql912dg92xna4y89ix` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_item`
--

LOCK TABLES `user_item` WRITE;
/*!40000 ALTER TABLE `user_item` DISABLE KEYS */;
INSERT INTO `user_item` VALUES (5,302,100001),(6,303,100001),(7,304,100001),(9,102,100001),(10,201,100001),(27,103,100001);
/*!40000 ALTER TABLE `user_item` ENABLE KEYS */;
UNLOCK TABLES;

-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: j9A704.p.ssafy.io    Database: richminime
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `balance` mediumtext DEFAULT 0,
  `card_number` varchar(255) NOT NULL,
  `clothing_count` int(11) DEFAULT 0,
  `connected_id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `item_count` int(11) DEFAULT 0,
  `nickname` varchar(20) NOT NULL,
  `organization_code` varchar(4) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` varchar(50) NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=100016 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (100000,'0','1111222233334444',0,'dd39','dd39@naver.com',-1,'관리자윤영','0301','$2a$10$YjDwf1KgaVYqr16RaqKwDO9blK.A/6b8vfhYKDkVv7GGxeN0NxMvC','ROLE_ADMIN'),(100001,'764','1234567890123456',5,'abc123','test@naver.com',7,'테스트1','0301','$2a$10$YjDwf1KgaVYqr16RaqKwDO9blK.A/6b8vfhYKDkVv7GGxeN0NxMvC','ROLE_USER'),(100002,'0','FfZPh/5zw4+F0s9s51O07xnXokeLytQgurohhru8PDwEkR6be1gfCiSiLfJ39IxoZURYMRyw5eXfGRa5SShDx3Z12ZaihbjP07zgqwvgp/Kuh87dCqn4uKZ4ykjqwzlWQqgdiOB6c4TVqqFwEwIDKCcP2QiJjkg1idYiuK2L2QA=',0,'fz.w382sAx9bmJLuuCaGXX','ansghddnd12@naver.com',0,'무농눙','0301','$2a$10$Gl2Ari5tQJ73LSv6wNSeGOiLAs4bO18fcYmrtTIhCLyGKSPfWuBS6','ROLE_USER'),(100010,'0','GZfswxMKrYVlwDjGbuopEYun4UG1YMwt8w+JBCd0H8ywzPVgMfAdZkpfMIPhISdXaZNpRGrgn/lCvPh0PWdDVyyH1RoY9GcXR3ev0nG99VUJIK6cxol5P1gOpCtHjt2TaZ5qALFjYXUkayhxk7ISOgQSh5iV9uFvpvMCGkozvJU=',0,'e0.9GRIBQ5wbzYJYIPfNWa','dnddl9368@gmail.com',0,'홍웅','0301','$2a$10$FBl3UDMb88W1a92i/N0FOesIiiPnNS08zsPMqajXgeGPJjOalTw5.','ROLE_USER'),(100015,'0','J19dFtSj/wdS6Ge+wVacI3Um/pDyY83ZFamQ3+7XKCkXWvOgX2H7yj+iKve5Y+67zUHL0t9Ebib2Qwb7i2BY6mVK5AsG7YRMZiDZFDnvSYLhTDIOgSwEv9USdKO+V65OYgGGfnH7Omq2wGtOgww3ZOzoGuYGXzcaY6RqL+U26iE=',0,'exbp3ACsAzW8yuwOgKsErW','harunz@naver.com',0,'EB','0301','$2a$10$Yg61VV7i5ezxcDOTaaFdWu0lLPN7NNZbAKJYCuVgSs.dUQnYpka8m','ROLE_USER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


