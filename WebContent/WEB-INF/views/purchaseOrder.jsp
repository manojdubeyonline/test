<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
var sessionUserId = null;
var userRoleData = "";
$(document).ready(function(){ 
	$("#purchaseOrders").attr("class","active");
		var w=1000;
		
		$('#flex1').flexigrid({
			url:'getPurchaseOrder',
			method: 'POST', 
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Item', name : '', width:550, sortable : true, align: 'left'},
				{display: 'Ware house', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Marked Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Marking Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Procurement Method', name : '', width:100, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Create', bclass: 'glyphicon glyphicon-plus', onpress : add},
		            {separator: true},
				 	{name: ' Direct Order', bclass: 'glyphicon glyphicon-export', onpress : direct},
		            {separator: true},
				 	//{name: ' Job Work', bclass: 'glyphicon glyphicon-transfer', onpress : jobWork},
		           // {separator: true},
				 	
	      ],
	      searchitems : [
	                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
	             
					
	      ],
			sortname: "code",
			sortorder: "asc",
			usepager: true,
			//title: 'Pending Purchase Orders',
			useRp: true,
			rp: 10,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w,
			//singleSelect: false
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
				{display: 'Order Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Procurement Method', name : '', width:100, sortable : true, align: 'left'},
				
					],
		  buttons : [
					{separator: true},
				 	//{name: ' Create', bclass: 'glyphicon glyphicon-plus', onpress : addSecond},
		            //{separator: true}
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
			url:'getPurchaseOrderList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Vendor', name : '', width:200, sortable : true, align: 'left'},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Due Date', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Order Type', name : '', width:100, sortable : true, align: 'left'},
				
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit', bclass: 'glyphicon glyphicon-pencil', onpress : open},
		            {separator: true},
		           //{name: ' PDF', bclass: 'glyphicon glyphicon-file', onpress : pdf},
		           //{separator: true},
				 	{name: ' Delete', bclass: 'glyphicon glyphicon-remove', onpress : remove},
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
		
		
		/*
		$('#flex4').flexigrid({
			url:'getJobWorkOrderList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Job Work Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Qoutation No', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Job Work Date', name : '', width:100, sortable : true, align: 'left'},
				
				
				
					],
		  buttons : [
					{separator: true},
				 	{name: ' Edit', bclass: 'glyphicon glyphicon-pencil', onpress : jobEdit},
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
			//title: 'Purchase Orders',
			useRp: true,
			rp: 1000,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			//width: w,
			singleSelect: true

		});
*/

//getUsers('user');

//getFirms("firm1");
//getFirms("firm2");
//getFromFirm("firm1");
//getWarehouses("warehouse");
 sessionUserId =${_SessionUser.userId};

getUserFirms("firm1",sessionUserId);
getUserFirms("firm2",sessionUserId);

getVendors("vendor");
getVendors("vendor5");
var userRoleId = ${_SessionUser.userRole.roleId};
getUserByRoleId(userRoleId);
//getUnits("unit");

});


	function open() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex3 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderViewPopup(orderId);
		}
		

	}
	
	function jobEdit() {
		//var requisitionId =  "";
		var jobId ="";
		var row = $('#flex4 tbody tr').has("input[name='jobWork_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		jobId = $(row).find("input[name='jobWork_id']:checked").val();
		if(jobId !=undefined && jobId !=null && jobId !=''){
			populateJobWorkOrderViewPopup(jobId);
		}
		

	}
	
	function pdf() {
		
		var orderId ="";
		var row = $('#flex3 tbody tr').has("input[name='order_id']:checked")
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
			
						var img = firmInfor.firmLogo;
						document.getElementById("imageId").src="resources/images/"+img+"";
						
							 // $("#store").html(data.requestedAtWareHouse.warehouseName);
							 $("#vendorCode").html(data.vendor.vendorId);
							 $("#vendorName").html(data.vendor.vendorName);
							 $("#address").html(data.vendorDetail.clientAddress);
							 $("#contactDetails").html("("+data.vendorDetail.clientTel+")");
							 $("#contactPerson").html(data.ContactPerson);
							 $("#email").html(data.vendorDetail.clientEmail);
							// $("#usName").html(data.addedBy.userName);
							// $("#userEmail").html(data.addedBy.email);
							 
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
							  
							  var count = $("#rowhid").val();
							  var tbl = document.getElementById("itemTable");
								//$("#itemTable").find("tr:gt(0)").remove();
								// $('#reqItemTable tr:last-child').remove();
								
								for(var r=0;r<data.orderItems.length;r++){
									var lastRow = tbl.rows.length;
									var newRow = tbl.insertRow(lastRow);
									
									var content = "<td>";
									
									content+="<div id=\"sr"+count+"\" align=\"center\"></div></td>"
											+ " <td ><div id=\"code"+count+"\" style=\"float:left;font-weight:bold;\"></div><div style=\"float:left;\">&nbsp;-&nbsp;</div><div id=\"codedesc"+count+"\" style=\"float:left;\"></div></td>"
											+ " <td align=\"right\"><div id=\"qty"+count+"\" style=\"float:left;width:65%\"></div><div id=\"unit"+count+"\"></div></td>"
											+ " <td align=\"right\"><div id=\"basicRate"+count+"\" style=\"float:right;\"></div></td>"
											+ " <td align=\"right\"><div id=\"total"+count+"\" style=\"float:right;\"></div></td>"
											

									$(newRow).html(content);
									$(newRow).attr("id", "itemTableRow" + count);
									//getUnits('unit' + count);
									//$("#unit"+ count).val(data.orderItems[r].unit.unitName);
									$("#codedesc"+count).html(data.orderItems[r].itemCode.codeDesc);
									$("#sr"+count).html(r+1);
									$("#code"+count).html(data.orderItems[r].itemCode.code);
									$("#unit"+count).html(data.orderItems[r].unit.unitName);
									var qt = data.orderItems[r].qty;
									$("#qty"+count).html(qt);
									
									var orderItem = data.orderItems[r];
									
									var basic = null;
									var sale = null;
									var cst = null;
									var excise = null;
									var amount = null;
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
										if(rateApplied.rate.rateId==4){
											cst = parseFloat(rateApplied.appliedAmount);
										}
										
										
									}
										
										
										$("#basicRate"+count).html(basic);
										var total = parseFloat(qt*basic);
										
										var exciseValue = parseFloat(total*(excise/100));
										var cstValue = parseFloat(exciseValue*(cst/100));
										var salesValue = parseFloat(((exciseValue+cstValue+total)*(sale/100)));
										
										
										
										$("#total"+count).html(parseFloat(qt*basic).toFixed( 2 ));
										$("#subTotal").html(parseFloat(qt*basic).toFixed( 2 ));
										$("#exDuty").html(exciseValue.toFixed( 2 ));
										$("#cess").html(cstValue.toFixed( 2 ));
										$("#saletax").html(salesValue.toFixed( 2 ));
										$("#excise").html(excise+"%");
										$("#cesson").html(cst+"%");
										$("#sale").html(sale+"%");
										
										amount = total+exciseValue+cstValue+salesValue;
										$("#totalInWord").html(inWords(Math.round(amount,2)));
										$("#totalInFigure").html(Math.round(amount,2).toFixed( 2 ));
										$("#totalRound").html(Math.round(amount,2).toFixed( 2 ));
											
									
									
									
									$("#rowhid").val(++count);
						
								}
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
		var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
		var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];
	    if ((num = num.toString()).length > 9) return 'overflow';
	    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
	    if (!n) return; var str = '';
	    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
	    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
	    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
	    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
	    str += (n[5] != 0) ? ((str != '') ? ' ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
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
   
	function add() {
		//var requisitionId =  "";
		var procurementId ="";
		var procurementIds="";
		$('#flex1 tbody tr').has("input[name='marking_id']:checked").each(function(index,id){
		
			procurementId =$(id).find("input[name='marking_id']:checked").val();
			if(procurementId !=''){
			procurementIds += procurementId+",";
			
				
			}
		})
	

		procurementIds = procurementIds.substr(0, procurementIds.length-1);
		
		populatePurchaseOrderMultipleCreatePopup(procurementIds);
		
		////addOrderLevelRates();
		
	}

	function addSecond() {
		
		var procurementId ="";
		var procurementIds="";
		$('#flex2 tbody tr').has("input[name='marking_id']:checked").each(function(index,id){
		
			procurementId =$(id).find("input[name='marking_id']:checked").val();
			if(procurementId !=''){
			procurementIds += procurementId+",";
			
				
			}
		})
	
		
		procurementIds = procurementIds.substr(0, procurementIds.length-1);
		
		populatePurchaseOrderMultipleCreatePopup(procurementIds);
		
		//addOrderLevelRates();
	}
	
	function direct() {
		var role = "";
		var userAccessCheck = null;
		if(userRoleData != null){
			role = userRoleData;
		}
		for(var u=0;u<role.access.length;u++){
			var userAccessLevel = role.access[u].accessLevel;
			if(parseInt(role.access[u].menu.menuId) == 504 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
				userAccessCheck++;
			}
		}
		if(userAccessCheck != null){
		$('#modal-add-req').modal({
			keyboard : true
		});
		//$("#requisitionId").val('');
		//$("#requisitionRefNo").val('');
		//$("#purchaseOrderDate").val("");
		$("#firm").val("");
		$("#firm1").val("");
		$("#warehouse").val("");
		$("#orderType").val("Direct Purchase");
		$("#rowhid").val(0);
		$('#modal-add-req').modal("show");
		$("#reqItemTable").find("tr:gt(0)").remove();
		addDirectRow();
		 $('#reqItemTable th:nth-child(3)').remove();
		}
	}
	
	function jobWork() {
		$('#job-work-form').modal({
			keyboard : true
		});
		
		$("#firm").val("");
		$("#firm1").val("");
		$("#warehouse").val("");
		$("#jobWorkDate").val(myDateFormatter(new Date()));
		$("#quotationDate").val(myDateFormatter(new Date()));
		$('#job-work-form').modal("show");
		addJobWorkRow();
		jobWorkRates();
		
	}
	
	
function addJobWorkRow() {
		
		var count = $("#masterItemId").val();
		var counter = $("#itemRowId").val();
		var tbl = document.getElementById("jobWorkItemTable");
		var lastRow = tbl.rows.length;
		//alert(lastRow)
		var newRow = tbl.insertRow(lastRow);

		var content = "<td>";
					
					content+=" <input type=\"text\" required readonly name=\"itemCode"
						+ count
						+ "\""
						+ " 	class=\"form-control\" id=\"itemCode"
						+ count
						+ "\" onclick=\"popPicker('"
						+ count
						+ "')\" / placeHolder=\"Click to pick item\"><input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\"\" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\"\" ></td>"
							
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Quantity"+count+"\" name=\"Quantity"+count+"\" placeholder=\"Quantity\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
							+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
							+" 	name=\"unit"+count+"\"> "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "jobWorkItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"4\">"
						headerContent+="<table class=\"table table-bordered table-hover\" id=\"innerJobWorkItemTable"+count+"\" width=\"100%\"><th class=\"active\">Item Code</th>"
							+"<th class=\"active\">Item Name</th>"
							+"<th class=\"active\">Quantity</th>"
							
							+"<th class=\"active\">Rate<div class=\"btn-group\" style=\"float: right\">"
							+"	<button type=\"button\" class=\"btn btn-default\""
							+"	onclick=\"addJobItemRow("+count+")\" id=\"addRowButton\">"
							+"	<span class=\"glyphicon glyphicon-plus\"></span>"
							+"	</button>"
									
									
									
							+"	</div></th></table></td>"
					$(nextHeader).html(headerContent);
						
						/*
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td>"
						nextContent+="<input type=\"text\" required readonly name=\"itemCode"
						+ count+counter
						+ "\""
						+ " 	class=\"form-control\" id=\"itemCode"
						+ count+counter
						+ "\" onclick=\"popPicker('"
						+ count+counter
						+ "')\" / placeHolder=\"Click to pick item\"><input type=\"hidden\" name=\"item"
						+ count+counter+ "\" id=\"item"+count+counter+"\" value=\"\" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count+counter
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count+counter
							+ "\"  value=\"\" ></td>"
							
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Quantity"+count+counter+"\" name=\"Quantity"+count+counter+"\" placeholder=\"Quantity\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\" ></td>"
					+"<td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Rate"+count+counter+"\" name=\"Rate"+count+counter+"\" placeholder=\"Rate\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\"></td></table></td>"

					
					$(nextRow).html(nextContent);	
					*/
					addJobItemRow(count);
					   $(nextHeader).attr("id", "innerJobWorkItemTableRow" + count); 
					   getUnits('unit' + count);
					   //getJobFirms("firm2");
					   $("#masterItemId").val(++count);
					   $("#itemRowId").val(++counter);

		
	}
	
	
function addJobItemRow(count) {
	
	//var count = counter;
	//var count = $("#newrowhid").val();
	  //document.getElementById("orderLevelButton").style.visibility = "hidden";
	var counter = $("#itemRowId").val();
	var tbl = document.getElementById("innerJobWorkItemTable"+count);
	var lastRow = tbl.rows.length;
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);

	var content = "<td>";
	
		content+="<input type=\"text\" required readonly name=\"itemCode"
			+ count+counter
			+ "\""
			+ " 	class=\"form-control\" id=\"itemCode"
			+ count+counter
			+ "\" onclick=\"popPicker('"
			+ count+counter
			+ "')\" / placeHolder=\"Click to pick item\"><input type=\"hidden\" name=\"itemId"
			+ count+counter+ "\" id=\"item"+count+counter+"\" value=\"\" >"
				
				+ " </td>"
				+ "<td><input type=\"text\" required readonly name=\"itemName"
				+ count+counter
				+ "\""
				+ " 	class=\"form-control\" id=\"itemName"
				+ count+counter
				+ "\"  value=\"\" ></td>"
				
		+ " <td><input type=\"text\" class=\"form-control\""
		+" 	id=\"qty"+count+counter+"\" name=\"qty"+count+counter+"\" placeholder=\"Quantity\" value=\"\"  onchange=\"jobWorkRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" onfocus=\"if(this.value=='0'){this.value=''}\"></td>"
		+"<td><input type=\"text\" class=\"form-control\""
		+" 	id=\"Rate"+count+counter+"\" name=\"Rate"+count+counter+"\" placeholder=\"Rate\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\"  onchange=\"jobWorkRateCalc();\"><input type=\"hidden\" class=\"form-control\""
		+" 	id=\"jobSubTotal"+count+counter+"\" name=\"jobSubTotal"+count+counter+"\" value=\"0\" ></td>"

	newRow.innerHTML = content;
		//var count = $("#newrowhid").val();
	$(newRow).attr("id", "innerItemRows" + counter);
	$("#itemRowId").val(++counter);
	//$("#rowId").val(++count);
	
}
	

