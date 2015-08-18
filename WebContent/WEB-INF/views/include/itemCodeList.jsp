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

		<c:forEach items="${codeList}" var="code">
			<tr>
				<td><a href="#" onclick="push('${code.codeId}','${code.code}','${code.codeDesc}')" ><span class="glyphicon glyphicon-plus-sign" ></span></a></td>
				<td><c:out value="${code.codeId }"></c:out></td>
				<td><c:out value="${code.code }"></c:out></td>
				<td><c:out value="${code.codeDesc }"></c:out></td>
				<td><c:out value="${code.newItemCode }"></c:out></td>
				<td><c:out value="${code.newItemDesc }"></c:out></td>
			</tr>
		</c:forEach>
	</tbody>


</table>

<script>
$(document).ready(function(){
    $('#pltable').DataTable();
});

</script>