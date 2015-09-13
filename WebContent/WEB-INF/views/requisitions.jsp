<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){

    $('#datetimepicker').datetimepicker({
      format: 'dd/MM/yyyy hh:mm:ss'
    });
 
	$("#flex1").dblclick(function(event){
		$('.trSelected',this).each( function(){
			var recordId = $('td[abbr="requisitionRefNo"] >div', this).html();
			populateRequisitionPopup(recordId, null);
			});
		});
	$("#requisitions").attr("class","active");
var w=1000;
$('#flex1').flexigrid({
url:'getRequisitions',
method: 'POST',
dataType : 'json',
	  
	  colModel : [
	       	{display: '', name : 'requisitionId', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Requisition Ref No', name : 'requisitionRefNo', sortable : true, align: 'left',width:120},
			{display: 'Item(s)', name : '', width:300, sortable : false, align: 'left'},
			{display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
			{display: 'Requested By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
			{display: 'Due Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
			{display: 'Status', name : 'fullFillmentStatus', width:120, sortable : true, align: 'center'},
			
			
				],
	  buttons : [
				{name: 'Add', bclass: 'add', onpress : add},
			 	{name: 'Edit', bclass: 'edit', onpress : open},
      
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
getItems("item");
getFirms("firm");
getWarehouses("warehouse");

   
});


	function open() {
		var recordId = $("input[name='requisitionId']:checked").val();
		populateRequisitionPopup(recordId, 'getRequisitionById');

	}

	function add() {
		$('#modal-add-req').modal({
			keyboard : true
		});
		$('#modal-add-req').modal("show");
	}
	function saveUpdateRequisition() {
		$('.close').click();
		$.ajax({
			url : 'saveRequisition',
			type : "POST",
			data : $("#reqForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Requistion saved successfully.');
				$('#flex1').flexOptions({
					url : "getRequisitions",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving Requistion');
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
			
			success : function(data) {
				$("#requisitionId").val(data.requisitionId);
				//$("#qty").val(data.qty);

				$("#requisitionRefNo").val(data.requisitionRefNo);
				$("#dueDate").val(data.dueDate);
				$("#firm").val(data.requestedForFirm.firmId);
				//$("#item").val(data.item.itemId);
				$("#warehouse").val(data.requestedAtWareHouse.wareId);

				var count = $("#rowhid").val();
				removeRow(1);
				var tbl = document.getElementById("reqItemTable");
				
				 $('#reqItemTable tr:last-child').remove();
				var lastRow = 2;
				for(var r=0;r<data.requisitionItems.length;r++){
					var newRow = tbl.insertRow(lastRow);

					var content = "<td><a href='#' onclick='removeRow("
							+ count
							+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a></td>"
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
							+ "')\" / placeHolder=\"Click to pick item\" value=\""+data.requisitionItems[r].itemCode.codeId+" \" ></td>"
							+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
					+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" value=\""+data.requisitionItems[r].itemCode.code+" \" /></td>"
							+ " <td><input type=\"text\" placeholder=\"Item Description\""
					+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
					+" 	class=\"form-control\" value=\""+data.requisitionItems[r].itemCode.codeDesc+" \"/></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\" value=\""+data.requisitionItems[r].qty+" \"></td>"
							+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
					+" 	name=\"unit"+count+"\">"
							+ " </select> "

							+ " </td>"

					newRow.innerHTML = content;
					$(newRow).attr("id", "reqItemTableRow" + count);
					getUnits('unit' + count);
					$("#rowhid").val(++count);

					$("#unit"+count).val(data.requisitionItems[r].unit.unitId);


				}
				



				
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Requistion' + data);
			
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

	function push(id, plNo, desc) {
		dlg.close();
		$('#item_desc' + selectedCounter).val(desc);
		$('#pl_no' + selectedCounter).val(plNo);
		$('#codeId' + selectedCounter).val(id);
	}

	function addRow() {
		var count = $("#rowhid").val();
		var tbl = document.getElementById("reqItemTable");
		var lastRow = tbl.rows.length;
		var newRow = tbl.insertRow(lastRow);

		var content = "<td><a href='#' onclick='removeRow("
				+ count
				+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a></td>"
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
</script>

<table width="100%" id="flex1"></table>
<%@ include file="include/addReq.jsp" %>
<script>
$(document).ready(function() {
  /*   $('#dueDate')
        .datepicker({
            format: "mm/dd/yyyy"
        }) */

});
      </script>