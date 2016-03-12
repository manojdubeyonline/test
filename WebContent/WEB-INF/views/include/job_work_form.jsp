<script>

function vali(){
	
	var vendor = document.getElementById('vendor5').value;
	if(vendor == ''){
		BootstrapDialog.alert('Please select vendor');
		return false;
	}
	
	var qoutation_no = document.getElementById('quotationNo').value;
	if(qoutation_no == '') {
		BootstrapDialog.alert('Please provide qoutation number');
		return false;
	}
	
	var count = document.getElementById('masterItemId').value;
	var rowCount = document.getElementById('itemRowId').value;
	var rateLevel = document.getElementById('rateRowId').value;
	
	for(var i=0;i<count;i++){
		var qty = document.getElementById('Quantity'+i).value;
		if(qty == ''){
			BootstrapDialog.alert('Please Enter item Qty');
			return false;
		}
		for(var j=0;j<count;j++){
			if( document.getElementById('item'+i).value == document.getElementById('item'+j).value && i != j){
				BootstrapDialog.alert('Item can not be same');
			return false;
		}
	}
}
	for(var p=0;p<count;p++){
		for(var q=0;q<rowCount;q++){
			for(var r=0;r<rowCount;r++){
				if(document.getElementById("item"+p+q) == null || document.getElementById("item"+p+r) == null  )
					continue;
				else
				{
					if( document.getElementById('item'+p+q).value == document.getElementById('item'+p+r).value && q != r){
						BootstrapDialog.alert('Two rate names can not be same');
					return false;
					}
					var itemQty = document.getElementById('qty'+q+r).value;
					if(itemQty == ''){
						BootstrapDialog.alert('Please Enter converted item Qty');
						return false;
					}
					var itemRate = document.getElementById('Rate'+q+r).value;
					if(itemRate == ''){
						BootstrapDialog.alert('Please Enter converted item rate ');
						return false;
					}
				}
			}
		}
		
	}
	
	for(var m=0;m<rateLevel;m++){
		for(var n=0;n<rateLevel;n++){
			if( document.getElementById('jobRateName'+m).value == document.getElementById('jobRateName'+n).value && m != n){
				BootstrapDialog.alert('Two rate names can not be same at Rates');
				return false;
			}	
		}
	}

}
</script>
	<style>
	.form-control{
	font-size: 12px;}
	
	#job-work-form{overflow-y:scroll;}
	</style>
	
	<div class="modal fade" id="job-work-form" role="dialog"
	aria-hidden="true">
	<form role="form" id="jobWorkForm" name="jobWorkForm" method="post" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title '>Job Work Order Form</h5>
				</div>
				<div class="modal-body">
				
				
				
				<div class="form-group">
				
						<label for="item">Firm</label> <input type="hidden" id="firm"
							name="firm" >
							
							<select  class="form-control"
							id="firm2" name="firm2" onChange="generateJobWorkNo('jobWorkNo', this.value)">
							<option value="" selected disabled>Select Firm </option>
							</select>
							
					</div>
					
					<div class="form-group">
						<label for="item">Job Work Order Number</label> <input type="text" class="form-control"
							id="jobWorkNo" name="jobWorkNo" readonly="readonly"><input type="hidden" 
							id="jobWorkId" name="jobWorkId" >
					</div>
					
					<div class="form-group">
						<label for="vendor">Vendor</label> <select
							class="form-control" id="vendor5" name="vendor5">
							<option value="" selected disabled>Select Vendor </option>
						</select>
					</div>
					
					<div class="form-group">
				        <label for="item">Job Work Order Date</label> 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker1">
				               <input type="text" class="form-control" name="jobWorkDate"
							id="jobWorkDate" placeholder="Job Work Order Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
				    </div>
				    
				    <div class=" form-group">

						<label for="item">Quotation Date</label>
						<label for="rate" style="margin-left:42%">Quotation Number</label>
						<div class="row">
						<div class="col-md-6" >	 
				        <div class="date">
				            <div class="input-group input-append date" id="dateRangePicker2">
				               <input type="text" class="form-control" name="quotationDate"
							id="quotationDate" placeholder="Quotation Date (dd/mm/yyyy)" />
				                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				            </div>
				        </div>
							</div>
							<div class="col-md-6" >
						 <input type="text" id="quotationNo" name="quotationNo" class="form-control" placeholder="Quotation Number">
					</div>
						</div>
					</div>
                    <!--  
					<div class="form-group">
						<label for="item">Item</label> <input type="hidden" id="item"
							name="item"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly">
					</div>

					

					<div class=" form-group">

						<label for="qty">Qty</label>
						<label for="rate" style="margin-left:58%">Rate</label>
						<div class="row">
							<div class="col-md-5">
								<input type="number" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty">
							</div>
							<div class="col-md-2">
								<select id="unit" name="unit" class="form-control"></select>
							</div>
							
							
							<div class="col-md-5" >
						 <input type="number" id="rate" name="rate" class="form-control" placeholder="Rate">
					</div>
						</div>
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
						<textarea id="orderRemarks"  name=" orderRemarks"class="formControl"  style="width: 100%; height:50px;"></textarea>
					</div>
					-->
					
					 <div class="panel-body" style="padding: 0px;">

							<table class="table table-bordered table-hover" id="jobWorkItemTable" style="margin-top: 0px; width:100%; valign:top;">
								
								<tr class="active">
									
									<th>Item Code</th>
									<th>Item Name</th>
									<th>Quantity</th>
									<th>Unit<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addJobWorkRow()" id="addButton">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											
											
										</div></th>
									
									
								</tr>
								
								
								
								
							
							</table>
							<input type="hidden" name="masterItemId" id="masterItemId" value="0"/>
							<input type="hidden" name="itemRowId" id="itemRowId" value="0"/>
							<input type="hidden" name="rateRowId" id="rateRowId" value="0"/>
							

						</div>
						
						
						
					<div class="panel panel-default">

						<div class="panel-heading"> Rates 
						
						<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default" id="orderLevelButton"
												onclick="jobWorkRates()" >
												<span class="glyphicon glyphicon-plus"></span>
											</button>
						</div>
						<div class="panel-body" style="padding: 0px;">
						<table id="addJobWorkTable" class="table table-bordered ">
							<tr>
									<th>Rate Name</th>
									<th colspan="2">Rate Value</th>
									
								</tr>
							
							
						</table>	
														
						</div>
					</div>
					
				</div>
				<div class="form-group">
						<label for="item">Total</label> <input type="text" class="form-control"
							id="jobWorkTotal" name="jobWorkTotal" placeholder="Total" readonly="readonly">
					</div>
					
					<div class="form-group" >
						<label for="remarks" style="vertical-align: top">Remarks</label> 
						<textarea id="jobRemarks"  name=" jobRemarks"class="formControl"  style="width: 100%; height:50px;"></textarea>
					</div>	
					
				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
							 onClick="saveJobWorkOrder()" onmouseenter="vali()">
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