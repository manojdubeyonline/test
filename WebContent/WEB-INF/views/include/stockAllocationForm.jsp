<script>
function validate(){
	var dueDate = document.getElementById('allocationDate').value;
	if(dueDate==''){
		BootstrapDialog.alert('Please select Allocation Date');
		return false;
	}
	saveStockAllocation()
}
</script>


<style>#modal-add-req{overflow-y:scroll;}</style>

<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="StockForm" name="StockForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title'>Stock Allocation Form</h5>
				</div>
				<div class="modal-body">
					<div class="form-group  form-group-sm">
						<label for="item">Stock Allocation Number</label> <input type="text" class="form-control"
							id="stockNo" name="stockNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="grpoId" name="grpoId" ><input type="hidden" 
							id="grpoRecieptId" name="grpoRecieptId" ><input type="hidden" 
							id="marking_id" name="marking_id" ><input type="hidden" 
							id="stockId" name="stockId">
					</div> 

                       <div class="form-group  form-group-sm">
						<label for="item">For the firm</label> <input type="hidden" id="firm"
							name="firm">
							
							<input type="hidden" id="warehouse"
							name="warehouse">
							<input type="text" class="form-control"
							id="firm1" name="firm1" readonly="readonly">
							
					</div>

                     <div class="form-group  form-group-sm">
						<label for="item">Supplier</label> 
							 <input type="text" class="form-control" name="vendor"
							id="vendor" placeholder="Vendor" disabled >
						
					</div>

                      <div class="form-group  form-group-sm">
				        <label for="item">GR Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker2">
				               <input type="text" class="form-control" name="grDate"
							id="grDate" placeholder="GR Date (dd/mm/yyyy)"  disabled>
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				    
				     <div class="form-group  form-group-sm">
				        <label for="item">Allocation Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="allocationDate"
							id="allocationDate" placeholder="Enter Allocation Date (dd/mm/yyyy)"  >
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				      
				    
                  <!--  
					<div class="form-group  form-group-sm">
						<label for="item">Item</label> <input type="hidden" id="item"
							name="item"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly">
					</div>

					
					<div class=" form-group">

						<label for="qty">Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="number" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty" disabled>
							</div>
							<div class="col-md-5">
								<select id="unit" name="unit" class="form-control" disabled></select>
							</div>
						</div>
					</div>
					
					
					<div class="form-group  form-group-sm" >
						<label for="rate" style="vertical-align: top">Rate</label> 
						<input type="number" id="rate" name="rate" class="form-control"  disabled>
					</div>
					
					
					  
					<div class="form-group  form-group-sm" >
						<label for="orderRemarks" style="vertical-align: top">Order Remarks</label> 
						<textarea id="orderRemarks"  name="orderRemarks"class="formControl"  style="width: 100%; height:50px;" disabled></textarea>
					</div>
					-->
					<div class="panel panel-default">
					
					 <div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="reqItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
						        	<th><b>Item Code</b></th>
									<th><b>Item Name</b></th>
									<th><b>Allocation Qty</b></th>
									<th><b>Unit</b></th>
									
								</tr>
								
							
							</table>
							<input type="hidden" name="rowid" id="rowid" value="0"/>
							

						</div>
					</div>
					<!-- 
					<div class="form-group  form-group-sm" >
						<label for="rate" style="vertical-align: top">Bill Amount</label> 
						<input type="number" id="rate" name="rate" class="form-control"  disabled>
					</div>
					
					<div class="form-group  form-group-sm">
						<label for="item">Approval</label> <select
							class="form-control" id="approvalStatus" name="approvalStatus" onchange="dynamicTextBox()">
							<option value="" selected disabled>Please Select</option>
							<option value="Y" >Approve</option>
							<option value="R" >Reject </option>
						</select>
					</div>
						<div id="dynamicRemarks"></div>
					<div class="form-group  form-group-sm" >
						<label for="approval_comments" style="vertical-align: top">Approval Remarks</label> 
						<textarea id="approval_comments"  name="approval_comments" class="formControl"  style="width: 100%; height:50px;"></textarea>
					</div>
					 -->
				</div>


				<div class="modal-footer">
					<div class="form-group  form-group-sm">

						<button type="button" class="btn btn-success" id="addReqSave"
							onClick="validate()">
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

