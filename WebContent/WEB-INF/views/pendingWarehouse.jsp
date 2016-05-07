<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#pendingWarehouse").attr("class","active");
	var w=1000;
		
		
			
		$('#flex1').flexigrid({
			url:'getPendingWarehouseList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				
				
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Order Type', name : '', width:100, sortable : true, align: 'left'},
				
				
				
					],
		  buttons : [
					//{separator: true},
				 	//{name: ' Direct', bclass: 'glyphicon glyphicon-export', onpress : addWarehouse},
				 	{separator: true},
				 	{name: ' Issue', bclass: 'glyphicon glyphicon-send', onpress : issue},
		            {separator: true},

	      ],
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	                
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
			//title: 'Purchase Orders',
			useRp: true,
			rp: 1000,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w*.74,
			singleSelect: true

		});

		$('#flex2').flexigrid({
			url:'getWarehouseBorrowList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
				{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Warehouse Borrow No', name : '', width:120, sortable : false, align: 'center'},
				{display: 'Donor Firm', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Reciever Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Donor Warehouse', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Reciever Warehouse', name : '', width:100, sortable : true, align: 'left'},

				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit', bclass: 'glyphicon glyphicon-pencil', onpress : open},
				 	
		            {separator: true},

	      ],
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	             
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
			//title: 'Purchase Orders',
			useRp: true,
			rp: 1000,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w*.74,
			singleSelect: true

		});
//getUsers('user');
var user =${_SessionUser.userId};

getUserFirms("fromFirm",user)
//getFirms("firm");
///getReceiverFirm("receiverFirm");
//getFromFirm("fromFirm");
//getWarehouses("warehouse");
//getVendors("vendor");
getUnits("unit");

});


function addWarehouse() {
	$('#modal-add-req').modal({
		keyboard : true
		
	});
	$("#requisitionRefNo");
	$("#warehouse");
	$("#user");
	$("#dueDate");
	$("#firm");
   
	$("#requisitionRefNo").val('');
	$("#warehouse").val('');
	$("#user").val('');
	$("#dueDate").val('');
	$("#firm").val('');
	$("#warehouse").val("");
	$("#rowhid").val(1);
	
	$("#reqItemTable").find("tr:gt(0)").remove();
	addRow();
	
	$('#modal-add-req').modal.show()
}



function addRow() {
	var count = $("#rowhid").val();
	var tbl = document.getElementById("reqItemTable");
	var lastRow = tbl.rows.length;
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);

	var content = "<td>";
	if(lastRow >1){
		content+="<a href='#' onclick='removeRow("
			+ count
			+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a>";
		}
	content+="</td>"
			+ " <td><select class=\"form-control\" name=\"priority"+count+"\""
	+" 	id=\"priority"+count+"\">"
			+ " 		<option value=\"0\">Normal</option>"
			+ " 		<option value=\"1\">High</option>"
			+ " 		<option value=\"2\">Urgent</option>"
			+ " </select></td>"
			+ " <td><input type=\"text\" required readonly name=\"codeId"
			+ count
			+ "\""
			+ " 	class=\"form-control\" id=\"codeId"
			+ count
			+ "\" onclick=\"popPicker('"
			+ count
			+ "')\" / placeHolder=\"Click to pick item\"></td>"
			+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
	+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" /></td>"
			+ " <td><input type=\"text\" placeholder=\"Item Description\""
	+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
	+" 	class=\"form-control\" /></td>"
	
			+ " <td><input type=\"text\" class=\"form-control\""
	+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\"></td>"
			+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
	+" 	name=\"unit"+count+"\">"
			+ " </select> "

			+ " </td>"
			
	newRow.innerHTML = content;
	$(newRow).attr("id", "reqItemTableRow" + count);
	getUnits('unit' + count);
	$("#rowhid").val(++count);
	
}
function removeRow(count) {
	$("#reqItemTableRow" + count).remove();
}


