<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
var sessionUserId = null;
var userRoleData = "";
$(document).ready(function(){
	//var w=screen.width;
	var w = 1000;
	$("#grpo").attr("class","active");
		
		
		
		$('#flex1').flexigrid({
			url:'getPendingGRPOList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Vendor', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Firm', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:350, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'PO Approval Date', name : '', width:100, sortable : true, align: 'left'},
				
				
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
			//width: w*.80,
			singleSelect: true

		});
		
		$('#flex2').flexigrid({
			url:'getLocalPurchaseOrder',
			method: 'POST', 
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Requisition Ref No', name : '', width:100, sortable : false, align: 'center'},
				{display: 'Item', name : '', width:550, sortable : true, align: 'left'},
				{display: 'Ware house', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Marked Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Due Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Procurement Method', name : '', width:100, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Create', bclass: 'glyphicon glyphicon-plus', onpress : localPurchaseGR},
		            {separator: true},
		            {name: ' Direct GR', bclass: 'glyphicon glyphicon-export', onpress : DirectGR},
		            {separator: true},
				 	
	      ],
	      searchitems : [
                          {display: 'Code Description', name :'codeDesc'},
	             
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
			//title: 'Pending Purchase Orders',
			useRp: true,
			rp: 20,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w,
			singleSelect: true
		});

		$('#flex3').flexigrid({
			url:'getGRPOList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Goods Reciept No', name : '', width:150, sortable : true, align: 'center'},
				
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
		            {name: ' PDF', bclass: 'glyphicon glyphicon-file', onpress : pdf},
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
			//width: w*.80,
			singleSelect: true

		});


sessionUserId =${_SessionUser.userId};
getUserFirms("firm",sessionUserId,'');

getVendors("vendor");

var userRoleId = ${_SessionUser.userRole.roleId};
getUserByRoleId(userRoleId);

});


function pdf() {
	//var requisitionId =  "";
	var grpoId ="";
	var row = $('#flex3 tbody tr').has("input[name='grpo_id']:checked")
	//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
	grpoId = $(row).find("input[name='grpo_id']:checked").val();
	if(grpoId !=undefined && grpoId !=null && grpoId !=''){
		populateGRPOPdf(grpoId);
	}
	

}


function populateGRPOPdf(grpoId) {

	var jsonRecord = {};
	
		url = 'getGRPOById';
	
	jsonRecord.id = grpoId;
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		
		success : function(data) {
			       if(data.approvalStatus != null ){
				  $("#grNo").html(data.goodsRecieptNo);
				  $("#totalBill").html((data.billAmount).toFixed( 2 ));
				  $("#grDate").html(dateConversion(myDateFormatter(data.grDate)));
				 
				  // $("#amount").val(parseFloat(data.billAmount));
				  $("#invoiceNo").html(data.vendorInvoiceNo);
				  $("#invoiceDate").html(dateConversion(myDateFormatter(data.vendorInvoiceDate)));
				  $("#vehicleNumber").html(data.vehicleNo);

					$('#grPdfForm').modal({
						keyboard : true
					});
					$('#grPdfForm').modal("show");
			       }
			       else{
			    	   BootstrapDialog.alert('GR is Not Approved');
			       }
					
					
		},
		error : function(data) {
			BootstrapDialog.alert('Error Pulling GR PDF Details' + data);
		
		}

	});
}

function dateConversion(dateCon){
	
	var monthNames = [
	                  "Jan", "Feb", "Mar",
	                  "Apr", "May", "June", "July",
	                  "Aug", "Sep", "Oct",
	                  "Nov", "Dec"
	                ];
	                var d = (dateCon).split('/');
	                var day = d[0];
	                var monthIndex = d[1];
	                while(monthIndex.charAt(0) === '0')
	                	monthIndex = monthIndex.substr(1);
	                var year = d[2];
	                var con = day + '-' + monthNames[monthIndex-1] + '-' + year
	                return con;
}

function add() {
	
	var orderId ="";
	var row = $('#flex1 tbody tr').has("input[name='order_id']:checked")

	//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
	orderId = $(row).find("input[name='order_id']:checked").val();
	if(orderId !=undefined && orderId !=null && orderId !=''){
		populateGRPOCreatePopup(orderId);
	}
	
	
	

}

function localPurchaseGR() {
	var procurementId ="";
	var procurementIds="";
	$('#flex2 tbody tr').has("input[name='marking_id']:checked").each(function(index,id){
	
		procurementId =$(id).find("input[name='marking_id']:checked").val();
		if(procurementId !=''){
		procurementIds += procurementId+",";
		
			
		}
	})

	
	procurementIds = procurementIds.substr(0, procurementIds.length-1);
	
	populateLocalPurchaseGRPOCreatePopup(procurementIds);
	
	
}


function DirectGR() {
	
	var role = "";
	var userAccessCheck = null;
	if(userRoleData != null){
		role = userRoleData;
	}
	for(var u=0;u<role.access.length;u++){
		var userAccessLevel = role.access[u].accessLevel;
		if(parseInt(role.access[u].menu.menuId) == 508 || (parseInt(role.access[u].menu.menuId) == 507 && (userAccessLevel == 'E'))){
			userAccessCheck++;
		}
	}
	if(userAccessCheck != null){
		$('#modal-add-req').modal({
			keyboard : true
		});
	$("#firm").val('');
	$("#firm1").val('');
	$("#warehouse").val('');
    $("#dueDate").val('');
    $("#grType").val("Direct Goods Receipt");
	$("#gr_date").val(myDateFormatter(new Date()));
	$("#rowhid").val(0);
	$('#modal-add-req').modal("show");
	$("#reqItemTable").find("tr:gt(0)").remove();
	addDirectGRRow();
	document.getElementById("addButton").style.display = "none";
	 $('#reqItemTable th:nth-child(3)').remove();
	}
	else{
		BootstrapDialog.alert('Only GR Approval Authority Can Create Direct GR');
		return;
	}
	
}

