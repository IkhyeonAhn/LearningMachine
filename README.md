
# **Learning Machine**

 <h3>  IT 교육 컨텐츠를 제공하는 웹 사이트</h3>

 - ## **프로젝트 개요**
	 + 프로젝트명 : 러닝머신(Learning Machine)
	 + 제작기간 : 2022.07.04 ~ 2022.08.01
	 + 프로젝트 목적 :
		  - 개발자들의 자기개발을 위한 다양한 컨텐츠 제공
		  - COVID-19에 의한 비대면 교육의 필요성
		  - 시간과 장소에 제한받지 않고 고품질 컨텐츠를 효율적으로 관리
	  
	  
 - ## **팀구성 및 역할 분담**
	 + 개발 : <a href = "https://github.com/IkhyeonAhn">안익현</a>, <a href="https://github.com/Hijineee">이희진</a>,  <a href = "https://github.com/skek3039">명재성</a>, <a href="https://github.com/Moonmaji">문형석</a>, <a href="https://github.com/ParkGuTy">박성균</a><br>
	```
	안익현 : 프로젝트 전체적인 기능 및 요구사항 도출, DB설계 및 구현, 팀원 역할 배분, 유저페이지 기능과 UI 구현
	이희진 : 관리자 페이지 상세 기능 요구사항 도출,관리자페이지 기능과 UI 구현
	명재성 : 강사 페이지 상세 기능 요구사항 도출, 강사페이지 기능과 UI구현
	문형석 : 강사페이지 기능과 UI구현
	박성균 : 관리자 페이지 기능과 UI구현, 사용자 공통기능(회원가입, 로그인) 구현
	```
	
 - ## **개발 환경**
	  ```
	  OS : Windows 11
	  IDE : Eclipse 4.23.0, VisualStudio Code, MySQL Workbench
	  Server(WAS) : Tomcat 9.0
	  Database : MariaDB 10.7
	  Lanuage : JAVA(Oracle JDK 11)
	  Framework : Spring 4.3.25.RELEASE
	  ```

 - ## **데이터베이스 구성도(ERD)**
	![ERD](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/erd.png)

