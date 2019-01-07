<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>我的订单</title>
</head>
</html>
<script>
    var deleteOrder = false;
    var deleteOrderid = 0;

    $(function(){
        $("a[orderStatus]").click(function(){
            var orderStatus = $(this).attr("orderStatus");
            if('all'==orderStatus){
                $("table[orderStatus]").show();
            }
            else{
                $("table[orderStatus]").hide();
                $("table[orderStatus="+orderStatus+"]").show();
            }

            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });

        $("a.deleteOrderLink").click(function(){
            deleteOrderid = $(this).attr("oid");
            deleteOrder = false;
            $("#deleteConfirmModal").modal("show");
        });

        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrder){
                var page="foredeleteOrder";
                $.post(
                    page,
                    {"oid":deleteOrderid},
                    function(result){
                        if("success"==result){
//							$("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
                        }
                        else{
                            location.href="loginPage";
                        }
                    }
                );

            }
        })

        $(".ask2delivery").click(function(){
            var link = $(this).attr("link");
//		$(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){

                    alert("卖家已秒发，刷新当前页面，即可进行确认收货");

                }
            });

        });


        $(".askrefund").click(function(){
            var link = $(this).attr("link");
//        $(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){
                    alert("退货申请已提交，请等待审核结果！" );


                }
            });

        });

        $(".ask2delete").click(function(){
            var link = $(this).attr("link");
//        $(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){
                    alert("确认删除订单嘛！" )
                    /*alert("卖家已秒发，刷新当前页面，即可进行确认收货")*/
                }
            });

        });


        $(".asktuihuo").click(function(){
            var link = $(this).attr("link");
//        $(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){
                    alert("卖家已秒退货发！！！三天内到达您的手中！");
                }
            });

        });






    });

</script>
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
		<div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
		<div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
		<div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
		<div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
		<div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
	</div>
	<div style="clear:both"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr>
				<td>商品<br>Commodity</td>
				<td width="100px">单价<br>Unit price</td>
				<td width="100px">数量<br>Quantity</td>
				<td width="120px">实付款<br>Real payment</td>
				<td width="100px">交易操作<br>Operation</td>
			</tr>
		</table>
	</div>

	<div class="orderListItem">
		<c:forEach items="${os}" var="o">
			<table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
				<tr class="orderListItemFirstTR">
					<td colspan="2">
						<b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span>订单号: ${o.orderCode}
					</span>
					</td>
					<td  colspan="2"><img width="13px" ></td>
					<td colspan="1">


					</td>
					<td class="orderItemDeleteTD">
							<%--<a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
                                <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                            </a>--%>

					</td>
				</tr>
				<c:forEach items="${o.orderItems}" var="oi" varStatus="st">
					<tr class="orderItemProductInfoPartTR" >
						<td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${oi.product.imageName}"></td>
						<td class="orderItemProductInfoPartTD" align="center">

							<center>
								<div class="orderListItemProductLinkOutDiv">
									<center><br><br>
										<a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
									</center>
								</div>

							</center>
						</td>

						<td  class="orderItemProductInfoPartTD" width="100px">

								<%--<div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></div>--%>
							<div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></div>
						</td>
						<c:if test="${st.count==1}">
							<td rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
								<span class="orderListItemNumber">${o.totalNumber}</span>
							</td>
							<center>
								<td rowspan="${fn:length(o.orderItems)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
									<div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/></div>
										<%--<div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>--%>
								</td>
							</center>
							<td rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
								<c:if test="${o.status=='waitConfirm' }">
									<a href="foreconfirmPay?oid=${o.id}">
										<button class="orderListItemConfirm">确认收货</button>
									</a>
								</c:if>
								<c:if test="${o.status=='waitPay' }">
									<a href="forealipay?oid=${o.id}&total=${o.total}">
										<button class="orderListItemConfirm">付款</button>
									</a>
								</c:if>

								<c:if test="${o.status=='waitDelivery' }">
									<%--<form action="tuihuo">
										<button class="orderListItemConfirm">退货</button><br>
									</form>--%>

									<button class="btn btn-info btn-sm ask2delivery" >待发货</button>
								</c:if>

								<c:if test="${o.status=='waitReview' }">




									<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal2">
										评价
									</button>

									<a  href= "tui_huo?oid=${o.id}" class="btn btn-info btn-sm " link="" >退货</a>

								</c:if>



								<a  href="delete_Order?oid=${o.id}" class="btn btn-info btn-sm " >删除订单</a>



								<c:if test="${o.status=='waitTuihuo' }">
									<button class="btn btn-info btn-sm asktuihuo" >待退货</button>
								</c:if>

								<c:if test="${o.status=='yituihuo' }">
									<button class="btn btn-info btn-sm " >已退货</button>
								</c:if>


							</td>







							<%--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
							<%--<div class="modal-dialog" role="document">--%>
							<%--<div class="modal-content">--%>
							<%--<div class="modal-header">--%>
							<%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
							<%--<h4 class="modal-title" id="myModalLabel">Modal title</h4>--%>
							<%--</div>--%>
							<%--<div class="modal-body">--%>
							<%--爸爸，积分可以当钱花，拿去！--%>
							<%--</div>--%>
							<%--<div class="modal-footer">--%>
							<%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
							<%--&lt;%&ndash;<a  href= "tui_huo?oid=${o.id}" class="btn btn-info btn-sm ">给我积分</a>&ndash;%&gt;--%>
							<%--<a  href="add_Point?m_id=${user.id}&m_point=${current_member.member_points}&value=${o.total}" class="btn btn-info btn-sm ">好的 爸爸收下了</a>--%>
							<%--</div>--%>
							<%--</div>--%>
							<%--</div>--%>
							<%--</div>--%>


							<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											<h4 class="modal-title" id="myModalLabel">Modal title</h4>
										</div>
										<div class="modal-body">
											确认评价吗？评价后，不可退货哟！
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
											<a  href= "forereview?oid=${o.id}" class="btn btn-info btn-sm ">别废话 我不退货</a>
										</div>
									</div>
								</div>
							</div>



						</c:if>
					</tr>
				</c:forEach>

			</table>
		</c:forEach>
		<</div>





</div>