<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ page import="com.digou.pojo.User" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ include file="admin_header.jsp" %>

<script>
    $(function () {
        $("button.orderPageCheckOrderItems").click(function () {
            var oid = $(this).attr("oid");
            $("tr.orderPageOrderItemTR[oid=" + oid + "]").toggle();
        });
    });

</script>

<title>订单管理</title>

<style>
    .table {
        padding: 8px;
        line-height: 20px;
        word-break: break-all;
    }

</style>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">订单管理 </ul>

            <dl class="am-icon-home" style="float: right;">
                当前位置：<a href=""> 首页 </a>>
                <a href="#">订单列表</a>
            </dl>

            <dl>

                <a href="admin_showAllOrder.do">
                    <button type="button"
                            class="am-btn am-btn-success am-round am-btn-xs am-icon-plus">
                        更新订单
                    </button>
                </a>
            </dl>
            <!--这里打开的是新页面-->
    </div>
    <form class="am-form am-g" action="" method="post">
        <table width="100%"
               class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
            <tr class="am-success">
                <th><center>订单ID</center></th>
                <th><center>订单者</center></th>
                <th>订单码</th>
                <%--<th width="100px">商品数量</th>--%>
                <%--<th width="100px">买家名称</th>--%>
                <th><center>创建时间</center></th>
                <th><center>支付时间</center></th>
                <th><center>发货时间</center></th>
                <th><center>确认收货时间</center></th>


                <th><center>状态</center></th>
                <th width="10px"><center>操作</center></th>


            </tr>
            </thead>
            <tbody>
                <c:if test="${os!=null}">
                    <c:forEach items="${os}" var="o">
                            <tr>
                                <td><center>
                                    <a href="admin_show_sinle_order?id=${o.id}">

                                            ${o.id}
                                    </a>


                                </center></td>
                                <td><center>${o.receiver}</center></td>


                                <td><center>
                                            ${o.orderCode}
                                </center></td>

                                <td><center><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></center></td>
                                <td><center><fmt:formatDate value="${o.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></center></td>
                                <td><center><fmt:formatDate value="${o.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></center></td>
                                <td><center><fmt:formatDate value="${o.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></center></td>
                                <td><center>${o.statusDesc}</center></td>
                                <td>
                                    <div class="am-btn-toolbar">
                                        <div class="am-btn-group am-btn-group-xs">
                                            <c:if test="${o.statusDesc eq '待发货'}">
                                                <a href="admin_send_Order?id=${o.id}"
                                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="点我发货"><span class="fas fa-igloo"></span>
                                                    <span class="glyphicon glyphicon-send" aria-hidden="true" ></span>
                                                </a>


                                            </c:if>


                                            <c:if test="${o.statusDesc eq '完成'}">
                                                <span
                                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="已发货"><span class=" glyphicon glyphicon-cd" aria-hidden="true" ></span>
                                                </span>

                                                </span>


                                            </c:if>


                                            <c:if test="${o.statusDesc eq '删除'}">

                                                 <span
                                                         class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                         title="已删除"><span class=" glyphicon glyphicon-remove-sign" aria-hidden="true" ></span>
                                                </span>



                                            </c:if>






                                            <c:if test="${o.statusDesc eq '待付款'}">
                                                <span href=""
                                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="代付款"><span class="fas fa-igloo"></span>
                                                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
                                                </span>

                                            </c:if>


                                            <c:if test="${o.statusDesc eq '等评价'}">
                                                <span
                                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="等评价"><span class="fas fa-igloo"></span>
                                                    <span class="glyphicon glyphicon-thumbs-up" aria-hidden="true" ></span>
                                                </span>

                                            </c:if>


                                            <c:if test="${o.statusDesc eq '待收货'}">
                                                <span
                                                        class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                        title="待收货"><span class="glyphicon glyphicon-cd" aria-hidden="true" ></span>
                                                </span>


                                            </c:if>



                                            <c:if test="${o.statusDesc eq '待退货'}">
                                                <a href="yi_tui_huo?oid=${o.id}"
                                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="点我退货"><span class="fas fa-igloo"></span>
                                                    <span class="glyphicon glyphicon-send" aria-hidden="true" ></span>
                                                </a>


                                            </c:if>



                                            <c:if test="${o.statusDesc eq '已退货'}">
                                                <a  class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                                   title="已退货"><span class="fas fa-igloo"></span>
                                                    <span class="glyphicon glyphicon-send" aria-hidden="true" ></span>
                                                </a>


                                            </c:if>



                                        </div>
                                    </div>
                                </td>
                            </tr>


                    </c:forEach>
                </c:if>

            </tbody>





        </table>

        <div class="pageDiv">
            <%@include file="../include/admin/adminPage.jsp"%>
        </div>

			</form>



			<div class=" foods">

                        <%--<p>
                            版权所有@2017 书香味道 <a href="http://www.lvgaopan.com/" target="_blank"
                                              title="书香味道">书香味道</a>

                        </p>--%>

                    </div>
                </div>
</div>
</body>
</html>