function addDirectGRRow() {
	
	var count = $("#rowhid").val();
	var counter = $("#rowId").val();
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
			+ " <td> <input type=\"text\" required readonly name=\"itemCode"
					+ count
					+ "\""
					+ " 	class=\"form-control\" id=\"itemCode"
					+ count
					+ "\" onclick=\"popPicker('"
					+ count
					+ "')\" / placeHolder=\"Click to pick item\"  style=\"width:400px\" ><input type=\"hidden\" name=\"item"
					+ count+ "\" id=\"item"+count+"\" value=\"\" >"
						
						+ " </td>"
						
						
				+ " <td><input type=\"text\" class=\"form-control\""
				+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();\"></td>"
						+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
						+" 	name=\"unit"+count+"\"> "

				+ " </td></td>"
				$(newRow).html(content);
				$(newRow).attr("id", "reqItemTableRow" + count);
				
				var nextRowHeader = tbl.rows.length;
				var nextHeader =tbl.insertRow(nextRowHeader);
				var headerContent="<td colspan=\"5\" class=\"active\">"
					headerContent+="Rate Per Unitx </td>"
				$(nextHeader).html(headerContent);
					
					
				var nextlastRow = tbl.rows.length;
				var nextRow =tbl.insertRow(nextlastRow);
				var nextContent ="<td colspan=\"5\">"
					nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
				+" 	id=\"rateName"+count+counter+"\" onchange=\"grRateCalc();\">"
			
				+ " </select></td><td><input type=\"text\" class=\"form-control\""
				+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"    onchange=\"grRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" /></td>"
				+"<td><a href='#' onclick='addGRRateRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" id=\"myBtn"+count+"\" class=\"btn btn-default\" ><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
				+" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></table></td>"

				
				$(nextRow).html(nextContent);				
				   $(nextRow).attr("id", "innerItemTableRow" + count); 
				   getUnits('unit' + count);
				   getRates('rateName'+count+counter);
				   $("#rowhid").val(++count);
				   $("#rowId").val(++counter);

	
}


function addGRRateRow(count) {
	
	//var count = counter;
	//var count = $("#newrowhid").val();
	  document.getElementById("orderLevelButton").style.visibility = "hidden";
	var counter = $("#rowId").val();
	var tbl = document.getElementById("innerItemTable"+count);
	var lastRow = tbl.rows.length;
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);

	var content = "<td>";
	
		content+="<select class=\"form-control\" name=\"rateName"+count+counter+"\""
		+" 	id=\"rateName"+count+counter+"\"  size\"6\"/>"
				
		+ " </select></td><td><input type=\"text\" class=\"form-control\""
		+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\" onchange=\"grRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\"></td>"
		+"<td><a href='#' onclick='removeRow("
		+counter+ "),grRateCalc();'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>"

	newRow.innerHTML = content;
		//var count = $("#newrowhid").val();
		getRates('rateName'+count+counter);	
	$(newRow).attr("id", "innerItemRows" + counter);
	$("#rowId").val(++counter);
	//$("#rowId").val(++count);
	
}


var selectedCounter = 0;

