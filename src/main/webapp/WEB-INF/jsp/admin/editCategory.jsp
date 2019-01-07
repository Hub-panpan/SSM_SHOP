<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>修改分类</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap/form-control.css" rel="stylesheet">
</head>
<body>
<div class="page-container" style="margin-top: 50px">
    <form class="form-horizontal" id="category-edit" action="" method="post">
        <div class="form-group">
        <label for="name" class="col-xs-offset-1 col-xs-4 col-sm-6 control-label">
            <span class="text-danger">*&nbsp;</span>分类名称：
        </label>
        <div class="col-sm-2">
            <input type="hidden" name="id"value="${cg.id}" id="id"/>
        </div>

        <div class="col-xs-6 col-sm-6">
            <input type="text" class="form-control" id="name" value="${cg.name}" name="name" placeholder="分类名称">
        </div>
    </div>
        <div class="form-group">
            <div class="col-xs-offset-6 col-9">
                <button type="button" id="submitBtn" class="btn btn-primary radius">修改分类</button>
                <button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;取消&nbsp;</button>
            </div>
        </div>
    </form>
</div>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.validation/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap.validation/css/bootstrapValidator.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer/2.4/layer.js"></script>
<script>
    $(document).ready(function() {
        //验证
        $("#category-edit").bootstrapValidator({
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
        $("#category-edit").bootstrapValidator('validate');
        var bv = $("#category-edit").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            var index = layer.load(3);
            console.log($("#category-edit").serialize());
            //发送ajax请求
            $.ajax({
                url: 'admin_category_edit?t=' + (new Date()).getTime(),
                async: false,//同步，会阻塞操作
                type: 'POST',//PUT DELETE POST
                data: $("#category-edit").serialize(),
                success: function(data) {
                    layer.close(index);
                    if(data.success==true){
                        layer.msg('修改成功！',{icon:1,time:1500},function(){
                            parent.location.reload(); // 页面刷新
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

    /*关闭弹出框口*/
    function layer_close(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
</script>
</html>
