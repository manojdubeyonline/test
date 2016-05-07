 <!-- 
<div style='height: 10px;'>&nbsp;</div>
<div>


	<ul class="nav nav-tabs">
		<li role="presentation" id="requisitions" ><a href="requisitions">Requisitions</a></li>
		<li role="presentation" id="pendingStockIssue"><a href="pendingStockIssue">Stock Issue</a></li>
		
		<li role="presentation" id="requisitionApproval"><a href="pendingPurchaseMarking">Requisition
				Marking</a></li>
		<li role="presentation" id="purchaseOrders"><a href="purchaseOrder">Purchase
				</a></li>
		<li role="presentation"  id="orderApproval"><a href="purchaseOrderApproval">Purchase Orders</a></li>
		<li role="presentation"  id="pendingWarehouse"><a href="pendingWarehouse">Warehouse</a></li>
		<li role="presentation" id="grpo"><a href="grpo">GRPO</a></li>
		<li role="presentation" id="grpoApproval"><a href="grpoApproval">GRPO Approval</a></li>
		<li role="presentation" id="warehouseDisbursement"><a href="#stockAllocation">Stock Allocation</a></li>
	</ul>
	
	</div>

<div style='height: 10px;'>&nbsp;</div>
-->

 

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div align="right"><a href="http://tender.railtechindia.in/top1.php" target="_blank" style="text-decoration:none;">Home</a> &nbsp; &nbsp; <i>You are Logged in as :</i> <strong>${_SessionUser.userName}</strong></div>
	<div style='height: 10px;'>&nbsp;</div>

	<div style='height: 10px;'>&nbsp;</div>
	<div>
	<ul class="nav nav-tabs">
		<c:forEach items="${_SessionUser.userRole.access}" var="userAccess">
		 <c:set var="currentMenuId" value="${userAccess.menu.menuId}" />
    		<fmt:parseNumber var="parsedMenuId" type="number" value="${currentMenuId}" />
   
		<c:if test="${(parsedMenuId > 500) && (parsedMenuId <600)}">
				<li role="presentation" id="<c:out value="${userAccess.menu.menuDescription }"></c:out>"><a href="<c:out value="${userAccess.menu.menuUrl }"></c:out>"><c:out value="${userAccess.menu.menuName }"></c:out></a></li>	
		</c:if>
		</c:forEach>
		</ul>
	</div>	
	<div style='height: 10px;'>&nbsp;</div>


