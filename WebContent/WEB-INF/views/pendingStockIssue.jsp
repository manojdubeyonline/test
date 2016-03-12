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
			{display: 'Qty', name : '', width:90, sortable : true, align: 'left'},
			{display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
			{display: 'Requested By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
			{display: 'Due Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
			{display: 'Status', name : 'fullFillmentStatus', width:60, sortable : true, align: 'center'},
			
			
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
      sortname: "code",
		sortorder: "asc",
		usepager: true,
	//	title: 'My Requisitions',
		useRp: true,
		rp: 20,
	//	showTableToggleBtn: true,//toggle button for the whole table
		resizable: false,
		//width: w,
		singleSelect: true

	});
		
		$('#flex2').flexigrid({
			url:'getStockIssuedHistory',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : 'ite', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Requisition Ref No', name : 'requisitionRefNo', sortable : true, align: 'left',width:120},
				{display: 'Item', name : '', width:300, sortable : true, align: 'left'},
				{display: 'Issued Qty', name : '', width:90, sortable : true, align: 'left'},
				{display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
				{display: 'Issued By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
				{display: 'Issued Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
				
				
				
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
			//width: w,
			singleSelect: true

		});
getUsers('user');
//getItems("item");
//getFirms("firm");
//getWarehouses("warehouse");
addRow();
   
});


	function open() {
		var requisitionRefNo =  "";
		var requisitionItemId ="";
		var row = $('#flex1 tbody tr').has("input[name='requisitionItemId']:checked")
		requisitionRefNo =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		requisitionItemId = $(row).find("input[name='requisitionItemId']:checked").val();
		if(requisitionRefNo!='' && requisitionItemId !=''){
			populateRequisitionItemPopup(requisitionRefNo,requisitionItemId);
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
		$("#rowhid").val(1);
		
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
		
		url = 'getRequisitionByRefNoForStockIssue';
		
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
						$("#reqItemId").val(reqItemId);
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
									+ "')\" / placeHolder=\"Click to pick item\" value=\""+data.requisitionItems[r].itemCode.codeId+" \" style =\"width:70px;\"></td>"
									+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
							+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" value=\""+data.requisitionItems[r].itemCode.code+" \" style =\"width:140px;\" /></td>"
									+ " <td><input type=\"text\" placeholder=\"Item Description\""
							+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
							+" 	class=\"form-control\" value=\""+data.requisitionItems[r].itemCode.codeDesc+" \"/></td>"
							+ " <td><input type=\"hidden\" placeholder=\"availableQty\""
							+" 	name=\"availableQty"+count+"\" id=\"availableQty"+count+"\""
							+" 	class=\"form-control\"  /><span id=\"availableQtyId"+count+"\"></span></td>"
									+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\" value=\""+data.requisitionItems[r].qty+"\" style =\"width:70px;\" onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.requisitionItems[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
									+" 	name=\"unit1"+count+"\" value=\"\">"
										+ " </span> "
		
									+ " </td>"
		
							$(newRow).html(content);
							$(newRow).attr("id", "reqItemTableRow" + count);
							//getUnits('unit' + count);
							$("#unit1"+count).html(data.requisitionItems[r].unit.unitName);
							getItemStock('#availableQtyId' + count,data.requisitionItems[r].itemCode.codeId, data.requestedAtWareHouse.wareId)
							
							$("#rowhid").val(++count);
		
							
		
						}
					
						for(var r=0;r<data.requisitionItems.length;r++){
							if(reqItemId!=data.requisitionItems[r].itemKey){
								continue;
							}
							$("#priority"+existingRows).val(data.requisitionItems[r].priority);
							$("#unit"+existingRows).val(data.requisitionItems[r].unit.unitName);
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
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h4 class="panel-title">
                   Pending Stock Issue<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h4 class="panel-title">
                   Stock Issued History<span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h4>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>
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