<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shang
  Date: 2018/12/26
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <![endif]-->
    <!--/meta 作为公共模版分离出去-->

    <link href="${pageContext.request.contextPath}/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap/form-control.css" rel="stylesheet">
</head>

<body>

<div class="page-container" style="margin-top: 50px">
    <form class="form-horizontal" id="product-add" action="" method="post">
        <div class="form-group">`
            <label for="name" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>商品名称：
            </label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="name"  name="name" placeholder="商品名称">
            </div>
        </div>
        <div class="form-group">
            <label for="subTitle" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">&nbsp;&nbsp;</span>商品简述：
            </label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="subTitle" name="subTitle" placeholder="商品简述">
            </div>
        </div>
        <div class="form-group">
            <label for="cid" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>商品分类：
            </label>
            <div class="col-sm-6">
                <select class="form-control" id="cid" name="cid" placeholder="请选择商品分类">
                    <option value="" selected>请选择分类</option>
                    <c:forEach items="${cs}" var="css">
                        <option value="${css.id}">${css.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="originalPrice" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>原价格：
            </label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="originalPrice" name="originalPrice" placeholder="请输入正确的价格">
            </div>
        </div>
        <div class="form-group">
            <label for="promotePrice" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>优惠价格：
            </label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="promotePrice" name="promotePrice" placeholder="请输入正确的价格">
            </div>
        </div>
        <div class="form-group">
            <label for="stock" class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>库存量：
            </label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="stock" name="stock" placeholder="0~9999">
            </div>
        </div>
        <div class="form-group">
            <input type="text" name="imageName" id="imageName" hidden/>
            <label class="col-sm-offset-1 col-sm-2 control-label">
                <span class="text-danger">*&nbsp;</span>展示缩略图片上传：
            </label>
            <div class="col-sm-6">
                <div class="uploader-list-container">
                    <div class="queueList">
                        <div id="dndArea" class="placeholder">
                            <div name="filePicker" id="filePicker-2"></div>
                            <p>或将照片拖到这里，最多可选5张</p>
                        </div>
                    </div>
                    <div class="statusBar" style="display:none;">
                        <div class="progress"> <span class="text">0%</span> <span class="percentage"></span> </div>
                        <div class="info"></div>
                        <div class="btns">
                            <div id="filePicker2"></div>
                            <div class="uploadBtn">开始上传</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-offset-1 col-sm-2 control-label">商品详情：</label>
            <div class="col-sm-6">
                <textarea name="detailed" style="width:100%;visibility:hidden;"></textarea>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" id="submitBtn" class="btn btn-primary radius">&nbsp;保存并发布&nbsp;</button>
                <button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </form>

</div>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.validation/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap.validation/css/bootstrapValidator.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/kindeditor/plugins/code/prettify.css" />
<script charset="utf-8" src="${pageContext.request.contextPath}/lib/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="${pageContext.request.contextPath}/lib/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${pageContext.request.contextPath}/lib/kindeditor/plugins/code/prettify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer/2.4/layer.js"></script>
<script type="text/javascript">
    var editor;
    /*关闭弹出框口*/
    function layer_close(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

    //保存发布
    //var form = $("#product-add");
    $(document).ready(function() {
        //验证
        $("#product-add").bootstrapValidator({
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
                            message: '商品名称是必填字段'
                        },
                        stringLength: {
                            min: 1,
                            max: 30,
                            message: '最多可以输入30个字符'
                        },
                    }
                },
                cid: {
                    validators: {
                        notEmpty: {
                            message: '请选择商品所属分类'
                        },
                    }
                },
                originalPrice: {
                    validators: {
                        notEmpty: {
                            message: '商品原价格是必填字段'
                        },
                        regexp: {
                            regexp: /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '金额必须大于0并且只能精确到分'
                        },
                    }
                },
                promotePrice: {
                    validators: {
                        callback:{
                            message: '优惠价格必须小于等于原价格',
                            callback: function(value, validator) {
                                var oPrice = $("#originalPrice").val();
                                var pPrice = $("#promotePrice").val();
                                if (oPrice == '' || pPrice =='')
                                    return true;
                                if (parseFloat(pPrice)<=parseFloat(oPrice))
                                    return true;
                                return false;
                            }
                        },
                        regexp: {
                            regexp: /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '金额必须大于0并且只能精确到分'
                        },

                    }
                },
                stock: {
                    validators: {
                        notEmpty: {
                            message: '库存量必填字段'
                        },
                        stringLength: {
                            min: 0,
                            max: 4,
                            message: '请输入0~9999的数字'
                        },
                        digits: {
                            message: '库存量必须是整数'
                        },

                    }
                }
            }
        });
    });
    $("#submitBtn").click(function () { //进行表单验证
        $("#product-add").bootstrapValidator('validate');
        var bv = $("#product-add").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            console.log(images);
            if(images==null){
                layer.alert('请上传商品展示缩略图! ', {title: '错误信息',icon: 0});
                return;
            }
            var index = layer.load(3);
            editor.sync();
//            console.log($("#product-add").serialize());
            //发送ajax请求
            $.ajax({
                url: 'admin_product_add?t=' + (new Date()).getTime(),
                async: false,//同步，会阻塞操作
                type: 'POST',//PUT DELETE POST
                data: $("#product-add").serialize(),
                success: function(data) {
                    layer.close(index);
                    if(data.success==true){
                        layer.msg('添加成功！',{icon:1,time:1500},function(){
                            parent.location.reload(); // 父页面刷新
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
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

    KindEditor.ready(function(K) {
        editor = K.create('textarea[name="detailed"]', {
            cssPath : 'lib/kindeditor/plugins/code/prettify.css',
            uploadJson : '/kindeditor/imageUpload',
            fileManagerJson : '/kindeditor/imageUpload',
            allowFileManager : false,
            afterUpload: function(){this.sync();}, //图片上传后，将上传内容同步到textarea中
            afterBlur: function(){this.sync();},   ////失去焦点时，将上传内容同步到textarea中
            height : '400px',
            afterCreate : function() {
                var self = this;
                K.ctrl(document, 13, function() {
                    self.sync();
                    document.forms['product-add'].submit();
                });
                K.ctrl(self.edit.doc, 13, function() {
                    self.sync();
                    document.forms['product-add'].submit();
                });
            }
        });
        prettyPrint();
    });

    var images=null;

    (function ($) {

        // 当domReady的时候开始初始化
        $(function () {
            var $wrap = $('.uploader-list-container'),

                // 图片容器
                $queue = $('<ul class="filelist"></ul>')
                    .appendTo($wrap.find('.queueList')),

                // 状态栏，包括进度和控制按钮
                $statusBar = $wrap.find('.statusBar'),

                // 文件总体选择信息。
                $info = $statusBar.find('.info'),

                // 上传按钮
                $upload = $wrap.find('.uploadBtn'),

                // 没选择文件之前的内容。
                $placeHolder = $wrap.find('.placeholder'),

                $progress = $statusBar.find('.progress').hide(),

                // 添加的文件数量
                fileCount = 0,

                // 添加的文件总大小
                fileSize = 0,

                // 优化retina, 在retina下这个值是2
                ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                thumbnailWidth = 110 * ratio,
                thumbnailHeight = 110 * ratio,

                // 可能有pedding, ready, uploading, confirm, done.
                state = 'pedding',

                // 所有文件的进度信息，key为file id
                percentages = {},
                // 判断浏览器是否支持图片的base64
                isSupportBase64 = (function () {
                    var data = new Image();
                    var support = true;
                    data.onload = data.onerror = function () {
                        if (this.width != 1 || this.height != 1) {
                            support = false;
                        }
                    }
                    data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
                    return support;
                })(),

                // 检测是否已经安装flash，检测flash的版本
                flashVersion = (function () {
                    var version;

                    try {
                        version = navigator.plugins['Shockwave Flash'];
                        version = version.description;
                    } catch (ex) {
                        try {
                            version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
                                .GetVariable('$version');
                        } catch (ex2) {
                            version = '0.0';
                        }
                    }
                    version = version.match(/\d+/g);
                    return parseFloat(version[0] + '.' + version[1], 10);
                })(),

                supportTransition = (function () {
                    var s = document.createElement('p').style,
                        r = 'transition' in s ||
                            'WebkitTransition' in s ||
                            'MozTransition' in s ||
                            'msTransition' in s ||
                            'OTransition' in s;
                    s = null;
                    return r;
                })(),

                // WebUploader实例
                uploader;

            if (!WebUploader.Uploader.support('flash') && WebUploader.browser.ie) {

                // flash 安装了但是版本过低。
                if (flashVersion) {
                    (function (container) {
                        window['expressinstallcallback'] = function (state) {
                            switch (state) {
                                case 'Download.Cancelled':
                                    layer.alert('您取消了更新！',{title: '错误信息',icon: 2})
                                    break;

                                case 'Download.Failed':
                                    layer.alert('安装失败',{title: '错误信息',icon: 2})
                                    break;

                                default:
                                    layer.alert('安装已成功，请刷新！',{title: '错误信息',icon: 1});
                                    break;
                            }
                            delete window['expressinstallcallback'];
                        };

                        var swf = 'expressInstall.swf';
                        // insert flash object
                        var html = '<object type="application/' +
                            'x-shockwave-flash" data="' + swf + '" ';

                        if (WebUploader.browser.ie) {
                            html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ';
                        }

                        html += 'width="100%" height="100%" style="outline:0">' +
                            '<param name="movie" value="' + swf + '" />' +
                            '<param name="wmode" value="transparent" />' +
                            '<param name="allowscriptaccess" value="always" />' +
                            '</object>';

                        container.html(html);

                    })($wrap);

                    // 压根就没有安转。
                } else {
                    $wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>');
                }

                return;
            } else if (!WebUploader.Uploader.support()) {
                layer.alert('Web Uploader 不支持您的浏览器！',{title: '错误信息',icon: 2});
                return;
            }

            // 实例化
            uploader = WebUploader.create({
                pick: {
                    id: '#filePicker-2',
                    label: '点击选择图片'
                },
                formData: {
                    uid: 123
                },
                dnd: '#dndArea',
                paste: '#uploader',
                swf: 'lib/webuploader/0.1.5/Uploader.swf',
                chunked: false,
                chunkSize: 512 * 1024,
                server: '/image/imageUpload',
                // runtimeOrder: 'flash',

                accept: {
                    title: 'Images',
                    extensions: 'gif,jpg,jpeg,bmp,png',
                    //mimeTypes: 'image/*'
                },

                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                fileNumLimit: 5,
                fileSizeLimit: 25 * 1024 * 1024,    // 25 M
                fileSingleSizeLimit: 5 * 1024 * 1024    // 5 M
            });

            // 拖拽时不接受 js, txt 文件。
            uploader.on('dndAccept', function (items) {
                var denied = false,
                    len = items.length,
                    i = 0,
                    // 修改js类型
                    unAllowed = 'text/plain;application/javascript ';

                for (; i < len; i++) {
                    // 如果在列表里面
                    if (~unAllowed.indexOf(items[i].type)) {
                        denied = true;
                        break;
                    }
                }

                return !denied;
            });

            uploader.on('dialogOpen', function () {
                console.log('here');
            });

            // uploader.on('filesQueued', function() {
            //     uploader.sort(function( a, b ) {
            //         if ( a.name < b.name )
            //           return -1;
            //         if ( a.name > b.name )
            //           return 1;
            //         return 0;
            //     });
            // });

            // 添加“添加文件”的按钮，
            uploader.addButton({
                id: '#filePicker2',
                label: '继续添加'
            });

            uploader.on('ready', function () {
                window.uploader = uploader;
            });

            // 当有文件添加进来时执行，负责view的创建
            function addFile(file) {
                var $li = $('<li id="' + file.id + '">' +
                    '<p class="title">' + file.name + '</p>' +
                    '<p class="imgWrap"></p>' +
                    '<p class="progress"><span></span></p>' +
                    '</li>'),

                    $btns = $('<div class="file-panel">' +
                        '<span class="cancel">删除</span>' +
                        '<span class="rotateRight">向右旋转</span>' +
                        '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
                    $prgress = $li.find('p.progress span'),
                    $wrap = $li.find('p.imgWrap'),
                    $info = $('<p class="error"></p>'),

                    showError = function (code) {
                        switch (code) {
                            case 'exceed_size':
                                text = '文件大小超出';
                                break;

                            case 'interrupt':
                                text = '上传暂停';
                                break;

                            default:
                                text = '上传失败，请重试';
                                break;
                        }

                        $info.text(text).appendTo($li);
                    };

                if (file.getStatus() === 'invalid') {
                    showError(file.statusText);
                } else {
                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;

                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }

                        if (isSupportBase64) {
                            img = $('<img src="' + src + '">');
                            $wrap.empty().append(img);
                        } else {
                            $.ajax('lib/webuploader/0.1.5/server/preview.php', {
                                method: 'POST',
                                data: src,
                                dataType: 'json'
                            }).done(function (response) {
                                if (response.result) {
                                    img = $('<img src="' + response.result + '">');
                                    $wrap.empty().append(img);
                                } else {
                                    $wrap.text("预览出错");
                                }
                            });
                        }
                    }, thumbnailWidth, thumbnailHeight);

                    percentages[file.id] = [file.size, 0];
                    file.rotation = 0;
                }

                file.on('statuschange', function (cur, prev) {
                    if (prev === 'progress') {
                        $prgress.hide().width(0);
                    } else if (prev === 'queued') {
                        $li.off('mouseenter mouseleave');
                        $btns.remove();
                    }

                    // 成功
                    if (cur === 'error' || cur === 'invalid') {
                        console.log(file.statusText);
                        showError(file.statusText);
                        percentages[file.id][1] = 1;
                    } else if (cur === 'interrupt') {
                        showError('interrupt');
                    } else if (cur === 'queued') {
                        percentages[file.id][1] = 0;
                    } else if (cur === 'progress') {
                        $info.remove();
                        $prgress.css('display', 'block');
                    } else if (cur === 'complete') {
                        $li.append('<span class="success"></span>');
                    }

                    $li.removeClass('state-' + prev).addClass('state-' + cur);
                });

                $li.on('mouseenter', function () {
                    $btns.stop().animate({height: 30});
                });

                $li.on('mouseleave', function () {
                    $btns.stop().animate({height: 0});
                });

                $btns.on('click', 'span', function () {
                    var index = $(this).index(),
                        deg;

                    switch (index) {
                        case 0:
                            uploader.removeFile(file);
                            return;

                        case 1:
                            file.rotation += 90;
                            break;

                        case 2:
                            file.rotation -= 90;
                            break;
                    }

                    if (supportTransition) {
                        deg = 'rotate(' + file.rotation + 'deg)';
                        $wrap.css({
                            '-webkit-transform': deg,
                            '-mos-transform': deg,
                            '-o-transform': deg,
                            'transform': deg
                        });
                    } else {
                        $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');
                        // use jquery animate to rotation
                        // $({
                        //     rotation: rotation
                        // }).animate({
                        //     rotation: file.rotation
                        // }, {
                        //     easing: 'linear',
                        //     step: function( now ) {
                        //         now = now * Math.PI / 180;

                        //         var cos = Math.cos( now ),
                        //             sin = Math.sin( now );

                        //         $wrap.css( 'filter', "progid:DXImageTransform.Microsoft.Matrix(M11=" + cos + ",M12=" + (-sin) + ",M21=" + sin + ",M22=" + cos + ",SizingMethod='auto expand')");
                        //     }
                        // });
                    }


                });

                $li.appendTo($queue);
            }

            // 负责view的销毁
            function removeFile(file) {
                var $li = $('#' + file.id);

                delete percentages[file.id];
                updateTotalProgress();
                $li.off().find('.file-panel').off().end().remove();
            }

            function updateTotalProgress() {
                var loaded = 0,
                    total = 0,
                    spans = $progress.children(),
                    percent;

                $.each(percentages, function (k, v) {
                    total += v[0];
                    loaded += v[0] * v[1];
                });

                percent = total ? loaded / total : 0;


                spans.eq(0).text(Math.round(percent * 100) + '%');
                spans.eq(1).css('width', Math.round(percent * 100) + '%');
                updateStatus();
            }

            function updateStatus() {
                var text = '', stats;
                if (state === 'ready') {
                    text = '选中' + fileCount + '张图片，共' +
                        WebUploader.formatSize(fileSize) + '。';
                } else if (state === 'confirm') {
                    stats = uploader.getStats();
                    if (stats.uploadFailNum) {
                        text = '已成功上传' + stats.successNum + '张照片，' +
                            stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
                    }

                } else {
                    stats = uploader.getStats();
                    text = '共' + fileCount + '张（' +
                        WebUploader.formatSize(fileSize) +
                        '），已上传' + stats.successNum + '张';

                    if (stats.uploadFailNum) {
                        text += '，失败' + stats.uploadFailNum + '张';
                    }
                }

                $info.html(text);
            }

            function setState(val) {
                var file, stats;

                if (val === state) {
                    return;
                }

                $upload.removeClass('state-' + state);
                $upload.addClass('state-' + val);
                state = val;

                switch (state) {
                    case 'pedding':
                        $placeHolder.removeClass('element-invisible');
                        $queue.hide();
                        $statusBar.addClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'ready':
                        $placeHolder.addClass('element-invisible');
                        $('#filePicker2').removeClass('element-invisible');
                        $queue.show();
                        $statusBar.removeClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'uploading':
                        $('#filePicker2').addClass('element-invisible');
                        $progress.show();
                        $upload.text('暂停上传');
                        break;

                    case 'paused':
                        $progress.show();
                        $upload.text('继续上传');
                        break;

                    case 'confirm':
                        $progress.hide();
                        $('#filePicker2').removeClass('element-invisible');
                        $upload.text('开始上传');

                        stats = uploader.getStats();
                        if (stats.successNum && !stats.uploadFailNum) {
                            setState('finish');
                            return;
                        }
                        break;
                    case 'finish':
                        stats = uploader.getStats();
                        if (stats.successNum) {
                            //alert('上传成功');
                        } else {
                            // 没有成功的图片，重设
                            state = 'done';
                            location.reload();
                        }
                        break;
                }
                updateStatus();
            }

            uploader.onUploadProgress = function (file, percentage) {
                var $li = $('#' + file.id),
                    $percent = $li.find('.progress span');

                $percent.css('width', percentage * 100 + '%');
                percentages[file.id][1] = percentage;
                updateTotalProgress();
            };

            uploader.onFileQueued = function (file) {
                fileCount++;
                fileSize += file.size;

                if (fileCount === 1) {
                    $placeHolder.addClass('element-invisible');
                    $statusBar.show();
                }

                addFile(file);
                setState('ready');
                updateTotalProgress();
            };

            uploader.onFileDequeued = function (file) {
                fileCount--;
                fileSize -= file.size;

                if (!fileCount) {
                    setState('pedding');
                }

                removeFile(file);
                updateTotalProgress();

            };
            // 文件上传成功
            uploader.on( 'uploadSuccess', function( file,data ) {
                if(data.success==true){
                    if(images==null){
                        images=data.result;
                    }else{
                        images+=","+data.result;
                    }
                    $("#image").val(images);
                }else{
                    layer.msg("上传失败:"+data.message,{icon: 2});
                    //删除文件
                    setTimeout(function(){
                        var $li = $('#' + file.id);
                        delete percentages[file.id];
                        updateTotalProgress();
                        $li.off().find('.file-panel').off().end().remove();
                        location.reload();
                    },1500);
                }

            });



            uploader.on('all', function (type) {
                var stats;
                switch (type) {
                    case 'uploadFinished':
                        setState('confirm');
                        break;

                    case 'startUpload':
                        setState('uploading');
                        break;

                    case 'stopUpload':
                        setState('paused');
                        break;

                }
            });

            uploader.onError = function (code) {
                if(code=="Q_TYPE_DENIED"){
                    layer.alert("文件类型不支持，仅支持gif,jpg,jpeg,bmp,png格式图片");
                }else if(code=="F_DUPLICATE"){
                    layer.alert("文件已选中，请勿重复上传");
                }else if(code="F_EXCEED_SIZE"){
                    layer.alert("文件大小超出限制，单张图片不得超过5MB");
                } else{
                    layer.alert('Error: ' + code);
                }

            };

            $upload.on('click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                }

                if (state === 'ready') {
                    uploader.upload();
                } else if (state === 'paused') {
                    uploader.upload();
                } else if (state === 'uploading') {
                    uploader.stop();
                }
            });

            $info.on('click', '.retry', function () {
                uploader.retry();
            });

            $info.on('click', '.ignore', function () {
                layer.msg('已忽略');
            });

            $upload.addClass('state-' + state);
            updateTotalProgress();


        });

    })(jQuery);
</script>
</body>
</html>
