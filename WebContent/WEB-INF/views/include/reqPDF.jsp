<style>
body {
    font-family:"Times New Roman",Times,serif;
    font-size: 9pt;
    line-height: 1.17;
}
td{
font-family:"Times New Roman",Times,serif;
    font-size: 9pt;
    line-height: 1.17;
}
hr {
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 0px;
    border: 0;
    border-top: 1px solid #000;
}
</style>

<html>
<body>
<script type="text/javascript" src="resources/js/jspdf.min.js"></script>
<script type="text/javascript" src="resources/js/html2canvas.min.js"></script>
<script type="text/javascript" src="resources/js/app.js"></script>
<div class="modal fade" id="firmDetail" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="pdfModal">
				
					<form class="form" id="reqPDFForm" name="reqPDFForm" method="post" target="_blank">
						 <div class="panel-body" >
							<table  id="firmDetailTable" style="margin-top: 0px; width:100%; valign:top;">
								<tr>
								<td width="30%" rowspan="5"><img  height="70px" width="150px" id="imageId"/></td>
								<td width="70%" align="right"><div id="firmName" style="font-weight:bold;" ></div></td></tr>
								<tr>
<td align="right"><div id="firmLocation"></div></td></tr>
<tr><td align="right"><div id="firmLocation1"></div></td></tr>

<tr><td align="right"><div style="float:right;"><div style="float:left;">Tel:</div><div id="firmPhone" style="float:left;"></div><div style="float:left;">,&nbsp;<h7>Fax:</h7></div><h7><div id="firmFax" style="float:left;"></h7></div></div></td></tr>
<tr>
<td align="right">Email: <div id="firmEmail"></div></td>
</tr>
</table>
							
<hr>
	<table border="0" width="100%">
		<tr>
			<td align="center"><strong><font="24"><div>REQUISITION</font></strong></div></td>
		</tr>
						
	 </table>
 <hr/>
						 
	 <table border="0" width="100%"> 
	 <tr>
	 <td width="15%" align="left" >Warehouse:</td>
	 <td width="45%"align="left" ><strong><div id="store"></div></strong></td>
	 <td width="15%" align="left" >Requisition No:</td>
	 <td width="22.5%" align="right" ><strong><div id="reqRefNo"></div></strong></td>
	 <td width="10%"></td>
	 <td width="10%"></td>
	 <td width="10%"></td>
	 <td width="1000px">
	 <input type="hidden" name="rowhid" id="rowhid" value="1" />
	<input type="hidden" name="htmlText" id="htmlText">
	</td>
	 </tr>
	
	
	
	 <tr>
	 <td width="15%" align="left" >Requested By :</td>
	 <td width="45%"align="left" ><div id="requestedBy"></div></td>
	 <td width="15%" align="left" >Requisition Date: </td>
	 <td width="20%"align="right" ><div id="reqDate"></div></td>
	 
	 </tr>
	 
	 
	 <tr>
	 <td width="15%" align="left" >Due Date :</td>
	<td width="45%"align="left" ><div id="duDate"></div></td>
	</tr>
</table>


<table border="1" width="100%" id="itemTable" >
<tr>
<td bgcolor="#eeeeee" border="1" align="left" width="3%">Sr</td>
<td bgcolor="#eeeeee" border="1" align="left" width="60%">Item Code - Item Description</td>
<td bgcolor="#eeeeee" border="1" align="right" width="14%">Quantity</td>
</tr>

<tr>
         <td align="center" ></td>
         <td align="left" ></td>
         <td align="right" ></td>
         
</tr>


</table>


		



<table border="0" width="100%">

<tr>
<td ><div style="float:left;"><strong><font color="#FF0000" >Remarks :</font></strong></div> <div id="remarks" style="float:left;"></div></td>

</tr>
</table>
</div>
	</form>
			</div>
			
			

			
		</div>
		
<center>
	<button type="button" class="btn btn-default" 	onclick="generatePdf()">
		<span class="glyphicon glyphicon-floppy-save">Open PDF</span>
	</button>
</center>	
			

	
</div>

</body></html>
<style>
.modal-dialog {
     padding: 15px;
    width:90%;
}
</style>

<script>
function generatePdf(){

	var content = $("#pdfModal").html();
	$("#htmlText").val(content);
	document.reqPDFForm.action="http://tender.railtechindia.in/dynamic_pdf.php";
	document.reqPDFForm.method="POST";
	document.getElementById("reqPDFForm").submit();
	

	}
	</script>
