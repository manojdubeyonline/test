<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){


	$("#requisitionApproval").attr("class","active");
		var w=1000;
		$('#flex1').flexigrid({
		url:'getPendingProcurementMarkingList',
		method: 'POST',
		dataType : 'json',
	  
	  colModel : [
	       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Item', name : '', width:550, sortable : true, align: 'left'},
			{display: 'Ware house', name : '', width:300, sortable : true, align: 'left'},
			{display: 'Requisitioned Qty', name : '', width:100, sortable : true, align: 'left'},
		
			
			
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
		//width: w,
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
				{display: 'Due Date', name : '', width:100, sortable : true, align: 'left'},
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
		//	width: w,
			singleSelect: true
			//height: screen.height*.20,

		});

			


//getUsers('user');
//getItems("item");
getFirms("firm");
getWarehouses("warehouse");
//addRow();
   
});


	function add() {
		//var requisitionId =  "";
		var procurementItemId ="";
		var row = $('#flex1 tbody tr').has("input[name='procurement_item_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		procurementItemId = $(row).find("input[name='procurement_item_id']:checked").val();
		if(procurementItemId !=''){
			populateProcurementItemPopup(procurementItemId);
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
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.procurementQty);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm").val(warehouse.firmId);
						getFirmById('firm1',warehouse.firmId);
						getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(warehouse.wareId);
						//getUnits('unit');
						$("#unit").val(data.unit.unitId)
						$("#marking_id").val(data.markingId)
						$("#procurementType").val(data.procurementType)
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
	
	
	function add1() {
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
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving procurement marking');
				return;
			}
		});

	}

	function populateProcurementItemPopup(procItemId) {

		var jsonRecord = {};
		
		url = 'getStock';
		
		jsonRecord.id = procItemId.substring(0,procItemId.indexOf("_"));
		jsonRecord.id2 = procItemId.substring(procItemId.indexOf("_")+1,procItemId.length);
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					var stockPK = data.itemStockPK;
					var itemCode = stockPK.itemCode;
					var warehouse = stockPK.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.requisitionedQty);
					//	$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm").val(warehouse.firmId);
						getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(warehouse.wareId);
						getUnits('unit');
						
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
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
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h4 class="panel-title">
                   Pending Marking<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
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