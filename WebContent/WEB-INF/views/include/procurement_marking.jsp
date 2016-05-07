<script>
function validate(){
	
	var duedate = document.getElementById('dueDate').value;
	if(duedate == ''){
		BootstrapDialog.alert('Please select due date');
		return false;
	}
	var procurement_method = document.getElementById('procurementType').value;
	if(procurement_method == '') {
		BootstrapDialog.alert('Please select procurement method');
		return false;
	}
	saveProcurement()
}

function numbersonly(form_element, e, decimal) {
	 var key;
	     var keychar;
	     
	     if (window.event) {
	        key = window.event.keyCode;
	     }
	     else if (e) {
	       key = e.whichs;
	    }
	    else {
	       return true;
	    }
	    keychar = String.fromCharCode(key);
	    
	    if ((key==null) || (key==0) || (key==8) ||  (key==9) || (key==13) || (key==27) ) {
	       return true;
	    }
	    else if ((("0123456789").indexOf(keychar) > -1)) {
	       return true;
	    }
	    else if (decimal && (keychar == ".")) { 
		if(form_element.value.indexOf('.')>0){
			return false;
		}
	      return true;
	    }
	    else
	       return false;
	}

	</script>
<div class="modal fade" id="modal-add-req" role="dialog"
	aria-hidden="true">
	<form role="form" id="procurementForm" name="procurementForm" method="post">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header panel-success'">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h5 class='modal-title '>Item Procurement Marking</h5>
				</div>
				<div class="modal-body">


					<div class="form-group">
						<label for="item">Item</label> <input type="hidden" id="item"
							name="item"><input type="text" class="form-control"
							id="item1" name="item1" readonly="readonly"><input type="hidden" 
							id="marking_id" name="marking_id" >
							
							<input type="hidden" 
							id="associatedRequisitionItemId" name="associatedRequisitionItemId" >
							<input type="hidden" 
							id="requisition_no" name="requisition_no" >
							<input type="hidden" 
							id="associatedRequisitionId" name="associatedRequisitionId" >
							
							<input type="hidden" 
							id="currentStatus" name="currentStatus" value="M" >
					</div>

					<div class="form-group">
						<label for="item">For the firm</label> <select
							class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('warehouse', this.value) ">
							<option value="" selected disabled>For the Firm</option>
						</select>
					</div>

					<div class="form-group">
						<label for="item">For the warehouse</label> <select
							class="form-control" id="warehouse" name="warehouse">
							<option value="" selected disabled>Store</option>
						</select>
					</div>

					<div class="form-group">
						<label for="item">Procure By</label>
						<div class="date">
							<div class="input-group input-append date" id="dateRangePicker">
								<input type="text" class="form-control" name="dueDate"
									id="dueDate" placeholder="Procure By (dd/mm/yyyy)" /> <span
									class="input-group-addon add-on"><span
									class="glyphicon glyphicon-calendar"></span></span>
							</div>
						</div>
					</div>
					<div class=" form-group">

						<label for="qty">Qty</label>
						<div class="row">
							<div class="col-md-7">
								<input type="text" class="form-control input-sm" id="qty"
									name="qty" placeholder="enter marking qty" onkeypress="return numbersonly(this,event, true);">
							</div>
							<div class="col-md-5">
								<input type="hidden" id="unit" name="unit" class="form-control" /><span id="unit1" class="form-control"></span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="item">Procurement Method</label> <select
							class="form-control" id="procurementType" name="procurementType">
							<option value="" selected disabled>Select Procurement Method </option>
							<option value="Purchase Order" >Purchase Order</option>
							<option value="Local Purchase" >Local Purchase</option>
							<option value="Warehouse Borrowing" >Warehouse Borrowing</option>
						</select>
					</div>

				</div>


				<div class="modal-footer">
					<div class="form-group">

						<button type="button" class="btn btn-success" id="addReqSave"
						onmouseenter=""	onClick="validate()">
							<span class="glyphicon glyphicon-floppy-save">Save </span>
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