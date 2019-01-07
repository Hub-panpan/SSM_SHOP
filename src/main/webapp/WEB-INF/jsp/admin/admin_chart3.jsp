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
        <div class="col-lg-8 col-md-offset-2">
            <div id="main" style="width: 600px;height:400px;margin-right: 200px ;"></div>



        </div>
        <div class="col-lg-2">
            <c:forEach items="${cs}" var="c">

                <li><a href="go_chart3?cid=${c.id}">  ${c.name}</a></li>

            </c:forEach>

        </div>


    </div>



</div>



<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    option = {
        title : {
            text: '地狗商城评论',
            subtext: '实时大数据统计',
            x:'center'
        },
        tooltip : {
//            trigger: 'item',
//            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
//            orient: 'vertical',
//            left: 'left',

        },
        series : [
            {
                name: '评论占比',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    <c:forEach var="item" items="${map3}">
                    {value:${item.value}, name:'${item.key}'  },

                    </c:forEach>
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/admin/assets/js/amazeui.min.js"></script>
<!--<![endif]-->
</body>


