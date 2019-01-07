

<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<nav class="top ">
	<a href="/forehome">
		<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>地狗首页
	</a>

	<span>欢迎来到地狗</span>

	<c:if test="${!empty user}">
		<a href="">${user.name}</a>
		<a href="personalCenter" >个人中心</a>
		<a href="forelogout">退出</a>

	</c:if>

	<c:if test="${empty user}">
		<a href="loginPage">请登录</a>
		<a href="registerPage">免费注册</a>
		<a href="adminloginPage">我是管理</a>
	</c:if>








	<span style="color: black; margin-left: 250px">地狗云持续为您护航！走你</span>

	<span class="pull-right">
		<c:if test="${!empty user}">
			<a href="shouCangPage">我的收藏</a>
			<a href="keFuPage">我的客服</a>
		</c:if>
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>${cartTotalItemNumber}</strong>件</a>
		</span>




</nav>



