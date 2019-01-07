<%--
  Created by IntelliJ IDEA.
  User: panpan
  Date: 18-10-30
  Time: 下午10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>





<!DOCTYPE html>







<html>

<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/fore/style.css" rel="stylesheet">

</head>

<body>






<nav class="top ">
    <a href="/forehome">
        <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>地狗首页
    </a>

    <span>欢迎来到地狗</span>

    <c:if test="${!empty user}">
        <a href="loginPage">${user.name}</a>
        <a href="forelogout">退出</a>
    </c:if>

    <c:if test="${empty user}">

        <a href="loginPage">请登录</a>
        <a href="registerPage">免费注册</a>
        <%--<a href="adminloginPage">我是管理</a>--%>
    </c:if>
    <span style="color: black; margin-left: 250px">地狗云持续为您护航！走你</span>

    <span class="pull-right">
		<c:if test="${!empty user}">
            <a href="shouCangPage">我的收藏</a>
        </c:if>
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>${cartTotalItemNumber}</strong>件</a>
		</span>
</nav>

<div >
    <a href="">
        <img id="simpleLogo" class="simpleLogo" src="img/site/simpleLogo.png">
    </a>

    <form action="foresearch" method="post" >
        <div class=" pull-right">
           <p>
<hr>
           </p>
            <p>
            <hr>
            </p>
            <p>
            <hr>
            </p>
            <p>
            <hr>
            </p>
            <p>
            <hr>
            </p>

            </p>

            <div class="searchBelow">
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>

<div class="payedDiv">
    <div class="payedTextDiv">
        <img src="img/site/paySuccess.png">
        <span>您已成功收藏</span>

    </div>

</div>


<div class="payedDiv">
    <div class="payedTextDiv">
      <center>
        <a href="shouCangPage"> <span>显示我的收藏</span></a>
      </center>
    </div>
</div>



</div>

<div id="footer"  class="footer" style="display: block;">
    <div id="footer_ensure" class="footer_ensure">
        <a href="#nowhere">
        </a>
    </div>
    <div class="horizontal_line">
    </div>
    <div id="footer_desc" class="footer_desc">
        <div class="descColumn"　>
        </div>

    </div>

    <div style="clear:both">
        <p><hr></p>
        <p><hr></p><p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>

        </p><p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>
        <p>
        <hr>
        </p>

        </p>
        </p>
    </div>




    <div id="copyright" class="copyright">
        <div class="coptyrightMiddle">
            <img id="cateye" class="cateye" src="img/site/cateye.png">











            <div class="white_link" >
                <a href="#nowhere"  style="padding-left:0px" > 山科大　计算机１５３　ｗｅｂ开发小组集团</a><span class="slash">|</span>
                <a href="#nowhere" > 最强底狗</a><span class="slash">|</span>

                <a href="#nowhere" >  最强底狗	</a><span class="slash">|</span>
                <a href="#nowhere" >  最强底狗	</a><span class="slash">|</span>
                <a href="#nowhere" >  最强底狗	</a><span class="slash">|</span>
                <a href="#nowhere" >  最强底狗	</a><span class="slash">|</span>
                <a href="#nowhere" >  最强底狗 		</a>
            </div>












        </div>
    </div>
</div>
</body>
</html>
