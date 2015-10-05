<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table id="pltable" class="table table-striped table-bordered">
	<thead>
		<tr class="active">
			<th>Pick</th>
			<th>Code ID</th>
			<th>Item Code</th>
			<th>Description</th>
			<th>New Item Code</th>
			<th>New Description</th>
		</tr>
	</thead>
	<tbody>

		<c:forEach items="${vendorList}" var="vendor">
			<tr>
				<td><a href="#" onclick="push('${vendor.vendorId}','${vendor.vendorName}')" ><span class="glyphicon glyphicon-plus-sign" ></span></a></td>
				<td><c:out value="${vendor.vendorId }"></c:out></td>
				<td><c:out value="${vendor.vendorName }"></c:out></td>
				<td><c:out value="${vendor.codeDesc }"></c:out></td>
				<td><c:out value="${vendor.newItemCode }"></c:out></td>
				<td><c:out value="${vendor.newItemDesc }"></c:out></td>
			</tr>
		</c:forEach>
	</tbody>


</table>

<script>
$(document).ready(function(){
    $('#pltable').DataTable();
});

</script>