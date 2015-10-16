<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#grpo").attr("class","active");
		var w=1000;
		
		
		$('#flex1').flexigrid({
			url:'getPendingGRPOList',
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
			url:'getGRPOList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: '', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Purchase Order No', name : '', width:150, sortable : true, align: 'center'},
				{display: 'Marking No', name : '', width:150, sortable : true, align: 'center'},
				{display: 'Firm', name : '', width:150, sortable : true, align: 'left'},
				{display: 'Item', name : '', width:300, sortable : true, align: 'left'},
				{display: 'Qty', name : '', width:100, sortable : true, align: 'left'},
				{display: 'Inward Date', name : '', width:100, sortable : true, align: 'left'},
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
			populatePurchaseOrderViewPopup(orderId);
		}
		

	}

	function open() {
		//var requisitionId =  "";
		var orderId ="";
		var row = $('#flex2 tbody tr').has("input[name='order_id']:checked")
		//requisitionId =  $(row).find('td[abbr="requisitionRefNo"] >div', this).html();
		orderId = $(row).find("input[name='order_id']:checked").val();
		if(orderId !=undefined && orderId !=null && orderId !=''){
			populatePurchaseOrderViewPopup(orderId);
		}
		

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
					
					var itemCode = data.itemCode;
					var warehouse = data.warehouse;
					
						$("#item").val(itemCode.codeId);
						$("#item1").val(itemCode.codeDesc);
						$("#qty").val(data.orderQty);
						$("#inward_qty").val(data.orderQty);
						$("#dueDate").val(myDateFormatter(data.dueDate));
						$("#inward_date").val(myDateFormatter(new Date()));
						$("#firm1").val(data.firm.firmName);
						$("#firm").val(data.firm.firmId);
						$("#unit").val(data.unit.unitId)
						$("#unit1").val(data.unit.unitName)
						$("#unitx").val(data.unit.unitName)
						$("#marking_id").val(data.markingId)
						$("#orderNo").val(data.purchaseOrderNo); 
						$("#orderId").val(data.orderId); 
						$("#vendor").val(data.vendor.vendorId); 
						$("#rate").val(data.rate); 
						$("#orderRemarks").val(data.remarks); 
						$('#modal-add-req').modal({
							keyboard : true
						});
						$('#modal-add-req').modal("show");
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Pulling Procurement Marking Details' + data);
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
				$('#flex2').flexOptions({
					url : "getGRPOList",
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
	

</script>


<div class="mainPanel">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default" id="pendingPanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#pendingContent">
                <h6 class="panel-title">
                   <small>Pending Goods Inward Entry</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
                </h6>
            </div>
           
                <div class="panel-body collapse in" id="pendingContent" style="margin:0px; padding:0px;">
                   <table style="width:100%" id="flex1"></table>
                </div>
           
        </div>
        <div class="panel panel-default" id="donePanel">
            <div class="panel-heading clicable" data-parent="#accordion"  data-toggle="collapse" data-target = "#doneContent">
               <h5 class="panel-title">
                    <small>Goods Inward Entered</small><span class="pull-right clickable"> <i class="glyphicon glyphicon-chevron-up"></i></span>
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
     $('#dateRangePicker')
        .datepicker({
            format: "dd/mm/yyyy",
            endDate : new Date(),
            defaultDate: new Date(),
            "autoclose": true
        }) 

});
      </script>