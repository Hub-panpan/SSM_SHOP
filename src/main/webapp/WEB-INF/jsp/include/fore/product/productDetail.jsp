<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<div class="productDetailDiv" >
	<div class="productDetailTopPart">
		<a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
		<a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">${p.reviewCount}</span> </a>
	</div>
	
	
	<div class="productParamterPart">
		<div class="productParamter">产品详情：</div>
		
		<div class="productParamterList">
			${p.detailed}
		</div>
		<div style="clear:both"></div>
	</div>
	

</div>