function popPicker(counter) {
	selectedCounter = counter;
	var selVal = $("#itemCode" + counter).val();
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



function push(id, plNo, desc) {
	dlg.close();
	//$('#itemName' + selectedCounter).val(desc);
	$('#itemCode' + selectedCounter).val(plNo+"/"+desc);
	$('#item' + selectedCounter).val(id);
}

var dlg = new BootstrapDialog({
	draggable : true,
	type : BootstrapDialog.TYPE_SUCCESS
});
	
function populateGRPOCreatePopup(orderId) {

	var jsonRecord = {};
	
	url = 'getPurchaseOrderByIdForGRPO';
	
	jsonRecord.id = orderId;
	
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
					if(parseInt(role.access[u].menu.menuId) == 507 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				document.getElementById("addSecondButton").style.display = "none";
				$("#firmId").val(data.firm.firmId);
				//$("#firm1").val(data.firm.firmName);
				$("#warehouseId").val(data.warehouse.wareId);
				getUserWarehouse("warehouse","", data.warehouse.wareId,sessionUserId);
				getUserFirms("firm",sessionUserId,data.firm.firmId);
				$("#warehouse").attr("disabled", true);
				$("#firm").attr("disabled", true);
				$("#vendor").val(data.vendor.vendorId);
				$("#grType").val("Purchase Order GR");
				$("#orderNo").val(data.purchaseOrderNo);
				$("#orderId").val(data.orderId);
				$("#dueDate").val(myDateFormatter(data.dueDate));
				$("#gr_date").val(myDateFormatter(new Date()));
				getVendorAddress("vendorAddress",data.vendor.vendorId,data.vendorDetail.locationId);
				//$("#marking_id").val(data.markingId)
				generateRecieptNo("recieptNo",$("#firmId").val(),$("#warehouseId").val());
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				var rateCounter = counter;
				
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					var mark= data.orderItems[count].procurementMarking;
					var itemCode = data.orderItems[count].itemCode;
					var orderItem = data.orderItems[count];
					
					var content = "<td>";
					if(lastRow >1){
						content+="<a href='#' onclick='removeRow("
							+ count
							+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a>";
					}
					content+="</td>"
						+ " 	<td><input type=\"hidden\" name=\"orderItemId"
						+ count+ "\" id=\"orderItemId"+count+"\" value=\""+data.orderItems[count].itemKey+"\" ><input type=\"hidden\" name=\"marking_id"
						+ count+ "\" id=\"marking_id"+count+"\" value=\"\" ><select name=\"item"+count+"\""
						+" 	id=\"item"+count+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   onchange=\"getQty("+count+","+counter+");itemCheck();\">"
						+ "<option value=\"\" selected disabled>Item Code / Item Description</option>"
						+ " </select></td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
						+" 	class=\"form-control\" value=\"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();\"></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[count].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
								+" 	name=\"unit1"+count+"\" value=\"\" style =\"width:70px;\">"
									+ " </span> "

								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count); 
					  
					   
					   var nextRowHeader = tbl.rows.length;
						var nextHeader =tbl.insertRow(nextRowHeader);
					   
					   var headerContent="<td colspan=\"5\" class=\"active\">"
							headerContent+="Rate Per Unitx</td>"
						$(nextHeader).html(headerContent);
							
							var nextlastRow = tbl.rows.length;
							var nextRow =tbl.insertRow(nextlastRow);
							var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\">";
							
						for(var k=0;k<orderItem.itemLevelRates.length;k++){
							
							var currentRateApplied = orderItem.itemLevelRates[k];
							if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
								continue;
							}
							//if(currentRateApplied.levelStatus == "I")
							//{
							nextContent+="<tr><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
							+" 	id=\"rateName"+count+counter+"\" onchange=\"grRateCalc();\">"
						
							+ " </select></td><td><input type=\"text\" class=\"form-control\""
							+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"grRateCalc();\"></td>"
							+"<td><div class =\"btn-group\" style=\"float:right\"></div></a><input type=\"hidden\" class=\"form-control\""+
							" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></tr>"

							//getRatesView(count+""+counter,itemRateApplied.itemLevelRates);
							//}
							 $("#rowId").val(++counter);
							 	
							
					 }
						nextContent+="</table></td>";
						$(nextRow).html(nextContent);	
						  $(nextRow).attr("id", "innerItemTableRow" + count);
						 
					   
						///order level
						
						var Ordercount = $("#grLevelRateId").val();
						var OrderExist = Ordercount;
						//	alert(count);
							var tbl = document.getElementById("addMultipleTable");
							for(var m=0;m<data.orderLevelRates.length;m++){
								var orderRateApplied =data.orderLevelRates[m];
								if(orderRateApplied.rate.rateId==21 ||orderRateApplied.rate.rateId==22 ||orderRateApplied.rate.rateId==23 || orderRateApplied.rate.rateId==1){
									continue;
								}
								if(orderRateApplied.levelStatus == "O")
								{
							var lastRow = tbl.rows.length;
							
							//alert(lastRow)
							
							var newRow = tbl.insertRow(lastRow);
							var content="</td>"		
								+ " <td><select class=\"form-control\" name=\"ratesName"+Ordercount+"\""
								+" 	id=\"ratesName"+Ordercount+"\" >"
								   
										+ " </select></td>"
										+ " 	<td><input type=\"text\" name=\"orderLevelRate"+Ordercount+"\""
										+" 	id=\"orderLevelRate"+Ordercount+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"purchaseRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
										+ "</td>"
								
							
							content += "<td>";
							if(lastRow >1){
								content+="<a href='#' onclick='deleteRow("+Ordercount+"),purchaseRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
							}	
							$("#grLevelRateId").val(++Ordercount);
								}			
							newRow.innerHTML = content;
							//getRates('ratesName'+Ordercount);
							$(newRow).attr("id", "addMultipleTableRow" + Ordercount);
							
							}
							
							for(var n=0;n<data.orderLevelRates.length;n++){
								var orderRateApplied =data.orderLevelRates[n];
								
								
								if(orderRateApplied.rate.rateId==23){
									$("#grLevelGrandTotal").val(orderRateApplied.appliedAmount);
								}
								if(orderRateApplied.rate.rateId==22){
									$("#grLevelTotal").val(orderRateApplied.appliedAmount);
								}
								
								if(orderRateApplied.rate.rateId==21 ||orderRateApplied.rate.rateId==22 ||orderRateApplied.rate.rateId==23 ||orderRateApplied.rate.rateId==1){
									continue;
								}
								if(orderRateApplied.levelStatus == "O")
								{
								 $("#ratesName"+OrderExist).val(orderRateApplied.rate.rateId);
								 $("#orderLevelRate"+OrderExist).val(orderRateApplied.appliedAmount);
								 
								 getRates('ratesName'+OrderExist,orderRateApplied.rate.rateId);
								 ++OrderExist;
								}
								
							
								 
							}
					   				
					
							  
							  getItemOption('item'+count,orderId);
							$("#rowhid").val(++count);
					
					
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
			BootstrapDialog.alert('Error Pulling GRPO Details' + data);
			return;
		}

	});
}


