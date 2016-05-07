<script>
function validation(){
var count = document.getElementById('rowhid').value;
var rowCount = document.getElementById('rowId').value;
var grLevel = document.getElementById('grLevelRateId').value;

for(var i=0;i<count;i++){
	var qty = document.getElementById('gr_Approve_Qty'+i).value;
	if(qty == ''){
		BootstrapDialog.alert('Please Enter GR Approval Qty');
		return false;
	}
	for(var j=0;j<rowCount;j++){
		for(var k=0;k<rowCount;k++){
			if(document.getElementById("rateName"+i+j) == null || document.getElementById("rateName"+i+k) == null  )
				continue;
			else
			{
				if( document.getElementById('rateName'+i+j).value == document.getElementById('rateName'+i+k).value && j != k){
					BootstrapDialog.alert('Two rate names can not be same');
				return false;
				}
			}
		}			
	} 
	for(var j=0;j<rowCount;j++){
		if(document.getElementById('rateValue'+i+j) == null)
			continue;
		else{
		var hiddenBasicRate = parseFloat(document.getElementById('hiddenRateValue'+i+j).value);
		var basicRate = parseFloat(document.getElementById('rateValue'+i+j).value);
		if(basicRate>hiddenBasicRate){
			BootstrapDialog.alert('Basic Rate Should Be Less Then Privious Basic Rate(Rs.'+hiddenBasicRate+' ) ');
			return false;
		 }
		}
	}
}
for(var m=0;m<grLevel;m++){
	for(var n=0;n<grLevel;n++){
		if( document.getElementById('ratesName'+m).value == document.getElementById('ratesName'+n).value && m != n){
			BootstrapDialog.alert('Two rate names can not be same at order level');
			return false;
		}	
	}
}
saveGRPOApproval()
}
</script>


<style>#modal-add-req{overflow-y:scroll;}</style>

<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="GrpoApprovalForm" name="GrpoApprovalForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">�</button>
					<h5 class='modal-title'>GRPO Approval Form</h5>
				</div>
				<div class="modal-body">
					<div class="form-group  form-group-sm">
						<label for="item">Goods Reciept Number</label> <input type="text" class="form-control"
							id="grRecieptNo" name="grRecieptNo" readonly="readonly"><input type="hidden" 
							id="orderId" name="orderId" ><input type="hidden" 
							id="grpoId" name="grpoId" ><input type="hidden" 
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
				        <label for="item">GR Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker2">
				               <input type="text" class="form-control" name="grDate"
							id="grDate" placeholder="GR Date (dd/mm/yyyy)"  disabled>
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				    
				      <div class=" form-group">

						<label for="item">Invoice Number</label>
						<label for="rate" style="margin-left:42%">Invoice Date</label>
						<div class="row">
						
							<div class="col-md-6" >
						 <input type="text" id="invoiceNo" name="invoiceNo" class="form-control" placeholder="Invoice Number">
					</div>
					<div class="col-md-6" >	 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker">
				               <input type="text" class="form-control" name="invoiceDate"
							id="invoiceDate" placeholder="Invoice Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
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
						        	<th><b>Item Code / Item Name</b></th>
									<th><b>GR Qty</b></th>
									<th><b>Approval Qty</b></th>
									<th><b>Unit</b></th>
									
								</tr>
								
							
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="0"/>
							<input type="hidden" name="rowId" id="rowId" value="0"/>
							<input type="hidden" name="grLevelRateId" id="grLevelRateId" value="0"/>
							

						</div>
					</div>
					
					
					<div class="panel panel-default">

						<div class="panel-heading">GR Level Rates 
						
						<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default" id="orderLevelButton"
												onclick="addGrLevelRates()" >
												<span class="glyphicon glyphicon-plus"></span>
											</button>
						</div>
						<div class="panel-body" style="padding: 0px;">
						<table id="addMultipleTable" class="table table-bordered ">
							<tr>
									<th>Rate Name</th>
									<th colspan="2">Rate Value</th>
									
								</tr>
							
							<input type="hidden" name="grLevelTotal" id="grLevelTotal" value="0"/>
						</table>	
						<input type="hidden" name="rowId" id="rowId" value="1"/>									
						</div>
					</div>
					
				</div>
					
					<div class="form-group  form-group-sm" >
						<label for="rate" style="vertical-align: top">Bill Amount</label> 
						<input type="number" id="totalBillAmount" name="totalBillAmount" class="form-control" readonly>
						<input type="hidden" id="grTotalRateAppliedId" name="grTotalRateAppliedId" >
						<input type="hidden" id="grLevelId" name="grLevelId" >
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
					
				</div>


				<div class="modal-footer">
					<div class="form-group  form-group-sm">

						<button type="button" class="btn btn-success" id="addReqSave"
							onClick="validation()">
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

<script>
function dynamicTextBox(){
	var s = null;
	if(document.getElementById('approvalStatus') == null){
		BootstrapDialog.alert('Please Select Approval');
		return false;
	}
	else{
		var status = document.getElementById('approvalStatus').value;
		if(status == 'R'){
			 s = '<div id="divRemove"><label for="approval_comments" style="vertical-align: top">Reason For Rejection</label>';
			 s+= '<textarea name="rejectRemaks" id="rejectRemarks" class="formControl" class="formControl" style="width: 100%; height:50px;" required></textarea ></div><br>';
			 document.getElementById("dynamicRemarks").innerHTML=s;
			//dynamicRemarks.innerHTML = dynamicRemarks.innerHTML +"<label for='approval_comments' style='vertical-align: top'>Reason For Rejection</label> <br><textarea name='mytext' class='formControl' style='width: 100%; height:50px;'></textarea ><br>"
		}
		if(status == 'Y'){
			
				 $("#divRemove").remove();
			}
		
	}
}

</script>