<script>
function validate(){
	
	
	
	var VendorInvoice = document.getElementById('vendorInvoiceNo').value;
	if(VendorInvoice == ''){
		BootstrapDialog.alert('Please Enter Vendor Invoice Number');
		return false;
	}
	
	var VendorInvoiceDate = document.getElementById('vendorInvoicedate').value;
	if(VendorInvoiceDate == ''){
		BootstrapDialog.alert('Please Enter Vendor Invoice Date');
		return false;
	}
	
	var VehicleNo = document.getElementById('vehicleNo').value;
	if(VehicleNo == ''){
		BootstrapDialog.alert('Please Enter Vehicle Number');
		return false;
	}
	
	var count = document.getElementById('rowhid').value;
	for(var m=0;m<count;m++){
		for(var n=0;n<count;n++){
			if( document.getElementById('item'+m).value == document.getElementById('item'+n).value && m != n){
				BootstrapDialog.alert('Two items can not be same');
				return false;
			}	
		}
		var GrQty = document.getElementById('gr_Qty'+m).value;
		if(GrQty == ''){
			BootstrapDialog.alert('Please Enter Quantity');
			return false;
		}
	}
	var billAmount = document.getElementById('grLevelGrandTotal').value;
	if(billAmount == ''){
		BootstrapDialog.alert('Please Enter Bill Amount');
		return false;
	}
	saveGRPO();
}


	</script>
	
	<style>#modal-add-req{overflow-y:scroll;}</style>

<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="grpoForm" name="grpoForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title '>Goods Inward Receipt Form</h5>
				</div>
				<div class="modal-body">
				
				<div class=" form-group">

						<label for="item">For the firm</label>
						<label for="item" style="margin-left:44%">Warehouse</label><input type="hidden" id="warehouseId"
							name="warehouseId"><input type="hidden" id="firmId" name="firmId">
							
						
						<div class="row">
						<div class="col-md-6" >
						  <select  class="form-control"
							id="firm" name="firm" onChange="getUserWarehouse('warehouse', this.value,'','${_SessionUser.userId}');">
							<option value="" selected disabled>Select Firm </option>
							</select>
						</div>
							<div class="col-md-6">
								<select class="form-control" id="warehouse" name="warehouse" onChange="generateDirectRecieptNo();" required>
							<option value="" selected disabled>Select Warehouse</option>
						</select>
				            
							</div>
						</div>
					</div>
				
				
				
					<div class="form-group">
						<label for="item">Goods Reciept Number</label> <input type="text" class="form-control"
							id="recieptNo" name="recieptNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  value="PurchaseOrder"><input type="hidden" 
							id="marking_id" name="marking_id" ><input type="hidden" 
							id="grpoId" name="grpoId" >
							<input type="hidden" id="grType" name="grType" >
							
					</div>
