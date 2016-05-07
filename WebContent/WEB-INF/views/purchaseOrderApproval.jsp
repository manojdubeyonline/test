<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
var userRoleData = "";
$(document).ready(function(){
	//var w=screen.width;
	var w = 1000;
	$("#orderApproval").attr("class","active");
		
		
		
			
		$('#flex1').flexigrid({
			url:'getPurchaseOrderList',
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
				{display: 'PO Date', name : '', width:100, sortable : true, align: 'left'},
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
			url:'getPurchaseOrderListApprovalCompleted',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Vendor', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Firm', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:350, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:70, sortable : true, align: 'left'},
				{display: 'PO Date', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Order Type', name : '', width:70, sortable : true, align: 'left'},
			    {display: 'Approval Date', name : '', width:70, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit', bclass: 'glyphicon glyphicon-pencil', onpress : open},
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
var userRoleId = ${_SessionUser.userRole.roleId};
getUserByRoleId(userRoleId);

});


	function add() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex1 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderApprovalPopup(orderId);
		}
		

	}
	
	
function pdf() {
		
		var orderId ="";
		var row = $('#flex2 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePdfPopup(orderId);
		}
	}
	
	function populatePdfPopup(orderId) {

		var jsonRecord = {};
				
				url = 'getPurchaseOrderById';
				
				jsonRecord.id = orderId;
				$.ajax({
					url : url,
					type : 'POST',
					data : JSON.stringify(jsonRecord),
					contentType : 'application/json',
					
					success : function(data) {
						
						
						var firmInfor = data.firm;
						$("#firmLocation").html(firmInfor.firmLocation);
						$("#firmLocation1").html(firmInfor.firmLocation1);
						$("#firmName").html(firmInfor.firmName);
						$("#firmName1").html(firmInfor.firmName);
						$("#firmPhone").html(firmInfor.firmPhone);
						$("#firmEmail").html(firmInfor.firmEmail);
						$("#firmFax").html(firmInfor.firmFax);
						$("#tinNo").html(firmInfor.tinNo);
						$("#panNo").html(firmInfor.panNo);
						$("#exciseCodeNo").html(firmInfor.centralNo);
			
						//var img = firmInfor.firmLogo;
						//document.getElementById("imageId").src="resources/images/"+img+"";
						var img = firmInfor.firmLogo;
						document.getElementById("imageId").src="http://tender.railtechindia.in/images/"+img;
						
							 // $("#store").html(data.requestedAtWareHouse.warehouseName);
							 $("#vendorCode").html(data.vendor.vendorId);
							 $("#vendorName").html(data.vendor.vendorName);
							 $("#address").html(data.vendorDetail.clientAddress);
							 $("#qautationDetails").html(data.quotationDetail+" ("+dateConversion(myDateFormatter(data.quotationDate))+")");
							 $("#contactDetails").html("("+data.vendorDetail.clientTel+")");
							 $("#contactPerson").html(data.contactPerson);
							 $("#email").html(data.vendorDetail.clientEmail);
							$("#usName").html(data.instructorName);
							 $("#userContact").html(data.instructorContact);
							$("#userEmail").html(data.instructorEmail);
							 
							 $("#city").html(data.vendorDetail.clientCity);
							 $("#state").html(data.vendorDetail.vendorState);
							 $("#pin").html(data.vendorDetail.vendorPin);
							 
							 $("#impDetails").html(data.importantDetails);
							 $("#discount").html(data.discount);
							 $("#deliveryTerms").html(data.deliveryTerm);
							 $("#deliveryPeriod").html(data.deliveryPeriod);
							 $("#paymentTerms").html(data.paymentTerm);
							 $("#freight").html(data.freight);
							 $("#packing").html(data.packing);
							 $("#insurance").html(data.insurance);
							 $("#sales").html(data.saleTax);
							 $("#qtyTolerance").html(data.qtyTolerance);
							 $("#quality").html(data.qualityAssurance);
							 $("#otherIns").html(data.otherInstruction);
							 
							 $("#poNo").html(data.purchaseOrderNo);
							//  $("#requestedBy").html(data.requestedByUser.userName);
							 $("#poDate").html(dateConversion(myDateFormatter(data.dueDate)));
							 // $("#reqDate").html(dateConversion(myDateFormatter(data.requestedDate)));
							 // $("#rowhid").val(0);
							  var count = $("#rowhid").val();
							  var tbl = document.getElementById("itemTable");
								//$("#itemTable").find("tr:gt(0)").remove();
								// $('#reqItemTable tr:last-child').remove();
								var subt = 0;
								 var excise = 0;
								 var sale = 0;
								for(var r=0;r<data.orderItems.length;r++){
									var lastRow = tbl.rows.length;
									var newRow = tbl.insertRow(lastRow);
									
									var content = "<td>";
									
									content+="<div id=\"sr"+count+"\" align=\"center\"></div></td>"
											+ " <td ><div id=\"code"+count+"\" style=\"float:left;font-weight:bold;\"></div><div style=\"float:left;\">&nbsp;-&nbsp;</div><div id=\"codedesc"+count+"\" style=\"float:left;\"></div></td>"
											+ " <td align=\"right\"><div id=\"qty"+count+"\" ></div></td>"
											+ " <td align=\"right\"><div id=\"basicRate"+count+"\" style=\"float:right;\"></div></td>"
											+ " <td align=\"right\"><div id=\"total"+count+"\" style=\"float:right;\"></div></td>"
											

									$(newRow).html(content);
									$(newRow).attr("id", "itemTableRow" + count);
									//getUnits('unit' + count);
									//$("#unit"+ count).val(data.orderItems[r].unit.unitName);
									$("#codedesc"+count).html(data.orderItems[r].itemCode.codeDesc);
									$("#sr"+count).html(r+1);
									$("#code"+count).html(data.orderItems[r].itemCode.code);
									//$("#unit"+count).html(data.orderItems[r].unit.unitName);
									var qt = data.orderItems[r].qty;
									$("#qty"+count).html(qt+" "+data.orderItems[r].unit.unitName);
									
									var orderItem = data.orderItems[r];
									
									
									for(var k=0;k<orderItem.itemLevelRates.length;k++){
										var rateApplied = orderItem.itemLevelRates[k];
										if(rateApplied.rate.rateId==1){
											basic = rateApplied.appliedAmount;
										}
										if(rateApplied.rate.rateId==2){
											excise = parseFloat(rateApplied.appliedAmount);
										}
										if(rateApplied.rate.rateId==3){
											sale = parseFloat(rateApplied.appliedAmount);
										}
										
										
										
									}
										
									
										$("#basicRate"+count).html(basic.toFixed( 2 ));
										var total = parseFloat(qt*basic);
										subt = subt+total;
										
										
										$("#total"+count).html(parseFloat(qt*basic).toFixed( 2 ));
										
										
											
									
									
									
									$("#rowhid").val(++count);
						
								}
								
								for(var n=0;n<data.orderLevelRates.length;n++){
									var rateApplied = data.orderLevelRates[n];
									
									if(rateApplied.rate.rateId==2){
										excise = parseFloat(rateApplied.appliedAmount);
									}
									if(rateApplied.rate.rateId==3){
										sale = parseFloat(rateApplied.appliedAmount);
									}
									
									
									
								}
								
								var exciseValue = parseFloat(subt*(excise/100));
								
								var salesValue = parseFloat(((exciseValue+subt)*(sale/100)));
								
								$("#subTotal").html(subt.toFixed( 2 ));
								$("#exDuty").html(exciseValue.toFixed( 2 ));
								$("#cess").html("0");
								$("#saletax").html(salesValue.toFixed( 2 ));
								$("#excise").html(excise+"%");
								//$("#cesson").html(cst+"%");
								$("#sale").html(sale+"%");
								
								amount = subt+exciseValue+salesValue;
								$("#totalInWord").html(inWords(Math.round(amount,2)));
								$("#totalInFigure").html(Math.round(amount,2).toFixed( 2 ));
								$("#totalRound").html(Math.round(amount,2).toFixed( 2 ));
						$('#firmDetail').modal({
							keyboard : true
						});
						$('#firmDetail').modal("show");
					},
					error : function(data) {
						BootstrapDialog.alert('Error Pulling Purchase Order Pdf' + data);
					
					}

				});
			}
	
	
	function inWords (num) {
		var a = ['','One ','Two ','Three ','Four ', 'Five ','Six ','Seven ','Eight ','Nine ','Ten ','Eleven ','Twelve ','Thirteen ','Fourteen ','Fifteen ','Sixteen ','Seventeen ','Eighteen ','Nineteen '];
		var b = ['', '', 'Twenty','Thirty','Forty','Fifty', 'Sixty','Seventy','Eighty','Ninety'];
	    if ((num = num.toString()).length > 9) return 'overflow';
	    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
	    if (!n) return; var str = '';
	    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'Crore ' : '';
	    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'Lakh ' : '';
	    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'Thousand ' : '';
	    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'Hundred ' : '';
	    str += (n[5] != 0) ? ((str != '') ? ' ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'Only ' : '';
	    return str;
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
	

	function populatePurchaseOrderApprovalPopup(orderId) {

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
					
					var role = "";
					var userAccessCheck = null;
					if(userRoleData != null){
						role = userRoleData;
					}
					for(var u=0;u<role.access.length;u++){
						var userAccessLevel = role.access[u].accessLevel;
						if(parseInt(role.access[u].menu.menuId) == 505 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
							userAccessCheck++;
						}
					}
					if(userAccessCheck != null){
					
					
					$("#firm").val(data.firm.firmId);
					$("#firm1").val(data.firm.firmName);
					$("#vendor").val(data.vendor.vendorId);
					$("#orderNo").val(data.purchaseOrderNo);
					$("#orderId").val(data.orderId);
					$("#dueDate").val(myDateFormatter(data.dueDate));
					
					//generateOrderNo("orderNo",$("#firm").val());
					var count = $("#rowhid").val();
					var counter = $("#rowId").val();
					var rateCounter = counter;
					//var counter=0;
					var tbl = document.getElementById("reqItemTable");
					$("#reqItemTable").find("tr:gt(0)").remove();
					
					
					for(var r=0;r<data.orderItems.length;r++){
						var lastRow = tbl.rows.length;
						var newRow = tbl.insertRow(lastRow);
						
						var orderItem = data.orderItems[r];
						var rateAppliedId = null;
						var rateId = null;
						
						var itemCode = data.orderItems[r].itemCode;
						
						var content = "<td>";
						
						content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
						+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
						+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"itemKey"
						+ count+ "\" value=\""+data.orderItems[r].itemKey+" \" ><input type=\"hidden\" name=\"rateAppliedId"
						+ count+ "\" value=\""+rateAppliedId+" \" >"
								
								+ " </td>"
								+ "<td><input type=\"text\" required readonly name=\"itemName"
								+ count
								+ "\""
								+ " 	class=\"form-control\" id=\"itemName"
								+ count
								+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
								
								+ " <td><input type=\"text\" class=\"form-control\""
								+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data.orderItems[r].histQty+"\" readonly=\"readonly\"></td>"
						+ " <td><input type=\"text\" class=\"form-control\""
						+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\""+data.orderItems[r].qty+"\" style =\"width:70px;\" readonly=\"readonly\"></td>"
								+ " <td><input type=\"hidden\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitId+"\" ><input type=\"text\" class=\"form-control\""
								+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitName+"\" readonly=\"readonly\">  "

						+ " </td></td>"
						$(newRow).html(content);
						$(newRow).attr("id", "reqItemTableRow" + count);
						
						var nextRowHeader = tbl.rows.length;
						var nextHeader =tbl.insertRow(nextRowHeader);
						var headerContent="<td colspan=\"5\" class=\"active\">"
							headerContent+="Rate Per Unit</td>"
						$(nextHeader).html(headerContent);
							
							
						var nextlastRow = tbl.rows.length;
						var nextRow =tbl.insertRow(nextlastRow);
						var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+r+"\" width=\"100%\">";
						
					for(var k=0;k<orderItem.itemLevelRates.length;k++){
						
						var currentRateApplied = orderItem.itemLevelRates[k];
						if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
							continue;
						}
						//if(currentRateApplied.levelStatus == "I")
						//{
						nextContent+="<tr><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
						+" 	id=\"rateName"+count+counter+"\" readonly=\"readonly\">"
					
						+ " </select></td><td><input type=\"text\" class=\"form-control\""
						+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"purchaseRateCalc();\" readonly=\"readonly\"></td>"
						+"<td><input type=\"hidden\" class=\"form-control\""+
						" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></tr>"

						//getRatesView(count+""+counter,itemRateApplied.itemLevelRates);
						//}
						 $("#rowId").val(++counter);
						
				 }
					nextContent+="</table></td>";
					$(nextRow).html(nextContent);	
					  $(nextRow).attr("id", "innerItemTableRow" + r);
					   
					for(var z=0;z<orderItem.itemLevelRates.length;z++){
						var currentRateApplied = orderItem.itemLevelRates[z];
						getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
						// $("#rateName"+r+z).val(currentRateApplied.rate.rateId);
						// $("#rateName"+r+z+" option").eq(currentRateApplied.rate.rateId).prop('selected', true);
						//alert(currentRateApplied.rate.rateId)
						if(currentRateApplied.rate.rateId==23){
							$("#orderLevelGrandTotal").val(currentRateApplied.appliedAmount);
						}
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
					
					 
					   
					   $("#rowhid").val(++count);
					  
				  
					
					
					$("#qty1"+count).html(data.orderItems[r].histQty);
					$("#unit1"+count).html(data.orderItems[r].unit.unitName);
					
					document.getElementById("orderLevelButton").style.display = "none";
					
					
			}


				///order level
				
				var Ordercount = $("#orderLevelRowId").val();
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
						+" 	id=\"ratesName"+Ordercount+"\" readonly=\"readonly\">"
						   
								+ " </select></td>"
								+ " 	<td><input type=\"text\" name=\"orderLevelRate"+Ordercount+"\""
								+" 	id=\"orderLevelRate"+Ordercount+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"purchaseRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" readonly=\"readonly\"/>"
								+ "</td>"
						
					
					content += "<td>";
					if(lastRow >1){
						content+="<a href='#' onclick='deleteRow("+Ordercount+"),purchaseRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
					}	
						}			
					newRow.innerHTML = content;
					//getRates('ratesName'+Ordercount);
					$(newRow).attr("id", "addMultipleTableRow" + Ordercount);
					$("#orderLevelRowId").val(++Ordercount);
					}
					
					for(var n=0;n<data.orderLevelRates.length;n++){
						var orderRateApplied =data.orderLevelRates[n];
						
						
						if(orderRateApplied.rate.rateId==23){
							$("#orderLevelGrandTotal").val(orderRateApplied.appliedAmount);
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
			BootstrapDialog.alert('Error Pulling Purchase Order Approval Details' + data);
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
		var orderId ="";
		var row = $('#flex2 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderApprovalViewPopup(orderId);
		}
	}
	/*
	function populatePurchaseOrderApprovalViewPopup(orderId) {

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
					for(var r=0;r<data.orderItems.length;r++){
						var itemCode = data.orderItems[r].itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.orderItems[r].qty);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#firm1").val(data.firm.firmName);
						$("#firm").val(data.firm.firmId);
						$("#unit").val(data.orderItems[r].unit.unitId)
						$("#marking_id").val(data.markingId)
						$("#orderNo").val(data.purchaseOrderNo); 
						$("#orderId").val(data.orderId); 
						$("#vendor").val(data.vendor.vendorId); 
						$("#rate").val(data.orderItems[r].basicRate); 
						$("#orderRemarks").val(data.remarks); 
						$("#approval_comments").val(data.approvalComments); 
						$("#approvalStatus").val(data.approvalStatus); 
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			 }
			},
			error : function(data) {
				BootstrapDialog.alert('Error Purchase Order Approval Details' + data);
				return;
			}

		});
	}
*/


function populatePurchaseOrderApprovalViewPopup(orderId) {

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
				
				var role = "";
				var userAccessCheck = null;
				if(userRoleData != null){
					role = userRoleData;
				}
				for(var u=0;u<role.access.length;u++){
					var userAccessLevel = role.access[u].accessLevel;
					if(parseInt(role.access[u].menu.menuId) == 505 && (userAccessLevel == 'E')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				$("#firm").val(data.firm.firmId);
				$("#firm1").val(data.firm.firmName);
				$("#vendor").val(data.vendor.vendorId);
				$("#orderNo").val(data.purchaseOrderNo);
				$("#orderId").val(data.orderId);
				$("#dueDate").val(myDateFormatter(data.dueDate));
				$("#approvalStatus").val(data.approvalStatus);
				
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				var rateCounter = counter;
				//var counter=0;
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				for(var r=0;r<data.orderItems.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					var orderItem = data.orderItems[r];
					var rateAppliedId = null;
					var rateId = null;
					
					var itemCode = data.orderItems[r].itemCode;
					
					var content = "<td>";
					
					content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
					+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
					+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"itemKey"
					+ count+ "\" value=\""+data.orderItems[r].itemKey+" \" ><input type=\"hidden\" name=\"rateAppliedId"
					+ count+ "\" value=\""+rateAppliedId+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
							
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data.orderItems[r].histQty+"\" readonly=\"readonly\"></td>"
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\""+data.orderItems[r].qty+"\" style =\"width:70px;\" readonly=\"readonly\"></td>"
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitId+"\" ><input type=\"text\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitName+"\" readonly=\"readonly\">  "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"5\" class=\"active\">"
						headerContent+="Rate Per Unit</td>"
					$(nextHeader).html(headerContent);
						
						
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+r+"\" width=\"100%\">";
					
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
					+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\">"
					+"<span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""+
					" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></tr>"

					//getRatesView(count+""+counter,itemRateApplied.itemLevelRates);
					//}
					 $("#rowId").val(++counter);
					
			 }
				nextContent+="</table></td>";
				$(nextRow).html(nextContent);	
				  $(nextRow).attr("id", "innerItemTableRow" + r);
				   
				for(var z=0;z<orderItem.itemLevelRates.length;z++){
					var currentRateApplied = orderItem.itemLevelRates[z];
					getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
					// $("#rateName"+r+z).val(currentRateApplied.rate.rateId);
					// $("#rateName"+r+z+" option").eq(currentRateApplied.rate.rateId).prop('selected', true);
					//alert(currentRateApplied.rate.rateId)
					if(currentRateApplied.rate.rateId==23){
						$("#orderLevelGrandTotal").val(currentRateApplied.appliedAmount);
					}
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
				
				 
				   
				   $("#rowhid").val(++count);
				  
			  
				
				
				$("#qty1"+count).html(data.orderItems[r].histQty);
				$("#unit1"+count).html(data.orderItems[r].unit.unitName);
				
				//document.getElementById("addButton").style.display = "none";
				
				
		}


			///order level
			
			var Ordercount = $("#orderLevelRowId").val();
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
					}			
				newRow.innerHTML = content;
				//getRates('ratesName'+Ordercount);
				$(newRow).attr("id", "addMultipleTableRow" + Ordercount);
				$("#orderLevelRowId").val(++Ordercount);
				}
				
				for(var n=0;n<data.orderLevelRates.length;n++){
					var orderRateApplied =data.orderLevelRates[n];
					
					
					if(orderRateApplied.rate.rateId==23){
						$("#orderLevelGrandTotal").val(orderRateApplied.appliedAmount);
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
		BootstrapDialog.alert('Error Pulling Purchase Order Approval Details' + data);
		return;
	}

});
}

	function savePurchaseOrderApproval() {
		$('.close').click();
		$.ajax({
			url : 'savePurchaseOrderApproval',
			type : "POST",
			data : $("#orderForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Purchase order approval saved successfully.');
				$('#flex1').flexOptions({
					url : "getPurchaseOrderList",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getPurchaseOrderListApprovalCompleted",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving purchase order approval.');
				return;
			}
		});

	}

	function populatePurchaseOrderCreatePopup(procId) {

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
						$("#dueDate").val('');
						$("#firm").val(warehouse.firmId);
						getFirmById('firm1',warehouse.firmId);
						getFirmWarehouses('warehouse',warehouse.firmId,warehouse.wareId) 
						$("#warehouse").val(warehouse.wareId);
						//getUnits('unit');
						$("#unit").val(data.unit.unitId)
						$("#marking_id").val(data.markingId)
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
				BootstrapDialog.alert('Error Unable to pull the User Role Details');
			}
		});
	
	}
	
	
	function purchaseRateCalc(){
		var rowCount = $("#rowId").val();
		var count = $("#rowhid").val();
		var orderLevel = $("#orderLevelRowId").val();
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
			orderQty =	document.getElementById("Order_Qty"+i).value;
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
		
		
		
			
			if(rateName == 2){
				 excise = parseFloat(document.getElementById("rateValue"+i+j).value);
				
				exciseValue = (excise/100)*basicRate;
				total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total)) +  ((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
				
			}
			if(rateName == 4 ){
				
			 cess = parseFloat(document.getElementById("rateValue"+i+j).value);
			   cessValue += (cess/100)*((excise/100)*basicRate);
			 total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total)) + ((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
			}
			if(rateName == 3){
				
				 sales = parseFloat(document.getElementById("rateValue"+i+j).value);
				var salesValue = (sales/100)*total;
				total = (total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total))))))) + (freight) + (otherCharges);
			}
			if(rateName == 5){
				
				freight = parseFloat(document.getElementById("rateValue"+i+j).value);
				total = ((total+((excise/100)*(total)) + ((cess/100)*(excise/100)*total))+((sales/100)*((total)+((excise/100)*(total))+((cess/100)*((excise/100)*((total)+((excise/100)*(total)))))))) + (freight) + (otherCharges);
			}
			
			if(rateName == 6){
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
		
		var orderLevel = $("#orderLevelRowId").val();
		var rowCount = $("#rowId").val();
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
			if(rateName == 4 ){
				
			 cess = parseFloat(document.getElementById("orderLevelRate"+r).value);
			   cessValue += (cess/100)*((excise/100)*basicRate);
			 total = (basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate)) + ((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate))))))) + (freight) + (otherCharges);
			}
			if(rateName == 3){
				
				 sales = parseFloat(document.getElementById("orderLevelRate"+r).value);
				var salesValue = (sales/100)*total;
				total = (basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate))+((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate))))))) + (freight) + (otherCharges);
			}
			if(rateName == 5){
				
				freight = parseFloat(document.getElementById("orderLevelRate"+r).value);
				total = ((basicRate+((excise/100)*(basicRate)) + ((cess/100)*(excise/100)*basicRate))+((sales/100)*((basicRate)+((excise/100)*(basicRate))+((cess/100)*((excise/100)*((basicRate)+((excise/100)*(basicRate)))))))) + (freight) + (otherCharges);
			}
			
			if(rateName == 6){
				otherCharges = parseFloat(document.getElementById("orderLevelRate"+r).value);
				total = total + otherCharges;
			}
		}
		}
		
		}
		else{
			total = basicRate;
		}
		
		
		
		 document.getElementById("orderLevelGrandTotal").value=Math.round(total,2);
		 document.getElementById("orderLevelTotal").value=Math.round(total,2);
		
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

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                    <small>Purchase Order Pending Approval</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel" >
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>Purchase Orders Approval Completed</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
                </div>

        </div>
    </div>
</div>















<%@ include file="include/purchase_order_form_approval.jsp" %>
<%@ include file="include/purPdf.jsp"%>
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