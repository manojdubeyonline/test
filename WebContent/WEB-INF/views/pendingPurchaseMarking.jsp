<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
var userRoleData = "";
$(document).ready(function(){
	//var w=screen.width;
	var w = 1000;

	$("#requisitionApproval").attr("class","active");
	
		$('#flex1').flexigrid({
		url:'getPendingProcurementMarkingList',
		method: 'POST',
		dataType : 'json',
	  
	  colModel : [
               {display: '', name : 'requisitionId', width:w*0.035, sortable : false, align: 'center'},
               {display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
               {display: 'Requisition Ref No', name : 'requisitionRefNo', sortable : true, align: 'left',width:120},
               {display: 'Item(s)', name : '', width:300, sortable : false, align: 'left'},
               {display: 'Qty', name : 'qty', width:120, sortable : true, align: 'center'},
               {display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
               {display: 'Requested By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
               {display: 'Due Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
               //{display: 'Status', name : 'fullFillmentStatus', width:120, sortable : true, align: 'center'},
		
			
			
				],
	  buttons : [
				{separator: true},
			 	{name: ' Mark ', bclass: 'glyphicon glyphicon-tag', onpress : add},
	            {separator: true}
      ],
      searchitems : [
                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
             
				
      ],
		sortname: "code",
		sortorder: "asc",
		usepager: true,
	//	title: 'Pending Procurement Marking',
		useRp: true,
		rp: 20,
	//	showTableToggleBtn: true,//toggle button for the whole table
		resizable: false,
		//width: w*.78,
		singleSelect: true
	});



		$('#flex2').flexigrid({
			url:'getProcurementMarkingList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Item', name : '', width:550, sortable : true, align: 'left'},
				{display: 'Ware house', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Marked Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Marking Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Procurement Method', name : '', width:100, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit ', bclass: 'glyphicon glyphicon-pencil', onpress : open},
		            {separator: true}
	      ],
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	             
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
			//title: 'Procurement Markings',
			useRp: true,
			rp: 20,
		//	showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w*.78,
			singleSelect: true
			//height: screen.height*.20,

		});

			


//getUsers('user');
//getItems("item");
getFirms("firm");
getWarehouses("warehouse");
//addRow();
var userRoleId = ${_SessionUser.userRole.roleId};
getUserByRoleId(userRoleId);
   
});


	function add() {
		var requisitionRefNo =  "";
		var requisitionItemId ="";
		var row = $('#flex1 tbody tr').has("input[name='requisitionItemId']:checked")
		requisitionRefNo =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		requisitionItemId = $(row).find("input[name='requisitionItemId']:checked").val();
		if(requisitionRefNo!='' && requisitionItemId !=''){
			populateProcurementItemPopup(requisitionRefNo,requisitionItemId);
		}
		

	}

	
	function open() {
		//var requisitionId =  "";
		var procurementItemId ="";
		var row = $('#flex2 tbody tr').has("input[name='marking_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		procurementItemId = $(row).find("input[name='marking_id']:checked").val();
		if(procurementItemId !=''){
			populateProcurementViewPopup(procurementItemId);
		}
		

	}
	
	
	function populateProcurementViewPopup(procId) {

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
					
					var role = "";
					var userAccessCheck = null;
					if(userRoleData != null){
						role = userRoleData;
					}
					for(var u=0;u<role.access.length;u++){
						var userAccessLevel = role.access[u].accessLevel;
						if(parseInt(role.access[u].menu.menuId) == 503 && (userAccessLevel == 'E')){
							userAccessCheck++;
						}
					}
					if(userAccessCheck != null){
					
					var itemCode = data.requisitionItemId.itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.procurementQty);
						$("#associatedRequisitionItemId").val(data.requisitionItemId.itemKey);
						$("#associatedRequisitionId").val(data.reqId.requisitionId);
					
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm").val(warehouse.firmId);
						getFirmById('firm1',warehouse.firmId);
						getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(warehouse.wareId);
						//getUnits('unit');
						$("#unit").val(data.unit.unitId)
						$("#unit1").html(data.unit.unitName);
						$("#marking_id").val(data.markingId)
						$("#procurementType").val(data.procurementType)
						generateOrderNo("orderNo",$("#firm").val()); 
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
				
				else{
					BootstrapDialog.alert('Access Denied');
					return;
				}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Purchase Order Details' + data);
				return;
			}

		});
	}
	
	
	
	function saveProcurement() {
		$('.close').click();
		$.ajax({
			url : 'saveProcurement',
			type : "POST",
			data : $("#procurementForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('procurement marking saved successfully.');
				$('#flex1').flexOptions({
					url : "getPendingProcurementMarkingList",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getProcurementMarkingList",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving procurement marking');
				return;
			}
		});

	}

	
	function populateProcurementItemPopup(requisitionRefNo,requisitionItemId) {

		var jsonRecord = {};
		
		url = 'getRequisitionByRefNoForStockIssue';
		
		jsonRecord.id = requisitionRefNo;
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data !=null){
					
					var role = "";
					var userAccessCheck = null;
					if(userRoleData != null){
						role = userRoleData;
					}
					for(var u=0;u<role.access.length;u++){
						var userAccessLevel = role.access[u].accessLevel;
						if(parseInt(role.access[u].menu.menuId) == 503 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
							userAccessCheck++;
						}
					}
					if(userAccessCheck != null){
					
					for(var r=0;r<data.requisitionItems.length;r++){
						if(requisitionItemId!=data.requisitionItems[r].itemKey){
							continue;
						}
						$("#associatedRequisitionId").val(data.requisitionId);
						$("#requisition_no").val(data.requisitionRefNo);
						$("#associatedRequisitionItemId").val(data.requisitionItems[r].itemKey);
						$("#item1").val(data.requisitionItems[r].itemCode.codeDesc);
						$("#item").val(data.requisitionItems[r].itemCode.codeId);
						$("#qty").val(data.requisitionItems[r].qty);
						$("#unit").val(data.requisitionItems[r].unit.unitId);
						$("#unit1").html(data.requisitionItems[r].unit.unitName);
					//	$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm").val(data.requestedForFirm.firmId);
						//getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(data.requestedAtWareHouse.wareId);
						getUnits('unit');
						
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
				}
				
				else{
					BootstrapDialog.alert('Access Denied');
					return;
				}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Item Stock Details' + data);
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
	
	function getUserByRoleId(userRoleId){
		var modelRequest = {};
		modelRequest.id = userRoleId
		$.ajax({
			url : 'getUserRoleByRoleId',
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if (data != null) {
					userRoleData = data;
					//alert(userRoleData);
                         }
							},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	
	}
	

	function push(id, plNo, desc) {
		dlg.close();
		$('#item_desc' + selectedCounter).val(desc);
		$('#pl_no' + selectedCounter).val(plNo);
		$('#codeId' + selectedCounter).val(id);
		getItemStock('#availableQtyId' + selectedCounter,id, $("#warehouse").val())
		//$('#availableQtyId' + selectedCounter).val(qty);
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
		+ " <td><input type=\"hidden\" placeholder=\"availableQty\""
		+" 	name=\"availableQty"+count+"\" id=\"availableQty"+count+"\""
		+" 	class=\"form-control\" /><span id=\"availableQtyId"+count+"\"></span></td>"
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
</script>

<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h4 class="panel-title">
                   Pending Marking<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h4 class="panel-title">
                   Procurement Markings<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>


<%@ include file="include/procurement_marking.jsp" %>
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