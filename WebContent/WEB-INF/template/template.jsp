<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>NDorsit</title>
		<script	type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
		<script	type="text/javascript"  src="<c:url value="/js/lib/bootstrap.min.js"/>"></script>
		<script	type="text/javascript"  src="<c:url value="/js/lib/bootstrap-dialog.min.js"/>"></script>
		<script	type="text/javascript" src="<c:url value="/js/lib/bootstrap-filestyle.min.js"/>"></script>
		<!-- DataTables -->
		<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/lib/bootstrap.min.css"/>" media="screen"/>
		<link rel="stylesheet"  type="text/css"href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/themes/smoothness/jquery-ui.css" />
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/lib/bootstrap-theme.min.css"/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/ndorsit.css"/>"/>
		<!-- DataTables CSS -->
		<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.2/css/jquery.dataTables.css">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/lib/bootstrap-dialog.min.css"/>" />
	</head>

	<body>
		<div id="container">
			<div id="header">
				<tiles:insertAttribute name="header" />
			</div>
			<div id="content">
				<tiles:insertAttribute name="body" />
			</div>
			<div id="footer">
				<tiles:insertAttribute name="footer" />
			</div>
		</div>
	</body>
</html>