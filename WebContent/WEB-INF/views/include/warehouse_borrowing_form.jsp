<div class="modal fade" id="warehouse_borriwing_form" role="dialog"
	aria-hidden="true">
	<form role="form" id="warehouseBorrowForm" name="warehouseBorrowForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title '>Warehouse Movement</h5>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<label for="item">From the firm</label>
						<select class="form-control" id="fromFirm" name="fromFirm"
							onChange="getWarehouseFirm('fromWarehouse', this.value) " required>
							<option value="" selected disabled>From Firm</option>
						</select>
						
				</div>
					<div class="form-group">
					<label for="item">From the warehouse</label>
						<select class="form-control" id="fromWarehouse" name="fromWarehouse" required>
						<option value="" selected disabled>From Warehouse</option>
						</select>
					</div>

					

					<div class="form-group">
						<label for="item">To the firm</label> <input type="hidden" id="firm2"
							name="firm2">
							
							
							<input type="text" class="form-control"
							id="firm1" name="firm1"  readonly="readonly">
							
							
							
					</div>
					
					<div class="form-group">
						<label for="item">To the warehouse</label> <input type="hidden" id="warehouse2"
							name="warehouse2">
							
							
							<input type="text" class="form-control" id="warehouse1"
							name="warehouse1" readonly="readonly">
							
							
							
					</div>
					
					<div class="form-group">
						<label for="item">Item</label> <input type="hidden" id="itemCode"
							name="itemCode"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly">
							<input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="orderType" name="orderType"  ><input type="hidden" 
							id="marking_id" name="marking_id" >
							
					</div>

					<div class=" form-group">

						<label for="qty">Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="number" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty">
							</div>
							<div class="col-md-5">
								<select id="unit" name="unit" class="form-control"></select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="item">Status</label> <select
							class="form-control" id="status" name="status">
							<option>Commit </option>
							<option>Dispatch </option>
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
					
					
					
					
					
				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							 onClick="saveWarehouseBorrow()">
							<span class="glyphicon glyphicon-floppy-save">Save</span>
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