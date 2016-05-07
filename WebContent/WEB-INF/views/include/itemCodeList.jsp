<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>

.modal-dialog {
    width: 75%;
    margin: 30px auto;
}</style>
<table id="pltable" style="width:80%">
</table>

<script type="text/javascript">
$(document).ready(function(){
	var w=screen.width;
	//$("#grpo").attr("class","active");
		
		
		
		$('#pltable').flexigrid({
			url:'getCodeList',
			method: 'POST',
			dataType : 'json',
		  
		  colModel : [
		       	{display: 'Pick', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Code Id', name : '', width:w*0.035, sortable : false, align: 'center'},
				{display: 'Item Code', name : 'code', width:150, sortable : false, align: 'center'},
				{display: 'Code Desc', name : 'codeDesc', width:400, sortable : false, align: 'left'},
				{display: 'New Code', name : '', width:150, sortable : false, align: 'left'},
				{display: 'New Desc', name : '', width:100, sortable : false, align: 'left'},
				
					],
		  buttons : [
					
				 	
	      ],
	      searchitems : [
	                {display: 'Description', name : 'codeDesc'},
	                {display: 'Item Code', name : 'code'},
	             
					
	      ],
			sortname: "codeId",
			sortorder: "asc",
			usepager: true,
			newp:1,
			//title: 'Purchase Orders',
			useRp: true,
			rp: 200,
			showTableToggleBtn: true,//toggle button for the whole table
			resizable: false,
			width: 700,
			height: screen.height*.50,
			singleSelect: true

		});
		});
</script>