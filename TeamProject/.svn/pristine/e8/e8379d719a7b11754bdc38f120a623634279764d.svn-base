<%--
	author  : 지승훈
	since   : 2017. 4. 25.
	version : 1.0
	subject : 페이지 Footer
	description :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<style>
		footer {
			width:100%;
			height:70px;
			position: relative;
			padding-top: 10px;
			left:0;
			bottom: 0;
			border-top:1px solid #f0f0f0;
			background-color: #F5F6FA;
			margin-top: 20px;
		}
		.footer{
			display:block;
			margin:0 auto;
			text-align:center;
		}
		#footerLogo{
			width:100px;
		}
	</style>
	<footer>
	<script type="text/javascript">
		//하단 footer 위치 동적계산
		$(document).ready(function() {
			$('footer').css("top", document.body.scrollHeight-document.body.offsetHeight); 
		});
	</script>
	<div class="footer">
		<img id="footerLogo" src="${pageContext.servletContext.contextPath}/resources/image/logo_footer.png">
		<div>
			<span>COPYRIGHT ⓒ 2017 GS ITM CO, LTD ALL RIGHT RESERVED. | TEL 02-2189-6700</span>
		</div>
	</div>
	</footer>
