<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<style>
	.home p{
		margin: 15px;
		text-align: center;
		color: gray;
		font-weight: bold;
	}

	.studyzoneborder{
		width: 400px;
		height: 400px;
		border: 1px;
		border-style:double;
		border-radius: 10px;
		margin-top: -600px;
		margin-left: 95px;
		background-color: white;
	}
	.studyzonebox{
		background-color: #8D7B68;
		width: 800px;
		height: 800px;
		overflow: hidden;
		position: relative;

	}
	.studyzonebox2{
		background-color: #8D7B68;
		width: 72%;
		height: 800px;
		overflow: hidden;
		position: absolute;
		z-index: 9;
	}

	.swiper-slide {
		background-size: cover; /* 이미지를 화면에 맞게 조절 */
		background-repeat: no-repeat; /* 배경 이미지 반복 제거 */
		background-position: center; /* 배경 이미지 중앙 정렬 */
		height: 100vh; /* 화면 높이의 100%로 설정하여 화면을 꽉 채우도록 함 */
		position: relative; /* position을 relative로 설정 */

	}

	.imgtext{
		color: white;
		font-size: 40px;
		margin-top: 590px;
		margin-left: 60px;
	}
	.imgtext > p{
		font-size: 60px;
		text-align: left;
		color: white;
		position: relative;
	}
	/* 스와이퍼 pagination 스타일 */
	.swiper-pagination {
		text-align: center;
		position: absolute;
		bottom: 70px !important; /* !important로 속성 강제 적용 */
		left: 50%;
		transform: translateX(-41%);
		margin-left: 90px;
	}
	.swiper-pagination2{
		text-align: center;
		position: absolute;
		bottom: -650px !important; /* !important로 속성 강제 적용 */
		left: 50%;
		transform: translateX(-41%);
		margin-left: 320px;
		color: azure;
		z-index: 55;
	}

	.swiper-horizontal>.swiper-pagination-bullets, .swiper-pagination-bullets.swiper-pagination-horizontal, .swiper-pagination-custom, .swiper-pagination-fraction {
		width: 1249px;
	}
	.swiper-button-next{
		text-align: center;
		position: absolute;
		bottom: -650px !important; /* !important로 속성 강제 적용 */
		left: 50%;
		transform: translateX(31%);
		margin-left: -90px;
		margin-top: 1150px;
		color: #8D7B68;
		z-index: 55;
		background-image: url('${path}/images/Navigatenext.png'); /* 이미지 파일의 경로를 설정하세요 */
		background-size: cover; /* 이미지를 버튼 크기에 맞게 조절 */
		width: 60px; /* 버튼의 너비 설정 */
		height: 60px; /* 버튼의 높이 설정 */



	}
	.swiper-button-prev{
		text-align: center;
		position: absolute;
		bottom: -650px !important; /* !important로 속성 강제 적용 */
		left: 50%;
		transform: translateX(31%);
		margin-left: -170px;
		margin-top: 1150px;
		color: #8D7B68;
		z-index: 55;
		background-image: url('${path}/images/Navigatebefore.png'); /* 이미지 파일의 경로를 설정하세요 */
		background-size: cover; /* 이미지를 버튼 크기에 맞게 조절 */
		width: 60px; /* 버튼의 너비 설정 */
		height: 60px; /* 버튼의 높이 설정 */



	}
	.banner {

		height: 800px;
		overflow: hidden; /* 내용이 부모 요소를 벗어나지 않도록 설정 */
	}


	.swiper-pagination .swiper-pagination-bullet {
		width: 120px;
		height: 6px;
		background-color: white;
		margin: 0 50px;
		cursor: pointer;
		display: inline-block;
		text-align: left;
		border-radius: 0;
		color: transparent;
	}

	.swiper-pagination2 .swiper-pagination-bullet {
		width: 80px;
		height: 6px;
		background-color: white;
		margin: 0 50px;
		cursor: pointer;
		display: inline-block;
		text-align: left;
		border-radius: 0;
		color: transparent;
	}

	/* bullet 내의 숫자를 숨기는 스타일 */
	.swiper-pagination-bullet::before {
		content: none; /* 내용(content)을 숨김 */
	}

	/* bullet 활성화 상태일 때의 스타일 */
	.swiper-pagination-bullet-active {
		background-color: white; /* 활성화된 bullet의 배경색 */
	}

	/* 테이블 스타일 */
	.home table {
		border-collapse: collapse;
		width: 100%;
		font-size: 18px;
		color: #4a4a4a; /* 텍스트 색상 */
	}

	.home .table-th, .table-td {
		border-bottom: 1px solid #ddd; /* 세로선 추가 */
		text-align: left;
		padding: 16px;
	}

	.home .table-th {
		font-size: 28px;
		color:black;/* 제목 글자색 */
	}


	.home .table-tr:hover {color:white;}/* 마우스 오버시 배경과 글자 색상 변경 */

	/* 최신소식 */
	.latestnews h5 {
		margin: 20px 0px 15px 30px;
		text-align: left;
	}

	.latestnews img {
		width: 600px;
		height: 300px;
	}

	.image-container img {
		width: 100%;
		object-fit: cover;
		transition: transform 0.3s ease;
	}

	.image-container img:hover {
		transform: scale(1.2); /* 이미지 크기를 1.2배 확대 */
	}

	/* 두번째 슬라이더 */
	.swiper-container.bannerSlider {
		width: 1400px
	}
