<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>


<title>商品管理</title>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">商品管理</ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="/adminIndex"> 首页 </a>>
            <a href="/admin_product_listAll">商品列表</a>
        </dl>

        <dl>
            <a href="javascript:;" onclick="addProducts()"><button type="button" class="am-btn am-btn-danger am-round am-btn-xs am-icon-plus">
                添加商品</button></a>
        </dl>
        <!--这里打开的是新页面-->



    </div>

    <!-- 这里是   显示会员的界面 -->

    <div class="soso am-form am-g ">
        <form action="" method="post">

            <p>
                <select name="find_value" data-am-selected="{btnWidth: 140, btnSize: 'sm', btnStyle: 'default'}">
                   <%--
                    <option value="All">显示全部会员</option>
                    <option value="member_phone">按照手机号查找</option>
                    <option value="member_name">按照用户名查找</option>
                    <option value="member_adress">按照用户查找</option>
                    <option value="member_points">按照用户名积分查找</option>
                    <option value="member_rights">按照会员权限查找</option>
                    --%>
                </select>

            </p>

            <p class="ycfg">
                <input name="search_input" type="text"
                       class="am-form-field am-input-sm" placeholder="圆角表单域" />
            </p>
            <p>
                <button type="submit" class="am-btn am-btn-xs am-btn-default am-xiao">
                    <i class="am-icon-search"></i>
                </button>
            </p>
            <%--<c:if test="${mlist==null}">--%>
            <%--<p style="font-size:18px;padding-top:2px;padding-left:20px;">--%>
            <%--> > >  当前查询结果为空 !</p>--%>
            <%--</c:if>--%>



            <%--<c:if test="${mlist.size()!=0}">--%>

            <%--<p style="font-size:18px;padding-top:2px;padding-left:20px;">查询结果如下： </p>--%>
            <%--</c:if>--%>
        </form>


    </div>


    <form class="am-form am-g">
        <table width="100%"class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
            <tr class="am-success">
                <th class="table-check"><input type="checkbox" />
                </th>
                <th>ID</th>
                <th>缩略图</th>
                <th>商品名称</th>
                <th>商品描述</th>
                <th width="53px">原价格</th>
                <th width="80px">优惠价格</th>
                <th width="80px">库存数量</th>
                <th width="150px">添加时间</th>
                <th width="150px">修改时间</th>
                <th width="60px">状态</th>
                <th width="50px">操作</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${ps}" var="p">
                <tr>
                    <td><input type="checkbox" />
                    </td>
                    <td>${p.id}</td>
                    <td>
                        <img width="60px" src="img/productSingle_middle/${p.imageName}">
                    </td>
                    <td>${p.name}</td>
                    <td>${p.subTitle}</td>
                    <td>${p.originalPrice}</td>
                    <td>${p.promotePrice}</td>
                    <td>${p.stock}</td>
                    <td><fmt:formatDate value="${p.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:if test="${empty p.updateDate}">暂未修改</c:if>
                        <c:if test="${!empty p.updateDate}"><fmt:formatDate value="${p.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
                    </td>
                    <td>
                        <c:if test="${p.stock gt 50}">
                            <c:if test="${p.status==1}">
                                <span class="label label-success">已发布</span>
                            </c:if>
                            <c:if test="${p.status==0}">
                                <span class="label label-warning">已下架</span>
                            </c:if>
                        </c:if>
                        <c:if test="${p.stock le 50}">
                            <span class="label label-danger">库存不足</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${p.status==0}">
                            <a href="javascript:;" onclick="product_start(this,${p.id},${p.status})" title="上架">
                                <span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true" ></span>
                            </a>
                        </c:if>
                        <c:if test="${p.status==1}">
                            <a href="javascript:;" onclick="product_stop(this,${p.id},${p.status})" title="下架">
                                <span class="glyphicon glyphicon-circle-arrow-down" aria-hidden="true" ></span>
                            </a>
                        </c:if>
                        <a href="javascript:" onclick="editProducts(${p.id})" title="编辑">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span>
                        </a>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
        <%--分页--%>
        <div class="pageDiv">
            <%@include file="../include/admin/adminPage.jsp"%>
        </div>
    </form>



    <div class="foods">
        <p>版权所有@2018 地狗商城 <a href="#" target="_blank" title="地狗商城">地狗商城</a></p>
    </div>

</div>

<script>

    /*产品-下架*/
    function product_stop(obj,id,status){
        layer.confirm('确认要下架ID为\''+id+'\'的商品吗？',{icon:0},function(index){
            var index = layer.load(3);
            $.ajax({
                type: 'PUT',
                async:false,
                url: '/admin_updateStatus/'+id+'/'+status,
                dataType: 'text',
                success: function(data){
                    layer.close(index);
                    location.reload();
                    layer.msg('已下架!',{icon: 5,time:1000});
                },
                error:function(XMLHttpRequest){
                    layer.close(index);
                    layer.alert('数据处理失败! 错误码:'+XMLHttpRequest.status,{title: '错误信息',icon: 2});
                }
            });
        });
    }
    /*产品-发布*/
    function product_start(obj,id,status){
        layer.confirm('确认要发布ID为\''+id+'\'的商品吗？',{icon:3},function(index){
            var index = layer.load(3);
            $.ajax({
                type: 'PUT',
                async:false,
                url: '/admin_updateStatus/'+id+'/'+status,
                dataType: 'text',
                success: function(data){
                    layer.close(index);
                    location.reload();
                    layer.msg('已发布!',{icon: 6,time:1000});
                },
                error:function(XMLHttpRequest){
                    layer.close(index);
                    layer.alert('数据处理失败! 错误码:'+XMLHttpRequest.status,{title: '错误信息',icon: 2});
                }
            });
        });
    }

    function addProducts() {
        //弹出即全屏
        var index = layer.open({
            type: 2,
            title:'添加商品',
            content: 'getCategory',
            area: ['320px', '195px'],
            maxmin: true
        });
        layer.full(index);
    }

    function editProducts(id) {
        //弹出即全屏
        var index = layer.open({
            type: 2,
            title:'添加商品',
            content: 'editProducts?id='+id,
            area: ['320px', '195px'],
            maxmin: true
        });
        layer.full(index);
    }



</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/admin/assets/js/amazeui.min.js"></script>
<!--<![endif]-->

</html>