- ## **프로젝트 주요코드(유저)**


	 + 결제 컨트롤러 : [UserPaymentController.java](https://github.com/IkhyeonAhn/LearningMachine/blob/main/src/main/java/com/learning/User/Controller/UserPaymentController.java)
		  - Iamport 결제API를 활용한 결제 유효성 검사
		  - 이미 결제한 강의면 결제 취소 후 해당 강의실로 이동
		  - 해당 강의가 찜하기가 되어있는 강의라면 결제 성공 시 찜 목록에서 삭제


	 + 비디오 시청 : [ULectureController.java](https://github.com/IkhyeonAhn/LearningMachine/blob/403beca95e0573a5e1cafa55b837e14efbe1ae7e/src/main/java/com/learning/User/Controller/ULectureController.java#L63)
		 - 강의 결제 여부에 따라 보여줄 수 있는 강의 수 제한(미결제 시 미리보기 최대 3개)


	 + 강의 리뷰 작성, 수정, 삭제 : [ULectureService.java.java](https://github.com/IkhyeonAhn/LearningMachine/blob/403beca95e0573a5e1cafa55b837e14efbe1ae7e/src/main/java/com/learning/User/Service/ULectureService.java#L285)
		 - 강의 결제 여부에 따라 리뷰 작성 제한
		 - 본인이 작성한 리뷰라면 수정, 삭제 가능


	 + 강의 Q&A 작성, 수정, 삭제 : [ULectureService.java](https://github.com/IkhyeonAhn/LearningMachine/blob/403beca95e0573a5e1cafa55b837e14efbe1ae7e/src/main/java/com/learning/User/Service/ULectureService.java#L321)
		  - 로그인이 되어있을 경우 최대 3개의 질문 작성 가능
		  - 본인이 작성한 질문만 수정, 삭제 가능하도록 유효성 검사
		  - 강사가 이미 나의 질문에 답변을 달았을 경우 수정 불가


	+ 강의 영상 질문 작성, 수정, 삭제 : [ULectureService.java](https://github.com/IkhyeonAhn/LearningMachine/blob/403beca95e0573a5e1cafa55b837e14efbe1ae7e/src/main/java/com/learning/User/Service/ULectureService.java#L267)
		 - 강의를 결제했을 경우에만 영상에 대한 질문 작성 가능
		 - 본인이 작성한 질문만 수정, 삭제 가능하도록 유효성 검사
		 - 강사가 이미 나의 질문에 답변을 달았을 경우 수정 불가


	+ 쪽지 읽기, 보내기, 삭제 : [MessageService.java](https://github.com/IkhyeonAhn/LearningMachine/blob/main/src/main/java/com/learning/Common/Service/MessageService.java)
		 - 로그인을 한 상태에서만 쪽지를 보낼 수 있습니다.
		 - 본인이 보낸 쪽지만 삭제할 수 있습니다
		 - 이미 상대가 내 쪽지를 읽었다면 삭제했을 때 나에게서만 보이지 않게됩니다.(수정 필요)


 - ## **프로젝트 주요화면(유저)**

  ### 메인화면
![main_noLogin](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220817_193616.png)
 + 로그인을 하지않은 상태의 메인페이지입니다.
	- 관리자와 강사 권한을 가진 유저도 사진과 같이 출력됩니다.
	- 강의 살펴보기를 누르면  강의목록으로 이동합니다.

![main_Login](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0001.png)
 + 로그인을 한 상태의 메인 페이지입니다.
	- 운영자와 관리자권한을 가진 유저는 로그인 하지않은 상태의 메인페이지로 처리됩니다.)
 
![main_Login_vq](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_202729.png)
 + 메인페이지에서 내 질문을 클릭했을 때의 모달창입니다.
	- 내가 동영상에서 질문했던 내용들이 출력됩니다.
	- 내가 했던 질문에 답이 달렸을 경우에는 사진과 같이 수정버튼이 나타나지 않습니다.

![main_Login_recentVideo](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_202914.png)
 + 메인화면에서 최근들은 강의를 클릭하면 나오는 모달창입니다.
	 - 내가 최근에 들은 동영상리스트를 들은 날짜 기준으로 내림차순 정렬하여 보여줍니다.
	 - 영상 제목을 클릭하면 해당 링크로 이동합니다.
 
![main_Login_recentVideo](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0007.png)
![main_Login_recentVideo](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0006.png)
 + 메인화면에서 최근온 쪽지를 클릭하면 이동하는 페이지입니다.
	  - 쪽지를 온 대상 행을 클릭하면 쪽지 모달창이 표시됩니다.
	  - 상대가 쪽지를 읽은 상태에서 삭제를 하면 본인에게만 표시가 안됩니다.

  ### 강의목록
![LectureList_noLogin](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220817_193717.png)
  + 로그인 하지않았을 경우의 강의 목록입니다.
 	 - 인기강의 / 최신강의 메뉴탭을 이용하여 강의들을 살펴볼 수 있습니다.
 	 - 인기 강의는 강의를 현재 수강하고 있는 학생들의 수를 기준으로 내림차순 정렬됩니다.
 	 - 최신 강의는 강의가 등록 된 날짜를 기준으로 내림차순 정렬됩니다.
 	 - 로그인을 하지않은 상태에서 찜하기(하트)버튼을 누르면 로그인창으로 이동합니다.
 
![LectureList_Login](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_202835.png)
 + 로그인을 했을 경우의 강의목록입니다.
 	 - 내가 결제했던 강의는 강의완료로 표시되며, 클릭하면 강의실로 이동합니다.
 	 - 찜하기를 누르면 하트가 화면과 같이 색이 채워지며 찜하기가 됩니다.
 
 ###  강의실
![Lecture_noLogin](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220817_193810.png)
 + 로그인하지 않은 상태의 강의실입니다.
	 - 강의 정보가 화면과 같이 출력됩니다.
	 - 강의에 대한 평점이 표시됩니다.
	 - 로그인을 하지 않았을 경우 쪽지 및 결제하기 버튼을 누르면 로그인창으로 이동됩니다.

![Lecture_Login](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_202948.png)
 + 로그인 한 상태의 강의실입니다.
	  - 결제하지 않은 강의라면 결제하기 버튼이 출력됩니다.
	  - 결제한 강의라면 처음부터 듣기 버튼만 출력됩니다.
	  - 결제한 상태에서 듣고 있던 강의가 있다면 이어듣기 버튼이 출력됩니다.
	  - 쪽지버튼을 눌러 선생님에게 쪽지를 보낼 수 있습니다.

![Lecture_noLogin_Review](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0002.png)
![Lecture_noLogin_QNA](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0004.png)
 + 로그인하지 않은 상태의 리뷰(강의실페이지), Q&A 기능입니다.
	  - 리뷰를 조회할 수 있습니다.
	  - Q&A를 조회할 수 있습니다.
	  - 로그인을 하지 않았기 때문에 작성버튼이 표시되지 않습니다.
	
![Lecture_Login_Review](http://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_203010.png)
![Lecture_noLogin_QNA](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0005.png)
  + 로그인한 상태의 리뷰(강의실페이지), Q&A 기능입니다.
	  - 구매를 한 강의라면 리뷰작성버튼이 표시되며 리뷰를 작성할 수 있습니다.
	  - 구매를 하지 않은 강의여도 Q&A를 최대 3개까지 작성할 수 있습니다.
	  - 이미 답변이 달린 질문이라면 수정할 수 없습니다.
	  - 리뷰와 Q&A모두 본인이 작성한 것이라면 수정, 삭제를 할 수 있습니다.
	  - 리뷰 삭제는 평점 반영과 악의적인 수정을 방지하기 위해 데이터베이스에서 삭제되지 않습니다.
	  - 리뷰는 삭제하면 다시 작성할 수 없습니다.
	
 ###  강의 결제
![LectureList_Login](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_203321.png)
 + 강의 결제페이지입니다.
	  - Iamport의 카카오페이를 활용하여 강의 결제를 진행합니다.
	  - 이미 구매한 강의라면 해당 강의의 강의실페이지로 이동합니다.
	 
 ###  강의 영상
![Lecture_Video_qna_Login_](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/20220818_203100.png)
![Lecture_Viedo_List](https://github.com/IkhyeonAhn/LearningMachine/blob/main/img/0003.png)
  + 강의 수강페이지입니다.
	  - 결제한 강의라면 출석처리가 됩니다.
	  - 결제한 강의라면 영상 질문 작성버튼이 출력 되고, 질문을 작성할 수 있습니다.
	  - 결제를 하지 않거나, 로그인을 하지 않은 경우 영상을 3개만 미리보기할 수 있습니다.
	  - 만약 미리보기 영상이 아닌 영상 듣기를 클릭하면, 로그인 페이지 혹은 결제 페이지로 이동합니다.

<hr>

 - ## **보완사항**
	 + UI /UX 개선
	 + Service에서 상세 처리
		  - 나름 Service에서 로직 처리 후 컨트롤러에서 반환 받도록 코딩했지만, 아직 엉성한 부분이 있음(특히 결제)
	 + Spring Security 적용
		  - 권한에 따른 인가를 효율적이고, 안전하게 관리하기 위함
	 + 로그인 후 이전에 있던 페이지로 이동
	 + 출석 	처리를 동영상 시청 및 진도율로 개선
		  - 현재 유튜브링크를 가져오는게 아닌, 동영상을 서버에 업로드 후 동영상 플레이어를 이용한 진도율 측정
		  - JS에서 페이지를 벗어났을 때 실행되는 함수가 있으므로 비정상(?)적인 페이지 이탈 경우에도 진도율을 정상적으로 반영
	 +  활용한 프론트엔드 개선
		  - 프론트엔드 프레임워크(및 라이브러리) 및 디자인패턴의 지식이 부족하여 비효율적인 코드를 작성했기 때문
	 + DB 가공방식 변경 (인터넷에 있는 자료에 의한 개인적인 생각, 확실하지 않음)
		  - 프론트에서 필요한 데이터를 가공할 때 현재 방식(테이블 자료를 따로 불러와 서버에서 처리)이 아닌, DB에서 효율적인 SQL문으로 불러오는 것이 효율적이기 때문이다.
		  - DB에서 WAS로 데이터를 불러올 때 자원을 많이 차지하므로 서버를 시작할 때 싱글톤 클래스를 만들어 테이블 자료들을 한 번에 저장한 상태에서 데이터 가공을 한 뒤, Insert, Update, Delete 등의 SQL문만 DB와 통신, 따로 만든 클래스에 반영
