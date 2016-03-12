<script>
function removeOption(){
	var $donorFirm = $("select[name='firm']");
	var $receiverFirm = $("select[name='receiverFirm']");

	$donorFirm.change(function() {
	    $receiverFirm.find('option').prop("disabled", false);
	    var selectedItem = $(this).val();
	    if (selectedItem) {
	        $receiverFirm.find('option[value="' + selectedItem + '"]').prop("disabled", true);
	    }
	});
}
</script>
<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="warehouseForm" name="warehouseForm"  method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h5 class='modal-title '>Warehouse</h5>
				</div>
				<div class="modal-body">
				<div class="form-group">
						<select class="form-control" id="firm" name="firm"
							onChange="getWarehouseFirm('warehouse', this.value) " required onclick="removeOption();">
							<option value="" >Donor Firm</option>
						</select>
						
				</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse" required>
						<option value="" >Donor Warehouse</option>
						</select>
					</div>
					
					<div class="form-group">
						<select class="form-control" id="receiverFirm" name="receiverFirm" 
						onChange="getWarehouseFirm('receiverwarehouse', this.value) " onclick="removeOption();">
							<option value="" >Receiver Firm</option>
						</select>
				</div>
					<div class="form-group">
						<select class="form-control" id="receiverwarehouse" name="receiverwarehouse" required>
							<option value="" >Receiver Warehouse</option>
						</select>
					</div>
					
					<div class="form-group">
						<select class="form-control" id="status" name="status" >
						<option value="Commit" >Commit</option>	
						<option value="Dispatch" >Dispatch</option>
						
						</select>
				    </div>
					
					
				

					 <div class="form-group">
				        
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="borrowApprovalDate"
							id="borrowApprovalDate" placeholder="Date (dd/mm/yyyy)" />
							<input type="hidden" 
							id="issueStatus" name="issueStatus"  value="N">
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>

					
					<input type="hidden" name="requisitionId" id="requisitionId"  />
				
					<div class="panel panel-default">
					<div class="panel-heading"> Warehouse Items
					<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											<button type="button" class="btn btn-default" id="addReqSave"
											 onClick="saveWarehouse()"><span class="glyphicon glyphicon-floppy-save"></span></button>
											
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