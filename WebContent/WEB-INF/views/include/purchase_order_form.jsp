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
	
	var count = document.getElementById('rowhid').value;
	var rowCount = document.getElementById('rowId').value;
	var orderLevel = document.getElementById('orderLevelRowId').value;
	
	for(var i=0;i<count;i++){
		var qty = document.getElementById('Order_Qty'+i).value;
		if(qty == ''){
			BootstrapDialog.alert('Please Enter Order Qty');
			return false;
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
}


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
				
						<label for="item">For the firm</label> <input type="hidden" id="firm"
							name="firm" >
							
							<input type="hidden" id="warehouse"
							name="warehouse">
							<select  class="form-control"
							id="firm1" name="firm1" onChange="generateOrderNo('orderNo', this.value)">
							<option value="" selected disabled>Select Firm </option>
							</select>
							
					</div>
					
					<div class="form-group">
						<label for="item">Purchase Order Number</label> <input type="text" class="form-control"
							id="orderNo" name="orderNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  >
					</div>
					
					
					<div class="form-group">
						<label for="item">Vendor</label> <select
							class="form-control" id="vendor" name="vendor">
							<option value="" selected disabled>Select Vendor </option>
						</select>
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
							
							
						</table>	
						<input type="hidden" name="rowId" id="rowId" value="1"/>									
						</div>
					</div>
					
				</div>
				<div class="form-group">
						<label for="item">Total</label> <input type="text" class="form-control"
							id="total" name="total" placeholder="Total" readonly="readonly">
					</div>
						
					
				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onmouseenter="validate()" onClick="savePurchaseOrder()">
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