function populateLocalPurchaseGRPOCreatePopup(markingId) {

	var jsonRecord = {};
	
	url = 'getMultipleProcurementMarkingById';
	
	jsonRecord.id = markingId;
	
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
					if(parseInt(role.access[u].menu.menuId) == 507 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				document.getElementById("addButton").style.display = "none";
				document.getElementById("addSecondButton").style.display = "none";
				//$("#firm").val(data[0].reqId.requestedForFirm.firmId);
				//$("#firm1").val(data[0].reqId.requestedForFirm.firmName);
				//$("#warehouse").val(data[0].reqId.requestedAtWareHouse.wareId);
				$("#firmId").val(data[0].reqId.requestedForFirm.firmId);
				
				$("#warehouseId").val(data[0].reqId.requestedAtWareHouse.wareId);
				getUserWarehouse("warehouse","",data[0].reqId.requestedAtWareHouse.wareId,sessionUserId);
				getUserFirms("firm",sessionUserId,data[0].reqId.requestedForFirm.firmId);
				$("#warehouse").attr("disabled", true);
				$("#firm").attr("disabled", true);
				
				
				
				$("#dueDate").val(myDateFormatter(data[0].dueDate));
				$("#gr_date").val(myDateFormatter(new Date()));
				$("#grType").val("Local Purchase GR");
				$("#marking_id").val(data.markingId);
				generateRecieptNo("recieptNo",$("#firmId").val(),$("#warehouseId").val());
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				for(var r=0;r<data.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					var itemCode = data[r].requisitionItemId.itemCode;
					
					var content = "<td>";
					
					content+="</td>"
						+ " 	<td><input type=\"hidden\" name=\"itemRateRow"
						+ count+ "\" id=\"itemRateRow"+count+"\" value=\"0\"><input type=\"hidden\" name=\"item"+count+"\""
						+" 	id=\"item"+count+"\" class=\"form-control\" value=\""+itemCode.codeId+"\" placeholder=\"Item Code / Item Description\"   onchange=\"itemCheck();\" style=\"width:300px\"><input type=\"text\" name=\"item1"+count+"\""
						+" 	id=\"item1"+count+"\" class=\"form-control\" value=\""+itemCode.code+" / "+itemCode.codeDesc+"\" placeholder=\"Item Code / Item Description\"   onchange=\"itemCheck();\" style=\"width:300px\">"
						
						+ "</td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
						+" 	class=\"form-control\" value=\""+data[r].procurementQty+"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();\"></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data[r].unit.unitId+"\"  readonly=\"readonly\"><input type=\"text\" class=\"form-control\""
								+" 	id=\"unit1"+count+"\" name=\"unit1"+count+"\"  value=\""+data[r].unit.unitName+"\"  readonly=\"readonly\">"
								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count);  
					   
					   var nextRowHeader = tbl.rows.length;
						var nextHeader =tbl.insertRow(nextRowHeader);
						//var counter = $("#itemRateRow"+count).val();
						var headerContent="<td colspan=\"5\" class=\"active\">"
							headerContent+="Rate Per Unit </td>"
						$(nextHeader).html(headerContent);
							
							
						var nextlastRow = tbl.rows.length;
						var nextRow =tbl.insertRow(nextlastRow);
						var nextContent ="<td colspan=\"5\">"
							nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
						+" 	id=\"rateName"+count+counter+"\" >"
						
						+ " </select></td><td><input type=\"text\" class=\"form-control\""
						+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"    onchange=\"grRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" /></td>"
						+"<td><a href='#' onclick='addRateRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" id=\"myBtn"+count+"\" class=\"btn btn-default\" ><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
						+" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></table></td>"

						
						$(nextRow).html(nextContent);	
						getRates('rateName'+count+counter);			
						   $(nextRow).attr("id", "innerItemTableRow" + count);       
						   $("#rowId").val(++counter);
						   $("#rowhid").val(++count);
					  				
				}
					
					
					
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
			BootstrapDialog.alert('Error Pulling GRPO Details' + data);
			return;
		}

	});
}


function addRateRow(count) {
	
	//var count = counter;
	//var count = $("#newrowhid").val();
	 // document.getElementById("orderLevelButton").style.visibility = "hidden";
	//var counter = $("#itemRateRow"+count).val();
	var counter = $("#rowId").val();
	var tbl = document.getElementById("innerItemTable"+count);
	var lastRow = tbl.rows.length;
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);

	var content = "<td>";
	
		content+="<select class=\"form-control\" name=\"rateName"+count+counter+"\""
		+" 	id=\"rateName"+count+counter+"\"  size\"6\"/>"
				
		+ " </select></td><td><input type=\"text\" class=\"form-control\""
		+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\" onchange=\"grRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\"></td>"
		+"<td><a href='#' onclick='removeRow("
		+counter+ "),grRateCalc();'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>"

	newRow.innerHTML = content;
		//var count = $("#newrowhid").val();
		getRates('rateName'+count+counter);	
	$(newRow).attr("id", "innerItemRows" + counter);
	//$("#itemRateRow"+count).val(++counter);
	$("#rowId").val(++counter);
	
	
}

function addGrLevelRates() {
	var count1 = $("#rowhid").val();
	
	for(i=0;i<count1; i++) {
  		  document.getElementById("myBtn"+i).style.display = "none";
  		
  	}	   
  	 
  		
	
	var count = $("#grLevelRateId").val();
	
//	alert(count);
	var tbl = document.getElementById("addMultipleTable");
	var lastRow = tbl.rows.length;
	
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);
	var content="</td>"		
		+ " <td><select class=\"form-control\" name=\"ratesName"+count+"\""
		+" 	id=\"ratesName"+count+"\" >"
		   
				+ " </select></td>"
				+ " 	<td><input type=\"text\" name=\"orderLevelRate"+count+"\""
				+" 	id=\"orderLevelRate"+count+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"grRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
				+ "</td>"
		
	
	content += "<td>";
	if(lastRow >1){
		content+="<a href='#' onclick='deleteRow("+count+"),grRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
	}	
				
	newRow.innerHTML = content;
	getRates('ratesName'+count);
	$(newRow).attr("id", "addMultipleTableRow" + count);
	$("#grLevelRateId").val(++count);
	
}