<!--
					<div class="form-group">
						<label for="item">For the firm</label> <input type="hidden" id="firm"
							name="firm">
							
							<input type="hidden" id="warehouse"
							name="warehouse">
							<input type="text" class="form-control"
							id="firm1" name="firm1" readonly="readonly">
							
					</div>
					
					<div class="form-group">
				        <label for="item">Expected Delivery Date</label> 
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Due Date (dd/mm/yyyy)"  disabled="disabled"/>
					</div>
					  
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Order Remarks</label> 
						<textarea id="orderRemarks"  name="orderRemarks"class="formControl"  style="width: 100%; height:50px;" disabled="disabled"></textarea>
					</div>
					-->
					<div class=" form-group">

						<label for="item">Vendor</label>
						
						<div class="row">
						<div class="col-md-4" >
						  <select
							class="form-control" id="vendor" name="vendor" onChange="getVendorAddress('vendorAddress', this.value)">
							<option value="" selected disabled>Select Vendor </option>
						</select>
						</div>
							<div class="col-md-8">
								<select
							class="form-control" id="vendorAddress" name="vendorAddress">
							<option value="" selected disabled>Select Vendor Address</option>
						</select>
				            
							</div>
							
							
							
						</div>
					</div>
					
				    
				    <div class="form-group">
				        <label for="item">GR Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="gr_date"
							id="gr_date" placeholder="Inward Date (dd/mm/yyyy)"  />
				             <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				    
				    
				   
				    
				    
				    <div class=" form-group">

						<label for="invoice">Vendor Invoice No.</label>
						<label for="item" style="margin-left:22%">Vendor Invoice Date</label>
						<label for="rate" style="margin-left:21%">Vehicle No.</label>
						<div class="row">
						<div class="col-md-4" >
						 <input type="text" id="vendorInvoiceNo" name="vendorInvoiceNo" class="form-control" placeholder="Enter Invoice Number">
						</div>
							<div class="col-md-4">
								 <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="vendorInvoicedate"
							id="vendorInvoicedate" placeholder="Vendor Invoice Date (dd/mm/yyyy)"  />
				             <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
							</div>
							
							
							<div class="col-md-4" >
						 <input type="text" id="vehicleNo" name="vehicleNo" class="form-control" placeholder="Vehicle No">
						</div>
						</div>
					</div>
				    
					<!-- 
					<div class=" form-group">

						<label for="qty">Order Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="number" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty" disabled="disabled">
							</div>
							<div class="col-md-5">
								<input id="unit" name="unit" class="form-control" type="hidden"><input id="unitx" name="unitx" class="form-control" disabled="disabled">
							</div>
						</div>
					</div>
					<div class=" form-group">

						<label for="qty">Inward Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="number" class="form-control input-sm" id="inward_qty"
									name="inward_qty" placeholder="Enter Inward Qty" onchange="qtyCheck();">
							</div>
							<div class="col-md-5">
								<input id="unit1" name="unit1" class="form-control" disabled="disabled">
							</div>
						</div>
					</div>
					
					
					<div class="form-group" >
						<label for="rate" style="vertical-align: top">Rate</label> 
						<input type="number" id="rate" name="rate" class="form-control" disabled="disabled">
					</div>
					 -->
					 			
					<div class="panel panel-default">
					
					
				
 					 <div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="reqItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
								<th></th>
									<th><b>Item Code / Item Name</b></th>
									<th><b>Original Qty</b></th>
									<th><b>GR Qty</b></th>
									<th><b>Unit</b><div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()" id="addButton">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											
											
										</div><div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addDirectGRRow()" id="addSecondButton">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											
											
										</div></th>
								</tr>
								
							
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="0"/>
							<input type="hidden" name="rowId" id="rowId" value="0"/>
							<input type="hidden" name="grLevelRateId" id="grLevelRateId" value="0"/>
							

						</div>
					</div>
					
					<div class="panel panel-default">

						<div class="panel-heading">GR Level Rates 
						
						<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default" id="orderLevelButton"
												onclick="addGrLevelRates()" >
												<span class="glyphicon glyphicon-plus"></span>
											</button>
						</div>
						<div class="panel-body" style="padding: 0px;">
						<table id="addMultipleTable" class="table table-bordered ">
							<tr>
									<th>Rate Name</th>
									<th colspan="2">Rate Value</th>
									
								</tr>
							
							<input type="hidden" name="grLevelTotal" id="grLevelTotal" value="0"/>
						</table>	
						<input type="hidden" name="rowId" id="rowId" value="1"/>									
						</div>
					</div>
					
				</div>
					 
					 
					<div class="form-group" >
						<label for="rate" style="vertical-align: top">Bill Amount</label> 
						<input type="number" id="grLevelGrandTotal" name="grLevelGrandTotal" class="form-control" placeholder="Total Bill Amount" readonly>
					</div>
					
					
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Inward Remarks</label> 
						<textarea id="inwardRemarks"  name="inwardComments"class="formControl"  style="width: 100%; height:50px;" ></textarea>
					</div>
				
				</div><!-- end of form body -->


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onmouseenter="" onClick="validate()">
							<span class="glyphicon glyphicon-floppy-save"></span>
						</button>

						<button type="button" class="btn btn-danger">
							<span class="glyphicon glyphicon-remove" class="close"
								data-dismiss="modal" aria-hidden="true"></span>
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