

<html>
<body>

<div class="modal fade" id="grPdfForm" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="pdfModal">
				
					<form class="form" id="grForm" name="grForm" method="post" target="_blank">
						 <div class="panel-body" >
							
							

						 
	 <table border="0" width="100%"> 
	 
	 <tr>
	 <td width="15%" align="left" >GR Number :</td>
	 <td width="45%"align="left" ><strong><div id="grNo"></div></strong></td> 
	 </tr>
	 
	 <tr>
	 <td width="15%" align="left" >GR Date :</td>
	 <td width="45%"align="left" ><div id="grDate"></div></td> 
	 </tr>
	 
	 <tr>
	 <td width="15%" align="left" >GR Amount :</td>
	 <td width="45%"align="left" ><strong><div id="totalBill"></div></strong></td>
	 
	
	 
	<td width="15%"></td>
	 <td width="15%"></td>
	 <td width="15%"></td>
	 <td width="1000px">
	 
	<input type="hidden" name="htmlText" id="htmlText">
	</td>
	 </tr>
	
	
	
	 
	 
	 
	
	
	 <tr>
	 <td width="15%" align="left" >Invoice Number :</td>
	 <td width="45%"align="left" ><div id="invoiceNo"></div></td> 
	 </tr>
	 
	  <tr>
	 <td width="15%" align="left" >Invoice Date :</td>
	 <td width="45%"align="left" ><div id="invoiceDate"></div></td> 
	 </tr>
	 
	 <tr>
	 <td width="15%" align="left" >Vehicle Number :</td>
	 <td width="45%"align="left" ><div id="vehicleNumber"></div></td> 
	 </tr>
</table>

<table width="30%">
<tr>
<td width="15%" align="right" >Authorised Signatory  </td>
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
	document.grForm.action="http://tender.railtechindia.in/dynamic_pdf.php";
	document.grForm.method="POST";
	document.getElementById("grForm").submit();
	

	}
	</script>
