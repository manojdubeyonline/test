<script>
function validate(){
	
	var billAmount = document.getElementById('billAmount').value;
	if(billAmount == ''){
		BootstrapDialog.alert('Please Enter Bill Amount');
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
	}
	
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
					<div class="form-group">
						<label for="item">Purchase Order Number</label> <input type="text" class="form-control"
							id="orderNo" name="orderNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  value="PurchaseOrder"><input type="hidden" 
							id="marking_id" name="marking_id" ><input type="hidden" 
							id="grpoId" name="grpoId" >
					</div>

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
					<!--  
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Order Remarks</label> 
						<textarea id="orderRemarks"  name="orderRemarks"class="formControl"  style="width: 100%; height:50px;" disabled="disabled"></textarea>
					</div>
					-->
					<div class="form-group">
						<label for="item">Supplier</label> <select
							class="form-control" id="vendor" name="vendor" disabled="disabled">
							<option value="" selected disabled>Select Supplier </option> 
						</select>
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
									<th><b>Order Qty</b></th>
									<th><b>GR Qty</b></th>
									<th><b>Unit</b><div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()" id="addButton">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											
											
										</div></th>
								</tr>
								
							
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="0"/>
							<input type="hidden" name="rowId" id="rowId" value="0"/>
							<input type="hidden" name="reqid" id="reqid" value=""/>

						</div>
					</div>
					 
					 
					<div class="form-group" >
						<label for="rate" style="vertical-align: top">Bill Amount</label> 
						<input type="number" id="billAmount" name="billAmount" class="form-control" placeholder="Total Bill Amount" >
					</div>
					
					
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Inward Remarks</label> 
						<textarea id="inwardRemarks"  name="inwardComments"class="formControl"  style="width: 100%; height:50px;" ></textarea>
					</div>
				
				</div><!-- end of form body -->


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onmouseenter="validate()" onClick="saveGRPO()">
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