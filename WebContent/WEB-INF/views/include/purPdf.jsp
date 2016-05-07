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

<html><body>
<script type="text/javascript" src="resources/js/jspdf.min.js"></script>


	<script type="text/javascript" src="resources/js/html2canvas.min.js"></script>
	
	<script type="text/javascript" src="resources/js/app.js"></script>
<div class="modal fade" id="firmDetail" role="dialog"
	aria-hidden="true">
	
		<div class="modal-dialog">
		<div class="modal-content" id="pdfModal">
				
				<form class="form" id="reqForm" name="reqForm" 
		method="post" target="_blank">
				
					

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
			<td align="center"><strong><font="24"><div>PURCHASE ORDER</font></strong></div></td>
		</tr>
						
	 </table>
 <hr/>

						 
<table style="width:100%"> 

<tr>
<td width="15%" align="left" >Vendor Code :</td>
<td width="45%"align="left" ><div id="vendorName" style="font-weight:bold;"></div></td>
<td width="17.5%" align="left" >PAN No :</td>
<td width="22.5%" align="right"><div id="panNo" ></div></td>
<td width="10%"></td>
<td width="10%"></td>
<td width="10%"></td>
<td width="1000px">			
<input type="hidden" name="rowhid" id="rowhid" value="1"/>
<input type="hidden" name="htmlText" id="htmlText"/>
</td>
</tr>

<tr>
<td align="left" valign="top" >Address :</td>
<td align="left" valign="top" ><div id="address"></div></td>
<td align="left" valign="top">TIN No :</td>
<td align="right" valign="top"><div id="tinNo"></div></td>
</tr>

<tr>
<td align="left" valign="top">City, State - Pin :</td>
<td align="left" valign="top"><div id="city" style="float:left;"></div><div  style="float:left;"> , </div><div id="state"  style="float:left;"></div><div  style="float:left;"> - </div><div id="pin" style="float:left;"></div></td>
<td align="Left" valign="top" >Excise Code No :</td>
<td align="right" valign="top" ><div id="exciseCodeNo" ></div></td>
</tr>

<tr>
<td align="left" valign="top">Quotation Detail :</td>
<td align="left" valign="top"><div id="qautationDetails"></div></td>
<td align="left" valign="top">Purchase Order No :</td>
<td  align="right" valign="top"><div id="poNo" style="font-weight:bold;"></div></td>
</tr>

<tr>   
<td align="left" valign="top">Contact Detail :</td>
<td align="left" valign="top"><div id="contactPerson" style="font-weight:bold;float:left;"></div><div id="contactDetails" ></div></td>
<td align="left" valign="top">Purchase Order Date :</td>
<td align="right" valign="top"><div id="poDate" ></div></td>
</tr>

<tr>
<td align="left" valign="top">Email :</td>
<td align="left" valign="top" colspan='3' ><div id="email"></div></td> 
</tr>


</table>







						 <hr/>
						 
<table style="width:100%"  id="itemTable" border="1" style="border: 1px solid black;">
<tr >
<td bgcolor="#eeeeee"  align="center" width="4%" >Sr</td>
<td bgcolor="#eeeeee"  align="left" width="56%">Item Code - Item Description</td>
<td bgcolor="#eeeeee"  align="right" width="12.5%">Quantity</td>
<td bgcolor="#eeeeee"  align="right" width="12.5%">Basic Rate</td>
<td bgcolor="#eeeeee"  align="right" width="15%">Total</td>


</tr>



</table>
&nbsp;&nbsp;
<table style="width:100%" border="0" >


<tr>
<td width="15%" rowspan=2 valign="top">Important Details:</td>
<td width="41%" rowspan=2 valign="top"><div id="impDetails"></div></td>
<td width="4%" rowspan=6></td>
<td align="left" width="24%" valign="bottom"><strong>Sub-Total:</strong></td>
<td align="right" width="16%" valign="bottom"><div id="subTotal" style="font-weight:bold;"></div></td>
</tr>
<tr>

<td align="Left" valign="bottom">Excise Duty @ <div id="excise" style="font-weight:bold;float:right;width:44%;"></div>:</td>
<td align="right" valign="bottom"><div id="exDuty"></div></td>
</tr>

<tr>
<td align="left" valign="top" rowspan=2>Discount:</td>
<td align="left" valign="top" rowspan=2><div id="discount" style="font-weight:bold;"></div></td>
<td align="Left" > </td>
<td align="right"></td>
</tr>