function jobWorkRates() {
	
	var count = $("#rateRowId").val();
	
//	alert(count);
	var tbl = document.getElementById("addJobWorkTable");
	var lastRow = tbl.rows.length;
	
	//alert(lastRow)
	var newRow = tbl.insertRow(lastRow);
	var content="</td>"		
		+ " <td><select class=\"form-control\" name=\"jobRateName"+count+"\""
		+" 	id=\"jobRateName"+count+"\" >"
		      
				+ " 		<option value=\"1\">Excise</option>"
				+ " 		<option value=\"2\">Cess</option>"
				+ " 		<option value=\"3\">Sales</option>"
				+ " 		<option value=\"4\">Freight</option>"
				+ " 		<option value=\"5\">Other Charges</option>"
				+ " </select></td>"
				+ " 	<td><input type=\"text\" name=\"jobRateValue"+count+"\""
				+" 	id=\"jobRateValue"+count+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"jobWorkRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
				+ "</td>"
		
	
	content += "<td>";
	if(lastRow >1){
		content+="<a href='#' onclick='deleteRow("+count+"),jobWorkRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
	}	
				
	newRow.innerHTML = content;
	$(newRow).attr("id", "addJobWorkTableRow" + count);
	$("#rateRowId").val(++count);
}
	
	
function populateJobWorkOrderViewPopup(jobId) {

	var jsonRecord = {};
	
	url = 'getJobWorkOrderById';
	
	jsonRecord.id = jobId;
	
	$.ajax({
		url : url,
		type : 'POST',
		data : JSON.stringify(jsonRecord),
		contentType : 'application/json',
		dataType : 'json',
		success : function(data) {
			if(data!=null){
				
				$("#firm").val(data.firm.firmId);
				$("#firm2").val(data.firm.firmId);
				$("#vendor5").val(data.vendor.vendorId);
				$("#jobWorkNo").val(data.jobWorkOrderNo);
				$("#jobWorkId").val(data.jobWorkId);
				$("#quotationNo").val(data.quotationNo);
				$("#jobWorkDate").val(myDateFormatter(data.jobWorkDate));
				$("#quotationDate").val(myDateFormatter(data.quotationDate));
				$("#jobWorkTotal").val(data.totalAmount);
				
				//generateOrderNo("orderNo",$("#firm").val());
				var count = $("#masterItemId").val();
				var counter = $("#itemRowId").val();
				//var counter=0;
				var tbl = document.getElementById("jobWorkItemTable");
				//$("#reqItemTable").find("tr:gt(0)").remove();
				//$('#reqItemTable th:nth-child(3)').remove();
				
				for(var r=0;r<data.masterItems.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					
					
					var itemCode = data.masterItems[r].itemCode;
					var jobItem = data.masterItems[r];
					
                   var content = "<td>";
					
					content+=" <input type=\"text\" required readonly name=\"itemCode"
						+ count
						+ "\""
						+ " 	class=\"form-control\" id=\"itemCode"
						+ count
						+ "\" onclick=\"popPicker('"
						+ count
						+ "')\" / placeHolder=\"Click to pick item\" value=\""+itemCode.code+"\"><input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\""+itemCode.codeId+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\""+itemCode.codeDesc+"\" ></td>"
							
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Quantity"+count+"\" name=\"Quantity"+count+"\" placeholder=\"Quantity\" value=\""+data.masterItems[r].qty+"\"   onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
							+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
							+" 	name=\"unit"+count+"\"> </select>"

					+ " </td></td>"
					
					$("#unit"+count).val(data.masterItems[r].unit.unitName);
					$(newRow).html(content);
					$(newRow).attr("id", "jobWorkItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<table class=\"table table-bordered table-hover\" id=\"innerJobWorkItemTable"+count+"\" width=\"100%\">"
						headerContent+="<th class=\"active\">Item Code</th>"
							+"<th class=\"active\">Item Name</th>"
							+"<th class=\"active\">Quantity</th>"
							
							+"<th class=\"active\">Rate<div class=\"btn-group\" style=\"float: right\">"
							+"	<button type=\"button\" class=\"btn btn-default\""
							+"	onclick=\"addJobItemRow("+count+")\" id=\"addRowButton\">"
							+"	<span class=\"glyphicon glyphicon-plus\"></span>"
							+"	</button>"
									
									
									
							+"	</div></th>"
					$(nextHeader).html(headerContent);
						
						for(var n=0;n<jobItem.jobWorkItem.length;n++){
							var jobItemCode = jobItem.jobWorkItem[n].itemCode;
							
							var nextlastRow = tbl.rows.length;
							var nextRow =tbl.insertRow(nextlastRow);
							var nextContent ="<td>"
								nextContent+="<input type=\"text\" required readonly name=\"itemCode"
								+ count+counter
								+ "\""
								+ " 	class=\"form-control\" id=\"itemCode"
								+ count+counter
								+ "\" onclick=\"popPicker('"
								+ count+counter
								+ "')\" / placeHolder=\"Click to pick item\" value=\""+jobItemCode.code+"\"><input type=\"hidden\" name=\"item"
								+ count+counter+ "\" id=\"item"+count+counter+"\" value=\""+jobItemCode.codeId+" \" >"
									
									+ " </td>"
									+ "<td><input type=\"text\" required readonly name=\"itemName"
									+ count+counter
									+ "\""
									+ " 	class=\"form-control\" id=\"itemName"
									+ count+counter
									+ "\"  value=\""+jobItemCode.codeDesc+"\" ></td>"
									
							+ " <td><input type=\"text\" class=\"form-control\""
							+" 	id=\"Quantity"+count+counter+"\" name=\"Quantity"+count+counter+"\" placeholder=\"Quantity\" value=\""+jobItem.jobWorkItem[n].qty+"\"   onkeypress=\"return numbersonly(this,event, true);\" ></td>"
							+"<td><input type=\"text\" class=\"form-control\""
							+" 	id=\"Rate"+count+counter+"\" name=\"Rate"+count+counter+"\" placeholder=\"Rate\" value=\""+jobItem.jobWorkItem[n].basicRate+"\"   onkeypress=\"return numbersonly(this,event, true);\"></td></td></table>"

							
							$(nextRow).html(nextContent);				
							 $(nextHeader).attr("id", "innerJobWorkItemTableRow" + count);   
					 
					  
					   
					//getUnits('unit' +count);
					//$("#qty1"+count).html(data.orderItems[r].histQty);
					//$("#unit1"+count).html(data.orderItems[r].unit.unitName);
					$("#masterItemId").val(++count);
					$("#itemRowId").val(++counter);
					//$("#warehouse").val(data.warehouse.wareId);
					//document.getElementById("addButton").style.display = "none";
				}
					
			}
				$('#job-work-form').modal({
					keyboard : true
				});
				$('#job-work-form').modal("show");
			}
			
		},
		error : function(data) {
			BootstrapDialog.alert('Error Pulling Job Work Order Details' + data);
			return;
		}

	});
}

	
	
	
	
function jobWorkRateCalc(){
	var count = $("#masterItemId").val();
	var rowCount = $("#itemRowId").val();
	var total = 0;
	for(var i=0;i<count;i++){
		for(var j=0;j<rowCount;j++){
			if(document.getElementById("Rate"+i+j) == null  )
				continue;
			else{
				var qty = parseFloat(document.getElementById("qty"+i+j).value);
				var rate = parseFloat(document.getElementById("Rate"+i+j).value);
				var res = qty * rate;
				document.getElementById("jobSubTotal"+i+j).value=res;
				total = total + res;
			}
			
		}
	}
	
	jobWorkTotal(total)
	
}	

function jobWorkTotal(rowRate){
	//document.getElementById("jobWorkTotal").value=total;
	
		var basicRate = 0;
		var exciseValue = 0;
		var cessValue = 0;
		var total = 0;
	        var excise = 0;
			var cess = 0;
			var sales = 0;
			var freight = 0;
			var otherCharges = 0;
			
			var row = $("#rateRowId").val();
		
			for(var r=0;r<row;r++){
			if(document.getElementById("jobRateName"+r) == null)
				continue;
			else{
				
			
			var rateName = document.getElementById("jobRateName"+r).value;
			
			if(rateName == 1){
				 excise = parseFloat(document.getElementById("jobRateValue"+r).value);
				
				exciseValue = (excise/100)*rowRate;
				total = (rowRate+((excise/100)*(rowRate)) + ((cess/100)*(excise/100)*rowRate)) +  ((sales/100)*((rowRate)+((excise/100)*(rowRate))+((cess/100)*((excise/100)*((rowRate)+((excise/100)*(rowRate))))))) + (freight) + (otherCharges);
				
			}
			if(rateName == 2 ){
				
			 cess = parseFloat(document.getElementById("jobRateValue"+r).value);
			   cessValue += (cess/100)*((excise/100)*rowRate);
			 total = (rowRate+((excise/100)*(rowRate)) + ((cess/100)*(excise/100)*rowRate)) + ((sales/100)*((rowRate)+((excise/100)*(rowRate))+((cess/100)*((excise/100)*((rowRate)+((excise/100)*(rowRate))))))) + (freight) + (otherCharges);
			}
			if(rateName == 3){
				
				 sales = parseFloat(document.getElementById("jobRateValue"+r).value);
				var salesValue = (sales/100)*total;
				total = (rowRate+((excise/100)*(rowRate)) + ((cess/100)*(excise/100)*rowRate))+((sales/100)*((rowRate)+((excise/100)*(rowRate))+((cess/100)*((excise/100)*((rowRate)+((excise/100)*(rowRate))))))) + (freight) + (otherCharges);
			}
			if(rateName == 4){
				
				freight = parseFloat(document.getElementById("jobRateValue"+r).value);
				total = ((rowRate+((excise/100)*(rowRate)) + ((cess/100)*(excise/100)*rowRate))+((sales/100)*((rowRate)+((excise/100)*(rowRate))+((cess/100)*((excise/100)*((rowRate)+((excise/100)*(rowRate)))))))) + (freight) + (otherCharges);
			}
			
			if(rateName == 5){
				otherCharges = parseFloat(document.getElementById("jobRateValue"+r).value);
				total = total + otherCharges;
			}
		}
		
		
			}
		
		
		
		
			document.getElementById("jobWorkTotal").value=total;
		
	
}

function generateJobWorkNo(field, firmId) {
	var modelRequest = {};
	modelRequest.id = firmId
	var sel = $("#" + field);
	$.ajax({
		url : 'generateJobWorkOrderNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the job work order no.');
		}
	});
}


	
function addDirectRow() {
		
		var count = $("#rowhid").val();
		var counter = $("#rowId").val();
		var tbl = document.getElementById("reqItemTable");
		var lastRow = tbl.rows.length;
		//alert(lastRow)
		var newRow = tbl.insertRow(lastRow);

		var content = "<td>";
					
					content+=" <input type=\"text\" required readonly name=\"itemCode"
						+ count
						+ "\""
						+ " 	class=\"form-control\" id=\"itemCode"
						+ count
						+ "\" onclick=\"popPicker('"
						+ count
						+ "')\" / placeHolder=\"Click to pick item\"><input type=\"hidden\" name=\"item"
						+ count+ "\" id=\"item"+count+"\" value=\"\" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\"\" ></td>"
							
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\"\"   onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();\"></td>"
							+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
							+" 	name=\"unit"+count+"\"> "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"5\" class=\"active\">"
						headerContent+="Rate Per Unit </td>"
					$(nextHeader).html(headerContent);
						
						
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td colspan=\"5\">"
						nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
					+" 	id=\"rateName"+count+counter+"\" onchange=\"purchaseRateCalc();\">"
				
					+ " </select></td><td><input type=\"text\" class=\"form-control\""
					+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"    onchange=\"purchaseRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" /></td>"
					+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" id=\"myBtn"+count+"\" class=\"btn btn-default\" ><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></table></td>"

					
					$(nextRow).html(nextContent);				
					   $(nextRow).attr("id", "innerItemTableRow" + count); 
					   getUnits('unit' + count);
					   getRates('rateName'+count+counter);
					   $("#rowhid").val(++count);
					   $("#rowId").val(++counter);

		
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
	$('#itemName' + selectedCounter).val(desc);
	$('#itemCode' + selectedCounter).val(plNo);
	$('#item' + selectedCounter).val(id);
}
	

