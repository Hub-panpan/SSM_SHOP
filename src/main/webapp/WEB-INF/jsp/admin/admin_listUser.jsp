<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%--<%@ page import="Member" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>


<title>用户管理</title>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">会员管理
        </ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="${pageContext.request.contextPath}/admin/adminindex.jsp"> 首页 </a>>
            <a href="#">会员列表</a>
        </dl>




    </div>

    <!-- 这里是   显示会员的界面 -->

    <div class="soso am-form am-g ">
        <form action="admin_user_list_like" method="post">

            <p>
                <select name="find_value"  data-am-selected="{btnWidth: 140, btnSize: 'sm', btnStyle: 'default'}">
                    <option value="All">显示全部会员</option>
                    <option value="member_phone">按照手机号查找</option>
                    <option value="member_name">按照用户名查找</option>
                    <option value="member_adress">按照用户地址查找</option>
                    <option value="member_points">按照用户名积分查找</option>
                    <option value="member_rights">按照会员权限查找</option>
                </select>

            </p>

            <p class="ycfg">
                <input name="search_input" type="text"
                       class="am-form-field am-input-sm" placeholder="圆角表单域" />
            </p>
            <p>
                <button type="submit"
                        class="am-btn am-btn-xs am-btn-default am-xiao">
                    <i class="am-icon-search"></i>
                </button>
            </p>
            <c:if test="${mlist==null}">
                <p style="font-size:18px;padding-top:2px;padding-left:20px;">
                    > > >  当前查询结果为空 !</p>
            </c:if>



            <c:if test="${mlist!=null}">

                <p style="font-size:18px;padding-top:2px;padding-left:20px;">查询结果如下： </p>
            </c:if>
        </form>


    </div>



    <c:if test="${mlist!=null}">

        <form class="am-form am-g">
            <table width="100%"
                   class="am-table am-table-bordered am-table-radius am-table-striped">
                <thead>
                <tr class="am-success">
                    <th class="table-check"><input type="checkbox" />
                    </th>

                    <th class="">ID</th>
                    <th class="">用户名</th>
                    <th class="">用户手机号</th>
                    <th class=" ">地址</th>
                    <th class=" ">积分</th>

                    <th class="">权限</th>
                    <th width="100px" class="table-set">操作</th>
                </tr>
                </thead>
                <tbody>



                <c:forEach items="${mlist}" var="u">
                    <%--<tr>--%>
                        <%--<td>${u.id}</td>--%>
                        <%--<td>${u.name}</td>--%>
                    <%--</tr>--%>




                <tr>
                    <td><input type="checkbox" />
                    </td>

                    <td>${u.id}</td>
                    <td>${u.member_name}</td>
                    <td>${u.member_phone}</td>
                    <td>${u.member_address}</td>
                    <td>${u.member_points}</td>
                    <td>${u.member_rights}</td>
                    <%--<td class="">ok</td>--%>


                    <td>

                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">



                                <a href="updateMemberRight?m_id=${u.id}&m_right=${u.member_rights}&value=1"
                                   class="am-btn am-btn-default am-btn-xs am-text-secondary am-round"
                                   title="解冻用户"><span class="am-icon-pencil-square-o"></span></a>


                                <a href="updateMemberRight?m_id=${u.id}&m_right=${u.member_rights}&value=-1"
                                   class="am-btn am-btn-default am-btn-xs am-text-danger am-round"
                                   title="冻结用户"><span class="am-icon-trash-o"></span></a>
                            </div>
                        </div></td>
                </tr>


                </c:forEach>




                </tbody>
            </table>
            <%--分页--%>
            <div class="pageDiv">
                <%@include file="../include/admin/adminPage.jsp"%>
            </div>


            <hr />

        </form>

    </c:if>


    <div class="foods">

        <p>版权所有@2017  <a href="http://www.lvgaopan.com/" target="_blank" title="书香味道">书香味道</a>

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