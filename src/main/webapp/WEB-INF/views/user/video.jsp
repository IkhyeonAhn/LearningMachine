<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>러닝머신 :: ${Video.v_videotitle }</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<meta content="" name="keywords">
	<meta content="" name="description">

	<!-- Favicon -->
	<link href="img/favicon.ico" rel="icon">

	<!-- Google Web Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
		rel="stylesheet">

	<!-- Icon Font Stylesheet -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

	<!-- Libraries Stylesheet -->
	<link href="./resources/lib/animate/animate.min.css" rel="stylesheet">
	<link href="./resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

	<!-- Customized Bootstrap Stylesheet -->
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">

	<!-- Template Stylesheet -->
	<link href="./resources/css/style.css" rel="stylesheet">
	<link href="./resources/css/admin.css" rel="stylesheet">

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="./resources/lib/wow/wow.min.js"></script>
	<script src="./resources/lib/easing/easing.min.js"></script>
	<script src="./resources/lib/waypoints/waypoints.min.js"></script>
	<script src="./resources/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="./resources/summernote/summernote-lite.js"></script>
	<script src="./resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
	<!-- Template Javascript -->
	<script src="./resources/js/main.js"></script>
	<style>
		.dropdown {
			position: fixed;
			display: inline-block;
			z-index: 100;
			margin: auto;
			display: inline-block;
		}

		.dropbtn_icon {
			font-family: 'Material Icons';
		}

		.dropbtn {
			border: 1px solid rgb(37, 37, 37);
			border-radius: 4px;
			background-color: #f5f5f5;
			text-align: center;
			font-weight: 400;
			color: rgb(37, 37, 37);
			padding: 12px;
			width: 50px;
			cursor: pointer;
			font-size: 12px;
		}

		.dropdown-content {
			display: none;
			position: absolute;
			z-index: 1;
			/*다른 요소들보다 앞에 배치*/
			font-weight: 400;
			background-color: #f9f9f9;
			min-width: 200px;
		}

		.dropdown-content a {
			display: block;
			text-decoration: none;
			color: rgb(37, 37, 37);
			font-size: 12px;
			padding: 12px 20px;
		}

		.dropdown-content a:hover {
			background-color: #ececec
		}

		.dropdown:hover .dropdown-content {
			display: block;
		}

		#video {
			position: relative;
			height: 0;
			padding-bottom: 56.25%
		}

		iframe {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
		}

		.background {
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100vh;
			background-color: rgba(0, 0, 0, 0.3);
			z-index: 1000;

			/* 숨기기 */
			z-index: -1;
			opacity: 0;
		}

		.show {
			opacity: 1;
			z-index: 1000;
			transition: all 0.5s;
		}

		.window {
			position: relative;
			width: 100%;
			height: 100%;
		}

		.popup {
			padding: 10px;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			background-color: #ffffff;
			box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

			/* 임시 지정 */
			width: 70%;
			height: 70%;

			/* 초기에 약간 아래에 배치 */
			transform: translate(-50%, -40%);
			overflow-y: auto;
		}

		.show .popup {
			transform: translate(-50%, -50%);
			transition: all 0.5s;
		}

		#closebtn {
			position: fixed;
			top: 0;
			right: 0;
			padding: 10px;
		}

		#ubutton {

			width: 24px;
		}
	</style>
	<script>
		$(document).ready(function () {
			$('.summernote').summernote({
				placeholder: 'content',
				minHeight: 370,
				maxHeight: null,
				focus: true,
				lang: 'ko-KR'
			});
		});
		function OpenModal(lqa_no) {
			var OpenModal = document.querySelector(".background" + lqa_no);
			OpenModal.classList.add("show");
		}

		function CloseModal(lqa_no) {
			var CloseModal = document.querySelector(".background" + lqa_no);
			CloseModal.classList.remove("show");
		}

		function CloseNOpen(close, open) {

			var CloseModal = document.querySelector(".background" + close);
			var OpenModal = document.querySelector(".background" + open);
			OpenModal.classList.add("show");
			CloseModal.classList.remove("show");
		}

		function edit(vq_no) {
			var vq_title = $('input[name=' + vq_no + 'vq_title]').val();
			var vq_content = $('#'+ vq_no +'vq_content').summernote('code');

			alert(vq_no);
			alert(vq_title);
			alert('#'+ vq_no +'vq_content');
			$.ajax({

				type: "post",
				url: "/web/LectureVideoQnaEdit.do?vq_no=" + vq_no,
				data: {
					vq_title: vq_title,
					vq_content: vq_content
				},
				error: function () {
					alert('머선 일이고');
				}
			}).done(function (result) {
				if (result == 1) {
					alert('질문 수정이 완료되었습니다');
				} else if (result == 0) {

					alert('수정 권한이 없습니다.');
				} else if (result == 3) {

					alert('답변이 달린 질문은 수정할 수 없습니다.');
				} else {

					alert('이상한짓 하지 마세요');
				}
				window.location.reload();
			});
		}

		function remove(vq_no) {
			if (confirm("질문을 삭제하시겠습니까?")) {
				$.ajax({

					type: "post",
					url: "/web/LectureVideoQnaRemove.do?vq_no=" + vq_no,
					error: function () {
						alert('머선 일이고');
					}
				}).done(function (result) {
					if (result == 1) {
						alert('질문이 삭제되었습니다');
					} else if (result == 0) {
						alert('삭제 권한이 없습니다.');
					}

					window.location.reload();
				});
			}
		}
	</script>
</head>

