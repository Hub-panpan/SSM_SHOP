<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%--<%@ page import="Member" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="admin_header.jsp"%>

<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<link rel="stylesheet" type="text/css" href="../../../admin/Hui/lib/Hui-iconfont/1.0.8/iconfont.css" />
<script src="https://cdn.bootcss.com/echarts/4.2.0-rc.2/echarts-en.common.js"></script>
<script src="../../../js/jquery/2.0.0/jquery.min.js"></script>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->

${admin.name}
<div class="container theme-showcase" role="main">
    <div class="row row-self page-container">
        <div class="col-lg-8 col-md-offset-1">
            <div id="main" style="width: 600px;height:400px;margin-right: 200px ;"></div>



        </div>
        <div class="col-lg-2 col-md-offset-1">
            <c:forEach items="${cs}" var="c">

                <li><a href="go_chart1?cid=${c.id}" onclick="">  ${c.name}</a></li>

            </c:forEach>

        </div>








    </div>



</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: 'ECharts 入门示例'
        },
        tooltip: {},
        legend: {
            data:['销量']
        },
        xAxis: {
            data:
//                ["安全座椅","太阳镜","品牌女装","时尚男装","男士西服","男士手拿包"]
            [<c:forEach var="item" items="${map1}">
                "${item.key}" ,
            </c:forEach>]

        },
        yAxis: {},
        series: [{
            name: '库存',
            type: 'bar',
            data:

                <%--[${shuju[0]}, 20, 36, 10, 10, 20,]--%>
                [<c:forEach var="item" items="${map1}">
                    ${item.value} ,
                </c:forEach>]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/admin/assets/js/amazeui.min.js"></script>
<!--<![endif]-->
</body>


