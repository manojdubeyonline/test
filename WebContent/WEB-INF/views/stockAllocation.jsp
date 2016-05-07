<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	var w=screen.width;

	$("#stockAllocation").attr("class","active");
		
		$('#flex1').flexigrid({
		url:'getGRPOListApprovalCompleted',
		method: 'POST',
		dataType : 'json',
	  
	  colModel : [
{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
{display: 'Goods Reciept No', name : '', width:150, sortable : false, align: 'center'},
{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
{display: 'Qty', name : '', width:70, sortable : true, align: 'left'},
{display: 'GR Date', name : '', width:70, sortable : true, align: 'left'},
{display: 'Approved By', name : '', width:70, sortable : true, align: 'left'},
{display: 'Approval Date', name : '', width:70, sortable : true, align: 'left'},
			
			
				],
	  buttons : [
				{separator: true},
				
				{name: ' Allocate ', bclass: 'glyphicon glyphicon-globe', onpress : add},
				{separator: true},
			 	
      ],
      searchitems : [
                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
             
				
      ],
      sortname: "code",
		sortorder: "asc",
		usepager: true,
	//	title: 'My Requisitions',
		useRp: true,
		rp: 20,
	//	showTableToggleBtn: true,//toggle button for the whole table
		resizable: false,
		width: w*.80,
		singleSelect: true

	});
		
		$('#flex2').flexigrid({
			url:'getStockAllocationList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : 'ite', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Stock Allocation No', name : 'stockAllocationNo', sortable : true, align: 'left',width:120},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:300, sortable : true, align: 'left'},
				{display: 'Allocated Qty', name : '', width:90, sortable : true, align: 'left'},
				{display: 'Allocation Date', name : 'allocationDate', width:120, sortable : true, align: 'center'},
				{display: 'GR Date', name : 'allocationDate', width:120, sortable : true, align: 'center'},
				{display: 'Allocated By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
				
				
				
				
					],
					
					 buttons : [
								{separator: true},
								
								{name: ' Edit ', bclass: 'glyphicon glyphicon-pencil', onpress : open},
								{separator: true},
							 	
				      ],
		
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	             
					
	      ],
	      sortname: "code",
			sortorder: "asc",
			usepager: true,
		//	title: 'My Requisitions',
			useRp: true,
			rp: 20,
		//	showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			width: w*.80,
			singleSelect: true

		});
getUsers('user');
//getItems("item");
//getFirms("firm");
//getWarehouses("warehouse");
addRow();
   
});


	
	
	

	
	
	function add() {
		var grpoId ="";
		var row = $('#flex1 tbody tr').has("input[name='grpo_id']:checked")
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateStockAllocationPopup(grpoId);
		}
	}
	
	function populateStockAllocationPopup(grpoId) {

		var jsonRecord = {};
		
		url = 'getGRPOById';
		
		jsonRecord.id = grpoId;
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					$("#firm1").val(data.orderId.firm.firmName);
					$("#firm").val(data.orderId.firm.firmId);
					$("#vendor").val(data.orderId.vendor.vendorName); 
					//$("#orderNo").val(data.orderId.purchaseOrderNo); 
					$("#orderId").val(data.orderId.orderId); 
					
					$("#dueDate").val(myDateFormatter(data.orderId.dueDate));
					
					$("#grpoId").val(data.grpoId);
					
					$("#marking_id").val(data.orderId.markingId);
					$("#grDate").val(myDateFormatter(data.grDate));
					generateStockNo("stockNo",$("#firm").val());
					var count = $("#rowid").val();
					
					var tbl = document.getElementById("reqItemTable");
					$("#reqItemTable").find("tr:gt(0)").remove();
					
					for(var r=0;r<data.grpoReceiptItems.length;r++){
					var orderId = data.orderId.orderId;
						var lastRow = tbl.rows.length;
						var newRow = tbl.insertRow(lastRow);
						
						
						
						var itemCode = data.grpoReceiptItems[r].itemCode;

						
						var content = "<td>";
						
						content+="<input type=\"text\" name=\"item1"+count+"\""
							+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" \" class=\"form-control\" placeholder=\"Item Code \"   readonly=\"readonly\" />"
							+ "<input type=\"hidden\" name=\"item"
							+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" ><input type=\"hidden\" name=\"grpoRecieptId"
							+ count+ "\" id=\"grpoRecieptId"+count+"\" value=\""+data.grpoReceiptItems[r].grpoEntryId+"\" > </td>"
							
									+ " <td><input type=\"text\" "
							+" 	name=\"itemCodesc"+count+"\" id=\"itemCodesc"+count+"\""
							+" 	class=\"form-control\" value=\""+itemCode.codeDesc+"\"  readonly=\"readonly\" /></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"allocation_Qty"+count+"\" name=\"allocation_Qty"+count+"\" placeholder=\"Allocation Qty\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"  ></td>"
									
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
									+" 	name=\"unit1"+count+"\" value=\"\" >"
										+ " </span> "

									+ " </td>"
									

						$(newRow).html(content);				
						   $(newRow).attr("id", "reqItemTableRow" + count);
						   //document.getElementById("addButton").style.display = "none";
						   //getItemOption('item'+count,orderId);	
						    $("#unit1"+count).html(data.grpoReceiptItems[r].unit.unitName);
						//$("#inward_date"+r).val(myDateFormatter(new Date()));
						$("#rowid").val(++count);
				}
					//$("#reqItemTable th:first-child").remove();
						
					$('#modal-add-req').modal({
						keyboard : true
					});
					$('#modal-add-req').modal("show");
				}
				
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling GRPO Details' + data);
				return;
			}

		});
	}
	
