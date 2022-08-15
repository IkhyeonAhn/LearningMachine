<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>Learning Machine:강사 페이지</title>
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

	<!-- Template Javascript -->
	<script src="./resources/js/main.js"></script>
	<style type="text/css">
		< style>@font-face {
			font-family: 'LeferiPoint-WhiteObliqueA';
			src:
				url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiPoint-WhiteObliqueA.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}

		body {
			font-family: LeferiPoint-WhiteObliqueA;
		}

		details {
			border-bottom: 1px solid #efefef;
			color: #666;
			font-size: 16px;
			padding: 15px;
		}

		details[open] summary {
			font-weight: 800;
		}

		details>summary {
			color: white;
			font-size: 17px;
			padding: 15px 0;
		}

		ul.tabs {
			margin: 0px;
			padding: 0px;
			list-style: none;
		}

		ul.tabs li {
			background: none;
			color: #222;
			display: inline-block;
			padding: 10px 25px;
			cursor: pointer;
		}

		ul.tabs li.current {
			background: #ededed;
			color: #222;
		}

		.tab-content {
			display: none;
		}

		.tab-content.current {
			display: flex;
		}

		#teacher {
			font-weight: 300px;
		}

		#content {
			width: 80%;
			height: 100%;
			border: 1px solid rgb(102, 202, 152);
			border-radius: 10px;
			display: inline-block;
		}

		.col-sm-6.col-md-4 {
			text-align: center;
			margin-bottom: 10px;
		}

		#category {

			border: 1px solid rgb(201, 236, 219);
			border-radius: 10px;
			width: 80%;
			height: 30px;
			background-color: rgb(201, 236, 219);
			text-align: center;
			margin: 0 auto;
		}

		.caption {
			text-align: center;
		}

		#paydone {
			background-color: paleturquoise;
		}

		#wish {
			color: rgba(0, 0, 0, 0.699);
			background-color: rgb(236, 161, 161);
			border: 0;
			outline: 0;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function () {

			$('ul.tabs li').click(function () {
				var tab_id = $(this).attr('data-tab');

				$('ul.tabs li').removeClass('current');
				$('.tab-content').removeClass('current');

				$(this).addClass('current');
				$("#" + tab_id).addClass('current');
			})

		});

		function WishAdd(l_code, wish){
			$.ajax({

				type: "post",
				url: "/web/addwish?l_code=" + l_code,
				success: function () {

					window.location.reload();
				},
				error: function () {
					alert('머선 일이고');
				}
			}).done(function (result) {
				if (result == 1 && wish == 0) {
					alert('강의를 찜했습니다');
				} else if(result == 1&& wish == 1){
					alert('찜을 취소했습니다');
				} else if (result == 0) {

					alert('권한이 없습니다.');
					CloseModal('Review');
				}
			});
		}
	</script>
</head>

