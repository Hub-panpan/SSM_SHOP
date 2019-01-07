<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%--<%@ page import="Member" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>

<link rel="stylesheet" type="text/css" href="../../../admin/Hui/lib/Hui-iconfont/1.0.8/iconfont.css" />

<title>3D饼状图</title>

<div class="admin-biaogelist">

    <div class="listbiaoti am-cf">
        <ul class="am-icon-users">统计管理
        </ul>

        <dl class="am-icon-home" style="float: right;">
            当前位置：<a href="${pageContext.request.contextPath}/admin/adminindex.jsp"> 首页 </a>>
            <a href="#">　＊＊</a>
        </dl>




    </div>

    <!-- 这里是   显示会员的界面 -->

    <div class="soso am-form am-g ">


        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 3D饼状图 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="page-container">


            <div id="container" style="min-width:700px;height:400px"></div>
        </div>

    </div>







</div>


<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="../../../admin/Hui/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../admin/Hui/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="../../../admin/Hui/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="../../../admin/Hui/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="../../../admin/Hui/lib/hcharts/Highcharts/5.0.6/js/highcharts.js"></script>
<script type="text/javascript" src="../../../admin/Hui/lib/hcharts/Highcharts/5.0.6/js/modules/exporting.js"></script>


<script type="text/javascript">
    ﻿﻿$(function () {
        $('#container').highcharts({
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45,
                    beta: 0
                }
            },
            title: {
                text: '地狗商城的SALE'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    depth: 35,
                    dataLabels: {
                        enabled: true,
                        format: '{point.name}'
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                data: [
                    ['Firefox',   45.0],
                    ['IE',       26.8],
                    {
                        name: 'Chrome',
                        y: 12.8,
                        sliced: true,
                        selected: true
                    },
                    ['Safari',    8.5],
                    ['Opera',     6.2],
                    ['Others',   0.7]
                ]
            }]
        });
    });
</script>