function open() {
		
		var stockId ="";
		var row = $('#flex2 tbody tr').has("input[name='stock_id']:checked")
		
		stockId = $(row).find("input[name='stock_id']:checked").val();
		if(stockId !=''){
			populateAllocatedItemPopup(stockId);
		}
		

	}
	
function populateAllocatedItemPopup(stockId) {

	var jsonRecord = {};
	
	url = 'getStockAllocationById';
	
	jsonRecord.id = stockId;
	
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		dataType : 'json',
		success : function(data) {
			if(data!=null){
				$("#firm1").val(data.firm.firmName);
				$("#firm").val(data.firm.firmId);
				$("#vendor").val(data.order.vendor.vendorName); 
				
				$("#orderId").val(data.order.orderId); 
				$("#stockNo").val(data.stockNo);
				$("#stockId").val(data.stockId);
				$("#dueDate").val(myDateFormatter(data.order.dueDate));
				
				$("#grpoId").val(data.grpo.grpoId);
				
				$("#marking_id").val(data.order.markingId);
				$("#grDate").val(myDateFormatter(data.grpo.grDate));
				$("#allocationDate").val(myDateFormatter(data.allocatedDate));
				//generateStockNo("stockNo",$("#firm").val());
				var count = $("#rowid").val();
				
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				for(var r=0;r<data.stockItems.length;r++){
				//var orderId = data.orderId.orderId;
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					
					var itemCode = data.stockItems[r].allocatedItem;

					
					var content = "<td>";
					
					content+="<input type=\"text\" name=\"item1"+count+"\""
						+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" \" class=\"form-control\" placeholder=\"Item Code \"   readonly=\"readonly\" />"
						+ "<input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" ><input type=\"hidden\" name=\"grpoRecieptId"
						+ count+ "\" id=\"grpoRecieptId"+count+"\" value=\""+data.grpo.grpoReceiptItems[r].grpoEntryId+"\" ><input type=\"hidden\" name=\"stockItemId"
						+ count+ "\" id=\"stockItemId"+count+"\" value=\""+data.stockItems[r].stockItemId+"\" > </td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"itemCodesc"+count+"\" id=\"itemCodesc"+count+"\""
						+" 	class=\"form-control\" value=\""+itemCode.codeDesc+"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"allocation_Qty"+count+"\" name=\"allocation_Qty"+count+"\" placeholder=\"Allocation Qty\" value=\""+data.stockItems[r].allocatedQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"  ></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.stockItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
								+" 	name=\"unit1"+count+"\" value=\"\" >"
									+ " </span> "

								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count);
					   //document.getElementById("addButton").style.display = "none";
					   //getItemOption('item'+count,orderId);	
					    $("#unit1"+count).html(data.stockItems[r].unit.unitName);
					//$("#inward_date"+r).val(myDateFormatter(new Date()));
					$("#rowid").val(++count);
			}
				//$("#reqItemTable th:first-child").remove();
					
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
			}
			
		},
		error : function(data) {
			BootstrapDialog.alert('Error Pulling GRPO Details' + data);
			return;
		}

	});
}
	
	
	function saveStockAllocation() {
		$('.close').click();
		$.ajax({
			url : 'saveStockAllocation',
			type : "POST",
			data : $("#StockForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Item Allocated successfully.');
				$('#flex1').flexOptions({
					url : "getGRPOListApprovalCompleted",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getStockAllocationList",
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

	
	

	function qtyCheck(){
		var count = $("#rowhid").val();
		for(var r=1;r<count;r++){
			var availQty = $("#availableQtyId"+r).html();
			var Qty = $("#qty"+r).val();
			if(Qty>availQty){
				BootstrapDialog.alert('Qty can not be greater then Available Qty');
				return;
			}
				
		}
		
		
	}
	
	
	function generateStockNo(field, firmId) {
		var modelRequest = {};
		modelRequest.id = firmId
		var sel = $("#" + field);
		$.ajax({
			url : 'generateStockAllocationNo',
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			success : function(data) {
				if (data != null) {
					$(sel).val(data);
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to generate the stock allocation no.');
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
				+ "')\" / placeHolder=\"Click to pick item\" ></td>"
				+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
		+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" /></td>"
				+ " <td><input type=\"text\" placeholder=\"Item Description\""
		+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
		+" 	class=\"form-control\" /></td>"
		+ " <td><input type=\"hidden\" placeholder=\"availableQty\""
		+" 	name=\"availableQty"+count+"\" id=\"availableQty"+count+"\""
		+" 	class=\"form-control\" /><span id=\"availableQtyId"+count+"\"></span></td>"
				+ " <td><input type=\"text\" class=\"form-control\""
		+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\" onkeypress=\"return numbersonly(this,event, true);\"></td>"
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
	
	 function numbersonly(form_element, e, decimal) {
		 var key;
		     var keychar;
		     
		     if (window.event) {
		        key = window.event.keyCode;
		     }
		     else if (e) {
		       key = e.which;
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

<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel" style="width:90%">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h4 class="panel-title" >
                   Pending Stock Allocation<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel" style="width:90%">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent" >
               <h4 class="panel-title">
                   Stock Allocate History<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>
<%@ include file="include/stockAllocationForm.jsp" %>
<script>
$(document).ready(function() {
     $('#dateRangePicker')
        .datepicker({
            format: "dd/mm/yyyy",
            endDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) ;

});
      </script>