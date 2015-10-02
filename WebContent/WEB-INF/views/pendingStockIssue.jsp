<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){

	$("#flex1").dblclick(function(event){
		$('.trSelected',this).each( function(){
			var recordId = $('td[abbr="requisitionRefNo"] >div', this).html();
			populateRequisitionPopup(recordId, null);
			});
		});
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
		var recordId =  $('td[abbr="requisitionRefNo"] >div', this).html();
		populateRequisitionPopup(recordId, 'getRequisitionByRefNo');

	}

	function add() {
		$('#modal-add-req').modal({
			keyboard : true
		});
		$('#modal-add-req').modal("show");
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

	function populateRequisitionPopup(recordId, url) {

		var jsonRecord = {};
		if(url==null){
			url = 'getRequisitionByRefNo';
		}
		jsonRecord.id = recordId;
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				$("#requisitionId").val(data.requisitionId);
				//$("#qty").val(data.qty);

				//$("#dueDate").val(data.dueDate);
				$("#firm").val(data.requestedForFirm.firmId);
				//$("#item").val(data.item.itemId);
				$("#warehouse").val(data.requestedAtWareHouse.wareId);
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
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

	function getUsers(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getUsers',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].userId + '">'
								+ data[i].userName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	}

	function getItems(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getItems',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].itemId + '">'
								+ data[i].itemDesc + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	}

	function getUnits(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getUnits',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].unitId + '">'
								+ data[i].unitName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the unit list');
			}
		});
	}

	function getFirmWarehouses(field, firmId) {
		var modelRequest = {};
		modelRequest.id = firmId
		var sel = $("#" + field);
		sel.html('<option value="" selected disabled>Store</option>')
		$.ajax({
			url : 'getFirmWarehouses',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].wareId + '">'
								+ data[i].warehouseName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list');
			}
		});
	}

	function generateRefNo() {
		var modelRequest = {};
		modelRequest.id = $("#firm").val();
		modelRequest.id2 = $("#warehouse").val();

		$.ajax({
			url : 'generateRequisitionRefNo',
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			success : function(data) {
				if (data != null) {
					$("#requisitionRefNo").val(data);
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to generate the ref no.');
			}
		});
	}
	function getWarehouses(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getWarehouses',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].wareId + '">'
								+ data[i].warehouseName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list');
			}
		});

	}

	function getFirms(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirms',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].firmId + '">'
								+ data[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Firm list');
			}
		});

	}

	function getUserFirms(field, userId) {
		var jsonRecord = {};
		jsonRecord.id = userId;
		var sel = $("#" + field);
		sel.html('<option value="" selected disabled>For the Firm</option>');
		$.ajax({
			url : 'getUserById',
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					var firms = data.userFirms;
					for (var i = 0; i < firms.length; i++) {
						sel.append('<option value="' + firms[i].firmId + '">'
								+ firms[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the User Firms list');
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