<script>

function validate(){
	
	
	var vendor = document.getElementById('vendor').value;
	if(vendor == ''){
		BootstrapDialog.alert('Please select vendor');
		return false;
	}
	
	var dateRange = document.getElementById('purchaseOrderDate').value;
	if(dateRange == '') {
		BootstrapDialog.alert('Please select Purchase Order Date');
		return false;
	}
	
	var quotationDetail = document.getElementById('quotationDetail').value;
	if(quotationDetail == ''){
		BootstrapDialog.alert('Please fill the Quotation Detail!');
		return false;
	}
	var quotationDate = document.getElementById('quotationDate').value;
	if(quotationDate == ''){
		BootstrapDialog.alert('Please fill the Quotation Date!');
		return false;
	}
	
	
	var count = document.getElementById('rowhid').value;
	var rowCount = document.getElementById('rowId').value;
	var orderLevel = document.getElementById('orderLevelRowId').value;
	
	for(var i=0;i<count;i++){
		var itemCode = document.getElementById('itemCode'+i).value;
		if(itemCode == ''){
			BootstrapDialog.alert('Please Pick Item!');
			return false;
		}
		var qty = document.getElementById('Order_Qty'+i).value;
		if(qty == ''){
			BootstrapDialog.alert('Please Enter Order Qty');
			return false;
		}
		
		var orderQty = parseFloat($("#Order_Qty"+i).val());
		var Qty = parseFloat($("#qty"+i).val());
		if(orderQty>Qty){
			BootstrapDialog.alert('Order Qty can not be greater then Original Qty');
			return;
		}
		
		
		for(var j=0;j<rowCount;j++){
			for(var k=0;k<rowCount;k++){
				if(document.getElementById("rateName"+i+j) == null || document.getElementById("rateName"+i+k) == null  )
					continue;
				else
				{
					if( document.getElementById('rateName'+i+j).value == document.getElementById('rateName'+i+k).value && j != k){
						BootstrapDialog.alert('Two rate names can not be same');
					return false;
					}
				}
			}			
		}
	}
	
	for(var m=0;m<orderLevel;m++){
		for(var n=0;n<orderLevel;n++){
			if( document.getElementById('ratesName'+m).value == document.getElementById('ratesName'+n).value && m != n){
				BootstrapDialog.alert('Two rate names can not be same at order level');
				return false;
			}	
		}
	}
	
	
	var impDetails = $('#impDetails').val();
	if(impDetails == '') {
		BootstrapDialog.alert('Please fill the Important Details!');
		return false;
	}
	var discount = $('#discount').val();
	if(discount == ''){
		BootstrapDialog.alert('Please fill the Discount!');
		return false;
	}
	
	var deliveryTerms = $('#deliveryTerms').val();
	if(deliveryTerms == ''){
		BootstrapDialog.alert('Please fill the Delivery Terms!');
		return false;
	}
	
	var deliveryPeriod = $('#deliveryPeriod').val();
	if(deliveryPeriod == ''){
		BootstrapDialog.alert('Please fill the Delivery Period!');
		return false;
	}
	
	var freight = $('#freight').val();
	if(freight == ''){
		BootstrapDialog.alert('Please fill the freight!');
		return false;
	}
	var packing = $('#packing').val();
	if(packing == ''){
		BootstrapDialog.alert('Please fill the Packing Detials!');
		return false;
	}
	var insurance = $('#insurance').val();
	if(insurance == '') {
		BootstrapDialog.alert('Please fill the Insurance Charges');
		return false;
	}
	var saleTax = $('#saleTax').val();
	if(saleTax == ''){
		BootstrapDialog.alert('Please fill the Sale Taxes');
		return false;
	}
	
	var qualityTolerance = $('#qualityTolerance').val();
	if(qualityTolerance == ''){
		BootstrapDialog.alert('Please fill the Quality Tolerance!');
		return false;
	}
	
	var qualityAssurance = $('#qualityAss').val();
	if(qualityAssurance == ''){
		BootstrapDialog.alert('Please fill the Quality Assurance!');
		return false;
	}
	var paymentTerm = $('#paymentTerm').val();
	if(paymentTerm == ''){
		BootstrapDialog.alert('Please fill the Payment Term!');
		return false;
	}
	var otherInstruction = $('#otherInstruction').val();
	if(otherInstruction == ''){
		BootstrapDialog.alert('Please fill the Other Instruction!');
		return false;
	}
	var instructorName = $('#instructorName').val();
	if(instructorName == '') {
		BootstrapDialog.alert('Please fill the Instructor Name');
		return false;
	}
	var instructorContact = $('#instructorCont').val();
	if(instructorContact == ''){
		BootstrapDialog.alert('Please fill the Instructor Contact Details!');
		return false;
	}
	
	var instructorEmail = $('#instructorEmail').val();
	if(instructorEmail == ''){
		BootstrapDialog.alert('Please fill the Instructor Email!');
		return false;
	}
	
	savePurchaseOrder()
}


