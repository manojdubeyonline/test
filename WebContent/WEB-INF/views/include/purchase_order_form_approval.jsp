<style>#modal-add-req{overflow-y:scroll;}</style>


<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="orderForm" name="orderForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title'>Purchase Order Approval Form</h5>
				</div>
				<div class="modal-body">
					<div class="form-group  form-group-sm">
						<label for="item">Purchase Order Number</label> <input type="text" class="form-control"
							id="orderNo" name="orderNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  value="PurchaseOrder"><input type="hidden" 
							id="marking_id" name="marking_id" >
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
						<label for="item">Supplier</label> <select
							class="form-control" id="vendor" name="vendor" disabled>
							<option value="" selected disabled>Select Supplier </option>
						</select>
					</div>

                        <div class="form-group  form-group-sm">
				        <label for="item">Expected Delivery Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Due Date (dd/mm/yyyy)"  disabled>
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
					<div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="reqItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
									
									<th>Item Code</th>
									<th>Item Name</th>
									<th>Original Qty</th>
									<th>Order Qty</th>
									<th>Unit</th>
										
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
					
					
					
					<div class="form-group  form-group-sm">
						<label for="item">Approval</label> <select
							class="form-control" id="approvalStatus" name="approvalStatus">
							<option value="Y" selected>Approve</option>
							<option value="R" selected>Reject </option>
						</select>
					</div>
						
					
					
					
					
				</div>


				<div class="modal-footer">
					<div class="form-group  form-group-sm">

						<button type="button" class="btn btn-success" id="addReqSave"
							onClick="savePurchaseOrderApproval()">
							<span class="glyphicon glyphicon-floppy-save">Save</span>
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