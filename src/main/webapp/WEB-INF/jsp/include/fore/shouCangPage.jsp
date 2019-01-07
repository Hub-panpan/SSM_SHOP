<%@ page import="com.digou.pojo.Collection" %><%--
  Created by IntelliJ IDEA.
  User: 李莉
  Date: 18-10-29
  Time: 下午11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>


<!DOCTYPE html>


<html>

<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/fore/style.css" rel="stylesheet">
    <script>
        function formatMoney(num) {
            num = num.toString().replace(/$|\,/g, '');
            if (isNaN(num))
                num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num * 100 + 0.50000000001);
            cents = num % 100;
            num = Math.floor(num / 100).toString();
            if (cents < 10)
                cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
                num = num.substring(0, num.length - (4 * i + 3)) + ',' +
                    num.substring(num.length - (4 * i + 3));
            return (((sign) ? '' : '-') + num + '.' + cents);
        }

        function checkEmpty(id, name) {
            var value = $("#" + id).val();
            if (value.length == 0) {

                $("#" + id)[0].focus();
                return false;
            }
            return true;
        }


        $(function () {


            $("a.productDetailTopReviewLink").click(function () {
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            });
            $("a.productReviewTopPartSelectedLink").click(function () {
                $("div.productReviewDiv").hide();
                $("div.productDetailDiv").show();
            });

            $("span.leaveMessageTextareaSpan").hide();
            $("img.leaveMessageImg").click(function () {

                $(this).hide();
                $("span.leaveMessageTextareaSpan").show();
                $("div.orderItemSumDiv").css("height", "100px");
            });

            $("div#footer a[href$=#nowhere]").click(function () {
                alert("模仿地狗的连接，并没有跳转到实际的页面");
            });


            $("a.wangwanglink").click(function () {
                alert("模仿旺旺的图标，并不会打开旺旺");
            });
            $("a.notImplementLink").click(function () {
                alert("这个功能没做，蛤蛤~");
            });


        });

    </script>
</head>

<body>


<nav class="top ">
    <a href="/forehome">
        <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
        地狗首页
    </a>

    <span>欢迎来地狗</span>


    <a href="loginPage">${user.name}</a>
    <a href="forelogout">退出</a>


    <span class="pull-right">

			<a href="shouCangPage">我的收藏</a>
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>${cartTotalItemNumber}</strong>件</a>
    </span>


</nav>


<div>
    <a href="">
        <img id="simpleLogo" class="simpleLogo" src="img/site/simpleLogo.png">
    </a>

    <form action="foresearch" method="post">
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="我的宝" value="" name="keyword">
            <button class="searchButton" type="submit">查收藏</button>
            <div class="searchBelow">


            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>




<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">亲　您的所有收藏</a></div>

    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">

            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="100px"></td>
                <td width="100px"></td>
            </tr>
        </table>

    </div>

    <div class="orderListItem">
        <%
            int size=-1;
        %>
        <table class="orderListItemTable" orderStatus="waitPay" oid="57">
            <c:forEach items="${collectionList}" var="co" varStatus="cost">
                <c:forEach items="${shoucangPd}" var="p" varStatus="st">
                    <c:if test="${p.id==co.pid}">
                        <tr class="orderListItemFirstTR">
                            <td colspan="2">

                            <%--<span>收藏时间:   <b>2018-10- 14:17:41</b>--%>
                            <%--</span>--%>
                            </td>
                            <td colspan="2"><img width="13px" src="img/site/orderItemTmall.png">地狗商场</td>
                            <td colspan="1">
                                    <%--<a class="wangwanglink" href="#nowhere">--%>
                                    <%--<div class="orderItemWangWangGif"></div>--%>
                                    <%--</a>--%>

                            </td>
                            <td class="orderItemDeleteTD">
                                <a class="deleteOrderLink" oid="57" href="shoucangDelete?id=${co.scid}">
                                    <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                                </a>
                            </td>
                        </tr>

                        <tr class="orderItemProductInfoPartTR">
                            <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${p.imageName}"></td>
                            <td class="orderItemProductInfoPartTD">
                                <div class="orderListItemProductLinkOutDiv">
                                    <a href="foreproduct?pid=90">${p.name}</a>
                                    <div class="orderListItemProductLinkInnerDiv">
                                        <img src="img/site/creditcard.png" title="支持信用卡支付">
                                        <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                        <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                    </div>
                                </div>
                            </td>
                            <td class="orderItemProductInfoPartTD" width="100px">

                            </td>
                            <td valign="top" rowspan="1" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <div class="orderListItemProductPrice">￥${p.promotePrice}</div>
                            </td>
                            <td valign="top" rowspan="1" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                                <span class="orderListItemNumber">1</span>
                            </td>
                            <td valign="top" rowspan="1" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">


                                <a href="foreproduct?pid=${p.id}">
                                    <button class="orderListItemConfirm">再次查看</button>
                                </a>


                            </td>

                        </tr>

                    </c:if>

                </c:forEach>
            </c:forEach>
        </table>

    </div>

</div>


<div class="modal " id="loginModal" tabindex="-1" role="dialog">
    <div class="modal-dialog loginDivInProductPageModalDiv">
        <div class="modal-content">
            <div class="loginDivInProductPage">
                <div class="loginErrorMessageDiv">
                    <div class="alert alert-danger">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                        <span class="errorMessage"></span>
                    </div>
                </div>

                <div class="login_acount_text">账户登录</div>
                <div class="loginInput ">
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-user"></span>
							</span>
                    <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">
                </div>

                <div class="loginInput ">
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-lock"></span>
							</span>
                    <input id="password" name="password" type="password" placeholder="密码" type="text">
                </div>
                <span class="text-danger">不要输入真实的地狗账号密码</span><br><br>
                <div>
                    <a href="#nowhere">忘记登录密码</a>
                    <a href="registerPage" class="pull-right">免费注册</a>
                </div>
                <div style="margin-top:20px">
                    <button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog">
    <div class="modal-dialog deleteConfirmModalDiv">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">确认删除？</h4>
            </div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
            </div>
        </div>
    </div>
</div>
</div>

<div id="footer" class="footer" style="display: block;">

    <div id="footer_ensure" class="footer_ensure">
        <a href="#nowhere">
            <img src="img/site/ensure.png">
        </a>
    </div>

    <div class="horizontal_line">
    </div>



    <div style="clear:both">

    </div>


    <div id="copyright" class="copyright">
        <div class="coptyrightMiddle">
            <img id="cateye" class="cateye" src="img/site/cateye.png">


            <div class="white_link">
                <a href="#nowhere" style="padding-left:0px"> 山科大　计算机１５３　ｗｅｂ开发小组集团</a><span class="slash">|</span>
                <a href="#nowhere"> 最强底狗</a><span class="slash">|</span>

                <a href="#nowhere"> 最强底狗 </a><span class="slash">|</span>
                <a href="#nowhere"> 最强底狗 </a><span class="slash">|</span>
                <a href="#nowhere"> 最强底狗 </a><span class="slash">|</span>
                <a href="#nowhere"> 最强底狗 </a><span class="slash">|</span>
                <a href="#nowhere"> 最强底狗 </a>
            </div>


        </div>
    </div>
</div>
</body>

</html>
