<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="text/javascript"
	src="<c:url value="/resources/js/lib/jquery.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/lib/moment.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/lib/bootstrap.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/lib/bootstrap-filestyle.min.js"/>"></script>

<script type="text/javascript"
	src="<c:url value="/resources/js/lib/bootstrap-dialog.min.js"/>"></script>

<script type="text/javascript"
	src="<c:url value="/resources/js/lib/bootstrap-datetimepicker.min.js"/>"></script>
	<script type="text/javascript"
	src="<c:url value="/resources/js/lib/jquery.dataTables.min.js"/>"></script>
	
		<script type="text/javascript"
	src="<c:url value="/resources/js/lib/jquery-migrate.js"/>"></script>

<script src="<c:url value="/resources/js/lib/flexigrid.js"/>"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap.min.css"/>"
	media="screen" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-dialog.min.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-theme.min.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-datetimepicker.min.css"/>" />
<%-- <link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-combined.min.css"/>" /> --%>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/style.css"/>" />

<link href="<c:url value="/resources/css/lib/flexigrid.css"/>"
	rel="stylesheet" />

</head>
<body>
		<div>
			
			<div>
				<tiles:insertAttribute name="body" />
			</div>
			
		</div>
	</body>
</html>