<tr>
<td align="Left" > </td>
<td align="right"></td>
</tr>

<tr>
<td align="left" >Total (In Figures):</td>
<td align="left" >Rs. <div id="totalInFigure" style="float:right;width:94%;"></div></td>
<td align="Left" >Sales Tax @<div id="sale" style="font-weight:bold;float:right;width:44%;"></div>:</td>
<td align="right"><div id="saletax"></div></td>
</tr>


<tr>
<td align="left" valign="top">Total (In Words):</td>
<td align="left" valign="top"><div id="totalInWord"></div></td>
<td align="left" valign="bottom"><strong>Total (Round Off):</strong></td>
<td align="right" valign="bottom"><div id="totalRound" style="font-weight:bold;font-color:#FF0000"></div></td>
</tr>

</table>
<hr>

<table border="0" style="width:100%;font-size:10px"> 


<tr>
<td colspan=2 align="left"><font color="#FF0000" ><strong>Terms & Conditions</strong></font></td>   
<td align="left"><font color="#FF0000" ><strong>Important Notes</strong></font></td>  
</tr>

<tr>
<td width="15%" align="left" valign="top">1. Delivery Terms:</td>
<td width="45%" align="left"><div id="deliveryTerms"></div></td>  
<td width="40%" align="left">1. Discrepancy with P.O to be reported within 7 Days.</td>      
</tr>

<tr>
<td align="left" valign="top">2. Delivery Period:</td>
<td align="left"><div id="deliveryPeriod"></div></td>   
<td align="left">2. Test certificates to accompany all dispatches.</td>              
</tr>

<tr>
<td align="left" valign="top">3. Payment Terms:</td>
<td align="left"><div id="paymentTerms"></div></td>  
<td align="left">3. Delivery Period to be adhered to strictly.</td>         
</tr>   
 
<tr>
<td align="left" valign="top">4. Freight:</td>
<td align="left"><div id="freight"></div></td> 
<td align="left">4. Excise Invoice as per regulation for claiming credit.</td>          
</tr>   

<tr>
<td align="left" valign="top">5. Packing:</td>
<td align="left"><div id="packing"></div></td>    
<td align="left">5. Qty Tolerance as per permissible standards.</td>      
</tr>     

<tr>
<td align="left" valign="top">6. Insurance:</td>
<td align="left"><div id="insurance"></div></td>    
<td align="left">6. Indicate P.O details on Invoice/Delivery Challan.</td>       
        
</tr>  
<tr>
<td align="left" valign="top">7. Sales Tax:</td>
<td align="left"><div id="sales"></div></td>    
<td align="left">7. Indicate Item code as specified on PO.</td>            
</tr>

<tr>
<td align="left" valign="top">8. Qty Tolerance:</td>
<td align="left"><div id="qtyTolerance"></div></td>    
<td align="left">8. Packing List to accompany all dispatches.</td>               
</tr>

<tr>
<td align="left" valign="top">9. Quality:</td>
<td align="left"><div id="quality"></div></td>    
<td align="left"></td>           
</tr>



</table>
<hr>


<table border="0" width="100%">

<tr>
<td align="left"><font color="#FF0000" ><strong>Other Instructions : &nbsp;</strong></font><div id="otherIns"></div></td>   
</tr>
</table>
<HR>

<table width="100%" >
<tr>
<td width="60%"  >For <strong><div id="firmName1"></div></strong></td> 
<td colspan="2"><strong>Order Instructed By:</strong></td>
</tr>

<tr>
<td >&nbsp;</td> 
<td width="10%">Name:</td>
<td width="30%" ><div id="usName"></div></td>
</tr>

<tr>
<td >&nbsp;</td> 
<td >Tel:</td>
<td> <div id="userContact"></div></td>
</tr>

<tr>
<td ><strong>(Authorized Signatory)</strong></td> 
<td >Email:</td>
<td ><div id="userEmail"></div></td>
</tr>
</table>  
<HR> 
</div>
</form>
</div>
</div>
<div>
<center>
						
	<button type="button" class="btn btn-default" 	onclick="generatePdf()">
		<span class="glyphicon glyphicon-floppy-save">Open PDF</span>
	</button>

</center>		
</div>
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
	document.reqForm.action="http://tender.railtechindia.in/dynamic_pdf.php";
	document.reqForm.method="POST";
	document.getElementById("reqForm").submit();
	
	}
</script>

