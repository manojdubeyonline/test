<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
var userRoleData = "";
$(document).ready(function(){

   /*  $('#datetimepicker').datetimepicker({
      format: 'dd/MM/yyyy'
    }); */
 
	$("#flex1").dblclick(function(event){
		$('.trSelected',this).each( function(){
			var recordId = $('td[abbr="requisitionRefNo"] >div', this).html();
			populateRequisitionPopup(recordId, null);
			});
		});
	$("#requisitions").attr("class","active");

	//  loadItemCodes();
	var w = 1000;
	//var w=screen.width;


	$('#flex1').flexigrid({
	url:'getRequisitions',
	method: 'POST',
	dataType : 'json',
		  
	  colModel : [
	       	{display: '', name : 'requisitionId', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Sr', name : 'sr', width:w*0.035, sortable : false, align: 'center'},
			{display: 'Requisition Ref No', name : 'requisitionRefNo', sortable : true, align: 'left',width:120},
			{display: 'Item(s)', name : '', width:300, sortable : false, align: 'left'},
			{display: 'Request Date', name : 'requestedDate', width:120, sortable : true, align: 'center'},
			{display: 'Requested By', name : 'requestedByUser', width:120, sortable : true, align: 'center'},
			{display: 'Due Date', name : 'dueDate', width:120, sortable : true, align: 'center'},
			{display: 'Status', name : 'fullFillmentStatus', width:120, sortable : true, align: 'center'},
			
			
				],
	  buttons : [
				{separator: true},
				{name: 'Add', bclass: 'glyphicon glyphicon-plus', onpress : add},
				{separator: true},
			 	{name: 'Edit', bclass: 'glyphicon glyphicon-pencil', onpress : open},
			 	{separator: true},
			 	{name: 'Delete', bclass: 'glyphicon glyphicon-remove', onpress : deleteRequisition},
			 	{separator: true},
			 	{name: 'PDF', id:'pdf', bclass: 'glyphicon glyphicon-file', onpress : pdf},
			 	{separator: true},
			 	
			 	
      
         
      ],
      searchitems : [
                {display: 'Requisition Ref No', name : 'requisitionRefNo'},
             
				
      ],
		sortname: "requestedDate",
		sortorder: "asc",
		usepager: true,
		title: 'Requisitions',
		useRp: true,
		rp: 1000,
		showTableToggleBtn: false,//toggle button for the whole table
		resizable: false,
		//width: w*.80,
		height: screen.height*.50,

	});
//getItems("item");
//getFirms("firm");
var user =${_SessionUser.userId};

getUserFirms("firm",user)
//getWarehouses("warehouse");
var userRoleId = ${_SessionUser.userRole.roleId};
getUserByRoleId(userRoleId);
   
});


	function open() {
		var recordId = $("input[name='requisitionId']:checked").val();
		populateRequisitionPopup(recordId, 'getRequisitionById');

	}
	
	function pdf() {
		var recordId = $("input[name='requisitionId']:checked").val();
		populatePdfPopup(recordId, 'getRequisitionById');

	}
	
	
	
	
	
	function populatePdfPopup(recordId, url) {

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
				
				
				var firmInfor = data.requestedForFirm;
				$("#firmLocation").html(firmInfor.firmLocation);
				$("#firmLocation1").html(firmInfor.firmLocation1);
				$("#firmName").html(firmInfor.firmName);
				$("#firmPhone").html(firmInfor.firmPhone);
				$("#firmEmail").html(firmInfor.firmEmail);
				$("#firmFax").html(firmInfor.firmFax);
	
				var img = firmInfor.firmLogo;
				document.getElementById("imageId").src="http://tender.railtechindia.in/images/"+img;
				
					  $("#store").html(data.requestedAtWareHouse.warehouseName);
					  $("#reqRefNo").html(data.requisitionRefNo);
					  $("#requestedBy").html(data.requestedByUser.userName);
					  $("#remarks").html(" "+data.remarks);
					  $("#duDate").html(dateConversion(myDateFormatter(data.dueDate)));
					  $("#reqDate").html(dateConversion(myDateFormatter(data.requestedDate)));
					  
					  var count = $("#rowhid").val();
					  var tbl = document.getElementById("itemTable");
						//$("#itemTable").find("tr:gt(0)").remove();
						// $('#reqItemTable tr:last-child').remove();
						
						for(var r=0;r<data.requisitionItems.length;r++){
							var lastRow = tbl.rows.length;
							var newRow = tbl.insertRow(lastRow);
							
							var content = "<td>";
							
							content+="<div id=\"sr"+count+"\" align=\"center\"></div></td>"
									+ " <td ><div id=\"code"+count+"\" style=\"float:left;font-weight:bold;\"></div><div style=\"float:left;\">&nbsp;-&nbsp;</div><div id=\"codedesc"+count+"\" style=\"float:left;\"></div></td>"
									+ " <td align=\"right\"><div id=\"qty"+count+"\" style=\"float:left;width:65%\"></div><div id=\"unit"+count+"\"></div></td>"
									

							$(newRow).html(content);
							$(newRow).attr("id", "itemTableRow" + count);
							//getUnits('unit' + count);
							//$("#unit"+ count).val(data.requisitionItems[r].unit.unitName);
							$("#codedesc"+count).html(data.requisitionItems[r].itemCode.codeDesc);
							$("#sr"+count).html(r+1);
							$("#code"+count).html(data.requisitionItems[r].itemCode.code);
							$("#unit"+count).html(data.requisitionItems[r].unit.unitName);
							$("#qty"+count).html(data.requisitionItems[r].qty);
							$("#rowhid").val(++count);
				
						}
						$('#firmDetail').modal({
							keyboard : true
						});
						$('#firmDetail').modal("show");
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Requistion' + data);
			
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

	function deleteRequisition() {
		var recordId = $("input[name='requisitionId']:checked").val();
		var modelRequest = {};
        		modelRequest.id = recordId
        		
        		$.ajax({
        			url : 'getRequisitionById',
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
        					if(parseInt(role.access[u].menu.menuId) == 501 && (userAccessLevel == 'E')){
        						userAccessCheck++;
        					}
        				}
        				if(userAccessCheck != null){
        				
        				if(data.currentStatus == "R"){
        					deleteReq();
        				}else{
        					BootstrapDialog
    						.alert('Requisition can not be delete');
        				}
        				
        				$('#flex1').flexOptions({
        					url : "getRequisitions",
        					newp : 1
        				}).flexReload();
        			}
        				else{
        					BootstrapDialog.alert('Access Denied');
        					return;
        				}
        			},
        			error : function(data) {
        				BootstrapDialog
        						.alert('Error unable to delete the requisition');
        				//BootstrapDialog
						//.alert('Requisition successfully deleted');
        				$('#flex1').flexOptions({
        					url : "getRequisitions",
        					newp : 1
        				}).flexReload();
        			}
        		});
            
       

	}
	
	function deleteReq() {
		
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
        				BootstrapDialog
        						.alert('Error unable to delete the requisition');
        				//BootstrapDialog
						//.alert('Requisition successfully deleted');
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
	
	function add() {
		var role = "";
		var userAccessCheck = null;
		if(userRoleData != null){
			role = userRoleData;
		}
		for(var u=0;u<role.access.length;u++){
			var userAccessLevel = role.access[u].accessLevel;
			if(parseInt(role.access[u].menu.menuId) == 501 && (userAccessLevel == 'E' || userAccessLevel == 'W')){
				userAccessCheck++;
			}
		}
		if(userAccessCheck != null){
		$('#modal-add-req').modal({
			keyboard : true
		});
		$("#requisitionId").val('');
		$("#requisitionRefNo").val('');
		$("#dueDate").val("");
		$("#firm").val("");
		$("#warehouse").val("");
		$("#rowhid").val(0);
		$('#modal-add-req').modal("show");
		$("#reqItemTable").find("tr:gt(0)").remove();
		addRow();
		}
		else{
			BootstrapDialog.alert('Access Denied');
			return;
		}
	}
	
	function saveUpdateRequisition() {
		
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
		$('.close').click();

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
				
				var role = "";
				var userAccessCheck = null;
				if(userRoleData != null){
					role = userRoleData;
				}
				for(var u=0;u<role.access.length;u++){
					var userAccessLevel = role.access[u].accessLevel;
					if(parseInt(role.access[u].menu.menuId) == 501 && (userAccessLevel == 'E')){
						userAccessCheck++;
					}
				}
				if(userAccessCheck != null){
				
				$("#requisitionId").val(data.requisitionId);
				//$("#qty").val(data.qty);
				
				$("#requisitionRefNo").val(data.requisitionRefNo);
				$("#dueDate").val(myDateFormatter(data.dueDate));
				//$('#dateRangePicker').datepicker("setDate", data.dueDate);
				$("#firm").val(data.requestedForFirm.firmId);
				getFirmWarehouses('warehouse', data.requestedForFirm.firmId,data.requestedAtWareHouse.wareId) 
				
				var count = $("#rowhid").val();
				var existingRows = count;
				//removeRow(1);
				var tbl = document.getElementById("reqItemTable");
				$("#reqItemTable").find("tr:gt(0)").remove();
				// $('#reqItemTable tr:last-child').remove();
				
				for(var r=0;r<data.requisitionItems.length;r++){
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
							+ "')\" / placeHolder=\"Click to pick item\" value=\""+data.requisitionItems[r].itemCode.codeId+" \" ></td>"
							+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
					+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" value=\""+data.requisitionItems[r].itemCode.code+" \" /></td>"
							+ " <td><input type=\"text\" placeholder=\"Item Description\""
					+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
					+" 	class=\"form-control\" value=\""+data.requisitionItems[r].itemCode.codeDesc+" \"/></td>"
							+ " <td><input type=\"text\" class=\"form-control\""
					+" 	id=\"qty"+count+"\" name=\"qty"+count+"\" placeholder=\"Quantity\" value=\""+data.requisitionItems[r].qty+"\"  onkeypress=\"return numbersonly(this,event, true);\"></td>"
							+ " <td><select class=\"form-control\" id=\"unit"+count+"\""
							+" 	name=\"unit"+count+"\">"
							+ " </select> "
							+ " </td>"

					$(newRow).html(content);
					$(newRow).attr("id", "reqItemTableRow" + count);
					getUnits('unit' + count,data.requisitionItems[r].unit.unitId);
					
					$("#rowhid").val(++count);

					$("#warehouse").val(data.requestedAtWareHouse.wareId);


				}
				
				for(var r=0;r<data.requisitionItems.length;r++){
					$("#priority"+existingRows).val(data.requisitionItems[r].priority);
					$("#unit"+existingRows).val(data.requisitionItems[r].unit.unitName);
					existingRows++;
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
				+ "')\" / placeHolder=\"Click to pick item\"   ></td>"
				+ " 	<td><input type=\"text\" name=\"pl_no"+count+"\""
		+" 	id=\"pl_no"+count+"\" class=\"form-control\" placeholder=\"PL No\" onchange=\"itemCheck();\"/></td>"
				+ " <td><input type=\"text\" placeholder=\"Item Description\""
		+" 	name=\"item_desc"+count+"\" id=\"item_desc"+count+"\""
		+" 	class=\"form-control\" /></td>"
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

	function push(id, plNo, desc) {
		dlg.close();
		$('#item_desc' + selectedCounter).val(desc);
		$('#pl_no' + selectedCounter).val(plNo);
		$('#codeId' + selectedCounter).val(id);
	}
	
	
	function itemCheck(){
		var count = document.getElementById('rowhid').value;
		for(var m=0;m<count;m++){
			for(var n=0;n<count;n++){
				if( document.getElementById('codeId'+m).value == document.getElementById('codeId'+n).value && m != n){
					BootstrapDialog.alert('Two items can not be same');
					return false;
				}	
			}
			
		}
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
		       key = e.whichs;
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

<table width="100%" id="flex1"></table>
<div id="itemCodeList" style="display:none"></div>
<%@ include file="include/addReq.jsp" %>
<%@ include file="include/reqPDF.jsp" %>
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