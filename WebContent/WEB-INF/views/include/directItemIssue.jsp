<script>
function validateQty(){
	
	var user = document.getElementById('user').value;
	if(user == ''){
		BootstrapDialog.alert('Please Select User Name');
		return false;
	}
	var firm = document.getElementById('firm').value;
	if(firm == ''){
		BootstrapDialog.alert('Please Select Firm');
		return false;
	}
	
	var warehouse = document.getElementById('warehouse').value;
	if(warehouse == ''){
		BootstrapDialog.alert('Please Select Store');
		return false;
	}
	var dueDate = document.getElementById('dueDate').value;
	if(dueDate == ''){
		BootstrapDialog.alert('Please Select Issue Date');
		return false;
	}
	
	var count = document.getElementById('rowhid').value;
	count = --count;
	for(i = 1; i <= count; i++){
		
		var codeId = document.getElementById('codeId'+i).value;
		if(codeId == '')
			{
			BootstrapDialog.alert('Please Pick Item');
			return false;
			}
		
		var availableQty = document.getElementById('availableQtyId'+i).innerHTML;
		if(availableQty =='' || availableQty == null || availableQty =='undefined'){
		BootstrapDialog.alert('Qty is not Available');
		}
		else {
		var availQty = parseInt(availableQty);
		var qty = document.getElementById('qty'+i).value;
		var q = parseInt(qty);
		if(q > availQty) {
			BootstrapDialog.alert('Qty is not greater than Available Qty');
			return false;
		}
		else {
			return true;
		}
		}
		return true;
	}
	
}

</script>

<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="issueForm" name="issueForm"  method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h5 class='modal-title '>Item Issue</h5>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<select class="form-control" id="user" name="user" required onchange="getUserFirms('firm',this.value)">
							<option value="" selected disabled>Issued To the User</option>
						</select>
					</div>
					
					<div class="form-group">
						<select class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('warehouse', this.value) " required>
							<option value="" selected disabled>For the Firm</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse" onchange="generateRefNo();" required>
							<option value="" selected disabled>Store</option>
						</select>
					</div>

					 <div class="form-group">
				        
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Issue Date (dd/mm/yyyy)" />
							<input type="hidden" 
							id="issueStatus" name="issueStatus"  value="N">
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>

					<div class="form-group">
						<input type="text" class="form-control" name="requisitionRefNo"
							id="requisitionRefNo" placeholder=" Reference Number" readonly  required/>
					</div>
					
					<input type="hidden" name="requisitionId" id="requisitionId"  />
					<input type="hidden" name="reqItemId" id="reqItemId"  />
				
					<div class="panel panel-default">
					<div class="panel-heading"> Requisition Items
					<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											<button type="button" class="btn btn-default" id="addReqSave"
											onmouseenter="validateQty();" onClick="saveItemIssue()"><span class="glyphicon glyphicon-floppy-save"></span></button>
											
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
    width:90%;
}
</style>