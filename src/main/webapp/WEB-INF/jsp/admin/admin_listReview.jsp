<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ include file="admin_header.jsp" %>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">评论管理
        </ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="${pageContext.request.contextPath}/admin/adminindex.jsp"> 首页 </a>>
            <a href="#">评论列表</a>
        </dl>

        <dl>
            <a href="remark-showAllRemark.do">
                <button type="button"
                        class="am-btn am-btn-success am-round am-btn-xs am-icon-plus">
                    查看当前评论
                </button>
            </a>


        </dl>
        <!--这里打开的是新页面-->


    </div>

    <!-- 这里是   显示直接显示窗口  menu-showMenu.do 实际上不需要 这个.do 的的界面 -->
    <!-- 实际上加载 数据 例如  ： 加载 栏目信息  或者说 加载 内容信息的时候  或者  加载首页的时候  我 们是在  监听器中 进行数据初始化操作 的 -->

    <form class="am-form am-g" action="" method="post">
        <table width="100%"
               class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
            <tr class="am-success">
                <th class="table-check"><input type="checkbox"/></th>
                <th class="">评论ID</th>
                <th class="">评论人</th>
                <th class="">评论产品</th>

                <th class="">评论时间</th>
                <th class="">评论内容</th>
                <th width="50px">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${reviewList!=null}">


                <c:forEach items="${reviewList}" var="r">
                <tr>
                    <td><input type="checkbox"/></td>

                    <td>${r.id }</td>
                    <td>${r.uid }</td>
                    <td>${r.pid } </td>

                    <td><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>

                    <td>${r.content }    </td>
                    <td>

                                <a class="label label-warning" href="delete_review?review_id=${r.id }">删除</a>
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


    <div class="foods">
        <p>版权所有@2018 <a href="http://www.lvgaopan.com/" target="_blank" title=""></a>
        </p>
    </div>


</div>

</div>


</div>