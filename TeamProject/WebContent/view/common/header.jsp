<%--
	author  : 지승훈
	since   : 2017. 4. 20.
	version : 1.0
	subject : 상단 메뉴 헤더
	description :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/header.css">
	<script>
		$(function(){
		  	var pull=$('#pull');
		  	    menu=$('header ul');
		  	    menuHeight=menu.height();
		  	    logo = $('#logo');
		  $(pull).on('click', function(e){
		  	e.preventDefault();
		  	$('#logo').remove();
		  	menu.slideToggle();
		  });
		    $(window).resize(function(){
		    	var w=$(window).width();
		    	if(w>600 && menu.is(':hidden')){
		    		menu.removeAttr('style');
		    		$('header ul').prepend(logo);
		    	}
		    });
		});
	</script>
	<div class="loginCheck">
		<a href="${pageContext.servletContext.contextPath}/mypage"><img src="${pageContext.servletContext.contextPath}/resources/image/MyPageLogo.PNG"></a>
		<a href="${pageContext.servletContext.contextPath}/mypage"><span>${Employee.empName}님 환영합니다.</span></a>
   	<a href="${pageContext.servletContext.contextPath}/login"><span style="margin-right: 10px">Logout</span></a>
    </div>
	<header class="header_nav">
	    <ul class="header_nav">
	       <li id="logo"><a href="${pageContext.servletContext.contextPath}/reservation/guidance">
	       <img src="${pageContext.servletContext.contextPath}/resources/image/logo.png" style="margin-top: -2px;"></a></li>
	       <li><a href="${pageContext.servletContext.contextPath}/reservation/guidance">예약안내</a></li>
	       <li><a href="${pageContext.servletContext.contextPath}/conferenceinfo?type=CR">회의실예약</a></li>
	       <li><a href="${pageContext.servletContext.contextPath}/conferenceinfo?type=ER">교육실예약</a></li>
	       <c:if test="${Authority eq 'conference'}">
	       		<li><a href="${pageContext.servletContext.contextPath}/conference/approval">회의실 결재목록</a></li>
	       </c:if>
	       <c:if test="${Authority eq 'education'}">
				<li><a href="${pageContext.servletContext.contextPath}/education/approval">교육실 결재목록</a></li>
	       </c:if>
	       <c:if test="${Authority eq 'system'}">
		   	<li><a href="${pageContext.servletContext.contextPath}/conference/manageaction">회의실 관리</a></li>
				<li><a href="${pageContext.servletContext.contextPath}/education/manageaction">교육실 관리</a></li>
				<li><a href="${pageContext.servletContext.contextPath}/provisioning">권한 관리</a></li>
	       </c:if>
	       <c:if test="${Employee.captionDepId ne null}">
		   	<li><a href="${pageContext.servletContext.contextPath}/sign">결재목록</a></li>
	       </c:if>
	    </ul>
	    <a id="pull" href="#"><img src="${pageContext.servletContext.contextPath}/resources/image/logo.png"></a>
	</header>
