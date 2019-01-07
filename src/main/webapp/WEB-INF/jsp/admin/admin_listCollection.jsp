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
        <ul class="am-icon-users">收藏管理
        </ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="${pageContext.request.contextPath}/admin/adminindex.jsp"> 首页 </a>>
            <a href="#">收藏列表</a>
        </dl>

        <dl>
            <a href="remark-showAllRemark.do">
                <button type="button"
                        class="am-btn am-btn-success am-round am-btn-xs am-icon-plus">
                    查看当前收藏
                </button>
            </a>


        </dl>
        <!--这里打开的是新页面-->


    </div>

    <!-- 这里是   显示直接显示窗口  menu-showMenu.do 实际上不需要 这个.do 的的界面 -->
    <!-- 实际上加载 数据 例如  ： 加载 栏目信息  或者说 加载 内容信息的时候  或者  加载首页的时候  我 们是在  监听器中 进行数据初始化操作 的 -->




    <div class="boughtDiv">

        <div style="clear:both"></div>
        <div class="orderListTitle">
            <table width="100%"
                   class="am-table am-table-bordered am-table-radius am-table-striped">
                <thead>

                <tr class="am-success">
                    <td>宝贝</td>
                    <td width="100px">单价</td>
                    <td width="100px">数量</td>
                    <td width="100px">库存</td>
                    <td width="100px">创建时间</td>
                </tr>
                </thead>
            </table>

        </div>

        <div class="orderListItem">
            <%
                int size=-1;
            %>
            <table width="100%"                   class="am-table am-table-bordered am-table-radius am-table-striped">

                <c:forEach items="${collecList}" var="co" varStatus="cost">
                    <c:forEach items="${collecList_plist}" var="p" varStatus="st">
                        <c:if test="${p.id==co.pid}">


                            <tr class="orderItemProductInfoPartTR">
                                <td class="orderItemProductInfoPartTD"><img width="80" height="80"
                                                                            src="img/productSingle_middle/${p.imageName}"></td>
                                <td class="orderItemProductInfoPartTD">
                                    <div class="orderListItemProductLinkOutDiv">
                                        <a href="foreproduct?pid=90">${p.name}</a>

                                    </div>
                                </td>
                                <td class="orderItemProductInfoPartTD" width="100px">
                                    <div class="orderListItemProductPrice">￥${p.promotePrice}</div>
                                </td>
                                <td valign="top" rowspan="1" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                    <span class="orderListItemNumber">1</span>
                                </td>

                                <td class="orderItemProductInfoPartTD" width="100px">
                                    <div class="orderListItemProductPrice">${p.stock}</div>
                                </td>

                                <td class="orderItemProductInfoPartTD" width="100px">
                                    <div class="orderListItemProductPrice">

                                                <fmt:formatDate value="${p.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                                    </div>
                                </td>



                            </tr>


                        </c:if>

                    </c:forEach>
                </c:forEach>
            </table>

            <div class="pageDiv">
                <%@include file="../include/admin/adminPage.jsp"%>
            </div>
        </div>


        <div class="foods">
            <p>版权所有@2017  <a href="http://www.lvgaopan.com/"
                             target="_blank" title=""></a>
            </p>
        </div>


    </div>

</div>

</div>


</div>