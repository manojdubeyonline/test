<script>
function validate(){
	var firm = document.getElementById('firm').value;
	if(firm == ''){
		BootstrapDialog.alert('Please select Firm');
		return false;
	}
	var warehouse = document.getElementById('warehouse').value;
	if(warehouse == '') {
		BootstrapDialog.alert('Please select Store');
		return false;
	}
	var dueDate = document.getElementById('dueDate').value;
	if(dueDate==''){
		BootstrapDialog.alert('Please select Date');
		return false;
	}
	var count = document.getElementById('rowhid').value;
	count = count - 1;
	for(i = 0; i <= count; i++){
		var codeId = document.getElementById('codeId'+i).value;
		if(codeId == ''){
			BootstrapDialog.alert('Please Pick item');
			return false;
		}
		var qty = document.getElementById('qty'+i).value;
		if(qty =='' || qty == null || qty =='undefined'){
			BootstrapDialog.alert('Please Enter Qty');
			return false;
		}
	}
	
}
</script><div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="reqForm" name="reqForm" action="saveRequisition"
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
						<select class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('warehouse', this.value,'') " required>
							<option value="" selected>For the Firm</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse" onchange="generateRefNo();" required>
							<option value="" selected>Store</option>
						</select>
					</div>
					
					 <div class="form-group">
				        
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Required By Date(dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
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
											onmouseenter="validate()"	onClick="saveUpdateRequisition()"><span class="glyphicon glyphicon-floppy-save"></span></button>
											
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
							<input type="hidden" name="pdf_ref_no" id="pdf_ref_no" value=""/>
							<input type="hidden" name="reqid" id="reqid" value=""/>

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
<script>
function viewPDF(internal_ref_no, reqId){
	document.forms[0].pdf_ref_no.value=internal_ref_no;
	document.forms[0].reqid.value = reqId;
	document.forms[0].action="PdfBuilder";
	doucment.forms[0].submit();
	
}

</script>