<body>
	<div class="container-xxl bg-white p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>
		<!-- Spinner End -->


		<jsp:include page="./header.jsp" />
		<div style="padding-top: 115px;">
			<h3>&nbsp;&nbsp;강의목록</h3>
			<hr style="border: solid 1px;">
		</div>
		<div>
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">인기 강의</li>
				<li class="tab-link" data-tab="tab-2">최신 강의</li>
			</ul>
		</div>
		<div style="padding-top: 20px; text-align: center;">
			<div class="row tab-content current" id="tab-1">
				<c:forEach items="${PopularList }" var="i">
					<div class="col-sm-6 col-md-4">
						<div id="content">
							<div class="thumbnail">
								<c:choose>
									<c:when test="${i.l_thumbnail eq null}">
										<img src="./img/leaf.png" alt="" onclick="location.href = './LectureDetail?l_code=${i.l_code}';" height="150px">
									</c:when>
									<c:otherwise>
										<img src="${i.l_thumbnail}" alt=""
									onclick="location.href = './LectureDetail?l_code=${i.l_code}';" height="150px">
									</c:otherwise>
								</c:choose>
								<div class="caption">
									<h3>
										<a href="./LectureDetail?l_code=${i.l_code}">
											<c:choose>
												<c:when test="${fn:length(i.l_name) > 12}">
													<c:out value="${fn:substring(i.l_name,0, 12)}.."/>
												</c:when>
												<c:otherwise>
													<c:out value="${i.l_name}"/>
												</c:otherwise>
											</c:choose>
										</a>
									</h3>
									<p id="category">${i.l_category }</p>
									<p id="teacher">${i.t_nickname}</p>
									<strong style="color: red;">${i.l_price}원</strong>
									<p>
										<strong style="color: rgb(50, 50, 155);">${i.grade_avg}점</strong><small>(${i.total_register}명 수강)</small>
									</p>
									<p>
										<c:if test = "${i.payment_whether eq 1}">
											<a href="./LectureDetail?l_code=${i.l_code }" class="btn btn-default"
											role="button">결제완료</a>
										</c:if>
										<c:if test = "${i.payment_whether eq 0}">
											<a href="./LectureDetail?l_code=${i.l_code }" class="btn btn-primary"
											role="button">이동하기</a>
										</c:if>
										<c:choose>
											<c:when test="${i.payment_whether eq 0 && sessionScope.u_id ne null}">
												<c:choose>
													<c:when test = "${i.wish eq 0}">
														<img src="./resources/img/empty_heart.png" onclick="WishAdd('${i.l_code}', '${i.wish}')">
													</c:when>
													<c:otherwise>
														<img src="./resources/img/heart.png" onclick="WishAdd('${i.l_code}', '${i.wish}')">
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${i.payment_whether eq 0 && sessionScope.u_id eq null}">
												<img src="./resources/img/empty_heart.png" onclick="location.href = './login'">
											</c:when>
										</c:choose>
									</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row tab-content" id="tab-2">
				<c:forEach items="${RecentList }" var="i">
					<div class="col-sm-6 col-md-4">
						<div id="content">
							<div class="thumbnail">
								<c:choose>
									<c:when test="${i.l_thumbnail eq null}">
										<img src="./img/leaf.png" alt="" onclick="location.href = './LectureDetail?l_code=${i.l_code}';" height="150px">
									</c:when>
									<c:otherwise>
										<img src="${i.l_thumbnail}" alt=""
									onclick="location.href = './LectureDetail?l_code=${i.l_code}';" height="150px">
									</c:otherwise>
								</c:choose>
								<div class="caption">
									<h3>
										<a href="./LectureDetail?l_code=${i.l_code}"> <c:choose>
												<c:when test="${fn:length(i.l_name) > 12}">
													<c:out value="${fn:substring(i.l_name,0, 12)}.." />
												</c:when>
												<c:otherwise>
													<c:out value="${i.l_name}" />
												</c:otherwise>
											</c:choose>
										</a>
									</h3>
									<p id="category">${i.l_category }</p>
									<p id="teacher">${i.t_nickname}</p>
									<strong style="color: red;">${i.l_price}원</strong>
									<p>
										<strong style="color: rgb(50, 50, 155);">${i.grade_avg}점</strong><small>(${i.total_register}명
											수강)</small>
									</p>
									<p>
										<c:if test="${i.payment_whether eq 1}">
											<a href="./LectureDetail?l_code=${i.l_code }"
												class="btn btn-default" role="button">결제완료</a>
										</c:if>
										<c:if test="${i.payment_whether eq 0}">
											<a href="./LectureDetail?l_code=${i.l_code }"
												class="btn btn-primary" role="button">이동하기</a>
										</c:if>
										<c:choose>
											<c:when
												test="${i.payment_whether eq 0 && sessionScope.u_id ne null}">
												<c:choose>
													<c:when test="${i.wish eq 0}">
														<img src="./resources/img/empty_heart.png"
															onclick="WishAdd('${i.l_code}', '${i.wish}')">
													</c:when>
													<c:otherwise>
														<img src="./resources/img/heart.png"
															onclick="WishAdd('${i.l_code}', '${i.wish}')">
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when
												test="${i.payment_whether eq 0 && sessionScope.u_id eq null}">
												<img src="./resources/img/empty_heart.png"
													onclick="location.href = './login'">
											</c:when>
										</c:choose>
									</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<%-- <jsp:include page="./team.jsp" /> --%>
	<jsp:include page="./footer.jsp" />


	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
	<script type="text/javascript">
		$('body > ul > li').click(function () {
			if ($(this).hasClass('active')) {
				$(this).find(' > ul').stop().slideUp(300);
				$(this).removeClass('active');
			} else {
				$(this).find(' > ul').stop().slideDown(300);
				$(this).addClass('active');
			}
		});
	</script>
</body>

</html>