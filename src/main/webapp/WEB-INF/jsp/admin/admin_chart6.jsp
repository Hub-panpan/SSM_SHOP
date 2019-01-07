<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%--<%@ page import="Member" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>

<link rel="stylesheet" type="text/css" href="../../../admin/Hui/lib/Hui-iconfont/1.0.8/iconfont.css" />

<title>3D柱状图</title>

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


        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 3D柱状图 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
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
    ﻿$(function () {
        // Set up the chart
        var chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'column',
                margin: 75,
                options3d: {
                    enabled: true,
                    alpha: 15,
                    beta: 15,
                    depth: 50,
                    viewDistance: 25
                }
            },
            title: {
                text: '产品消费总额收入图'
            },
            subtitle: {
                text: '前端页面'
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            series: [{
                data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
            }]
        });


        // Activate the sliders
        $('#R0').on('change', function(){
            chart.options.chart.options3d.alpha = this.value;
            showValues();
            chart.redraw(false);
        });
        $('#R1').on('change', function(){
            chart.options.chart.options3d.beta = this.value;
            showValues();
            chart.redraw(false);
        });

        function showValues() {
            $('#R0-value').html(chart.options.chart.options3d.alpha);
            $('#R1-value').html(chart.options.chart.options3d.beta);
        }
        showValues();
    });
</script>