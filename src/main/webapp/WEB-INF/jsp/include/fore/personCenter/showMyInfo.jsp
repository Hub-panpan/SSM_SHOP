

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">用户详情</a></div>
        <div><a  orderStatus="waitPay" href="forecart">我的购物车</a></div>
        <div><a  orderStatus="waitDelivery" href="shouCangPage">我的收藏</a></div>
        <div><a  orderStatus="waitConfirm" href="forebought">我的订单</a></div>
        <div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">为我推荐</a></div>
        <div><a  href="foremypoint" class="noRightborder">我的积分等级</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
    </div>

</div>
<div class="container theme-showcase" role="main">
    <div class="row row-self page-container">
        <div class="col-md-4 col-md-offset-4">
            <div class="page-header">
                <br>
                <h2>用户详情</h2>
            </div>


            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">用户名</h3>
                </div>
                <div class="panel-body">
                    ${current_member.member_name}
                </div>
            </div>


            <div class="panel panel-default">
                <div class="panel-heading">用户手机</div>
                <div class="panel-body">
                    ${current_member.member_phone}
                </div>
            </div>



            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">用户地址</h3>
                </div>
                <div class="panel-body">
                    ${current_member.member_address}
                </div>
            </div>



            <div class="panel panel-default">
                <div class="panel-heading">用户权限</div>
                <div class="panel-body">
                    ${current_member.member_rights}
                </div>
            </div>


            <div class="form-group  text-center">
                <%--<button type="submit" name="submit" class="btn btn-success" href="updateMyinfo.jsp">点我修改个人信息</button>--%>
                <a class="btn btn-success" href="foreupdate">点我修改个人信息</a>

            </div>

        </div>

        </form>
    </div>
</div>
</div>
