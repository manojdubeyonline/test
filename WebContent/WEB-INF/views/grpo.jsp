<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#grpo").attr("class","active");
		var w=1000;
		
		
		$('#flex1').flexigrid({
			url:'getPurchaseOrderListApprovalCompleted',
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
				 	{name: ' Create', bclass: 'glyphicon glyphicon-plus', onpress : add},
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
			url:'getGRPOList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : true, align: 'center'},
				
				{display: 'Firm', name : '', width:150, sortable : true, align: 'center'},
				{display: 'Item', name : '', width:300, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'GR Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Added By', name : '', width:100, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit', bclass: 'glyphicon glyphicon-pencil', onpress : open},
		            {separator: true},
		            {name: ' Delete', bclass: 'glyphicon glyphicon-remove', onpress : remove},
		            {separator: true},
				 	
	      ],
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	             
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
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
//getUnits("unit");
//getUnits("unit1");
});


	function add() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex1 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populateGRPOCreatePopup(orderId);
		}
		

	}

	
	
function populateGRPOCreatePopup(orderId) {

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
				$("#gr_date").val(myDateFormatter(new Date()));
				
				$("#marking_id").val(data.markingId)
				
				var count = $("#rowhid").val();
				
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					var itemCode = data.orderItems[count].itemCode;
					
					var content = "<td>";
					if(lastRow >1){
						content+="<a href='#' onclick='removeRow("
							+ count
							+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a>";
					}
					content+="</td>"
						+ " 	<td><input type=\"hidden\" name=\"orderItemId"
						+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><select name=\"item"+count+"\""
						+" 	id=\"item"+count+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   onchange=\"getQty("+count+");\">"
						+ "<option value=\"\" selected disabled>Item Code / Item Description</option>"
						+ " </select></td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
						+" 	class=\"form-control\" value=\"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[count].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
								+" 	name=\"unit1"+count+"\" value=\"\" style =\"width:70px;\">"
									+ " </span> "

								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count);             
					   getItemOption('item'+count,orderId);					
					
					$("#rowhid").val(++count);
					
					
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
	
	
function addRow(){
	
	var count = $("#rowhid").val();
	
	var tbl = document.getElementById("reqItemTable");
	
		var lastRow = tbl.rows.length;
		var newRow = tbl.insertRow(lastRow);
		var content = "<td>";
		
			content+="<a href='#' onclick='removeRow("
				+ count
				+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a>";
	
		content+="</td>"
			+ " 	<td><input type=\"hidden\" name=\"orderItemId"
			+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><select name=\"item"+count+"\""
			+" 	id=\"item"+count+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   onchange=\"getQty("+count+");\">"
			+ "<option value=\"\" selected disabled>Item Code / Item Description</option>"
			+ " </select></td>"
			
					+ " <td><input type=\"text\" "
			+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
			+" 	class=\"form-control\" value=\"\"  readonly=\"readonly\" /></td>"
			+ " <td><input type=\"text\" class=\"form-control\""
			+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
					
					+ " <td><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
					+" 	name=\"unit1"+count+"\" value=\"\" style =\"width:70px;\">"
						+ " </span> "

					+ " </td>"
					

		$(newRow).html(content);				
		   $(newRow).attr("id", "reqItemTableRow" + count);             
		  getAddRowItemOption('item'+count);
		//getUnits('unit' +count);
		//$("#qty1"+count).html(data.orderItems[count].qty);
		
		$("#inward_date"+count).val(myDateFormatter(new Date()));
		$("#rowhid").val(++count);
		//$("#rowId").val(++counter);
		
}

