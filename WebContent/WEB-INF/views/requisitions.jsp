<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
$(document).ready(function(){

	$("#flex1").dblclick(function(event){
		$('.trSelected',this).each( function(){
			var recordId = $('td[abbr="requisitionId"] >div', this).html();
			populateRequisitionPopup(recordId);
			});
		});
	
var w=1000;
$('#flex1').flexigrid({
url:'getRequisitions',
method: 'POST',
dataType : 'json',
	  
	  colModel : [
			{display: 'Sr', name : '', width:w*0.035, sortable : false, align: 'center'},
			
			{display: 'Requisition No', name : 'requisitionId', sortable : true, align: 'left',width:120},
			{display: 'Item', name : 'requisition.item.id', width:120, sortable : false, align: 'center'},
			{display: 'Request Date', name : 'voucher_date', width:120, sortable : true, align: 'center'},
			{display: 'Requested By', name : 'voucher_entry_date', width:120, sortable : true, align: 'center'},
			{display: 'Due Date', name : 'voucher_project', width:120, sortable : true, align: 'center'},
			{display: 'Qty', name : 'voucher_type', width:120, sortable : true, align: 'center'},
			{display: 'Status', name : 'voucher_type', width:120, sortable : true, align: 'center'},
			{display: 'Approved By', name : 'voucher_type', width:120, sortable : true, align: 'center'},
			
				],
	  buttons : [
				{name: 'Add', bclass: 'add', onpress : add},
			 //{name: 'Print', bclass: 'print_excel', onpress : doCommand},
      
              {separator: true}
      ],
      searchitems : [
                {display: 'Voucher Id', name : 'voucher_id'},
                {display: 'Voucher No', name : 'voucher_no', isdefault: true},
				{display: 'Voucher Desc', name : 'voucher_description'},
				{display: 'Voucher Date', name : 'voucher_date'},
				{display: 'Voucher Entry Date(dd/mm/yyyy)', name : 'voucher_entry_date'},
				{display: 'Project(E/I)', name : 'voucher_project'},
				{display: 'Type(D/C)', name : 'voucher_type'},
				
      ],
		sortname: "voucher_id",
		sortorder: "asc",
		usepager: true,
		title: 'My Requisitions',
		useRp: true,
		rp: 1000,
		showTableToggleBtn: false,//toggle button for the whole table
		resizable: false,
		width: w,
		height: screen.height*.50,

	});
getItems("item");
getFirms("firm");
getWarehouses("warehouse");

   
});

function doCommand(com, grid)  {
	
}

function add()  {
	$('#modal-add-req').modal({
		keyboard : true
	});
	$('#modal-add-req').modal("show");  
}
function saveUpdateRequisition(){  
	 $('.close').click();  
	 $.ajax(	{
	    url : 'saveRequisition',
	    type: "POST",
	    data : $("#reqForm").serialize(),
	    asynch: true,
	    success:function(data) 
	    {    	
	    	BootstrapDialog.alert('Requistion saved successfully.');
	    	$('#flex1') .flexOptions({ url: "getRequisitions", newp: 1 }).flexReload();    	
	    	return;	
	    },
	    error: function(data) 
	    {
	    	BootstrapDialog.alert('Error Saving Requistion');
	 		return;   	
	    }
	});
			     
} 

function populateRequisitionPopup(recordId){
	
	var jsonRecord ={};

	jsonRecord.id=recordId;
	$.ajax({
		url : 'getRequisitionById',
		type : 'POST',
		contentType : 'application/json',
		data : JSON.stringify(jsonRecord),
		asynch : true,
		success : function(data){
			$("#requisitionId").val(data.requisitionId);
			$("#qty").val(data.qty);
			
			$("#dueDate").val(data.dueDate);
			$("#firm").val(data.requestedForFirm.firmId);
			$("#item").val(data.item.itemId);
			$("#warehouse").val(data.requestedAtWareHouse.wareId);
			$('#modal-add-req').modal({
				keyboard : true
			});
			$('#modal-add-req').modal("show");  
		},
		error : function(data){
			
		}
		
		});
}

function getItems(field) {
	var sel=  $("#"+field);
	$.ajax({
        url: 'getItems',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
       
        success: function( data ) {
        	if(data!=null ) {
        	    for (var i = 0; i < data.length; i++) {
        	    	sel.append('<option value="' + data[i].itemId + '">' + data[i].itemDesc + '</option>');
        		 }        		
        	}
        },
		error:function(data){
			BootstrapDialog.alert('Error Unable to pull the item list');
		}
    });
}

function getFirmWarehouses(field, firmId) {
	var modelRequest ={};
	modelRequest.id= firmId
	var sel=  $("#"+field);
	$.ajax({
        url: 'getFirmWarehouses',
        type: 'POST',
        dataType: 'JSON',
        data : JSON.stringify(modelRequest),
        contentType: 'application/json',
       
        success: function( data ) {
        	if(data!=null ) {
        	    for (var i = 0; i < data.length; i++) {
        	    	sel.append('<option value="' + data[i].wareId + '">' + data[i].warehouseName + '</option>');
        		 }        		
        	}
        },
		error:function(data){
			BootstrapDialog.alert('Error Unable to pull the warehouse list');
		}
    });
}

function getWarehouses(field) {
	var sel=  $("#"+field);
	$.ajax({
        url: 'getWarehouses',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
       
        success: function( data ) {
        	if(data!=null ) {
        	    for (var i = 0; i < data.length; i++) {
        	    	sel.append('<option value="' + data[i].wareId + '">' + data[i].warehouseName + '</option>');
        		 }        		
        	}
        },
		error:function(data){
			BootstrapDialog.alert('Error Unable to pull the warehouse list');
		}
    });
   

}

function getFirms(field) {
	var sel=  $("#"+field);
	$.ajax({
        url: 'getFirms',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
       
        success: function( data ) {
        	if(data!=null ) {
        	    for (var i = 0; i < data.length; i++) {
        	    	sel.append('<option value="' + data[i].firmId + '">' + data[i].firmName + '</option>');
        		 }        		
        	}
        },
		error:function(data){
			BootstrapDialog.alert('Error Unable to pull the Firm list');
		}
    });
   

}


</script>

<table width="100%" id="flex1"></table>
<%@ include file="include/addReq.jsp" %>
<script>
$(document).ready(function() {
  /*   $('#dueDate')
        .datepicker({
            format: "mm/dd/yyyy"
        }) */

});
      </script>