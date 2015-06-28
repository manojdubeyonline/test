<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title>EV</title>
	<link href="<c:url value="/css/smoothness/jquery-ui-1.10.0.custom.css"/>" rel="stylesheet"/>
	<script src="<c:url value="/js/jquery-1.9.0.js"/>"></script>
	<script src="<c:url value="/js/flexigrid.js"/>"></script>
	<link href="<c:url value="/css/flexigrid.css"/>" rel="stylesheet"/>
	<!--link href="<c:url value="/css/flexi-style.css"/>" rel="stylesheet"/-->
</head>

<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="content">
			<tiles:insertAttribute name="content" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>
