<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="orderForm" name="orderForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">�</button>
					<h5 class='modal-title '>Purchase Order Form</h5>
				</div>
				<div class="modal-body">


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

					<div class=" form-group"">

						<label for="qty">Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="text" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty">
							</div>
							<div class="col-md-5">
								<select id="unit" name="unit" class="form-control"></select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="item">Supplier</label> <select
							class="form-control" id="vendor" name="vendor">
							<option value="" selected disabled>Select Supplier </option>
						</select>
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
						<textarea id="orderRemarks" class="formControl"  style="width: 100%; height:50px;"></textarea>
					</div>
					
				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							onClick="saveProcurement()">
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