function removeRow(count) {
	$("#reqItemTableRow" + count).remove();
}
	
	
	
	var itemOptions ="";
	var itemData = "";
	function getItemOption(field,orderId){
		var modelRequest = {};
		url : 'getItemByOrderId',
		modelRequest.id = orderId
		var sel = $("#"+field);
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				if (data != null) {
					itemData = data;
					for (var i = 0; i < data.orderItems.length; i++) {
						var itemCode = data.orderItems[i].itemCode;
						itemOptions+='<option value="' + itemCode.codeId + '">'
						+ itemCode.code +' / '+ itemCode.codeDesc + '</option>';
						}
					if(itemOptions!=""){
						 sel.append(itemOptions);
					 return;
					}

				}
							},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	
	}

	
	function getQty(count){
		if (itemData != null) {
			var orderItemId = $("#item"+count).val()
					for (var i = 0; i < itemData.orderItems.length; i++) {
						var itemCode = itemData.orderItems[i].itemCode;
						if(orderItemId == itemCode.codeId){
							$("#order_qty"+count).val(itemData.orderItems[i].qty);
							$("#orderItemId"+count).val(itemData.orderItems[i].itemKey);
						    $("#unit"+count).val(itemData.orderItems[i].unit.unitId);
						    $("#unit1"+count).html(itemData.orderItems[i].unit.unitName);
						    
						 }
						}
					}
				else{		
			
				BootstrapDialog.alert('Error Unable to set order qty');
				}	
		}

	
	function getAddRowItemOption(field){
		var sel = $("#"+field);
		if(itemOptions!=""){
			 sel.append(itemOptions);
		 return;
		}
		
	}
	
	
	function dateCall(count){
		$(document).ready(function() {
		     $('#dateRangePicker'+count)
		        .datepicker({
		            format: "dd/mm/yyyy",
		            endDate : new Date(),
		            defaultDate: new Date(),
		            "autoclose": true
		        }) 

		});
		
	}
	
	function open() {
		//var requisitionId =  "";
		var grpoId ="";
		var row = $('#flex2 tbody tr').has("input[name='grpo_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateGRPOViewPopup(grpoId);
		}
		

	}
	
	
	
	function populateGRPOViewPopup(grpoId) {

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
					$("#vendor").val(data.orderId.vendor.vendorId); 
					$("#orderNo").val(data.orderId.purchaseOrderNo); 
					$("#orderId").val(data.orderId.orderId); 
					$("#billAmount").val(data.billAmount);
					$("#vendorInvoiceNo").val(data.vendorInvoiceNo);
					$("#vendorInvoicedate").val(myDateFormatter(data.vendorInvoiceDate));
					$("#vehicleNo").val(data.vehicleNo);
					$("#dueDate").val(myDateFormatter(data.orderId.dueDate));
					$("#grpoId").val(data.grpoId);
					$("#gr_date").val(myDateFormatter(data.grDate));
					$("#inwardRemarks").val(data.inwardComments);
					$("#marking_id").val(data.orderId.markingId);
					
					var count = $("#rowhid").val();
					
					var tbl = document.getElementById("reqItemTable");
					$("#reqItemTable").find("tr:gt(0)").remove();
					
					for(var r=0;r<data.grpoReceiptItems.length;r++){
					var orderId = data.orderId.orderId;
						var lastRow = tbl.rows.length;
						var newRow = tbl.insertRow(lastRow);
						
						
						
						var itemCode = data.grpoReceiptItems[r].itemCode;

						
						var content = "<td>";
						
						content+="<input type=\"text\" name=\"item1"+count+"\""
							+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" / "+itemCode.codeDesc+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   readonly=\"readonly\" style =\"width:350px;\" />"
							+ "<input type=\"hidden\" name=\"item"
							+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" > <input type=\"hidden\" name=\"orderItemId"
							+ count+ "\" id=\"orderItemId"+count+"\" value=\""+data.grpoReceiptItems[r].orderItemId.itemKey+"\" ><input type=\"hidden\" name=\"grpoItemId"
							+ count+ "\" id=\"grpoItemId"+count+"\" value=\""+data.grpoReceiptItems[r].grpoEntryId+"\" ></td>"
							
									+ " <td><input type=\"text\" "
							+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
							+" 	class=\"form-control\" value=\""+data.grpoReceiptItems[r].orderItemId.qty+"\"  readonly=\"readonly\" /></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
									
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
									+" 	name=\"unit1"+count+"\" value=\"\" style =\"width:70px;\">"
										+ " </span> "

									+ " </td>"
									

						$(newRow).html(content);				
						   $(newRow).attr("id", "reqItemTableRow" + count);  
						   document.getElementById("addButton").style.display = "none";
						   //getItemOption('item'+count,orderId);	
						    $("#unit1"+count).html(data.grpoReceiptItems[r].unit.unitName);
						$("#inward_date"+r).val(myDateFormatter(new Date()));
						$("#rowhid").val(++count);
				}
					$("#reqItemTable th:first-child").remove();
						
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
	
	
	
	function remove() {
		var grpoId = $("input[name='grpo_id']:checked").val();
		BootstrapDialog.confirm('Are you sure you want to delete?', function(result){
            if(result) {
            	var modelRequest = {};
        		modelRequest.id = grpoId
        		
        		$.ajax({
        			url : 'deleteGRPO',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				BootstrapDialog
						.alert('GRPO successfully deleted');
        				$('#flex2').flexOptions({
        					url : "getGRPOList",
        					newp : 1
        				}).flexReload();
        			},
        			error : function(data) {
        				//BootstrapDialog
        						//.alert('Error unable to delete the requisition');
        				BootstrapDialog
						.alert('GRPO successfully deleted');
        				$('#flex2').flexOptions({
        					url : "getGRPOList",
        					newp : 1
        				}).flexReload();
        			}
        		});
            }else {
                return
            }
        });

	}
	
	function saveGRPO() {
		$('.close').click();
		$.ajax({
			url : 'saveGRPO',
			type : "POST",
			data : $("#grpoForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('GRPO saved successfully.');
				$('#flex1').flexOptions({
					url : "getPurchaseOrderListApprovalCompleted",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getGRPOList",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving GRPO.');
				return;
			}
		});

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
	
	function qtyCheck(){
		var count = $("#rowhid").val();
		for(var r=0;r<count;r++){
			var inwardQty =parseFloat($("#gr_Qty"+r).val()) ;
			var orderQty = parseFloat($("#order_qty"+r).val());
			if(inwardQty>orderQty){
				BootstrapDialog.alert('GR Qty can not be greater then Order Qty');
				return;
			}
				
		}
		
		
	}

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                   <small>Goods Receipt</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>View Goods Receipt</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>















<%@ include file="include/grpo_form.jsp" %>
<script>
$(document).ready(function() {
     $('.date')
        .datepicker({
            format: "dd/mm/yyyy",
            endDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) 

});
      </script>