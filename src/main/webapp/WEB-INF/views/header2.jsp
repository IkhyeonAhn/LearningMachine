<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
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
<c:choose>
	<c:when test="${sessionScope.u_authority > 3 || sessionScope.u_authority eq null}">
		<div class="container-xxl bg-primary hero-header">
			<div class="container">
				<div class="row g-5 align-items-center">
					<div class="col-lg-6 text-center text-lg-start">
						<h1 class="text-white mb-4 animated zoomIn">Learning Machine</h1>
						<p class="text-white pb-3 animated zoomIn">마케팅보다는 좋은 콘텐츠에 집중합니다.<br> 좋지 않은 콘텐츠라도 홍보와 포장을 통해 이윤을
							남길 수 있지만,<br><strong><I> 우리는 콘텐츠에 집중합니다.</I></strong> <br> 좋은 콘텐츠를 통해 자연스럽게 알려지고, 소개하게 되어 모두
							함께 성장하는 공간을 만들겠습니다.</p>
						<a href="./LectureList"
							class="btn btn-outline-light rounded-pill border-2 py-3 px-5 animated slideInRight">강의
							살펴보기</a>
					</div>
					<div class="col-lg-6 text-center text-lg-start">
						<img class="img-fluid animated zoomIn" src="img/hero.png" alt="">
					</div>
				</div>
			</div>
		</div>

		</html>
	</c:when>
	<c:otherwise>
		<div class="container-xxl py-6">
			<div class="container" id="user_main">
				<div class="row g-5">
					<div class="col-lg-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="d-inline-block border rounded-pill text-primary px-4 mb-3"
							onclick="location.href = './myLecture'">내 강의 ▶</div>
						<table class="table" style="text-align: center;">
							<c:choose>
								<c:when test="${fn:length(RegistedLecture) eq 0}">
									<thead\>
										<tr>
											<th>수강하는 강의가 없어요</th>
											<c:forEach var="i" begin="0" end="${3 - fn:length(RegistedLecture)}">
										<tr>
											<td> .</td>
										</tr>
										</c:forEach>
										</tr>
										</thead>
								</c:when>
								<c:when test="${fn:length(RegistedLecture) >= 5}">
									<tbody>
										<c:forEach items="${RegistedLecture}" var="i" begin="0" end="4">
											<tr>
												<th scope="row"><a
														href="./LectureDetail?l_code=${i.l_code}">${i.l_name}</a></th>
												<td>${i.t_nickname}</td>
												<td><small>출석률 : ${i.attendance_rate}%</small></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${RegistedLecture}" var="i">
											<tr>
												<th scope="row"><a
														href="./LectureDetail?l_code=${i.l_code}">${i.l_name}</a></th>
												<td>${i.t_nickname}</td>
												<td><small>출석률 : ${i.attendance_rate}%</small></td>
											</tr>
										</c:forEach>
										<c:forEach var="i" begin="0" end="${4 - fn:length(RegistedLecture)}">
											<tr>
												<td colspan="3"> .</td>
												<td></td>
												<td></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="col-lg-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="d-inline-block border rounded-pill text-primary px-4 mb-3"
							onclick="OpenModal('RecentVideo')">최근들은
							강의 ▶</div>
						<div class="background backgroundRecentVideo">
							<div class="window">
								<div class="popup">
									<a class="btn btn-outline-light" style="color: black; margin : 4px;" id="closebtn"
										onclick="CloseModal('RecentVideo');">닫기</a>
									<h2>최근에 들은 강의</h2>
									<table class="table" style="text-align: center;">
										<c:forEach items="${RecentVideo}" var="i">
											<tr>
												<th scope="row"><a
														href="./LectureDetail?l_code=${i.l_code}">${i.l_name}</a></th>
												<td>${i.t_nickname}</td>
												<td><small><a
															href="./LectureVideo?v_no=${i.v_no}">${i.v_videotitle}</a></small>
												</td>
												<td><small>${i.va_date}</small></td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div>
									<div></div>
								</div>
							</div>
						</div>
						<table class="table" style="text-align: center;">
							<c:choose>
								<c:when test="${fn:length(RecentVideo) eq 0}">
									<thead\>
										<tr>
											<th>최근에 들은 강의가 없어요</th>
											<c:forEach var="i" begin="0" end="${3 - fn:length(RecentVideo)}">
										<tr>
											<td> .</td>
										</tr>
										</c:forEach>
										</tr>
										</thead>
								</c:when>
								<c:when test="${fn:length(RecentVideo) >= 5}">
									<tbody>
										<c:forEach items="${RecentVideo}" var="i" begin="0" end="4">
											<tr>
												<th scope="row"><a
														href="./LectureDetail?l_code=${i.l_code}">${i.l_name}</a></th>
												<td>${i.t_nickname}</td>
												<td><small><a
															href="./LectureVideo?v_no=${i.v_no}">${i.v_videotitle}</a></small>
												</td>
												<td><small>${i.va_date}</small></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${RecentVideo}" var="i">
											<tr>
												<th scope="row"><a
														href="./LectureDetail?l_code=${i.l_code}">${i.l_name}</a></th>
												<td>${i.t_nickname}</td>
												<td><small><a
															href="./LectureVideo?v_no=${i.v_no}">${i.v_videotitle}</a></small>
												</td>
												<td><small>${i.va_date}</small></td>
											</tr>
										</c:forEach>
										<c:forEach var="i" begin="0" end="${4 - fn:length(RecentVideo)}">
											<tr>
												<td colspan="4"> .</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="col-lg-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="d-inline-block border rounded-pill text-primary px-4 mb-3"
							onclick="OpenModal('VQ')">내
							질문 ▶</div>
						<div class="background backgroundVQ">
							<div class="window">
								<div class="popup">
									<button id="closebtn" onclick="CloseModal('VQ');">닫기</button>
									<table class="table table-hover" style="overflow-y: auto;">
										<tbody>
											<c:forEach items="${VideoQnas}" var="Map">
												fix. vqlist 출력해주고 모달 열어주기
											</c:forEach> 
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<c:forEach items="${VideoQnas}" var="i">
							<div class="background background${i.vq_no}">
								<div class="window">
									<div class="popup">
										<button id="closebtn" onclick="CloseNOpen('${i.vq_no}', 'VQ');">뒤로가기</button>
										<h2 class="card-title">질문</h2>
										<c:if test="${sessionScope.u_id eq i.u_id}">
											<img id="ubutton" src="./resources/img/Uremove.png"
												onclick="remove('${i.vq_no}')">
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
							<c:if test="${sessionScope.u_id eq i.u_id}">
								<div class="background backgroundEdit${i.vq_no}">
									<div class="window">
										<div class="popup">
											<button id="closebtn"
												onclick="CloseNOpen('Edit${i.vq_no}', '${i.vq_no}');">돌아가기</button>
											<div class="row g-3">
												<div class="col-md-6">
													<div class="form-floating">
														<input type="text" class="form-control" id="name"
															name="${i.vq_no}vq_title" placeholder="리뷰 제목"
															value="${i.vq_title}">
													</div>
												</div>
												<textarea class="summernote" id="${i.vq_no}vq_content"
													style="height: 150px; resize: none; z-index: 1100;">${i.vq_content}</textarea>
											</div>
											<div class="col-12">
												<button class="btn btn-primary w-100 py-3" type="button"
													onclick="edit('${i.vq_no}')">질문 수정하기</button>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<table class="table" style="text-align: center;">
							<c:choose>
								<c:when test="${fn:length(VideoQnas) eq 0}">
									<thead\>
										<tr>
											<th>질문이 없어요</th>
											<c:forEach var="i" begin="0" end="${3 - fn:length(VideoQnas)}">
										<tr>
											<td> .</td>
										</tr>
										</c:forEach>
										</tr>
										</thead>
								</c:when>
								<c:when test="${fn:length(VideoQnas) >= 5}">
									<tbody>
										<c:forEach items="${VideoQnas}" var="i" begin="0" end="4">
											<tr onclick="OpenModal('${i.vq_no}')">
												<th scope="row">${i.l_name}</th>
												<td>${i.vq_title}</td>
												<td><small>${i.vq_date}</small></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${VideoQnas}" var="i">
											<tr onclick="OpenModal('${i.vq_no}')">
												<th scope="row">${i.l_name}</th>
												<td>${i.vq_title}</td>
												<td><small>${i.vq_date}</small></td>
											</tr>
										</c:forEach>
										<c:forEach var="i" begin="0" end="${4 - fn:length(VideoQnas)}">
											<tr>
												<td colspan="3"> .</td>
												<td></td>
												<td></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="col-lg-5 wow fadeInUp" data-wow-delay="0.1s" onclick="location.href = './message'">
						<div class="d-inline-block border rounded-pill text-primary px-4 mb-3">최근 온 쪽지 ▶</div>
						<table class="table" style="text-align: center;">
							<c:choose>
								<c:when test="${fn:length(RecentMessage) eq 0}">
									<thead\>
										<tr>
											<th>최근에 온 쪽지가 없어요</th>
											<c:forEach var="i" begin="0" end="${3 - fn:length(RecentMessage)}">
										<tr>
											<td> .</td>
										</tr>
										</c:forEach>
										</tr>
										</thead>
								</c:when>
								<c:when test="${fn:length(RecentMessage) >= 5}">
									<tbody>
										<c:forEach items="${RecentMessage}" var="i" begin="0" end="4">
											<tr>
												<th scope="row">${i.from_nickname}</th>
												<td>${i.le_content}</td>
												<td><small>${i.le_date}</small></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${RecentMessage}" var="i">
											<tr>
												<th scope="row">${i.from_nickname}</th>
												<td>${i.le_content}</td>
												<td><small>${i.le_date}</small></td>
											</tr>
										</c:forEach>
										<c:forEach var="i" begin="0" end="${4 - fn:length(RecentMessage)}">
											<tr>
												<td colspan="3"> .</td>
												<td></td>
												<td></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>