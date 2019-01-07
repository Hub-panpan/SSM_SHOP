<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%--<%@ page import="Member" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>


<title>显示订单详情</title>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">订单管理
        </ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="${pageContext.request.contextPath}/admin/adminindex.jsp"> 首页 </a>>
            <a href="#">订单详情</a>
        </dl>




    </div>

    <!-- 这里是   显示会员的界面 -->

    <div class="container theme-showcase" role="main">
        <div class="row row-self page-container">
            <div class="col-md-4 col-md-offset-2">
                <div class="page-header">

                    <h2>订单详情</h2>
                </div>


                <c:if test="${single_order!=null}">

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">订单id</h3>
                            </div>
                            <div class="panel-body">
                                    ${single_order.id}
                            </div>


                        </div>


                        <div class="panel panel-default">
                            <div class="panel-heading">订单码</div>
                            <div class="panel-body">
                                    ${single_order.orderCode}
                            </div>
                        </div>



                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">用户地址</h3>
                            </div>
                            <div class="panel-body">
                                    ${single_order.address}
                            </div>
                        </div>



                        <div class="panel panel-default">
                            <div class="panel-heading">用户手机号</div>
                            <div class="panel-body">
                                    ${single_order.mobile}
                            </div>
                        </div>


                        <div class="panel panel-default">
                            <div class="panel-heading">收货人</div>
                            <div class="panel-body">
                                    ${single_order.receiver}
                            </div>
                        </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">留言</div>
                        <div class="panel-body">
                                ${single_order.userMessage}
                        </div>
                    </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">创建订单</div>
                            <div class="panel-body">

                              <fmt:formatDate value="${single_order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                            </div>
                        </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">付款时间</div>
                        <div class="panel-body">
                            <fmt:formatDate value="${single_order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">确认时间</div>
                        <div class="panel-body">
                            <fmt:formatDate value="${single_order.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">状态</div>
                        <div class="panel-body">
                                ${single_order.status}
                                ${single_order.statusDesc}

                        </div>
                    </div>

                    </c:if>


            </div>

        </div>
    </div>



    <div class="foods">

        <p>  <a href="http://www.lvgaopan.com/" target="_blank" title="书香味道">书香味道</a>

        </p>

    </div>



</div>

</div>


</div>

</div>


</div>

<!--[if lt IE 9]>
<script src="../js/jquery.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/polyfill/rem.min.js"></script>
<script src="assets/js/polyfill/respond.min.js"></script>
<script src="assets/js/amazeui.legacy.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/admin/assets/js/amazeui.min.js"></script>
<!--<![endif]-->


</body>
</html>