function grRateCalc(){
	var rowCount = $("#rowId").val();
	var count = $("#rowhid").val();
	
	var orderQty = 0;
	var basicRate = 0;
	var exciseValue = 0;
	var cessValue = 0;
	var total = 0;
	var excise = 0;
	var cess = 0;
	var sales = 0;
	var freight = 0;
	var otherCharges = 0;
	
	for(var i=0;i<count;i++)
	{
		//var rowCount = $("#itemRateRow"+i).val();
		orderQty =	document.getElementById("gr_Qty"+i).value;
	var addStatus=0;
	var basicRate = 0;
	for(var j=0;j<rowCount;j++)
	{
		
		if(document.getElementById("rateValue"+i+j) == null  )
			continue;
		else
		{
			var rateName =document.getElementById("rateName"+i+j).value;
			if(rateName == 1){
				var conCheck = parseFloat(document.getElementById("rateValue"+i+j).value);
				basicRate = basicRate + conCheck;
			}
		
		//total = total+basicRate*orderQty;
		total =basicRate*orderQty;
	
	
		if(rateName == 1){
			total =  ((total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total)))))))) + (freight) + (otherCharges);
		}
		
		if(rateName == 2){
			 excise = parseFloat(document.getElementById("rateValue"+i+j).value);
			
			exciseValue = (excise/100)*basicRate;
			total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total)) +  ((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
			
		}
		//if(rateName == 4 ){
			
		// cess = parseFloat(document.getElementById("rateValue"+i+j).value);
		//   cessValue += (cess/100)*((excise/100)*basicRate);
		// total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total)) + ((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
		//}
		if(rateName == 3){
			
			 sales = parseFloat(document.getElementById("rateValue"+i+j).value);
			var salesValue = (sales/100)*total;
			total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
		}
		if(rateName == 4){
			
			freight = parseFloat(document.getElementById("rateValue"+i+j).value);
			total = ((total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total)))))))) + (freight) + (otherCharges);
		}
		
		if(rateName == 5){
			otherCharges = parseFloat(document.getElementById("rateValue"+i+j).value);
			total =  ((total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total)))))))) + (freight) + (otherCharges);
		}
	
	
		addStatus = total;

	}
		
	}
	
	document.getElementById("itemLevelTotal"+i).value=addStatus;
	totalCalc();
	}
	
	
	
}

function totalCalc(){
	
	var orderLevel = $("#grLevelRateId").val();

	var orderQty = 0;
	var basicRate = 0;
	var exciseValue = 0;
	var cessValue = 0;
	
	
	var count = $("#rowhid").val();
	var total = 0;
	for(var i=0;i<count;i++)
		{
		 subTotal = parseFloat(document.getElementById("itemLevelTotal"+i).value);
		 basicRate +=subTotal;
	
		}
	
	
	if(orderLevel>0){
		var excise = 0;
		var cess = 0;
		var sales = 0;
		var freight = 0;
		var otherCharges = 0;
	for(var r=0;r<orderLevel;r++){
		
		if(document.getElementById("ratesName"+r) == null)
			continue;
		else{
			
		
		var rateName = document.getElementById("ratesName"+r).value;
		
		if(rateName == 2){
			 excise = parseFloat(document.getElementById("orderLevelRate"+r).value);
			
			exciseValue = (excise/100)*basicRate;
			total = (basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate)) +  ((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate))))))) + (freight) + (otherCharges);
			
		}
		//if(rateName == 4 ){
			
		// cess = parseFloat(document.getElementById("orderLevelRate"+r).value);
		  // cessValue += (cess/100)*((excise/100)*basicRate);
		 //total = (basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate)) + ((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate))))))) + (freight) + (otherCharges);
		//}
		if(rateName == 3){
			
			 sales = parseFloat(document.getElementById("orderLevelRate"+r).value);
			var salesValue = (sales/100)*total;
			total = (basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate))+((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate))))))) + (freight) + (otherCharges);
		}
		if(rateName == 4){
			
			freight = parseFloat(document.getElementById("orderLevelRate"+r).value);
			total = ((basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate))+((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate)))))))) + (freight) + (otherCharges);
		}
		
		if(rateName == 5){
			otherCharges = parseFloat(document.getElementById("orderLevelRate"+r).value);
			total = total + otherCharges;
		 }
		
	   }
	 }
	document.getElementById("grLevelTotal").value=Math.round(total,2);
	}
	else{
		total = basicRate;
	}
	
	
	
	 document.getElementById("grLevelGrandTotal").value=Math.round(total,2);
	 
	
}


function itemCheck(){
	var count = document.getElementById('rowhid').value;
	for(var m=0;m<count;m++){
		for(var n=0;n<count;n++){
			if( document.getElementById('item'+m).value == document.getElementById('item'+n).value && m != n){
				BootstrapDialog.alert('Two items can not be same');
				return false;
			}	
		}
		
	}
}