</style>

<jsp:include page="common/header.jsp"/>

<sction id="home-section">
	<div class="home" style="justify-content: center; display: flex;">
		<div style="width: 100%;  justify-content: center; display: flex;">
			<div style="width: 100%">
				<div style="justify-content: center; display: flex;">
					<div class="swiper">
						<div class="swiper mySwiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide" style="background-image: url('${path}/images/mainbanner1.png'); background-size: cover;">
									<div class="imgtext">
										<p>Le procope</p>
										<p style="font-size: 40px">프랑스 카페</p>
										<p style="font-size: 15px">'르 프로코프’를 모티브로 한 클래식하고 엔틱한 컨셉의 인테리어는<br>
											엔틱함과 젠틀한 분위기를 잡아주어 집중할 수 있는 최적의 공간을 제공합니다.</p>
									</div>
								</div>
								<div class="swiper-slide" style="background-image: url('${path}/images/mainbanner2.png'); background-size: cover;">
									<div class="imgtext">
										<p>Premium</p>
										<p style="font-size: 40px">고품격 학습 공간</p>
										<p style="font-size: 15px">고풍스러운 컨셉의 인테리어에 눈이 편안한 'Key Color'를 적용해<br>
											더욱더 몰입도 있는 학습이 가능하게 만들어줍니다.</p>
									</div>
								</div>
								<div class="swiper-slide" style="background-image: url('${path}/images/mainbanner3.png'); background-size: cover;">
									<div class="imgtext">
										<p>Intellect</p>
										<p style="font-size: 40px">최초의 복합문화학습공간</p>
										<p style="font-size: 15px">모든 학습자들의 고민 '즐거운 공부방법'<br>
											그 해답을 집중할곳 없스카는 교육공간에 ‘문화’를 더하는 방법으로 해결책을 제시합니다.</p>
									</div>
								</div>
							</div>
							<div class="swiper-pagination"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="mainpage-seat-info" class="home" style="margin-bottom: 50px; width: 100%; justify-content: center; display: flex">
		<div style="margin-left: 175px; overflow-x: hidden; overflow-y: hidden; width: 1280px; height: 800px;">
			<div class="banner">
				<div class="studyzonebox">
					<div class="studyzonebox2">
						<h1 style="margin-left: 50px; margin-top: 350px; color: white; font-weight: 800;font-size: 70px">
							INTERIOR
						</h1>
						<h1 style="margin-left: 50px; color: white; font-weight: 800;font-size: 70px">
							DESIGN
						</h1>
					</div>
				</div>
				<div class="swiper-container bannerSlider"">
				<div class="swiper-wrapper" style="width: 100%; display: flex; position: relative">
					<div class="swiper-slide" >
						<div class="studyzoneborder">
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">일반석(개방형)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<img src="${path}/images/studyzone1.png">
							</a>
							<p>
								개방형 학습 공간으로 <br> 경쟁의식을 느끼며 학습할 수 있는 공간
							</p>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="studyzoneborder">
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">일반석(반밀폐형)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<img src="${path}/images/studyzone2.png">
							</a>
							<p>
								반 밀폐형 학습 공간으로 <br>학습 프라이빗을 보장받는 공간
							</p>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="studyzoneborder">
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">일반석(2인용)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<img src="${path}/images/studyzone3.png">
							</a>
							<p>
								친구, 동료, 연인과 함께 학습할 수 있는 공간
							</p>
						</div>
					</div>
					<div class="swiper-slide">
						<div  class="studyzoneborder">
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">지정석(1인실)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<img src="${path}/images/studyzone4.png">
							</a>
							<p>
								학습에 방해가 될 수 있는 모든 요소를 <br>완벽하게 차단한 완전몰입이 가능한 좌석
							</p>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="studyzoneborder" >
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">스터디룸(4인실)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<div>
									<img src="${path}/images/studyzone5.png">

								</div>
							</a>
							<p>
								화이트보드와 모니터가 구비되어있는 <br>공간으로 그룹스터디에 적합한 공간
							</p>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="studyzoneborder" >
							<h3 style="font-weight: 900; margin-top: 20px; margin-left: 20px;">스터디룸(8인실)</h3>
							<a style="justify-content: center;  display: flex; margin-top: 50px; margin-bottom: 20px;">
								<img src="${path}/images/studyzone6.png">
							</a>
							<p>
								공통된 목표를 갖고 있는 <br>그룹 학습자들을 위한 공간
							</p>
						</div>
					</div>

				</div>


				<div style="position: absolute; top: 480px; width: 100%;">
					<div class="swiper-button-prev" style="position: absolute; top: 0; left: 780px"></div>
					<div class="swiper-button-next" style="position: absolute; top: 0; left: 780px"></div>
					<div class="swiper-pagination2" style="position: absolute; top: 1150px; left: -100px;"></div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div style="justify-content: center; display: flex; margin: 0 auto 150px auto; width: 1240px;">
		<div>
			<h2 style="font-weight: 900; text-align: left;">없스카 최신소식</h2>

			<div class="latestnews" style="padding: 0px 20px; justify-content: center; display: flex">
				<c:if test="${ empty eventlist && empty noticelist }">
					<h3>최근소식이 없습니다.</h3>
				</c:if>

				<!-- 이벤트 페이지 -->
				<c:if test="${not empty eventlist}">
					<div style="width: 100%; overflow: hidden;">
						<c:forEach var="event" items="${eventlist}">
							<a href="${path}/customer/event/detail/${event.no}" style="color: black;">
								<div style="width: 50%; width: 600px; float: left; box-sizing: border-box; padding: 10px;">
									<div style="width: 550px; box-shadow: 5px 5px 10px 0px #dfe0e1; padding-bottom: 20px;
										"
									>
										<c:if test="${not event.content.contains('image')}">
											<div style="width: 100%; object-fit: cover;" class="image-container">
												<div style="overflow: hidden; width: 550px; height: 316px;">
													<img src="${path}/images/logoblack.jpg" />
												</div>

												<h5 style="color: #707070;">
													Event / <fmt:formatDate value="${event.createDate}" pattern='yyyy-MM-dd' />
												</h5>
												<h5>[${event.kind}] ${fn:substring(event.title, 0, 25)}...</h5>
											</div>
										</c:if>
										<c:if test="${event.content.contains('image')}">
											<div style="width: 100%; object-fit: cover;" class="image-container">
												<div style="overflow: hidden">
														${event.content}
												</div>

												<h5 style="color: #707070;">
													Event / <fmt:formatDate value="${event.createDate}" pattern='yyyy-MM-dd' />
												</h5>
												<h5>[${event.kind}] ${fn:substring(event.title, 0, 25)}...</h5>
											</div>
										</c:if>
									</div>
								</div>
							</a>
						</c:forEach>
					</div>
				</c:if>

				<!-- 공지사항 페이지 -->
				<c:if test="${not empty noticelist }">
					<div style="width: 100%; overflow: hidden;">
						<c:forEach var="notice" items="${noticelist}">
							<a href="${path}/customer/notice/detail/${notice.no}" style="color: black;">
								<div style="width: 50%; width: 600px; float: left; box-sizing: border-box; padding: 10px;">
									<div style="width: 550px; box-shadow: 5px 5px 10px 0px #dfe0e1; padding-bottom: 20px;
										"
									>
										<c:if test="${not notice.content.contains('image')}">
											<div style="width: 100%;" class='image-container'>
												<div style="overflow: hidden; width: 550px; height: 316px;">
													<img src="${path}/images/logoblack.jpg" />
												</div>
												<h5 style="color: dimgray;">
													공지사항 / <fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd" />
												</h5>
												<h5>${fn:substring(notice.title, 0, 25)}...</h5>
											</div>
										</c:if>
										<c:if test="${notice.content.contains('image')}">
											<div style="width: 100%;" class='image-container'>
												<div style="overflow: hidden">
														${notice.content}
												</div>
												<h5 style="color: dimgray;">
													공지사항 / <fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd" />
												</h5>
												<h5>${fn:substring(notice.title, 0, 25)}...</h5>
											</div>
										</c:if>
									</div>
								</div>
							</a>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</sction>


