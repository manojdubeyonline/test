<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="reqForm" name="reqForm" action="saveRequisition"
		method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<h4 class='modal-title'>Add Requisition</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<select class="form-control" id="item" name="item">
							<option value="" selected>Select Item</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('firm', this.value) ">
							<option value="" selected>For the Firm</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse">
							<option value="" selected>Raised To Warehouse</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" id="qty" name="qty"
							placeholder="Quantity">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Required By Date(dd/mm/yyyy)" />
					</div>
					<input type="hidden" name="requisitionId" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="addReqSave"
						onClick="saveUpdateRequisition()">Save</button>
				</div>
			</div>
		</div>

	</form>
</div>