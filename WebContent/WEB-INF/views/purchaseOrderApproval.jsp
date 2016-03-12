<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#orderApproval").attr("class","active");
		var w=1000;
		
		
			
		$('#flex1').flexigrid({
			url:'getPurchaseOrderList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Due Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Order Type', name : '', width:100, sortable : true, align: 'left'},
				
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Approval', bclass: 'glyphicon glyphicon-pencil', onpress : add},
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
			url:'getPurchaseOrderListApprovalCompleted',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Due Date', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Order Type', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Approval Status', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Approval Date', name : '', width:70, sortable : true, align: 'left'},
				
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
//getUsers('user');

//getFirms("firm");
//getWarehouses("warehouse");
getVendors("vendor");
getUnits("unit");

});


	function add() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex1 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderApprovalPopup(orderId);
		}
		

	}
	
	

function populatePurchaseOrderApprovalPopup(orderId) {

	var jsonRecord = {};
	
	url = 'getPurchaseOrderById';
	
	jsonRecord.id = orderId;
	
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		dataType : 'json',
		success : function(data) {
			if(data!=null){
				
				$("#firm").val(data.firm.firmId);
				$("#firm1").val(data.firm.firmName);
				$("#vendor").val(data.vendor.vendorId);
				$("#orderNo").val(data.purchaseOrderNo);
				$("#orderId").val(data.orderId);
				$("#dueDate").val(myDateFormatter(data.dueDate));
				
				//generateOrderNo("orderNo",$("#firm").val());
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				//var counter=0;
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				for(var r=0;r<data.orderItems.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					var total = data.orderItems[r];
					var rateAppliedId = null;
					for(var k=0;k<total.itemLevelRates.length;k++){
						$("#total").val(total.itemLevelRates[k].appliedAmount);
						rateAppliedId = total.itemLevelRates[k].rateAppliedId;
					}
					var itemCode = data.orderItems[r].itemCode;
					
					var content = "<td>";
					
					content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
					+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
					+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"itemKey"
					+ count+ "\" value=\""+data.orderItems[r].itemKey+" \" ><input type=\"hidden\" name=\"rateAppliedId"
					+ count+ "\" value=\""+rateAppliedId+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
							
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data.orderItems[r].histQty+"\" ><span class=\"form-control\""
					+" 	id=\"qty1"+count+"\" name=\"qty1"+count+"\" placeholder=\"Quantity\" ></span></td>"
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\""+data.orderItems[r].qty+"\" style =\"width:70px;\" readonly=\"readonly\"></td>"
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
					+" 	name=\"unit1"+count+"\" value=\"\">"
						+ " </span> "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"5\" class=\"active\">"
						headerContent+="Rate Per Unit</td>"
					$(nextHeader).html(headerContent);
						
						
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td colspan=\"5\">"
						nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
					+" 	id=\"rateName"+count+counter+"\" readonly=\"readonly\">"
					+ " 		<option value=\"0\">Basic Rate</option>"
					+ " 		<option value=\"1\">Excise</option>"
					+ " 		<option value=\"2\">Cess</option>"
					+ " 		<option value=\"3\">Sales</option>"
					+ " 		<option value=\"4\">Freight</option>"
					+ " 		<option value=\"5\">Other Charges</option>"
					+ " </select></td><td><input type=\"text\" class=\"form-control\""
					+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\""+data.orderItems[r].basicRate+"\"  onchange=\"purchaseRateCalc();\" readonly=\"readonly\"></td>"
					+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"subTotal"+count+"\" name=\"subTotal"+count+"\" value=\"0\" ></td></table></td>"

					
					$(nextRow).html(nextContent);				
					   $(nextRow).attr("id", "innerItemTableRow" + count);             
					
					//getUnits('unit' +count);
					$("#qty1"+count).html(data.orderItems[r].histQty);
					$("#unit1"+count).html(data.orderItems[r].unit.unitName);
					$("#rowhid").val(++count);
					$("#rowId").val(++counter);
					$("#warehouse").val(data.warehouse.wareId);
					
					
			}
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
			}
			
		},
		error : function(data) {
			BootstrapDialog.alert('Error Pulling Purchase Order Approval Details' + data);
			return;
		}

	});
}


	function remove() {
		var recordId = $("input[name='requisitionId']:checked").val();
		BootstrapDialog.confirm('Are you sure you want to delete?', function(result){
            if(result) {
            	var modelRequest = {};
        		modelRequest.id = recordId
        		
        		$.ajax({
        			url : 'deleteRequisition',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				BootstrapDialog
						.alert('Requisition successfully deleted');
        				$('#flex1').flexOptions({
        					url : "getRequisitions",
        					newp : 1
        				}).flexReload();
        			},
        			error : function(data) {
        				//BootstrapDialog
        						//.alert('Error unable to delete the requisition');
        				BootstrapDialog
						.alert('Requisition successfully deleted');
        				$('#flex1').flexOptions({
        					url : "getRequisitions",
        					newp : 1
        				}).flexReload();
        			}
        		});
            }else {
                return
            }
        });

	}
	function open() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex2 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderApprovalViewPopup(orderId);
		}
	}
	/*
	function populatePurchaseOrderApprovalViewPopup(orderId) {

		var jsonRecord = {};
		
		url = 'getPurchaseOrderById';
		
		jsonRecord.id = orderId;
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					for(var r=0;r<data.orderItems.length;r++){
						var itemCode = data.orderItems[r].itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.orderItems[r].qty);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm1").val(data.firm.firmName);
						$("#firm").val(data.firm.firmId);
						$("#unit").val(data.orderItems[r].unit.unitId)
						$("#marking_id").val(data.markingId)
						$("#orderNo").val(data.purchaseOrderNo); 
						$("#orderId").val(data.orderId); 
						$("#vendor").val(data.vendor.vendorId); 
						$("#rate").val(data.orderItems[r].basicRate); 
						$("#orderRemarks").val(data.remarks); 
						$("#approval_comments").val(data.approvalComments); 
						$("#approvalStatus").val(data.approvalStatus); 
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			 }
			},
			error : function(data) {
				BootstrapDialog.alert('Error Purchase Order Approval Details' + data);
				return;
			}

		});
	}
*/


