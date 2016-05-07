<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta name="viewport" content="width=device-width, initial-scale=1"/> 
	<meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
	<meta http-equiv="PRAGMA" content="NO-CACHE">
	     
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Railtech Purchase Order Management</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/jquery.dataTables.min.css"/>"
	media="screen" />
            
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap.min.css"/>"
	media="screen" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-dialog.min.css"/>" />
	
	<link href="<c:url value="/resources/css/lib/flexigrid.css"/>"
	rel="stylesheet" />
	  
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-theme.min.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-datepicker.css"/>" />
<%-- <link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/lib/bootstrap-combined.min.css"/>" /> --%>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/style.css"/>" />
	   
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
	src="<c:url value="/resources/js/lib/bootstrap-datepicker.js"/>"></script>
	<script type="text/javascript"
	src="<c:url value="/resources/js/lib/jquery.dataTables.min.js"/>"></script>
	   
		<script type="text/javascript"
	src="<c:url value="/resources/js/lib/jquery-migrate.js"/>"></script>
   
<script src="<c:url value="/resources/js/lib/flexigrid.js"/>"></script>
<script src="<c:url value="/resources/js/railtech.js"/>"></script>
    
<!-- Optional theme -->
<link rel="icon" type="image/png"
	href="<c:url value="/resources/images/n1.jpg"/>"
	media="screen" />
            

<script type="text/javascript">
	   
		$(document).ready(
				function() {
					var ie8or9 = $('html').hasClass('ie8')
							|| $('html').hasClass('ie9');
					$(document).ajaxStart(function() {
						setTimeout(function() {
							$("#ajaxBusy").show();
						}, ie8or9 ? 50 : 0);
					}).ajaxStop(function() { 
						setTimeout(function() {
							$("#ajaxBusy").hide();
						}, ie8or9 ? 100 : 0);
					});
					document.getElementById("ajaxBusy").innerHTML ="<img alt='please wait ...  loading' src='<c:url value='/resources/images/ajax_loader.gif'/>'>";
				});
	</script>
	                   
<script type="text/javascript">
     
$(document).ready(function(){  
	jQuery(function($){
$(".panel-heading.clickable").on("click", function(e){
	if($(this).hasClass('collapsed')){
			$(this).find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
			}else{
				$(this).find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
				}
})   
		})  
});  
</script>
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
		<div id="ajaxBusy"></div>
	</div>
</body>
</html>