<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var swiper1 = new Swiper(".mySwiper1", {
		slidesPerView: 1,
		spaceBetween: 0,
		loop: true,
		centeredSlides: true,
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
			renderBullet: function (index, className) {
				return '<span class="' + className + '">' + (index + 1) + "</span>";
			},
		},

	});

	var swiper2 = new Swiper('.swiper-container.bannerSlider', {
		loop: true, // 무한 루프 설정

		slidesPerView: 3, // 동시에 표시되는 슬라이드 수
		spaceBetween: 50, // 슬라이드 간 간격 (픽셀 단위)
		centeredSlides: true, // 다음 슬라이드를 50%만 표시 (가운데 정렬)
		pagination: {
			el: ".swiper-pagination2",
			clickable: true,
			renderBullet: function (index, className) {
				return '<span class="' + className + '">' + (index + 1) + "</span>";
			},
		},
		navigation: {
			nextEl: ".swiper-button-next",
			prevEl: ".swiper-button-prev",
		},
	});

	// 없스카 최신소식 스크립트
	$(document).ready(function() {
		$(".image-container").each(function() {
			var $container = $(this);
			var $images = $container.find("img");
			var $paragraphs = $container.find("p");

			$images.hide();
			$paragraphs.remove();
			$images.first().show();
			// console.log($images.first().length)
		});
	});
</script>


<jsp:include page="common/footer.jsp"/>