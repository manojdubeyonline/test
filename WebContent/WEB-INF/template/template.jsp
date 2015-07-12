<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Railtech Purchase Order Management</title>
<%-- 		<script	type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
		<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />

<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
		<link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
     
		
		<script	type="text/javascript"  src="<c:url value="/resources/js/lib/bootstrap.min.js"/>"></script>
		
		<script	type="text/javascript" src="<c:url value="/resources/js/lib/bootstrap-filestyle.min.js"/>"></script> --%>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script	type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.14.30/css/bootstrap-datetimepicker.css"></script>

<script	type="text/javascript"  src="<c:url value="/resources/js/lib/bootstrap-dialog.min.js"/>"></script>
<script	type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.14.30/css/bootstrap-datetimepicker.min.css"></script>

<script	type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.14.30/js/bootstrap-datetimepicker.min.js"></script>

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.2.1/jquery-migrate.js"></script>
		<script src="<c:url value="/resources/js/lib/flexigrid.js"/>"></script>
		
		<link href="<c:url value="/resources/css/lib/flexigrid.css"/>" rel="stylesheet"/><%-- 
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/lib/bootstrap.min.css"/>" media="screen"/>
		
		<link rel="stylesheet"  type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.0/css/bootstrap-datepicker3.min.css" />
		
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/lib/bootstrap-theme.min.css"/>" /> --%>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css"/>"/>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/lib/bootstrap-dialog.min.css"/>" />
	</head>

	<body>
		<div class="container">
			<div class="header">
				<tiles:insertAttribute name="header" />
			</div>
			<div class="content-wells">
				<tiles:insertAttribute name="body" />
			</div>
			<div class="footer">
				<tiles:insertAttribute name="footer" />
			</div>
		</div>
	</body>
</html>