

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">用户详情</a></div>
        <div><a  orderStatus="waitPay" href="forecart">我的购物车</a></div>
        <div><a  orderStatus="waitDelivery" href="shouCangPage">我的收藏</a></div>
        <div><a  orderStatus="waitConfirm" href="forebought">我的订单</a></div>
        <div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">为我推荐</a></div>
        <div><a  orderStatus="" href="showMyPoint.jsp" class="noRightborder">我的积分等级</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
    </div>

</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">



                <c:choose>


                    <c:when test="${current_member.member_points lt 999}">

                            小主，您的积分现在为${current_member.member_points}!赶快去购物吧！

                    </c:when>


                    <c:when test="${current_member.member_points ge 999}">

                        老败家了，您的积分现在为${current_member.member_points}!赶快去购物吧！

                    </c:when>


                </c:choose>




            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">残忍拒绝</button>
                <a type="button" class="btn btn-primary" href="/forehome">去购物</a>
            </div>
        </div>
    </div>
</div>

<div class="container theme-showcase" role="main">
    <div class="row row-self page-container">
        <div class="col-md-6 col-md-offset-2">
            <div class="page-header">
                <br>
                <h2>用户积分</h2>
            </div>



            <div class="panel panel-default">
                <div class="panel-heading">用户积分</div>
                <div class="panel-body">
                    <h2>     ${current_member.member_points} </h2>

                </div>
            </div>






            <c:choose>


                <c:when test="${current_member.member_points lt 100}">

                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                        点我有惊喜
                    </button>

                </c:when>


                <c:when test="${current_member.member_points ge 100}">

                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                        点我有惊喜
                    </button>

                </c:when>


            </c:choose>







        </div>

        </form>
    </div>
</div>
</div>
