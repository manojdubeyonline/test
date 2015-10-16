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
						<label for="item">Item</label> <input type="hidden" id="item"
							name="item"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly">
					</div>

					<div class="form-group">
						<label for="item">For the firm</label> <input type="hidden" id="firm"
							name="firm">
							
							<input type="hidden" id="warehouse"
							name="warehouse">
							<input type="text" class="form-control"
							id="firm1" name="firm1" readonly="readonly">
							
					</div>
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Order Remarks</label> 
						<textarea id="orderRemarks"  name="orderRemarks"class="formControl"  style="width: 100%; height:50px;" disabled="disabled"></textarea>
					</div>
					<div class="form-group">
						<label for="item">Supplier</label> <select
							class="form-control" id="vendor" name="vendor" disabled="disabled">
							<option value="" selected disabled>Select Supplier </option> 
						</select>
					</div>
					<div class=" form-group"">

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
					<div class=" form-group"">

						<label for="qty">Inward Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="number" class="form-control input-sm" id="inward_qty"
									name="inward_qty" placeholder="enter inward qty">
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
					
					<div class="form-group" >
						<label for="rate" style="vertical-align: top">Bill Amount</label> 
						<input type="number" id="billAmount" name="billAmount" class="form-control" placeholder="Total Bill Amount" >
					</div>
					
					<div class="form-group">
				        <label for="item">Expected Delivery Date</label> 
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Due Date (dd/mm/yyyy)"  disabled="disabled"/>
					</div>
				    
				    <div class="form-group">
				        <label for="item">Inward Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="inward_date"
							id="inward_date" placeholder="Inward Date (dd/mm/yyyy)"  />
				             <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
					<div class="form-group" >
						<label for="orderRemarks" style="vertical-align: top">Inward Remarks</label> 
						<textarea id="orderRemarks"  name="inwardComments"class="formControl"  style="width: 100%; height:50px;" ></textarea>
					</div>
				
				</div><!-- end of form body -->


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onClick="saveGRPO()">
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