function populatePurchaseOrderViewPopup(orderId) {

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
					if(parseInt(role.access[u].menu.menuId) == 504 && (userAccessLevel == 'E')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				$("#firm").val(data.firm.firmId);
				$("#firm1").val(data.firm.firmId);
				//$("#warehouse").val(data.warehouse.wareId);
				getUserWarehouse("warehouse","", data.warehouse.wareId,sessionUserId);
				$("#vendor").val(data.vendor.vendorId);
				//$("#vendorAddress").val(data.vendorDetail.locationId);
				getVendorAddress("vendorAddress",data.vendor.vendorId,data.vendorDetail.locationId);
				$("#impDetails").val(data.importantDetails);
				
				$("#discount").val(data.discount);
				$("#deliveryTerms").val(data.deliveryTerm);
				$("#deliveryPeriod").val(data.deliveryPeriod);
				$("#freight").val(data.freight);
				$("#packing").val(data.packing);
				$("#insurance").val(data.insurance);
				$("#saleTax").val(data.saleTax);
				$("#qualityTolerance").val(data.qtyTolerance);
				$("#qualityAss").val(data.qualityAssurance);
				$("#paymentTerm").val(data.paymentTerm);
				$("#otherInstruction").val(data.otherInstruction);
				
				$("#instructorName").val(data.instructorName);
				$("#instructorCont").val(data.instructorContact);
				$("#instructorEmail").val(data.instructorEmail);
				
				$("#orderNo").val(data.purchaseOrderNo);
				$("#orderId").val(data.orderId);
				$("#purchaseOrderDate").val(myDateFormatter(data.dueDate));
				$("#quotationDate").val(myDateFormatter(data.quotationDate));
				$("#quotationDetail").val(data.quotationDetail);
				$("#contactPerson").val(data.contactPerson);
				$("#orderType").val(data.orderType);
				
				for(var n=0;n<data.orderLevelRates.length;n++){
					if(data.orderLevelRates[n].rate.rateId == 23){
					$("#orderLevelGrandTotalRateId").val(data.orderLevelRates[n].rateAppliedId);
					}
					if(data.orderLevelRates[n].rate.rateId == 22){
						$("#orderLevelTotalRateId").val(data.orderLevelRates[n].rateAppliedId);
						}
					
					}
				
				//generateOrderNo("orderNo",$("#firm").val());
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				var rateCounter = counter;
				//var counter=0;
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				//$('#reqItemTable th:nth-child(3)').remove();
				
				for(var r=0;r<data.orderItems.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					var orderItem = data.orderItems[r];
					
					var itemLevelTotalId = null;
					for(var x=0;x<orderItem.itemLevelRates.length;x++){
						if(orderItem.itemLevelRates[x].rate.rateId==21){
							itemLevelTotalId = orderItem.itemLevelRates[x].rateAppliedId;
						}
					}
					
					
					var rateAppliedId = null;
					var rateId = null;
					
					var itemCode = data.orderItems[r].itemCode;
					
					var content = "<td>";
					
					content+=" <input type=\"hidden\" name=\"orderItemTotalRateId"
						+ count+ "\" id=\"orderItemTotalRateId"+count+"\" value=\""+itemLevelTotalId+"\"><input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
					+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
					+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"itemKey"
					+ count+ "\" value=\""+data.orderItems[r].itemKey+" \" ><input type=\"hidden\" name=\"rateAppliedId"
					+count+ "\" value=\""+rateAppliedId+" \" ><input type=\"hidden\" name=\"rateId"
					+ count+ "\" value=\""+rateAppliedId+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ r
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ r
							+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
							
							+ " <td id=\"3\"><input type=\"text\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data.orderItems[r].histQty+"\" readonly=\"readonly\"></td>"
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\""+data.orderItems[r].qty+"\"  onchange=\"qtyCheck();purchaseRateCalc();\"></td>"
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitId+"\" readonly><input type=\"text\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data.orderItems[r].unit.unitName+"\" readonly=\"readonly\">"

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
						var nextContent ="<td colspan=\"5\"><table class=\"table table-bordered table-hover\" id=\"innerItemTable"+r+"\" width=\"100%\">";
						
					for(var k=0;k<orderItem.itemLevelRates.length;k++){
						
						var currentRateApplied = orderItem.itemLevelRates[k];
						if(currentRateApplied.rate.rateId==21 ||currentRateApplied.rate.rateId==22 ||currentRateApplied.rate.rateId==23){
							continue;
						}
						//if(currentRateApplied.levelStatus == "I")
						//{
						nextContent+="<tr><td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"orderItemRateId"+count+counter+"\" name=\"orderItemRateId"+count+counter+"\"  value=\""+currentRateApplied.rateAppliedId+"\"  ><select class=\"form-control\" name=\"rateName"+count+counter+"\""
						+" 	id=\"rateName"+count+counter+"\" onchange=\"purchaseRateCalc();\">"
					
						+ " </select></td><td><input type=\"text\" class=\"form-control\""
						+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"  value=\"\"  onchange=\"purchaseRateCalc();\"></td>"
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
						//getRates('rateName'+count+rateCounter,currentRateApplied.rate.rateId);
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
					
					document.getElementById("addButton").style.display = "none";
					
					
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
						+ " <td><input type=\"hidden\" class=\"form-control\""
						+" 	id=\"orderLevelRateId"+Ordercount+"\" name=\"orderLevelRateId"+Ordercount+"\"  value=\""+orderRateApplied.rateAppliedId+"\"  ><select class=\"form-control\" name=\"ratesName"+Ordercount+"\""
						+" 	id=\"ratesName"+Ordercount+"\" >"
						   
								+ " </select></td>"
								+ " 	<td><input type=\"text\" name=\"orderLevelRate"+Ordercount+"\""
								+" 	id=\"orderLevelRate"+Ordercount+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"purchaseRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
								+ "</td>"
						
					
					content += "<td>";
					if(lastRow >1){
						content+="<a href='#' onclick='deleteRow("+Ordercount+"),purchaseRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
					}
					$("#orderLevelRowId").val(++Ordercount);
						}			
					newRow.innerHTML = content;
					//getRates('ratesName'+Ordercount);
					$(newRow).attr("id", "addMultipleTableRow" + Ordercount);
					
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
					
				var oType = data.orderType;
				if(oType == "Direct Purchase"){
					$('#reqItemTable th:nth-child(3)').remove();
					$('#reqItemTable td:nth-child(3)').remove();
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
			BootstrapDialog.alert('Error Pulling Purchase Order Details' + data);
			return;
		}

	});
}


	
	
	
	function remove() {
		var recordId = $("input[name='order_id']:checked").val();
		
           
            	var modelRequest = {};
        		modelRequest.id = recordId
        		
        		$.ajax({
        			url : 'getPurchaseOrderById',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				
        				var role = "";
        				var userAccessCheck = null;
        				if(userRoleData != null){
        					role = userRoleData;
        				}
        				for(var u=0;u<role.access.length;u++){
        					var userAccessLevel = role.access[u].accessLevel;
        					if(parseInt(role.access[u].menu.menuId) == 504 && (userAccessLevel == 'E')){
        						userAccessCheck++;
        					}
        				}
        				if(userAccessCheck != null){
        				
        				if(data.approvalStatus == null){
        					deletePurchaseOrder();
        				}
        				else{
        					BootstrapDialog
    						.alert('Purchase order can not be delete');
        				
        				
        				$('#flex3').flexOptions({
        					url : "getPurchaseOrderList",
        					newp : 1
        				}).flexReload();
        				}
        				}
        				else{
        					BootstrapDialog.alert('Access Denied');
        					return;
        				}
        			},
        			error : function(data) {
        				//BootstrapDialog
        						//.alert('Error unable to delete the requisition');
        				BootstrapDialog
						.alert(' Error unable to delete the Purchase order');
        				$('#flex3').flexOptions({
        					url : "getPurchaseOrderList",
        					newp : 1
        				}).flexReload();
        			}
        		});
            
       

	}
	
	function deletePurchaseOrder() {
		
		BootstrapDialog.confirm('Are you sure you want to delete?', function(result){
            if(result) {
            	var modelRequest = {};
        		modelRequest.id = recordId
        		
        		$.ajax({
        			url : 'deletePurchaseOrder',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				BootstrapDialog
						.alert('Purchase order successfully deleted');
        				$('#flex3').flexOptions({
        					url : "getPurchaseOrderList",
        					newp : 1
        				}).flexReload();
        			},
        			error : function(data) {
        				//BootstrapDialog
        						//.alert('Error unable to delete the requisition');
        				BootstrapDialog
						.alert(' Error unable to delete the Purchase order');
        				$('#flex3').flexOptions({
        					url : "getPurchaseOrderList",
        					newp : 1
        				}).flexReload();
        			}
        		});
            }else {
                return
            }
        });

	}
	
	
	function removeJob() {
		var recordId = $("input[name='jobWorkId']:checked").val();
		BootstrapDialog.confirm('Are you sure you want to delete?', function(result){
            if(result) {
            	var modelRequest = {};
        		modelRequest.id = recordId
        		
        		$.ajax({
        			url : 'deleteJobWorkOrder',
        			type : 'POST',
        			dataType : 'JSON',
        			data : JSON.stringify(modelRequest),
        			contentType : 'application/json',

        			success : function(data) {
        				BootstrapDialog
						.alert('Job Work order successfully deleted');
        				$('#flex4').flexOptions({
        					url : "getJobWorkOrderList",
        					newp : 1
        				}).flexReload();
        			},
        			error : function(data) {
        				//BootstrapDialog
        						//.alert('Error unable to delete the requisition');
        				BootstrapDialog
						.alert(' Error unable to delete the Job Work order');
        				$('#flex4').flexOptions({
        					url : "getJobWorkOrderList",
        					newp : 1
        				}).flexReload();
        			}
        		});
            }else {
                return
            }
        });

	}
	
	
	
	function savePurchaseOrder() {
		$('.close').click();
		$.ajax({
			url : 'savePurchaseOrder',
			type : "POST",
			data : $("#orderForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Purchase order saved successfully.');
				$('#flex1').flexOptions({
					url : "getPurchaseOrder",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getLocalPurchaseOrder",
					newp : 1
				}).flexReload();
				
				$('#flex3').flexOptions({
					url : "getPurchaseOrderList",
					newp : 1
				}).flexReload();
				$('#flex4').flexOptions({
					url : "getJobWorkOrderList",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving purchase order.');
				return;
			}
		});

	}

	
	function saveJobWorkOrder() {
		$('.close').click();
		$.ajax({
			url : 'saveJobWorkOrder',
			type : "POST",
			data : $("#jobWorkForm").serialize(),
			asynch : true,
			success : function(data) {
				BootstrapDialog.alert('Job work order saved successfully.');
				$('#flex1').flexOptions({
					url : "getPurchaseOrder",
					newp : 1
				}).flexReload();
				$('#flex2').flexOptions({
					url : "getLocalPurchaseOrder",
					newp : 1
				}).flexReload();
				
				$('#flex3').flexOptions({
					url : "getPurchaseOrderList",
					newp : 1
				}).flexReload();
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving job work  order.');
				return;
			}
		});

	}
	
	
	function addOrderLevelRates() {
		var count1 = $("#rowhid").val();
		
		for(i=0;i<count1; i++) {
	  		  document.getElementById("myBtn"+i).style.display = "none";
	  		
	  	 }	   
	  	 
	  		
		
		var count = $("#orderLevelRowId").val();
		
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
					+" 	id=\"orderLevelRate"+count+"\" class=\"form-control\" placeholder=\"Order Level Rate\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\"  onchange=\"purchaseRateCalc();\"  onkeypress=\"return numbersonly(this,event, true);\" />"
					+ "</td>"
			
		
		content += "<td>";
		if(lastRow >1){
			content+="<a href='#' onclick='deleteRow("+count+"),purchaseRateCalc()'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>";
		}	
					
		newRow.innerHTML = content;
		getRates('ratesName'+count);
		$(newRow).attr("id", "addMultipleTableRow" + count);
		$("#orderLevelRowId").val(++count);
		
	}
	function deleteRow(count) {
		$("#addMultipleTableRow" + count).remove();
		//$("#orderLevelRowId").val(--count);
	}			
			
	
	
	
	function populatePurchaseOrderMultipleCreatePopup(procId) {

		var jsonRecord = {};
		
		url = 'getMultipleProcurementMarkingById';
		
		jsonRecord.id = procId;
		
		
		$.ajax({
			url : url,
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',
			
			success : function(data) {
				
				var role = "";
				var userAccessCheck = null;
				if(userRoleData != null){
					role = userRoleData;
				}
				for(var u=0;u<role.access.length;u++){
					var userAccessLevel = role.access[u].accessLevel;
					if(parseInt(role.access[u].menu.menuId) == 504 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				var checkStatus=0;
				var fid = data[0].warehouse.firmId;
				var wid = data[0].warehouse.wareId;
				for(var i=0;i<data.length;i++)
					{
					if(fid==data[i].warehouse.firmId && wid==data[i].warehouse.wareId)
						checkStatus++;
					}
				if(checkStatus == data.length ){
				$("#firm").val(data[0].warehouse.firmId);
				$("#firm1").val(data[0].warehouse.firmId);
				$("#warehouse").val(data[0].warehouse.wareId);
				getUserWarehouse("warehouse","", data[0].warehouse.wareId,sessionUserId);
				$("#orderType").val(data[0].procurementType);
				
				generateOrderNo("orderNo",$("#firm").val());
				var count = $("#rowhid").val();
				var counter = $("#rowId").val();
				//var counter=0;
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				
				
				for(var r=0;r<data.length;r++){
					var lastRow = tbl.rows.length;
					var newRow = tbl.insertRow(lastRow);
					var itemCode = data[r].requisitionItemId.itemCode;
					
					var content = "<td>";
					
					content+=" <input type=\"text\" class=\"form-control\" readonly name=\"itemCode"+count+"\""
					+" 	id=\"itemCode"+count+"\" value=\""+itemCode.code+" \"/><input type=\"hidden\" name=\"item"
					+ count+ "\" value=\""+itemCode.codeId+" \" ><input type=\"hidden\" name=\"marking_id"
					+ count+ "\" value=\""+data[r].markingId+" \" ><input type=\"hidden\" name=\"requisition_id"
					+ count+ "\" value=\""+data[r].reqId.requisitionId+" \" ><input type=\"hidden\" name=\"requisitionItem_id"
					+ count+ "\" value=\""+data[r].requisitionItemId.itemKey+" \" >"
							
							+ " </td>"
							+ "<td><input type=\"text\" required readonly name=\"itemName"
							+ count
							+ "\""
							+ " 	class=\"form-control\" id=\"itemName"
							+ count
							+ "\"  value=\""+itemCode.codeDesc+" \" ></td>"
							
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"qty"+count+"\" name=\"qty"+count+"\"  value=\""+data[r].procurementQty+"\" ><span class=\"form-control\""
					+" 	id=\"qty1"+count+"\" name=\"qty1"+count+"\" placeholder=\"Quantity\" ></span></td>"
					+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"Order_Qty"+count+"\" name=\"Order_Qty"+count+"\" placeholder=\"Order Qty\" value=\"\" style =\"width:90px;\"  onkeypress=\"return numbersonly(this,event, true);\" onchange=\"qtyCheck();purchaseRateCalc();\"></td>"
							+ " <td><input type=\"hidden\" class=\"form-control\""
							+" 	id=\"unit"+count+"\" name=\"unit"+count+"\"  value=\""+data[r].unit.unitId+"\" ><span class=\"form-control\" id=\"unit1"+count+"\""
					+" 	name=\"unit1"+count+"\" value=\"\">"
						+ " </span> "

					+ " </td></td>"
					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					
					var nextRowHeader = tbl.rows.length;
					var nextHeader =tbl.insertRow(nextRowHeader);
					var headerContent="<td colspan=\"5\" class=\"active\">"
						headerContent+="Rate Per Unit </td>"
					$(nextHeader).html(headerContent);
						
						
					var nextlastRow = tbl.rows.length;
					var nextRow =tbl.insertRow(nextlastRow);
					var nextContent ="<td colspan=\"5\">"
						nextContent+="<table class=\"table table-bordered table-hover\" id=\"innerItemTable"+count+"\" width=\"100%\"><td><select class=\"form-control\" name=\"rateName"+count+counter+"\""
					+" 	id=\"rateName"+count+counter+"\" onchange=\"purchaseRateCalc();\">"
					
					+ " </select></td><td><input type=\"text\" class=\"form-control\""
					+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\"    onchange=\"purchaseRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\" /></td>"
					+"<td><a href='#' onclick='addRow(" +count+")'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" id=\"myBtn"+count+"\" class=\"btn btn-default\" ><span class=\"glyphicon glyphicon-plus\" ></span></button></div></a><input type=\"hidden\" class=\"form-control\""
					+" 	id=\"itemLevelTotal"+count+"\" name=\"itemLevelTotal"+count+"\" value=\"0\" ></td></table></td>"

					
					$(nextRow).html(nextContent);	
					getRates('rateName'+count+counter);			
					   $(nextRow).attr("id", "innerItemTableRow" + count);       
					
					//getUnits('unit' +count);
					$("#qty1"+count).html(data[r].procurementQty);
					$("#unit1"+count).html(data[r].unit.unitName);
					$("#rowhid").val(++count);
					$("#rowId").val(++counter);
					$("#warehouse").val(data[r].warehouse.wareId);
					document.getElementById("addButton").style.display = "none";

				}
				
				
				
				$('#modal-add-req').modal({
					keyboard : true
				});
				$('#modal-add-req').modal("show");
				}
				else{
					
					BootstrapDialog.alert('Error Firm and warehouse are different' );
				}
				}
				else{
					BootstrapDialog.alert('Access Denied');
					return;
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Purchase Order Details' + data);
			
			}

		});
	}
   
	function qtyCheck(){
		var count = $("#rowhid").val();
		for(var r=0;r<count;r++){
			var orderQty = parseFloat($("#Order_Qty"+r).val());
			var Qty = parseFloat($("#qty"+r).val());
			if(orderQty>Qty){
				BootstrapDialog.alert('Order Qty can not be greater then Original Qty');
				return;
			}
				
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
				BootstrapDialog.alert('Error Unable to pull the User Role Details');
			}
		});
	
	}
	
	
	var dlg = new BootstrapDialog({
		draggable : true,
		type : BootstrapDialog.TYPE_SUCCESS
	});
	

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
		document.getElementById("orderLevelTotal").value=Math.round(total,2);
		}
		else{
			total = basicRate;
		}
		
		
		
		 document.getElementById("orderLevelGrandTotal").value=Math.round(total,2);
		 
		
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
				BootstrapDialog.alert('Error Unable to pull the Purchase Order');
			}
		});

	}

	

	function addRow(count) {
		
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
			+" 	id=\"rateValue"+count+counter+"\" name=\"rateValue"+count+counter+"\" placeholder=\"Rate Value\" onfocus=\"if(this.value=='0'){this.value=''}\"  value=\"0\" onchange=\"purchaseRateCalc();\" onkeypress=\"return numbersonly(this,event, true);\"></td>"
			+"<td><a href='#' onclick='removeRow("
			+counter+ "),purchaseRateCalc();'><div class =\"btn-group\" style=\"float:right\"><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-minus\" ></span></button></div></a></td>"

		newRow.innerHTML = content;
			//var count = $("#newrowhid").val();
			getRates('rateName'+count+counter);	
		$(newRow).attr("id", "innerItemRows" + counter);
		$("#rowId").val(++counter);
		//$("#rowId").val(++count);
		
	}
	
	function removeOption(rateName){
		$('select').on('change',function(){
		    var value=$(this).val();
		    $('select').not(this).each(function(){
		        $(this).find('option[value='+value+']').remove();
		    });
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

	
	function removeRow(count) {
		$("#innerItemRows" + count).remove();
	}
	
	
</script>


<div class="mainPanel">
	<div class="panel-group" id="accordion">
		<div class="panel panel-default" id="pendingPanel">
			<div class="panel-heading clicable" data-parent="#accordion"
				data-toggle="collapse" data-target="#pendingContent">
				<h6 class="panel-title">
					Pending Purchase Order<span class="pull-right clickable"> <i
						class="glyphicon glyphicon-chevron-up"></i></span>
				</h6>
			</div>

			<div class="panel-body collapse in" id="pendingContent"
				style="margin: 0px; padding: 0px;">
				<table style="width: 100%" id="flex1"></table>
			</div>

		</div>
		<div class="panel panel-default" id="donePanel">
			<div class="panel-heading clicable" data-parent="#accordion"
				data-toggle="collapse" data-target="#doneContent">
				<h5 class="panel-title">
					Pending Local Purchase<span class="pull-right clickable"> <i
						class="glyphicon glyphicon-chevron-up"></i></span>
				</h5>
			</div>

			<div class="panel-body" id="doneContent"
				style="margin: 0px; padding: 0px;">
				<table style="width: 100%" id="flex2"></table>
			</div>

		</div>


		<div class="panel panel-default" id="donePanel">
			<div class="panel-heading clicable" data-parent="#accordion"
				data-toggle="collapse" data-target="#doneContent">
				<h5 class="panel-title">
					View Purchase Orders<span class="pull-right clickable"> <i
						class="glyphicon glyphicon-chevron-up"></i></span>
				</h5>
			</div>

			<div class="panel-body" id="doneContent"
				style="margin: 0px; padding: 0px;">
				<table style="width: 100%" id="flex3"></table>
			</div>

		</div>
<!-- 
		<div class="panel panel-default" id="donePanel">
			<div class="panel-heading clicable" data-parent="#accordion"
				data-toggle="collapse" data-target="#doneContent">
				<h5 class="panel-title">
					View Job Work<span class="pull-right clickable"> <i
						class="glyphicon glyphicon-chevron-up"></i></span>
				</h5>
			</div>

			<div class="panel-body" id="doneContent"
				style="margin: 0px; padding: 0px;">
				<table style="width: 100%" id="flex4"></table>
			</div>

		</div>
		 -->
		
	</div>
</div>















<%@ include file="include/purchase_order_form.jsp"%>
<%@ include file="include/job_work_form.jsp"%>
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