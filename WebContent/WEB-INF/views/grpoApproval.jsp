<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#grpoApproval").attr("class","active");
		var w=1000;
		
		
			
		$('#flex1').flexigrid({
			url:'getGRPOList',
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
			//width: w,
			singleSelect: true

		});

		$('#flex2').flexigrid({
			url:'getGRPOListApprovalCompleted',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : false, align: 'center'},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:400, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Due Date', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Approved By', name : '', width:70, sortable : true, align: 'left'},
				{display: 'Approval Status', name : '', width:70, sortable : true, align: 'left'},
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
			//width: w,
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
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
					$("#item").val(itemCode.codeId);
					$("#item1").val(itemCode.codeDesc);
					$("#qty").val(data.orderId.orderQty);
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
					$("#rate").val(data.orderId.rate); 
					$("#orderRemarks").val(data.orderId.remarks); 
					$("#inwardRemarks").val(data.inwardComments);
					$('#modal-add-req').modal({
						keyboard : true
					});
					$('#modal-add-req').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling GRPO Pending Approval Details' + data);
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
				return;
			},
			error : function(data) {
				BootstrapDialog.alert('Error Saving GRPO approval.');
				return;
			}
		});

	}

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
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
					$("#item").val(itemCode.codeId);
					$("#item1").val(itemCode.codeDesc);
					$("#qty").val(data.orderId.orderQty);
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
					$("#rate").val(data.orderId.rate); 
					$("#orderRemarks").val(data.orderId.remarks); 
					$("#inwardRemarks").val(data.inwardComments);
					$("#approvalStatus").val(data.approvalStatus);
					$("#approval_comments").val(data.approvalComments);
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling GRPO Approval Details' + data);
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

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                    <small>GRPO Pending Approval</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>GRPOs Approval Completed</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h5>
            </div>
        
                <div class="panel-body" id="doneContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex2"></table>
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