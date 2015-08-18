<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table id="pltable" class="table table-striped table-bordered">
	<thead>
		<tr class="active">
			<th>Pick</th>
			<th>PL ID</th>
			<th>PL Number</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>

		<c:forEach items="${plList}" var="plItem">
			<tr>
				<td><a href="#" onclick="push('${plItem.plId}','${plItem.plNo}','${plItem.itemDesc}')" ><span class="glyphicon glyphicon-plus-sign" ></span></a></td>
				<td><c:out value="${plItem.plId }"></c:out></td>
				<td><c:out value="${plItem.plNo }"></c:out></td>
				<td><c:out value="${plItem.itemDesc }"></c:out></td>
			</tr>
		</c:forEach>
	</tbody>


</table>

<script>
$(document).ready(function(){
    $('#pltable').DataTable();
});

</script>