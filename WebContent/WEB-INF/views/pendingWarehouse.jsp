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
					{separator: true},
				 	{name: ' Direct', bclass: 'glyphicon glyphicon-export', onpress : addWarehouse},
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
			//width: w,
			singleSelect: true

		});

		$('#flex2').flexigrid({
			url:'getWarehouseBorrowList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
				{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
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
			//width: w,
			singleSelect: true

		});
getUsers('user');

getFirms("firm");
getReceiverFirm("receiverFirm");
getFromFirm("fromFirm");
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
		var row = $('#flex1 tbody tr').has("input[name='marking_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		procurementId = $(row).find("input[name='marking_id']:checked").val();
		if(procurementId !=''){
			populateWarehouseBorrowIssuePopup(procurementId);
		}
	}
	
	function populateWarehouseBorrowIssuePopup(procId) {

		var jsonRecord = {};
		
		url = 'getProcurementMarkingById';
		
		jsonRecord.id = procId;
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					
					var itemCode = data.requisitionItemId.itemCode
					var warehouse = data.warehouse;
					
						$("#itemCode").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.procurementQty);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm2").val(warehouse.firmId);
						getFirmById('firm1',warehouse.firmId);
						$("#warehouse2").val(warehouse.wareId);
						$("#warehouse1").val(warehouse.warehouseName);
						//getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId);
						//getUnits('unit');
						$("#unit").val(data.unit.unitId);
						$("#marking_id").val(data.markingId);
						$("#orderType").val(data.procurementType);
						generateOrderNo("orderNo",$("#firm2").val()); 
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











<%@ include file="include/warehouse_form_Direct.jsp" %>

<%@ include file="include/warehouse_borrowing_form.jsp" %>



<script>
$(document).ready(function() {
     $('#dateRangePicker')
        .datepicker({
            format: "dd/mm/yyyy",
            startDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) 

});
      </script>