function populatePurchaseOrderApprovalViewPopup(orderId) {

	var jsonRecord = {};
	
	url = 'getPurchaseOrderById';
	
	jsonRecord.id = orderId;
	
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		dataType : 'json',
		success : function(data) {
			if(data!=null){
				$("#firm").val(data.firm.firmId);
				$("#firm1").val(data.firm.firmName);
				$("#vendor").val(data.vendor.vendorId);
				$("#orderNo").val(data.purchaseOrderNo);
				$("#orderId").val(data.orderId);
				$("#dueDate").val(myDateFormatter(data.dueDate));
				$("#approvalStatus").val(data.approvalStatus);
				
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				//var counter=0;
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				for(var r=0;r<data.orderItems.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					var total = data.orderItems[r];
					var rateAppliedId = null;
					for(var k=0;k<total.itemLevelRates.length;k++){
						$("#total").val(total.itemLevelRates[k].appliedAmount);
						rateAppliedId = total.itemLevelRates[k].rateAppliedId;
					}
					var itemCode = data.orderItems[r].itemCode;
					
					var content = "<td>";
					
					content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
					+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
					+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"itemKey"
					+ count+ "\" value=\""+data.orderItems[r].itemKey+" \" ><input type=\"hidden\" name=\"rateAppliedId"
					+ count+ "\" value=\""+rateAppliedId+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
							
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data.orderItems[r].histQty+"\" ><span class=\"form-control\""
					+" 	id=\"qty1"+count+"\" name=\"qty1"+count+"\" placeholder=\"Quantity\" ></span></td>"
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\""+data.orderItems[r].qty+"\" style =\"width:70px;\" readonly=\"readonly\"></td>"
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
					+" 	name=\"unit1"+count+"\" value=\"\">"
						+ " </span> "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"5\" class=\"active\">"
						headerContent+="Rate Per Unit</td>"
					$(nextHeader).html(headerContent);
						
						
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td colspan=\"5\">"
						nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
					+" 	id=\"rateName"+count+counter+"\" readonly=\"readonly\">"
					+ " 		<option value=\"0\">Basic Rate</option>"
					+ " 		<option value=\"1\">Excise</option>"
					+ " 		<option value=\"2\">Cess</option>"
					+ " 		<option value=\"3\">Sales</option>"
					+ " 		<option value=\"4\">Freight</option>"
					+ " 		<option value=\"5\">Other Charges</option>"
					+ " </select></td><td><input type=\"text\" class=\"form-control\""
					+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\""+data.orderItems[r].basicRate+"\"  onchange=\"purchaseRateCalc();\" readonly=\"readonly\"></td>"
					+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"subTotal"+count+"\" name=\"subTotal"+count+"\" value=\"0\" ></td></table></td>"

					
					$(nextRow).html(nextContent);				
					   $(nextRow).attr("id", "innerItemTableRow" + count);             
					
					//getUnits('unit' +count);
					$("#qty1"+count).html(data.orderItems[r].histQty);
					$("#unit1"+count).html(data.orderItems[r].unit.unitName);
					$("#rowhid").val(++count);
					$("#rowId").val(++counter);
					$("#warehouse").val(data.warehouse.wareId);
					
					
			}
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
			}
			
		},
		error : function(data) {
			BootstrapDialog.alert('Error Purchase Order Approval Details' + data);
			return;
		}

	});
}

	function savePurchaseOrderApproval() {
		$('.close').click();
		$.ajax({
			url : 'savePurchaseOrderApproval',
			type : "POST",
			data : $("#orderForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Purchase order approval saved successfully.');
				$('#flex1').flexOptions({
					url : "getPurchaseOrderList",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getPurchaseOrderListApprovalCompleted",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving purchase order approval.');
				return;
			}
		});

	}

	function populatePurchaseOrderCreatePopup(procId) {

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
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.procurementQty);
						$("#dueDate").val('');
						$("#firm").val(warehouse.firmId);
						getFirmById('firm1',warehouse.firmId);
						getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(warehouse.wareId);
						//getUnits('unit');
						$("#unit").val(data.unit.unitId)
						$("#marking_id").val(data.markingId)
						generateOrderNo("orderNo",$("#firm").val()); 
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Purchase Order Details' + data);
				return;
			}

		});
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

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                    <small>Purchase Order Pending Approval</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>Purchase Orders Approval Completed</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>















<%@ include file="include/purchase_order_form_approval.jsp" %>
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