$(document).ready(function() {
    $('#quotationDateRangePicker')
       .datepicker({
           format: "dd/mm/yyyy",
           endDate : new Date(),
           defaultDate: new Date(),
           "autoclose": true
       }) 

});

</script>
	<style>
	.form-control{
	font-size: 12px;}
	
	#modal-add-req{overflow-y:scroll;}
	</style>
	
	<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="orderForm" name="orderForm" method="post" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title '>Purchase Order Form</h5>
				</div>
				<div class="modal-body">
				
				
				
				<div class="form-group">
				
						<label for="item">For the Firm</label> <input type="hidden" id="firm"
							name="firm" >
							
							
							<select  class="form-control"
							id="firm1" name="firm1" onChange="generateOrderNo('orderNo', this.value);getUserWarehouse('warehouse', this.value,'','${_SessionUser.userId}');">
							<option value="" selected disabled>Select Firm </option>
							</select>
							
					</div>
					
					<div class="form-group">
					<label for="item">For the Warehouse</label>
						<select class="form-control" id="warehouse" name="warehouse"  required>
							<option value="" selected disabled>Warehouse</option>
						</select>
					</div>
					
					<div class="form-group">
						<label for="item">Purchase Order Number</label> <input type="text" class="form-control"
							id="orderNo" name="orderNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  >
					</div>
					
					<!-- 
					<div class="form-group">
						<label for="item">Vendor</label> <select
							class="form-control" id="vendor" name="vendor">
							<option value="" selected disabled>Select Vendor </option>
						</select>
					</div>
					 -->
					
					<div class=" form-group">

						<label for="item">Vendor</label>
						
						<div class="row">
						<div class="col-md-4" >
						  <select
							class="form-control" id="vendor" name="vendor" onChange="getVendorAddress('vendorAddress', this.value,'')">
							<option value="" selected disabled>Select Vendor </option>
						</select>
						</div>
							<div class="col-md-4">
								<select
							class="form-control" id="vendorAddress" name="vendorAddress">
							<option value="" selected disabled>Select Vendor Address</option>
						</select>
				            
							</div>
							<div class="col-md-4">
								 <input type="text" id="contactPerson" name="contactPerson" class="form-control" placeholder="Contact Person">
				            
							</div>
							
							
							
						</div>
					</div>
					
					<div class="form-group">
				        <label for="item">Purchase Order Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="purchaseOrderDate"
							id="purchaseOrderDate" placeholder="Purchase Order Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				    
				     <div class=" form-group">

						<label for="item">Quotation Detail</label>
						<label for="rate" style="margin-left:42%">Quotation Date</label>
						<div class="row">
						
							<div class="col-md-6" >
						 <input type="text" id="quotationDetail" name="quotationDetail" class="form-control" placeholder="Quotation Detail">
					</div>
					<div class="col-md-6" >	 
				        <div class="date">
				            <div class="input-group input-append date" id="quotationDateRangePicker">
				               <input type="text" class="form-control" name="quotationDate"
							id="quotationDate" placeholder="Quotation Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
							</div>
						</div>
					</div>
                    <!--  
					<div class="form-group">
						<label for="item">Item</label> <input type="hidden" id="item"
							name="item"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly">
					</div>

					

					<div class=" form-group">

						<label for="qty">Qty</label>
						<label for="rate" style="margin-left:58%">Rate</label>
						<div class="row">
							<div class="col-md-5">
								<input type="number" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty">
							</div>
							<div class="col-md-2">
								<select id="unit" name="unit" class="form-control"></select>
							</div>
							
							
							<div class="col-md-5" >
						 <input type="number" id="rate" name="rate" class="form-control" placeholder="Rate">
					</div>
						</div>
					</div>
					
					
					
					
					<div class="form-group">
				        <label for="item">Expected Delivery Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Due Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
					
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Order Remarks</label> 
						<textarea id="orderRemarks"  name=" orderRemarks"class="formControl"  style="width: 100%; height:50px;"></textarea>
					</div>
					-->
					
					 <div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="reqItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
									
									<th>Item Code</th>
									<th>Item Name</th>
									<th>Original Qty</th>
									<th>Order Qty</th>
									<th>Unit<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addDirectRow()" id="addButton">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											
											
										</div></th>
									
									
								</tr>
								
								
								
								
							
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="0"/>
							<input type="hidden" name="rowId" id="rowId" value="0"/>
							<input type="hidden" name="orderLevelRowId" id="orderLevelRowId" value="0"/>
							<input type="hidden" name="reqid" id="reqid" value=""/>

						</div>
						
						
						
					<div class="panel panel-default">

						<div class="panel-heading">Order Level Rates 
						
						<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default" id="orderLevelButton"
												onclick="addOrderLevelRates()" >
												<span class="glyphicon glyphicon-plus"></span>
											</button>
						</div>
						<div class="panel-body" style="padding: 0px;">
						<table id="addMultipleTable" class="table table-bordered ">
							<tr>
									<th>Rate Name</th>
									<th colspan="2">Rate Value</th>
									
								</tr>
							
							<input type="hidden" name="orderLevelTotal" id="orderLevelTotal" value="0"/>
						</table>	
						<input type="hidden" name="rowId" id="rowId" value="1"/>									
						</div>
					</div>
					
				</div>
				<div class="form-group">
						<label for="item">Total</label> <input type="text" class="form-control"
							id="orderLevelGrandTotal" name="orderLevelGrandTotal" placeholder="Total" readonly="readonly">
							<input type="hidden" id="orderLevelGrandTotalRateId" name="orderLevelGrandTotalRateId" >
						<input type="hidden" id="orderLevelTotalRateId" name="orderLevelTotalRateId" >
					</div>
						
					<div class=" form-group">

						<label for="item">Important Details</label>
						<label for="item" style="margin-left:42%">Discount</label>
						
						<div class="row">
						<div class="col-md-6" >
						  <input type="text" class="form-control input-sm" id="impDetails"
									name="impDetails" placeholder="Enter Important Details">
						</div>
							<div class="col-md-6">
								<input type="text" class="form-control input-sm" id="discount"
									name="discount" placeholder="Enter Discount">
				            
							</div>
						</div>
					</div>
					
						
					<div class=" form-group">

						<label for="item">Delivery Terms</label>
						<label for="item" style="margin-left:43%">Delivery Period</label>
						
						<div class="row">
						<div class="col-md-6" >
						  <input type="text" class="form-control input-sm" id="deliveryTerms"
									name="deliveryTerms" placeholder="Enter Delivery Terms">
						</div>
							<div class="col-md-6">
								<input type="text" class="form-control input-sm" id="deliveryPeriod"
									name="deliveryPeriod" placeholder="Enter Delivery Period">
				            
							</div>
						</div>
					</div>
					
					<div class=" form-group">

						<label for="item">Freight</label>
						<label for="item" style="margin-left:48%">Packing</label>
						
						<div class="row">
						<div class="col-md-6" >
						  <input type="text" class="form-control input-sm" id="freight"
									name="freight" placeholder="Enter Freight">
						</div>
							<div class="col-md-6">
								<input type="text" class="form-control input-sm" id="packing"
									name="packing" placeholder="Enter Packing">
				            
							</div>
						</div>
					</div>
					
					<div class=" form-group">

						<label for="item">Insurance</label>
						<label for="item" style="margin-left:46%">Sale Tax</label>
						
						<div class="row">
						<div class="col-md-6" >
						  <input type="text" class="form-control input-sm" id="insurance"
									name="insurance" placeholder="Enter Insurance">
						</div>
							<div class="col-md-6">
								<input type="text" class="form-control input-sm" id="saleTax"
									name="saleTax" placeholder="Enter Sale Tax">
				            
							</div>
						</div>
					</div>
					
					<div class=" form-group">

						<label for="item">Quantity Tolerance</label>
						<label for="item" style="margin-left:42%">Quality Assurance</label>
						
						<div class="row">
						<div class="col-md-6" >
						  <input type="text" class="form-control input-sm" id="qualityTolerance"
									name="qualityTolerance" placeholder="Enter Quality Tolerance">
						</div>
							<div class="col-md-6">
								<input type="text" class="form-control input-sm" id="qualityAss"
									name="qualityAss" placeholder="Enter Quality Assurance">
				            
							</div>
						</div>
					</div>
					
					<div class="form-group" >
						<label for="paymentTerm" style="vertical-align: top">Payment Term</label> 
						<textarea id="paymentTerm"  name="paymentTerm"class="formControl"  style="width: 100%; height:30px;"></textarea>
					</div>
					
					<div class="form-group" >
						<label for="otherInstruction" style="vertical-align: top">Other Instruction</label> 
						<textarea id="otherInstruction"  name="otherInstruction"class="formControl"  style="width: 100%; height:40px;"></textarea>
					</div>
					<label for="item">Order Instruted By :</label>
					<div class=" form-group">

						
						<label for="item">Name</label>
						<label for="item" style="margin-left:31%">Contact</label>
						<label for="item" style="margin-left:30%">Email</label>
						<div class="row">
						<div class="col-md-4" >
						  <input type="text" class="form-control input-sm" id="instructorName"
									name="instructorName" placeholder="Enter Name">
						</div>
							<div class="col-md-4">
								<input type="number" class="form-control input-sm" id="instructorCont"
									name="instructorCont" placeholder="Enter Contact No.">
				            
							</div>
							<div class="col-md-4">
								<input type="text" class="form-control input-sm" id="instructorEmail"
									name="instructorEmail" placeholder="Enter Email">
				            
							</div>
						</div>
					</div>
					
				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onmouseenter="" onClick="validate()">
							<span class="glyphicon glyphicon-floppy-save">Save Order</span>
						</button>

						<button type="button" class="btn btn-danger">
							<span class="glyphicon glyphicon-remove" class="close"
								data-dismiss="modal" aria-hidden="true">Cancel </span>
						</button>

					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<style>
.modal-dialog {
	padding: 15px;
	width: 80%;
}
</style>