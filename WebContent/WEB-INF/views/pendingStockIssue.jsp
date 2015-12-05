<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){


	$("#pendingStockIssue").attr("class","active");
		var w=1000;
		$('#flex1').flexigrid({
		url:'getPendingStockIssue',
		method: 'POST',
		dataType : 'json',
	  
	  colModel : [
	       	{display: '', name : 'ite', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Requisition Ref No', name : 'requisitionRefNo', sortable : true, align: 'left',width:120},
			{display: 'Item', name : '', width:300, sortable : true, align: 'left'},
			{display: 'Qty', name : '', width:30, sortable : true, align: 'left'},
			{display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
			{display: 'Requested By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
			{display: 'Due Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
			{display: 'Status', name : 'fullFillmentStatus', width:120, sortable : true, align: 'center'},
			
			
				],
	  buttons : [
				{separator: true},
				{name: ' Direct Issue ', bclass: 'glyphicon glyphicon-export', onpress : add},
				{separator: true},
			 	{name: ' Issue ', bclass: 'glyphicon glyphicon-send', onpress : open},
      
              {separator: true}
      ],
      searchitems : [
                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
             
				
      ],
		sortname: "requestedDate",
		sortorder: "asc",
		usepager: true,
		title: 'My Requisitions',
		useRp: true,
		rp: 1000,
		showTableToggleBtn: false,//toggle button for the whole table
		resizable: false,
		width: w,
		height: screen.height*.50,

	});
getUsers('user');
//getItems("item");
//getFirms("firm");
//getWarehouses("warehouse");
addRow();
   
});


	function open() {
		var requisitionId =  "";
		var requisitionItemId ="";
		var row = $('#flex1 tbody tr').has("input[name='requisitionItemId']:checked")
		requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		requisitionItemId = $(row).find("input[name='requisitionItemId']:checked").val();
		if(requisitionId!='' && requisitionItemId !=''){
			populateRequisitionItemPopup(requisitionId,requisitionItemId);
		}
		

	}

	function add() {
		$('#modal-add-req').modal({
			keyboard : true
			
		});
		$("#requisitionRefNo").removeAttr('disabled');
		$("#warehouse").removeAttr('disabled');
		$("#user").removeAttr('disabled');
		$("#dueDate").removeAttr('disabled');
		$("#firm").removeAttr('disabled');

		$("#requisitionRefNo").val('');
		$("#warehouse").val('');
		$("#user").val('');
		$("#dueDate").val('');
		$("#firm").val('');
		$("#warehouse").val("");
		$("#rowhid").val(0);
		
		$("#reqItemTable").find("tr:gt(0)").remove();
		addRow();
		
		$('#modal-add-req').modal.show()
	}
	function saveItemIssue() {
		$('.close').click();
		$.ajax({
			url : 'saveItemIssue',
			type : "POST",
			data : $("#issueForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Item issue saved successfully.');
				$('#flex1').flexOptions({
					url : "getPendingStockIssue",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving Item Issue Details');
				return;
			}
		});

	}

	function populateRequisitionItemPopup(refNo, reqItemId) {

		var jsonRecord = {};
		
		url = 'getRequisitionByRefNo';
		
		jsonRecord.id = refNo;
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
						$("#requisitionId").val(data.requisitionId);
						$("#requisitionRefNo").val(data.requisitionRefNo);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#user").val(data.requestedByUser.userId);
						getUserFirms('firm',data.requestedByUser.userId);
						$("#firm").val(data.requestedForFirm.firmId);
						getFirmWarehouses('warehouse', data.requestedForFirm.firmId,data.requestedAtWareHouse.wareId) 
						$("#warehouse").val(data.requestedAtWareHouse.wareId);
						
                         
						$("#requisitionRefNo").attr('disabled', 'disabled');
						$("#warehouse").attr('disabled', 'disabled');
						$("#user").attr('disabled', 'disabled');
						$("#dueDate").attr('disabled', 'disabled');
						$("#firm").attr('disabled', 'disabled');
						
						var count = $("#rowhid").val();
						var existingRows = count;
						var tbl = document.getElementById("reqItemTable");
						$("#reqItemTable").find("tr:gt(0)").remove();
						
						for(var r=0;r<data.requisitionItems.length;r++){
							if(reqItemId!=data.requisitionItems[r].itemKey){
								continue;
							}
							var lastRow = tbl.rows.length;
							var newRow = tbl.insertRow(lastRow);
							
							var content = "<td>";
							if(r >0){
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
									+ " <td><input type=\"hidden\" name=\"itemKey"
									+ count+ "\" value=\""+data.requisitionItems[r].itemKey+" \" >"
									+"<input type=\"text\" required readonly name=\"codeId"
									+ count
									+ "\""
									+ " 	class=\"form-control\" id=\"codeId"
									+ count
									+ "\" onclick=\"popPicker('"
									+ count
									+ "')\" / placeHolder=\"Click to pick item\" value=\""+data.requisitionItems[r].itemCode.codeId+" \" ></td>"
									+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
							+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" value=\""+data.requisitionItems[r].itemCode.code+" \" /></td>"
									+ " <td><input type=\"text\" placeholder=\"Item Description\""
							+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
							+" 	class=\"form-control\" value=\""+data.requisitionItems[r].itemCode.codeDesc+" \"/></td>"
							+ " <td><input type=\"hidden\" placeholder=\"availableQty\""
							+" 	name=\"availableQty"+count+"\" id=\"availableQty"+count+"\""
							+" 	class=\"form-control\"  /><span id=\"availableQtyId"+count+"\"></span></td>"
									+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\" value=\""+data.requisitionItems[r].qty+"\"></td>"
									+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
							+" 	name=\"unit"+count+"\">"
									+ " </select> "
		
									+ " </td>"
		
							$(newRow).html(content);
							$(newRow).attr("id", "reqItemTableRow" + count);
							getUnits('unit' + count);
							getItemStock('#availableQtyId' + count,data.requisitionItems[r].itemCode.codeId, data.requestedAtWareHouse.wareId)
							
							$("#rowhid").val(++count);
		
							
		
						}
					
						for(var r=0;r<data.requisitionItems.length;r++){
							if(reqItemId!=data.requisitionItems[r].itemKey){
								continue;
							}
							$("#priority"+existingRows).val(data.requisitionItems[r].priority);
							$("#unit"+existingRows).val(data.requisitionItems[r].unit.unitId);
							existingRows++;
						}
		
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Requistion' + data);
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
					$(field).html(data.availableQty);
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Item Stock');
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

<table style="width:100%" id="flex1"></table>
<%@ include file="include/directItemIssue.jsp" %>
<script>
$(document).ready(function() {
     $('#dateRangePicker')
        .datepicker({
            format: "dd/mm/yyyy",
            endDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) 

});
      </script>