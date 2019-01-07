<%--
  Created by IntelliJ IDEA.
  User: shang
  Date: 2019/1/1
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>
<title>分类管理</title>
<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">分类管理</ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="/adminIndex"> 首页 </a>>
            <a href="/toCategory">分类列表</a>
        </dl>

        <dl>

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


    <table class="table">
        <tr>
            <td style="padding-left: 4vw" width="200" class="va-t">
                <ul id="treeDemo" class="ztree">
                    <li class="level0" tabindex="0" hidefocus="true" treenode="">
                        <span title="" class="button level0 switch roots_docu" treenode_switch=""></span>
                        <span title="" treenode_ico="" class="button ico_docu" style=""></span>
                        <span >所有分类</span>
                    </li>
                    <c:forEach items="${cs}" var="c">
                        <li class="level0" tabindex="0" hidefocus="true" treenode="">
                            <span  title="" class="button level0 switch center_close" treenode_switch=""></span>
                            <a  class="level0" treenode_a="" onclick="editCategory(${c.id})" target="_blank" style="" title="点击进行编辑">
                                <span title="" treenode_ico="" class="button ico_close" style=""></span>
                                <span>${c.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </td>
            <td class="va-t">
                <div class="page-container">
                    <form class="form-horizontal" id="category-add" action="" method="post">
                        <div class="form-group">`
                            <label for="name" class="col-sm-offset-1 col-sm-2 control-label">
                                <span class="text-danger">*&nbsp;</span>分类名称：
                            </label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="name" name="name" placeholder="分类名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="button" id="submitBtn" class="btn btn-primary radius">&nbsp;添加分类&nbsp;</button>
                            </div>
                        </div>
                    </form>
                </div>
            </td>
        </tr>
    </table>




    <div class="foods">
        <p>版权所有@2018 地狗商城 <a href="#" target="_blank" title="地狗商城">地狗商城</a></p>
    </div>



</div>
<script>
    $(document).ready(function() {
        //验证
        $("#category-add").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '分类名称是必填字段'
                        },
                        stringLength: {
                            min: 2,
                            max: 5,
                            message: '最少输入2个字符，最多输入5个字符'
                        }
                    }
                }
            }
        });
    });
    $("#submitBtn").click(function () { //进行表单验证
        $("#category-add").bootstrapValidator('validate');
        var bv = $("#category-add").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            var index = layer.load(3);
            console.log($("#category-add").serialize());
            //发送ajax请求
            $.ajax({
                url: 'admin_category_add?t=' + (new Date()).getTime(),
                async: false,//同步，会阻塞操作
                type: 'POST',//PUT DELETE POST
                data: $("#category-add").serialize(),
                success: function(data) {
                    layer.close(index);
                    if(data.success==true){
                        layer.msg('添加成功！',{icon:1,time:1500},function(){
                            location.reload(); // 页面刷新
                        });
                    }else{
                        layer.alert(data.message, {title: '错误信息',icon: 2});
                    }
                },
                error:function(XMLHttpRequest) {
                    layer.close(index);
                    layer.alert('数据处理失败! 错误码:'+XMLHttpRequest.status,{title: '错误信息',icon: 2});
                }
            })
        }
    });

    function  editCategory(id) {
        layer.open({
            type: 2,
            title:'修改商品',
            content: '/toEditCategory?id='+id,
            area: ['400px', '400px'],
        });
    }
</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/admin/assets/js/amazeui.min.js"></script>
<!--<![endif]-->
</html>

