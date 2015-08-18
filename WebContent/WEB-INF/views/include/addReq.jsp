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
						<select class="form-control" id="firm" name="firm"
							onChange="getFirmWarehouses('firm', this.value) " required>
							<option value="" selected>For the Firm</option>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" id="warehouse" name="warehouse" onchange="generateRefNo();" required>
							<option value="" selected>Store</option>
						</select>
					</div>
					
					<div class="form-group" >
						<input type="text" class="form-control" name="dueDate"
							id="dueDate" placeholder="Required By Date(dd/mm/yyyy)" />
					</div>
					
					<div class="form-group">
						<input type="text" class="form-control" name="requisitionRefNo"
							id="requisitionRefNo" placeholder=" Reference Number" readonly  required/>
					</div>
					
					<input type="hidden" name="requisitionId" />
				
					<div class="panel panel-default">
					<div class="panel-heading"> Requisition Items</div>
 					 <div class="panel-body">

							<table class="table table-bordered table-hover" id="reqItemTable">
								<tr>
									<td colspan="7">
										<div class="btn-group" style="float: right">
											<button type="button" class="btn btn-default"
												onclick="addRow()">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
											
											<button type="button" class="btn btn-default" id="addReqSave"
												onClick="saveUpdateRequisition()"><span class="glyphicon glyphicon-floppy-save"></span></button>
											
											<button type="button" class="btn btn-default"
												data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
										</div>
									</td>
								</tr>
								<tr class="active">
									<th></th>
									<th>Priority</th>
									<th>Pick Item</th>
									<th>PL No</th>
									<th>Description</th>
									<th>Qty</th>
									<th>Unit</th>
								</tr>
								<%
									int count = 0;
								%>

								<tr>
									<td></td>
									<td><select class="form-control" name="priority<%=count%>"
										id="priority<%=count%>">
											<option value="0">Normal</option>
											<option value="1">High</option>
											<option value="2">Urgent</option>

									</select></td>
									<td>
										<input type="text" name="codeId<%=count%>" readOnly placeHolder="Click to pick the Item"
											class="form-control" id="codeId<%=count%>" onClick="popPicker('<%=count%>')">
									</td>
									<td><input type="text" name="pl_no<%=count%>"
										id="pl_no<%=count%>" class="form-control" placeholder="PL No" /></td>
									<td><input type="text" placeholder="Item Description"
										name="item_desc<%=count%>" id="item_desc<%=count%>"
										class="form-control" /></td>
									<td><input type="text" class="form-control"
										id="qty<%=count%>" name="qty<%=count%>" placeholder="Quantity"></td>
									<td><select class="form-control" id="unit<%=count%>"
										name="unit<%=count%>">
									</select> <script>
							$(document).ready(function(){
								getUnits('unit<%=count%>');
							});

							</script></td>

								</tr>
							</table>
							<input type="hidden" name="rowhid" id="rowhid" value="<%=++count %>"/>

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