function generateRecieptNo(field,firmId,wareId) {
	var modelRequest = {};
	
	modelRequest.id = firmId;
	modelRequest.id2 = wareId;
	var sel = $("#"+field);
	$.ajax({
		url : 'generateGoodsRecieptNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the reciept no.');
		}
	});
}
	
	
function generateDirectRecieptNo() {
	var modelRequest = {};
	var firmId = $("#firm").val();
	var wareId = $("#warehouse").val()
	modelRequest.id = firmId;
	modelRequest.id2 = wareId;
	var sel = $("#recieptNo");
	$.ajax({
		url : 'generateGoodsRecieptNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the reciept no.');
		}
	});
}
	
	
function addRow(){
	
	var count = $("#rowhid").val();
	var counter = $("#rowId").val();
	// var counter = $("#itemRateRow"+count).val();
	
	
	var tbl = document.getElementById("reqItemTable");
	
		var lastRow = tbl.rows.length;
		var newRow = tbl.insertRow(lastRow);
		var content = "<td>";
		
			content+="<a href='#' onclick='removeRow("
				+ count
				+ ")'><span class=\"glyphicon glyphicon-trash\"></span></a>";
	
		content+="</td>"
			+ " 	<td><input type=\"hidden\" name=\"itemRateRow"
			+ count+ "\" id=\"itemRateRow"+count+"\" value=\"0\"><input type=\"hidden\" name=\"orderItemId"
			+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><input type=\"hidden\" name=\"marking_id"
			+ count+ "\" id=\"marking_id"+count+"\" value=\"\" ><select name=\"item"+count+"\""
			+" 	id=\"item"+count+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   onchange=\"getQty("+count+","+counter+");grRateCalc();\">"
			+ "<option value=\"\" selected disabled>Item Code / Item Description</option>"
			+ " </select></td>"
			
					+ " <td><input type=\"text\" "
			+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
			+" 	class=\"form-control\" value=\"\"  readonly=\"readonly\" /></td>"
			+ " <td><input type=\"text\" class=\"form-control\""
			+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();\"></td>"
					
					+ " <td><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
					+" 	name=\"unit1"+count+"\" value=\"\" style =\"width:70px;\">"
						+ " </span> "

					+ " </td>"
					

		$(newRow).html(content);				
		   $(newRow).attr("id", "reqItemTableRow" + count);  
		 // var counter = $("#itemRateRow"+count).val();
		   var nextRowHeader = tbl.rows.length;
			var nextHeader =tbl.insertRow(nextRowHeader);
		   
		   var headerContent="<td colspan=\"5\" class=\"active\">"
				headerContent+="Rate Per Unitx</td>"
			$(nextHeader).html(headerContent);
				
				var nextlastRow = tbl.rows.length;
				var nextRow =tbl.insertRow(nextlastRow);
				var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\">";
				var orderItem = itemData.orderItems[count];

			for(var k=0;k<orderItem.itemLevelRates.length;k++){
				
				var currentRateApplied = orderItem.itemLevelRates[k];
				if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
					continue;
				}
				//if(currentRateApplied.levelStatus == "I")
				//{
				nextContent+="<tr><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
				+" 	id=\"rateName"+count+counter+"\">"
			
				+ " </select></td><td><input type=\"text\" class=\"form-control\""
				+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"purchaseRateCalc();\"></td>"
				+"<td><div class =\"btn-group\" style=\"float:right\"></div></a><input type=\"hidden\" class=\"form-control\""+
				" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></tr>"

				//getRatesView(count+""+counter,itemRateApplied.itemLevelRates);
				//}
				 //$("#itemRateRow"+count).val(++counter);
				$("#rowId").val(++counter);
				 	
				
		 }
			nextContent+="</table></td>";
			$(nextRow).html(nextContent);	
			  $(nextRow).attr("id", "innerItemTableRow" + count);
		   
		   
		   
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

	
	function getQty(count,rateCounter){
		if (itemData != null) {
			var orderItemId = $("#item"+count).val()
					for (var i = 0; i < itemData.orderItems.length; i++) {
						var itemCode = itemData.orderItems[i].itemCode;
						if(orderItemId == itemCode.codeId){
							$("#order_qty"+count).val(itemData.orderItems[i].qty);
							$("#orderItemId"+count).val(itemData.orderItems[i].itemKey);
							//$("#marking_id"+count).val(itemData.orderItems[i].procurementMarking.markingId);
						    $("#unit"+count).val(itemData.orderItems[i].unit.unitId);
						    $("#unit1"+count).html(itemData.orderItems[i].unit.unitName);
						    
						 
			//var rateCounter = 0;
			var orderItem = itemData.orderItems[i];
			for(var z=0;z<orderItem.itemLevelRates.length;z++){
				var currentRateApplied = orderItem.itemLevelRates[z];
				
				//if(currentRateApplied.rate.rateId==23){
					//$("#grLevelGrandTotal").val(currentRateApplied.appliedAmount);
				//}
				if(currentRateApplied.rate.rateId==21){
					$("#itemLevelTotal"+count).val(currentRateApplied.appliedAmount);
				}
				if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
					continue;
				}	
				//if(currentRateApplied.levelStatus == "I")
				//{
				 $("#rateName"+count+rateCounter).val(currentRateApplied.rate.rateId);
				 $("#rateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
				//}
				getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
				 ++rateCounter;
				 
			}
			
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
		var row = $('#flex3 tbody tr').has("input[name='grpo_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateGRPOViewPopup(grpoId);
		}
		

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
					
					var role = "";
					var userAccessCheck = null;
					if(userRoleData != null){
						role = userRoleData;
					}
					for(var u=0;u<role.access.length;u++){
						var userAccessLevel = role.access[u].accessLevel;
						if(parseInt(role.access[u].menu.menuId) == 508 || (parseInt(role.access[u].menu.menuId) == 507 && (userAccessLevel == 'E'))){
							userAccessCheck++;
						}
					}
					//alert(userAccessCheck);
					if(userAccessCheck != null){
						
					
					$("#firm1").val(data.firm.firmName);
					$("#firm").val(data.firm.firmId);
					$("#vendor").val(data.vendor.vendorId);
					
					//$("#vendorAddress").val(data.vendorDetail.locationId);
					//$('#vendorAddress option[value="'+data.vendorDetail.locationId+'"]').attr('selected','selected');
					getVendorAddress("vendorAddress",data.vendor.vendorId,data.vendorDetail.locationId);
					$("#vendorInvoiceNo").val(data.vendorInvoiceNo);
					$("#vendorInvoicedate").val(myDateFormatter(data.vendorInvoiceDate));
					$("#vehicleNo").val(data.vehicleNo);
					
					$("#grpoId").val(data.grpoId);
					$("#recieptNo").val(data.goodsRecieptNo);
					$("#gr_date").val(myDateFormatter(data.grDate));
					$("#inwardRemarks").val(data.inwardComments); 
					$("#grType").val(data.grType);
					
					for(var n=0;n<data.grLevelRates.length;n++){
						if(data.grLevelRates[n].rate.rateId==23){
						$("#grTotalRateAppliedId").val(data.grLevelRates[n].grRateId);
						}
						if(data.grLevelRates[n].rate.rateId==22){
							$("#grLevelId").val(data.grLevelRates[n].grRateId);
							}
						
						}
					
					var count = $("#rowhid").val();
					var counter = $("#rowId").val();
					var rateCounter = counter;
					
					var tbl = document.getElementById("reqItemTable");
					$("#reqItemTable").find("tr:gt(0)").remove();
					
					for(var r=0;r<data.grpoReceiptItems.length;r++){
					
						var lastRow = tbl.rows.length;
						var newRow = tbl.insertRow(lastRow);
						
						
						var Qty = 0;
						var itemLevelTotalId = null;
						var itemCode = data.grpoReceiptItems[r].itemCode;
						var grItem = data.grpoReceiptItems[r];
						
						for(var x=0;x<grItem.itemLevelGRRates.length;x++){
							if(grItem.itemLevelGRRates[x].rate.rateId==21){
								itemLevelTotalId = grItem.itemLevelGRRates[x].grRateId;
							}
						}
						
						
						if(data.grpoReceiptItems[r].procurementMarking != null){
							Qty = data.grpoReceiptItems[r].procurementMarking.procurementQty;
						}
						else{
							Qty = data.grpoReceiptItems[r].orderItemId.qty;
							}

						
						var content = "<td>";
						
						content+="<input type=\"hidden\" name=\"itemLevelTotalRAId"
							+ count+ "\" id=\"itemLevelTotalRAId"+count+"\" value=\""+itemLevelTotalId+"\"><input type=\"text\" name=\"item1"+count+"\""
							+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" / "+itemCode.codeDesc+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"   readonly=\"readonly\" style =\"width:350px;\" />"
							+ "<input type=\"hidden\" name=\"item"
							+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" > <input type=\"hidden\" name=\"orderItemId"
							+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><input type=\"hidden\" name=\"grpoItemId"
							+ count+ "\" id=\"grpoItemId"+count+"\" value=\""+data.grpoReceiptItems[r].grpoEntryId+"\" ></td>"
							
									+ " <td><input type=\"text\" "
							+" 	name=\"order_qty"+count+"\" id=\"order_qty"+count+"\""
							+" 	class=\"form-control\" value=\""+Qty+"\"  readonly=\"readonly\" /></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"gr_Qty"+count+"\" name=\"gr_Qty"+count+"\" placeholder=\"GR Qty\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();\"></td>"
									
									+ " <td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitId+"\" ><input type=\"text\" class=\"form-control\""
									+" 	id=\"unit1"+count+"\" name=\"unit1"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitName+"\" readonly=\"readonly\" >"
										

									+ " </td>"
									

						$(newRow).html(content);				
						   $(newRow).attr("id", "reqItemTableRow" + count); 
						 //$("#unit1"+count).html(data.grpoReceiptItems[r].unit.unitName);
						   
						   var nextRowHeader = tbl.rows.length;
							var nextHeader =tbl.insertRow(nextRowHeader);
							//var counter = $("#itemRateRow"+count).val();
							//var rateCounter = counter;
						   var headerContent="<td colspan=\"5\" class=\"active\">"
								headerContent+="Rate Per Unitx</td>"
							$(nextHeader).html(headerContent);
								
								var nextlastRow = tbl.rows.length;
								var nextRow =tbl.insertRow(nextlastRow);
								var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+r+"\" width=\"100%\">";
								
							for(var k=0;k<grItem.itemLevelGRRates.length;k++){
								
								var currentRateApplied = grItem.itemLevelGRRates[k];
								if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
									continue;
								}
								
								nextContent+="<tr><td><input type=\"hidden\" class=\"form-control\""
									+" 	id=\"grItemRateId"+count+counter+"\" name=\"grItemRateId"+count+counter+"\"  value=\""+currentRateApplied.grRateId+"\"  ><select class=\"form-control\" name=\"rateName"+count+counter+"\""
								+" 	id=\"rateName"+count+counter+"\">"
							
								+ " </select></td><td><input type=\"text\" class=\"form-control\""
								+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"grRateCalc();\"></td>"
								+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\">"
								+"<span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""+
								" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></tr>"

								
								
								$("#rowId").val(++counter);
								
						 }
							//$("#itemRateRow" + count).val(0);
							nextContent+="</table></td>";
							$(nextRow).html(nextContent);	
							  $(nextRow).attr("id", "innerItemTableRow" + r);
							   
							for(var z=0;z<grItem.itemLevelGRRates.length;z++){
								var currentRateApplied = grItem.itemLevelGRRates[z];
								
								if(currentRateApplied.rate.rateId==23){
									$("#grLevelGrandTotal").val(currentRateApplied.appliedAmount);
								}
								if(currentRateApplied.rate.rateId==21){
									$("#itemLevelTotal"+count).val(currentRateApplied.appliedAmount);
								}
								if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
									continue;
								}	
								
								 $("#rateName"+count+rateCounter).val(currentRateApplied.rate.rateId);
								 $("#rateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
								
								getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
								 ++rateCounter;
								 
							}
							
						 document.getElementById("addButton").style.display = "none";
						   
						   $("#inward_date"+r).val(myDateFormatter(new Date()));
						$("#rowhid").val(++count);
				}
					
					//GR Level
					var Grcount = $("#grLevelRateId").val();
					var GrExist = Grcount;
					//	alert(count);
						var tbl = document.getElementById("addMultipleTable");
						for(var m=0;m<data.grLevelRates.length;m++){
							var grRateApplied =data.grLevelRates[m];
							if(grRateApplied.rate.rateId==21 ||grRateApplied.rate.rateId==22 ||grRateApplied.rate.rateId==23 || grRateApplied.rate.rateId==1){
								continue;
							}
							if(grRateApplied.levelStatus == "O")
							{
						var lastRow = tbl.rows.length;
						
						//alert(lastRow)
						
						var newRow = tbl.insertRow(lastRow);
						var content="</td>"		
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"grLevelRateId"+Grcount+"\" name=\"grLevelRateId"+Grcount+"\"  value=\""+grRateApplied.grRateId+"\"  ><select class=\"form-control\" name=\"ratesName"+Grcount+"\""
							+" 	id=\"ratesName"+Grcount+"\" >"
							   
									+ " </select></td>"
									+ " 	<td><input type=\"text\" name=\"orderLevelRate"+Grcount+"\""
									+" 	id=\"orderLevelRate"+Grcount+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"grRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
									+ "</td>"
							
						
						content += "<td>";
						if(lastRow >1){
							content+="<a href='#' onclick='deleteRow("+Grcount+"),grRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
						}	
						$("#grLevelRateId").val(++Grcount);
							}			
						newRow.innerHTML = content;
						
						$(newRow).attr("id", "addMultipleTableRow" + Grcount);
						
						}
						
						for(var n=0;n<data.grLevelRates.length;n++){
							var grRateApplied =data.grLevelRates[n];
							
							
							if(grRateApplied.rate.rateId==23){
								$("#grLevelGrandTotal").val(grRateApplied.appliedAmount);
								
							}
							
							if(grRateApplied.rate.rateId==21 ||grRateApplied.rate.rateId==22 ||grRateApplied.rate.rateId==23 ||grRateApplied.rate.rateId==1){
								continue;
							}
							if(grRateApplied.levelStatus == "O")
							{
							 $("#ratesName"+GrExist).val(grRateApplied.rate.rateId);
							 $("#orderLevelRate"+GrExist).val(grRateApplied.appliedAmount);
							 getRates('ratesName'+GrExist,grRateApplied.rate.rateId);
							 ++GrExist;
							}
							
							 
						}
					
					$("#reqItemTable th:first-child").remove();
						
					$('#modal-add-req').modal({
						keyboard : true
					});
					$('#modal-add-req').modal("show");
				}
					else{
						BootstrapDialog.alert('Only GR Approval Authority Can Edit GR');
						return;
					}
				}
				
				
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling GRPO Details' + data);
				return;
			}

		});
	}
	
	
	
	function remove() {
		
		var role = "";
		var userAccessCheck = null;
		if(userRoleData != null){
			role = userRoleData;
		}
		for(var u=0;u<role.access.length;u++){
			var userAccessLevel = role.access[u].accessLevel;
			if(parseInt(role.access[u].menu.menuId) == 508 || (parseInt(role.access[u].menu.menuId) == 507 && (userAccessLevel == 'E'))){
				userAccessCheck++;
			}
		}
		
		if(userAccessCheck != null){
		var grpoId = $("input[name='grpo_id']:checked").val();
		
            	var modelRequest = {};
        		modelRequest.id = grpoId
        		
        		$.ajax({
        			url : 'getGRPOById',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				if(data.approvalStatus == null){
        					deletegrpo();
        				} 
        				else{
        					BootstrapDialog
    						.alert('GRPO can not be delete');
        				}
        				
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
        				$('#flex1').flexOptions({
        					url : "getPendingGRPOList",
        					newp : 1
        				}).flexReload();
        				$('#flex2').flexOptions({
        					url : "getLocalPurchaseOrder",
        					newp : 1
        				}).flexReload();
        				$('#flex3').flexOptions({
        					url : "getGRPOList",
        					newp : 1
        				}).flexReload();
        			}
        		});
           
		}
		else{
			BootstrapDialog.alert('Only GR Approval Authority Can Delete GR');
			return;
		}
	}
	
	function deletegrpo() {
		BootstrapDialog.confirm('Are you sure you want to delete?', function(result){
			var grpoId = $("input[name='grpo_id']:checked").val();
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
        				$('#flex1').flexOptions({
        					url : "getPendingGRPOList",
        					newp : 1
        				}).flexReload();
        				$('#flex2').flexOptions({
        					url : "getLocalPurchaseOrder",
        					newp : 1
        				}).flexReload();
        				$('#flex3').flexOptions({
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
					url : "getPendingGRPOList",
					newp : 1
				}).flexReload();
				$('#flex3').flexOptions({
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
        <div class="panel panel-default" id="pendingPanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                   <small>Goods Receipt</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        
         <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>Local Purchase Goods Receipt</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
        
        <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>View Goods Receipt</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex3"></table>
                </div>

        </div>
    </div>
</div>
















<%@ include file="include/grpo_form.jsp" %>
<%@ include file="include/grPdf.jsp" %>
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