<body>
	<div class="dropdown">
		<button class="dropbtn">
			<span class="dropbtn_icon">=</span>
		</button>
		<div class="dropdown-content">
			<a onclick="javascript:history.back()">뒤로가기</a>
			<a onclick="OpenModal('qnas')">질문목록</a>
			<a onclick="OpenModal('List')">강의목록</a>
			<a onclick="location.href = './'">홈으로</a>
		</div>
	</div>
	<div id="video">
		<iframe src="https://www.youtube.com/embed/${Video.v_root}" title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
			allowfullscreen></iframe>
	</div>
	<div class="container">
		<div class="background backgroundqnas">
			<div class="window">
				<div class="popup">
					<button id="closebtn" onclick="CloseModal('qnas');">닫기</button>
					<table class="table table-hover" style="overflow-y: auto;">
						<c:forEach items="${VideoQnas}" var="i">
							<c:set var="title" value="${i.vq_title}" />
							<c:set var="content" value="${i.vq_content}" />
							<tr onclick="CloseNOpen('qnas', '${i.vq_no}')">
								<td style="width: 30%;">
									<c:choose>
										<c:when test="${fn:length(title) > 20}">
											${fn:substring(title, 0 , 17)}...
										</c:when>
										<c:otherwise>
											${i.vq_title}
										</c:otherwise>
									</c:choose>
								</td>
								<td style="width: 50%;">
									<c:choose>
										<c:when test="${fn:length(content) > 40}">
											${fn:substring(content, 0 , 37)}...
										</c:when>
										<c:otherwise>
											${i.vq_content}
										</c:otherwise>
									</c:choose>
								</td>
								<td style="width: 20%;">${i.vq_date}</td>
							</tr>
						</c:forEach>
					</table>
					<div class="col-12">
						<c:choose>
							<c:when test="${Video.pay_whether eq 1}">
								<button class="btn btn-primary w-100 py-3" type="button" style="position: fixed;"
									onclick="CloseNOpen('qnas', 'Write')">질문작성하러가기</button>
							</c:when>
							<c:when test="${Video.pay_whether eq 0 && sessionScope.u_id ne null}">
								<button class="btn btn-primary w-100 py-3" type="button" style="position: fixed;"
									onclick="location.href = './Pay?l_code=${Video.l_code}'">질문작성하러가기</button>
							</c:when>
							<c:otherwise>
								<button class="btn btn-primary w-100 py-3" type="button" style="position: fixed;"
									onclick="location.href = '/web/login'">로그인</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="background backgroundWrite">
			<div class="window">
				<div class="popup">
					<button id="closebtn" onclick="CloseNOpen('Write', 'qnas');">돌아가기</button>
					<form action="./LectureVideoQnaWrite.do?v_no=${Video.v_no}" method="post">
						<div class="row g-3">
							<div class="col-md-6">
								<div class="form-floating">
									<input type="text" class="form-control" id="name" name="vq_title"
										placeholder="리뷰 제목">
								</div>
							</div>
							<textarea class="summernote" id="message" name="vq_content"
								style="height: 150px; resize: none; z-index: 1100;"></textarea>
						</div>
						<div class="col-12">
							<button class="btn btn-primary w-100 py-3" type="submit">제출</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="background backgroundList">
			<div class="window">
				<div class="popup">
					<button id="closebtn" onclick="CloseModal('List');">닫기</button>
					<table class="table table-hover" style="overflow-y: auto;">
						<tbody>
							<c:forEach items="${LectureVideos}" var="Map">
								<c:set var="key" value="${Map.key}" />
								<tr>
									<td>[${Map.key}강] ${Map.value.v_videotitle}</td>
									<td><a class="btn btn-outline-light"
											style="background-color: rgba(55, 110, 92, 0.781);"
											href="./LectureVideo?v_no=${Map.value.v_no}">듣기</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<c:forEach items="${VideoQnas}" var="i">
			<c:if test="${sessionScope.u_id eq i.u_id}">
				<div class="background backgroundEdit${i.vq_no}">
					<div class="window">
						<div class="popup">
							<button id="closebtn" onclick="CloseNOpen('Edit${i.vq_no}', '${i.vq_no}');">돌아가기</button>
							<div class="row g-3">
								<div class="col-md-6">
									<div class="form-floating">
										<input type="text" class="form-control" id="name" name="${i.vq_no}vq_title"
											placeholder="리뷰 제목" value="${i.vq_title}">
									</div>
								</div>
								<textarea class="summernote" id="${i.vq_no}vq_content"
									style="height: 150px; resize: none; z-index: 1100;">${i.vq_content}</textarea>
							</div>
							<div class="col-12">
								<button class="btn btn-primary w-100 py-3" type="button" onclick="edit('${i.vq_no}')">질문 수정하기</button>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<div class="background background${i.vq_no}">
				<div class="window">
					<div class="popup">
						<button id="closebtn" onclick="CloseNOpen('${i.vq_no}', 'qnas');">뒤로가기</button>
						<h2 class="card-title">질문</h2>
						<c:if test="${sessionScope.u_id eq i.u_id}">
							<img id="ubutton" src="./resources/img/Uremove.png" onclick="remove('${i.vq_no}')">
							<c:if test="${i.vq_confirm eq 0}">
								<img id="ubutton" src="./resources/img/Uedit.png"
									onclick="CloseNOpen('${i.vq_no}', 'Edit${i.vq_no}')">
							</c:if>
						</c:if>
						<h6 style="color: black;">${i.u_nickname}</h6>
						<h6>제목 : </h6>${i.vq_title}<br>
						<h6>내용 : </h6>${i.vq_content}<br><br>
						<h2 class="card-title">답변</h2>
						<h6 style="color: black;">${i_t_nickname}</h6>
						<h6>제목 : </h6>${i.vqr_title}<br>
						<h6>내용 : </h6>${i.vqr_content}
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>

</html>