function saveWarehouse() {
	$('.close').click();
	$.ajax({
		url : 'saveWarehouseBorrowDirect',
		type : "POST",
		data : $("#warehouseForm").serialize(),
		asynch : true,
		success : function(data) {
			BootstrapDialog.alert('Saved successfully.');
			$('#flex1').flexOptions({
				url : "getPendingWarehouseList",
				newp : 1
			}).flexReload();
			$('#flex2').flexOptions({
				url : "getWarehouseBorrowList",
				newp : 1
			}).flexReload();
			return;
			
		},
		error : function(data) {
			BootstrapDialog.alert('Error Saving ');
			return;
		}
	});

}


function saveWarehouseBorrow() {
	$('.close').click();
	$.ajax({
		url : 'saveWarehouseBorrow',
		type : "POST",
		data : $("#warehouseBorrowForm").serialize(),
		asynch : true,
		success : function(data) {
			BootstrapDialog.alert(' saved successfully.');
			$('#flex1').flexOptions({
				url : "getPendingWarehouseList",
				newp : 1
			}).flexReload();
			return;
		},
		error : function(data) {
			BootstrapDialog.alert('Error Saving ');
			return;
		}
	});

}

function push(id, plNo, desc) {
	dlg.close();
	$('#item_desc' + selectedCounter).val(desc);
	$('#pl_no' + selectedCounter).val(plNo);
	$('#codeId' + selectedCounter).val(id);
}

	var dlg = new BootstrapDialog({
		draggable : true,
		type : BootstrapDialog.TYPE_SUCCESS
	});
	var selectedCounter = 0;

	function popPicker(counter) {
		selectedCounter = counter;
		var selVal = $("#codeId" + counter).val();
		/* var url ="";
		if(selVal==0){
			url="plPicker";
			dlg.setTitle("PLwise Item List")
		}else if(selVal == 1){ */
		url = "itemCodePicker";
		dlg.setTitle("Item Codewise Item List")
		/* }else{
			return;
		} */
		var jsonRecord = {};

		//jsonRecord.id=recordId;
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				dlg.setMessage($.parseHTML(data, true));

				dlg.realize();
				dlg.open();
			},
			error : function(data) {

			}

		});
	}

	function getItemStock(field,itemCode, warehouseId) {
		var modelRequest = {};
		modelRequest.id = itemCode;
		modelRequest.id2 = warehouseId;

		$.ajax({
			url : 'getItemStock',
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			success : function(data) {
				if (data != null) {
					$(field).html(data);
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Item Stock');
			}
		});

	}
	
	function issue() {
		//var requisitionId =  "";
		var procurementId ="";
		var procurementIds="";
		$('#flex1 tbody tr').has("input[name='marking_id']:checked").each(function(index,id){
		
			procurementId =$(id).find("input[name='marking_id']:checked").val();
			if(procurementId !=''){
			procurementIds += procurementId+",";
			
				
			}
		})
	

		procurementIds = procurementIds.substr(0, procurementIds.length-1);
		
		populateWarehouseBorrowIssuePopup(procurementIds);
		
	}
	
	function populateWarehouseBorrowIssuePopup(procId) {

		var jsonRecord = {};
		
		url = 'getMultipleProcurementMarkingById';
		
		jsonRecord.id = procId;
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					var checkStatus=0;
					var fid = data[0].warehouse.firmId;
					var wid = data[0].warehouse.wareId;
					for(var i=0;i<data.length;i++)
						{
						if(fid==data[i].warehouse.firmId && wid==data[i].warehouse.wareId)
							checkStatus++;
						}
					
					if(checkStatus == data.length ){
						
						$("#firmId").val(data[0].reqId.requestedForFirm.firmId);
						$("#firmName").val(data[0].reqId.requestedForFirm.firmName);
						$("#warehouseId").val(data[0].warehouse.wareId);
						$("#warehouseName").val(data[0].warehouse.warehouseName);
						$("#requisitionId").val(data[0].reqId.requisitionId);
						
						$("#orderType").val(data.procurementType);
						
						
						var count = $("#rowhid").val();
						
						var tbl = document.getElementById("reqItemTable");
						$("#reqItemTable").find("tr:gt(0)").remove();
						
						
						for(var r=0;r<data.length;r++){
							var lastRow = tbl.rows.length;
							var newRow = tbl.insertRow(lastRow);
							var itemCode = data[r].requisitionItemId.itemCode;
							
							var content = "<td>";
							
							content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
							+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
							+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"marking_id"
							+ count+ "\" value=\""+data[r].markingId+" \" ><input type=\"hidden\" name=\"requisition_id"
							+ count+ "\" value=\""+data[r].reqId.requisitionId+" \" ><input type=\"hidden\" name=\"requisitionItem_id"
							+ count+ "\" value=\""+data[r].requisitionItemId.itemKey+" \" >"
									
									+ " </td>"
									+ "<td><input type=\"text\" required readonly name=\"itemName"
									+ count
									+ "\""
									+ " 	class=\"form-control\" id=\"itemName"
									+ count
									+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
									
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data[r].procurementQty+"\" ><span class=\"form-control\""
							+" 	id=\"qty1"+count+"\" name=\"qty1"+count+"\" placeholder=\"Quantity\" ></span></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"Borrow_Qty"+count+"\" name=\"Borrow_Qty"+count+"\" placeholder=\"Borrow Qty\" value=\"\" style =\"width:90px;\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();purchaseRateCalc();\"></td>"
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
							+" 	name=\"unit1"+count+"\" value=\"\">"
								+ " </span> "

							+ " </td></td>"
							$(newRow).html(content);
							$(newRow).attr("id", "reqItemTableRow" + count);
							
							$("#qty1"+count).html(data[r].procurementQty);
							$("#unit1"+count).html(data[r].unit.unitName);
							$("#rowhid").val(++count);
						}
						$('#warehouse_borriwing_form').modal({
							keyboard : true
						});
						$('#warehouse_borriwing_form').modal("show");
				}
				}
                else{
					
					BootstrapDialog.alert('Error Firm and warehouse are different' );
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Warehouse Borrowing  Details' + data);
				return;
			}

		});
	}

	/*
function populateWarehouseBorrowIssuePopup(procId) {

	var jsonRecord = {};
	
	url = 'getMultipleProcurementMarkingById';
	
	jsonRecord.id = procId;
	
	
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		
		success : function(data) {
			var checkStatus=0;
			var fid = data[0].warehouse.firmId;
			var wid = data[0].warehouse.wareId;
			for(var i=0;i<data.length;i++)
				{
				if(fid==data[i].warehouse.firmId && wid==data[i].warehouse.wareId)
					checkStatus++;
				}
			if(checkStatus == data.length ){
			$("#firm").val(data[0].warehouse.firmId);
			$("#firm1").val(data[0].warehouse.firmId);
			$("#warehouse").val(data[0].warehouse.wareId);
			
			$("#orderType").val(data[0].procurementType);
			
			//generateOrderNo("orderNo",$("#firm").val());
			var count = $("#rowhid").val();
			var counter = $("#rowId").val();
			//var counter=0;
			var tbl = document.getElementById("reqItemTable");
			$("#reqItemTable").find("tr:gt(0)").remove();
			
			
			for(var r=0;r<data.length;r++){
				var lastRow = tbl.rows.length;
				var newRow = tbl.insertRow(lastRow);
				var itemCode = data[r].requisitionItemId.itemCode;
				
				var content = "<td>";
				
				content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
				+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
				+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"marking_id"
				+ count+ "\" value=\""+data[r].markingId+" \" ><input type=\"hidden\" name=\"requisition_id"
				+ count+ "\" value=\""+data[r].reqId.requisitionId+" \" ><input type=\"hidden\" name=\"requisitionItem_id"
				+ count+ "\" value=\""+data[r].requisitionItemId.itemKey+" \" >"
						
						+ " </td>"
						+ "<td><input type=\"text\" required readonly name=\"itemName"
						+ count
						+ "\""
						+ " 	class=\"form-control\" id=\"itemName"
						+ count
						+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
						
						+ " <td><input type=\"hidden\" class=\"form-control\""
						+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data[r].procurementQty+"\" ><span class=\"form-control\""
				+" 	id=\"qty1"+count+"\" name=\"qty1"+count+"\" placeholder=\"Quantity\" ></span></td>"
				+ " <td><input type=\"text\" class=\"form-control\""
				+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\"\" style =\"width:90px;\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();purchaseRateCalc();\"></td>"
						+ " <td><input type=\"hidden\" class=\"form-control\""
						+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
				+" 	name=\"unit1"+count+"\" value=\"\">"
					+ " </span> "

				+ " </td></td>"
				$(newRow).html(content);
				$(newRow).attr("id", "reqItemTableRow" + count);
				
				var nextRowHeader = tbl.rows.length;
				var nextHeader =tbl.insertRow(nextRowHeader);
				var headerContent="<td colspan=\"5\" class=\"active\">"
					headerContent+="Rate Per Unit </td>"
				$(nextHeader).html(headerContent);
					
					
				var nextlastRow = tbl.rows.length;
				var nextRow =tbl.insertRow(nextlastRow);
				var nextContent ="<td colspan=\"5\">"
					nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
				+" 	id=\"rateName"+count+counter+"\" onchange=\"purchaseRateCalc();\">"
				
				+ " </select></td><td><input type=\"text\" class=\"form-control\""
				+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"    onchange=\"purchaseRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" /></td>"
				+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" id=\"myBtn"+count+"\" class=\"btn btn-default\" ><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
				+" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></table></td>"

				
				$(nextRow).html(nextContent);	
				getRates('rateName'+count+counter);			
				   $(nextRow).attr("id", "innerItemTableRow" + count);       
				
				//getUnits('unit' +count);
				$("#qty1"+count).html(data[r].procurementQty);
				$("#unit1"+count).html(data[r].unit.unitName);
				$("#rowhid").val(++count);
				$("#rowId").val(++counter);
				$("#warehouse").val(data[r].warehouse.wareId);
				

			}
			
			
			
			$('#modal-add-req').modal({
				keyboard : true
			});
			$('#modal-add-req').modal("show");
			}
			else{
				
				BootstrapDialog.alert('Error Firm and warehouse are different' );
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Pulling Purchase Order Details' + data);
		
		}

	});
}
	
*/
	
	
	function open() {
		//var requisitionId =  "";
		var warehouseBorrowId ="";
		var row = $('#flex2 tbody tr').has("input[name='borrow_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		warehouseBorrowId = $(row).find("input[name='borrow_id']:checked").val();
		if(warehouseBorrowId !=''){
			populateWarehouseBorrowViewPopup(warehouseBorrowId);
		}
	}
	
	function populateWarehouseBorrowViewPopup(wareBorrowId) {

		var jsonRecord = {};
		
		url = 'getBorrowById';
		
		jsonRecord.id = wareBorrowId;
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
						$("#itemCode").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.borrowQty);
						$("#warehouse_borrow_id").val(data.borrowId);
						$("#firm1").val(data.toFirm.firmName);
						$("#fromFirm").val(data.fromFirm.firmId);
						//getFirmById('firm1',warehouse.firmId);
						//$("#warehouse2").val(warehouse.wareId);
						$("#warehouse1").val(data.toWarehouse.warehouseName);
						$("#fromWarehouse").val(data.fromWarehouse.warehouseName);
						//getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId);
						$("#unit").val(data.unit.unitId);
						$("#dueDate").val(myDateFormatter(data.borrowDueDate));
						$("#status").val(data.status);
						 
						$('#warehouse_borriwing_form').modal({
							keyboard : true
						});
						$('#warehouse_borriwing_form').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Warehouse Borrowing  Details' + data);
				return;
			}

		});
	}
	
</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                    <b>Pending Warehouse</b><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <b>Warehouse</b><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>













<%@ include file="include/warehouse_borrowing_form.jsp" %>



<script>
$(document).ready(function() {
     $('#dateRangePicker1')
        .datepicker({
            format: "dd/mm/yyyy",
            startDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) 

});
      </script>