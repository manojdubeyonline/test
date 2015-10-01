<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="reqForm" name="reqForm" action="directItemIssue"
		method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<h5 class='modal-title'>Add Requisition</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" >
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<select class="form-control" id="user" name="user" required>
							<option value="" selected disabled>Issued To the User</option>
						</select>
					</div>
					
					<div class="form-group">
						<select class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('firm', this.value) " required>
							<option value="" selected disabled>For the Firm</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse" onchange="generateRefNo();" required>
							<option value="" selected disabled>Store</option>
						</select>
					</div>

					<div class="input-append" id="datetimepicker">
						<input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Date of Issue(dd/mm/yyyy)" />
						
						<span class="add-on"> <i data-time-icon="icon-time"
							data-date-icon="icon-calendar"></i>
						</span>
					</div>

					<div class="form-group">
						<input type="text" class="form-control" name="requisitionRefNo"
							id="requisitionRefNo" placeholder=" Reference Number" readonly  required/>
					</div>
					
					<input type="hidden" name="requisitionId" id="requisitionId"  />
				
					<div class="panel panel-default">
					<div class="panel-heading"> Requisition Items
					<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											<button type="button" class="btn btn-default" id="addReqSave"
												onClick="saveUpdateRequisition()"><span class="glyphicon glyphicon-floppy-save"></span></button>
											
										</div>
					</div>
 					 <div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="reqItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
									<th></th>
									<th>Priority</th>
									<th>Pick Item</th>
									<th>PL No</th>
									<th>Description</th>
									<th>Avail. Qty</th>
									<th>Qty</th>
									<th>Unit</th>
								</tr>
								
							
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="0"/>

						</div>
					</div>
					
						
					

				</div>
			
			</div>
		</div>

	</form>
</div>
<style>
.modal-dialog {
     padding: 15px;
    width:80%;
}
</style>