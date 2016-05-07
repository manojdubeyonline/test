<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	//var w=screen.width;
	var w=1000;
	$("#grpoApproval").attr("class","active");
		
		
		
			
		$('#flex1').flexigrid({
			url:'getGRPOListForApproval',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Goods Reciept No', name : '', width:150, sortable : false, align: 'center'},
				
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
			//width: w*.80,
			singleSelect: true

		});
		
		$('#flex2').flexigrid({
			url:'getGRPOListRejectionCompleted',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Goods Reciept No', name : '', width:150, sortable : false, align: 'center'},
				
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'GR Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Status', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Rejected By', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Reason', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Rejected Date', name : '', width:70, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Approval', bclass: 'glyphicon glyphicon-pencil', onpress : openRejection},
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

		$('#flex3').flexigrid({
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
			//width: w*.80,
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
		var grpoId ="";
		var row = $('#flex1 tbody tr').has("input[name='grpo_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateGRPOApprovalPopup(grpoId);
		}
		

	}
	
	

function populateGRPOApprovalPopup(grpoId) {

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
				$("#firm1").val(data.firm.firmName);
				$("#firm").val(data.firm.firmId);
				$("#vendor").val(data.vendor.vendorId); 
				$("#grRecieptNo").val(data.goodsRecieptNo); 
				$//("#orderId").val(data.orderId.orderId); 
				$//("#rate").val(data.billAmount);
				$//("#dueDate").val(myDateFormatter(data.orderId.dueDate));
				$("#invoiceDate").val(myDateFormatter(data.vendorInvoiceDate));
				$("#invoiceNo").val(data.vendorInvoiceNo);
				$("#grpoId").val(data.grpoId);
				$("#inwardRemarks").val(data.inwardComments);
				$//("#marking_id").val(data.orderId.markingId);
				$("#grDate").val(myDateFormatter(data.grDate));
				
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
				//var orderId = data.orderId.orderId;
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					var grItem = data.grpoReceiptItems[r];
					var itemCode = data.grpoReceiptItems[r].itemCode;

					for(var x=0;x<grItem.itemLevelGRRates.length;x++){
						if(grItem.itemLevelGRRates[x].rate.rateId==21){
							itemLevelTotalId = grItem.itemLevelGRRates[x].grRateId;
						}
					}
					
					var content = "<td>";
					
					content+="<input type=\"hidden\" name=\"itemLevelTotalRAId"
						+ count+ "\" id=\"itemLevelTotalRAId"+count+"\" value=\""+itemLevelTotalId+"\"><input type=\"text\" name=\"item1"+count+"\""
						+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" / "+itemCode.codeDesc+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"  style =\"width:320px;\" readonly=\"readonly\" />"
						+ "<input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" > <input type=\"hidden\" name=\"orderItemId"
						+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><input type=\"hidden\" name=\"grpoItemId"
						+ count+ "\" id=\"grpoItemId"+count+"\" value=\""+data.grpoReceiptItems[r].grpoEntryId+"\" ></td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"gr_Qty"+count+"\" id=\"gr_Qty"+count+"\""
						+" 	class=\"form-control\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"gr_Approve_Qty"+count+"\" name=\"gr_Approve_Qty"+count+"\" placeholder=\"Approval Qty\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();qtyCheck();\"  ></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitId+"\" ><input type=\"text\" class=\"form-control\""
								+" 	id=\"unit1"+count+"\" name=\"unit1"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitName+"\" readonly=\"readonly\" >"
									

								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count);
					  // $("#unit1"+count).html(data.grpoReceiptItems[r].unit.unitName);
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
							+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"grRateCalc();rateCheck();\"><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"hiddenRateValue"+count+counter+"\" name=\"hiddenRateValue"+count+counter+"\"  value=\"\"  ></td>"
							+"<td><input type=\"hidden\" class=\"form-control\""+
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
								$("#totalBillAmount").val(currentRateApplied.appliedAmount);
							}
							if(currentRateApplied.rate.rateId==21){
								$("#itemLevelTotal"+count).val(currentRateApplied.appliedAmount);
							}
							if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
								continue;
							}	
							
							 $("#rateName"+count+rateCounter).val(currentRateApplied.rate.rateId);
							 $("#rateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
							 $("#hiddenRateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
							
							getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
							 ++rateCounter;
							 
						}
						
					
					   
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
							$("#totalBillAmount").val(grRateApplied.appliedAmount);
							
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
		var grpoId ="";
		var row = $('#flex3 tbody tr').has("input[name='grpo_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateGRPOApprovalViewPopup(grpoId);
		}
	}

	function openRejection() {
		//var requisitionId =  "";
		var grpoId ="";
		var row = $('#flex2 tbody tr').has("input[name='grpo_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		grpoId = $(row).find("input[name='grpo_id']:checked").val();
		if(grpoId !=undefined && grpoId !=null && grpoId !=''){
			populateGRPOApprovalViewPopup(grpoId);
		}
	}

	
	
	function saveGRPOApproval() {
		$('.close').click();
		$.ajax({
			url : 'saveGRPOApproval',
			type : "POST",
			data : $("#GrpoApprovalForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('GRPO approval saved successfully.');
				$('#flex1').flexOptions({
					url : "getGRPOList",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getGRPOListApprovalCompleted",
					newp : 1
				}).flexReload();
				$('#flex3').flexOptions({
					url : "getGRPOListApprovalCompleted",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving GRPO approval.');
				return;
			}
		});

	}
/*
	function populateGRPOApprovalViewPopup(grpoId) {

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
					for(var r=0;r<data.orderId.orderItems.length;r++){
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
					$("#item").val(itemCode.codeId);
					$("#item1").val(itemCode.codeDesc);
					$("#qty").val(data.orderId.orderItems[r].qty);
					$("#inward_qty").val(data.inwardQty);
					$("#billAmount").val(data.billAmount);
					$("#dueDate").val(myDateFormatter(data.orderId.dueDate));
					$("#inward_date").val(myDateFormatter(data.inwardDate));
					$("#firm1").val(data.orderId.firm.firmName);
					$("#firm").val(data.orderId.firm.firmId);
					$("#unit").val(data.unit.unitId)
					$("#unit1").val(data.unit.unitName)
					$("#unitx").val(data.unit.unitName)
					$("#marking_id").val(data.markingId)
					$("#orderNo").val(data.orderId.purchaseOrderNo); 
					$("#orderId").val(data.orderId);
					$("#grpoId").val(data.grpoId);
					$("#vendor").val(data.orderId.vendor.vendorId); 
					$("#rate").val(data.orderId.orderItems[r].basicRate); 
					$("#orderRemarks").val(data.orderId.remarks); 
					$("#inwardRemarks").val(data.inwardComments);
					$("#approvalStatus").val(data.approvalStatus);
					$("#approval_comments").val(data.approvalComments);
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			  }
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling GRPO Approval Details' + data);
				return;
			}

		});
	}
*/


function populateGRPOApprovalViewPopup(grpoId) {

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
				$("#firm1").val(data.firm.firmName);
				$("#firm").val(data.firm.firmId);
				$("#vendor").val(data.vendor.vendorId);
				$("#grRecieptNo").val(data.goodsRecieptNo); 
				//$("#orderNo").val(data.orderId.purchaseOrderNo); 
				//$("#orderId").val(data.orderId.orderId); 
				$("#rate").val(data.billAmount);
				$("#grDate").val(myDateFormatter(data.grDate));
				$("#invoiceDate").val(myDateFormatter(data.vendorInvoiceDate));
				$("#grpoId").val(data.grpoId);
				$("#invoiceNo").val(data.vendorInvoiceNo);
				$("#inwardRemarks").val(data.inwardComments);
				//$("#marking_id").val(data.orderId.markingId);
				$("#approvalStatus").val(data.approvalStatus);
				$("#approval_comments").val(data.approvalComments);
				
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
				//var orderId = data.orderId.orderId;
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					var grItem = data.grpoReceiptItems[r];
					var itemCode = data.grpoReceiptItems[r].itemCode;

					for(var x=0;x<grItem.itemLevelGRRates.length;x++){
						if(grItem.itemLevelGRRates[x].rate.rateId==21){
							itemLevelTotalId = grItem.itemLevelGRRates[x].grRateId;
						}
					}
					
					var content = "<td>";
					
					content+="<input type=\"hidden\" name=\"itemLevelTotalRAId"
						+ count+ "\" id=\"itemLevelTotalRAId"+count+"\" value=\""+itemLevelTotalId+"\"><input type=\"text\" name=\"item1"+count+"\""
						+" 	id=\"item1"+count+"\"  value=\""+itemCode.code+" / "+itemCode.codeDesc+"\" class=\"form-control\" placeholder=\"Item Code / Item Description\"  style =\"width:320px;\" readonly=\"readonly\" />"
						+ "<input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+"\" > <input type=\"hidden\" name=\"orderItemId"
						+ count+ "\" id=\"orderItemId"+count+"\" value=\"\" ><input type=\"hidden\" name=\"grpoItemId"
						+ count+ "\" id=\"grpoItemId"+count+"\" value=\""+data.grpoReceiptItems[r].grpoEntryId+"\" ></td>"
						
								+ " <td><input type=\"text\" "
						+" 	name=\"gr_Qty"+count+"\" id=\"gr_Qty"+count+"\""
						+" 	class=\"form-control\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  readonly=\"readonly\" /></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"gr_Approve_Qty"+count+"\" name=\"gr_Approve_Qty"+count+"\" placeholder=\"Approval Qty\" value=\""+data.grpoReceiptItems[r].inwardQty+"\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"grRateCalc();qtyCheck();\"  ></td>"
								
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitId+"\" ><input type=\"text\" class=\"form-control\""
								+" 	id=\"unit1"+count+"\" name=\"unit1"+count+"\"  value=\""+data.grpoReceiptItems[r].unit.unitName+"\" readonly=\"readonly\" >"
									

								+ " </td>"
								

					$(newRow).html(content);				
					   $(newRow).attr("id", "reqItemTableRow" + count);
					  // $("#unit1"+count).html(data.grpoReceiptItems[r].unit.unitName);
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
							+" 	id=\"rateName"+count+counter+"\" readonly=\"readonly\">"
						
							+ " </select></td><td><input type=\"text\" class=\"form-control\""
							+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"grRateCalc();rateCheck();\" readonly=\"readonly\"><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"hiddenRateValue"+count+counter+"\" name=\"hiddenRateValue"+count+counter+"\"  value=\"\"  ></td>"
							+"<td><input type=\"hidden\" class=\"form-control\""+
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
								$("#totalBillAmount").val(currentRateApplied.appliedAmount);
							}
							if(currentRateApplied.rate.rateId==21){
								$("#itemLevelTotal"+count).val(currentRateApplied.appliedAmount);
							}
							if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
								continue;
							}	
							
							 $("#rateName"+count+rateCounter).val(currentRateApplied.rate.rateId);
							 $("#rateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
							 $("#hiddenRateValue"+count+rateCounter).val(currentRateApplied.appliedAmount);
							
							getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
							 ++rateCounter;
							 
						}
						
					
					   
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
						+" 	id=\"ratesName"+Grcount+"\" readonly=\"readonly\">"
						   
								+ " </select></td>"
								+ " 	<td><input type=\"text\" name=\"orderLevelRate"+Grcount+"\""
								+" 	id=\"orderLevelRate"+Grcount+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"grRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" readonly=\"readonly\" />"
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
							$("#totalBillAmount").val(grRateApplied.appliedAmount);
							
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
			orderQty =	document.getElementById("gr_Approve_Qty"+i).value;
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
		
		
		
		 document.getElementById("totalBillAmount").value=Math.round(total,2);
		 
		
	}
	
	function qtyCheck(){
		var count = $("#rowhid").val();
		for(var r=0;r<count;r++){
			var grQty =parseFloat($("#gr_Qty"+r).val()) ;
			var grApprovedQty = parseFloat($("#gr_Approve_Qty"+r).val());
			if(grApprovedQty>grQty){
				BootstrapDialog.alert('GR Approval Qty can not be greater then GR Qty');
				return;
			}
				
		}
		
		
	}
	
	function rateCheck(){
		var count = $("#rowhid").val();
		var rowCount = $("#rowId").val();
		for(var m=0;m<count;m++){
			for(var n=0;n<rowCount;n++){
			var hiddenBasicRate =parseFloat($("#hiddenRateValue"+m+n).val()) ;
			var basicRate = parseFloat($("#rateValue"+m+n).val());
			var rateName = parseFloat($("#rateName"+m+n).val());
			if(rateName == 1){
			if(basicRate>hiddenBasicRate){
				BootstrapDialog.alert('Basic Rate Should Be Less Then Privious Basic Rate(Rs.'+hiddenBasicRate+' ) ');
				return;
			 }
			}	
		}
	}
}
	

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                    <small>Goods Receipt Approval</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>View Goods Receipt Rejected</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
        
        <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>View Goods Receipt Approved</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex3"></table>
                </div>

        </div>
    </div>
</div>















<%@ include file="include/grpo_form_approval.jsp" %>
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