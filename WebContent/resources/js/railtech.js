

function generateRefNo() {
		var modelRequest = {};
		modelRequest.id = $("#firm").val();
		modelRequest.id2 = $("#warehouse").val();

		$.ajax({
			url : 'generateRequisitionRefNo',
			type : 'POST',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',
			success : function(data) {
				if (data != null) {
					$("#requisitionRefNo").val(data);
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to generate the ref no.');
			}
		});
}


function generateWarehouseRefNo() {
	var modelRequest = {};
	modelRequest.id = $("#fromFirm").val();
	modelRequest.id2 = $("#fromWarehouse").val();

	$.ajax({
		url : 'generateWarehouseRefNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$("#warehouseRefNo").val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the Warehouse ref no.');
		}
	});
}

function generateIssuesRefNo() {
	var modelRequest = {};
	modelRequest.id = $("#firm").val();
	modelRequest.id2 = $("#warehouse").val();
	var sel = $("#issueRefNo");

	$.ajax({
		url : 'generateIssueRefNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the Issue ref no.');
		}
	});
}

function generateIssueRefNo(firmId,warehouseId) {
	var modelRequest = {};
	modelRequest.id = firmId
	modelRequest.id2 = warehouseId
	var sel = $("#issueRefNo");

	$.ajax({
		url : 'generateIssueRefNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the Issue ref no.');
		}
	});
}


function getVendorAddress(field, vendorId,selectedAddress) {
	var modelRequest = {};
	modelRequest.id = vendorId
	var sel = $("#" + field);
	$.ajax({
		url : 'getVendorAddress',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				sel.html('<option value="" selected>Select Vendor Address</option>');
				for (var i = 0; i < data.length; i++) {
					if(selectedAddress == data[i].locationId){
						sel.append('<option value="' + data[i].locationId + '"selected >'
								+ data[i].clientAddress + '</option>');
					}
					else{
					sel.append('<option value="' + data[i].locationId + '">'
							+ data[i].clientAddress + '</option>');
					}
				}
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to get vendor addresses');
		}
	});
}


function generateRecieptNo(field, firmId) {
	var modelRequest = {};
	modelRequest.id = firmId
	var sel = $("#" + field);
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


function generateOrderNo(field, firmId) {
	var modelRequest = {};
	modelRequest.id = firmId
	var sel = $("#" + field);
	$.ajax({
		url : 'generatePurchaseOrderNo',
		type : 'POST',
		data : JSON.stringify(modelRequest),
		contentType : 'application/json',
		success : function(data) {
			if (data != null) {
				$(sel).val(data);
			}
		},
		error : function(data) {
			BootstrapDialog.alert('Error Unable to generate the order no.');
		}
	});
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

	function getWarehouses(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getWarehouses',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].wareId + '">'
								+ data[i].warehouseName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list ');
			}
		});

	}

	function getFirms(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirms',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].firmId + '">'
								+ data[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Firm list ');
			}
		});

	}
	
	function getReceiverFirm(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirms',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].firmId + '">'
								+ data[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Firm list ');
			}
		});

	}
	
	function getFromFirm(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirms',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].firmId + '">'
								+ data[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the Firm list ');
			}
		});

	}
	
	
	
	
	function getFirmWarehouses(field, firmId, defaultVal) {
		var modelRequest = {};
		modelRequest.id = firmId
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirmWarehouses',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					sel.html('<option value="" selected>Store</option>');
					
					for (var i = 0; i < data.length; i++) {
						
						if(defaultVal==data[i].wareId){
							sel.append('<option value="' + data[i].wareId + '"selected >'
									+ data[i].warehouseName + '</option>');
						}else{
							sel.append('<option value="' + data[i].wareId + '" >'
									+ data[i].warehouseName + '</option>');
						}
						
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list ');
			}
		});
	}
	
	
	
	function getWarehouseFirm(field, firmId, defaultVal) {
		var modelRequest = {};
		modelRequest.id = firmId
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirmWarehouses',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					sel.html('<option value="" selected>Warehouse</option>');
					
					for (var i = 0; i < data.length; i++) {
						if(defaultVal==data[i].wareId){
							sel.append('<option value="' + data[i].wareId + '"selected >'
									+ data[i].warehouseName + '</option>');
						}else{
							sel.append('<option value="' + data[i].wareId + '" >'
									+ data[i].warehouseName + '</option>');
						}
						
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list ');
			}
		});
	}

	
	

	function getFirmById(field, firmId) {
		var modelRequest = {};
		modelRequest.id = firmId
		var sel = $("#" + field);
		$.ajax({
			url : 'getFirmById',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					sel.val(data.firmName);
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the firm details');
			}
		});
	}
	
	function getUsers(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getUsers',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].userId + '">'
								+ data[i].userName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	}

	function getItems(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getItems',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].itemId + '">'
								+ data[i].itemDesc + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the item list');
			}
		});
	}

	function getVendors(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getVendors',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].vendorId + '">'
								+ data[i].vendorName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the vendor list');
			}
		});
	}
	function getUnits(field, selectedVal) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getUnits',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						if(selectedVal == data[i].unitId){
							sel.append('<option value="' + data[i].unitId + '" selected>'
									+ data[i].unitName + '</option>');
						}else{
							sel.append('<option value="' + data[i].unitId + '">'
									+ data[i].unitName + '</option>');
						}
						
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the unit list');
			}
		});
	}
	
	function getUserFirms(field, userId,defaultValue) {
		var jsonRecord = {};
		jsonRecord.id = userId;
		var sel = $("#" + field);
		sel.html('<option value="" selected disabled>For the Firm</option>');
		$.ajax({
			url : 'getUserById',
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					var firms = data.userFirms;
					for (var i = 0; i < firms.length; i++) {
						if(defaultValue == firms[i].firmId){
						sel.append('<option value="' + firms[i].firmId + '" selected>'
								+ firms[i].firmName + '</option>');
						}
						else{
							sel.append('<option value="' + firms[i].firmId + '">'
									+ firms[i].firmName + '</option>');
						}
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the User Firms list');
			}
		});

	}
	
	function getUserWarehouse(field, firmId, defaultVal,userId) {
		var modelRequest = {};
		modelRequest.id = userId
		var sel = $("#" + field);
		$.ajax({
			url : 'getUserById',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					sel.html('<option value="" selected disabled>Warehouse</option>');
					var warehouses = data.userWarehouses;
					for (var i = 0; i < warehouses.length; i++) {
						if(defaultVal == warehouses[i].wareId){
							sel.append('<option value="' + warehouses[i].wareId + '" selected>'
									+ warehouses[i].warehouseName + '</option>');
						}
						else{
						if(firmId==warehouses[i].firmId){
							sel.append('<option value="' + warehouses[i].wareId + '" >'
									+ warehouses[i].warehouseName + '</option>');
						 }
						}
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list ');
			}
		});
	}
	
	
	function getUWarehouse(field,userId,defaultVal) {
		var modelRequest = {};
		modelRequest.id = userId
		var sel = $("#" + field);
		$.ajax({
			url : 'getUserById',
			type : 'POST',
			dataType : 'JSON',
			data : JSON.stringify(modelRequest),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					sel.html('<option value="" selected disabled>Warehouse</option>');
					var warehouses = data.userWarehouses;
					for (var i = 0; i < warehouses.length; i++) {
						if(defaultVal == warehouses[i].wareId){
							sel.append('<option value="' + warehouses[i].wareId + '" selected>'
									+ warehouses[i].warehouseName + '</option>');
						}
						else{
						
							sel.append('<option value="' + warehouses[i].wareId + '" >'
									+ warehouses[i].warehouseName + '</option>');
						}
					}
				}
			},
			error : function(data) {
				BootstrapDialog
						.alert('Error Unable to pull the warehouse list ');
			}
		});
	}
	
	
	function getUFirms(field,wareId,userId) {
		var jsonRecord = {};
		jsonRecord.id = userId;
		var sel = $("#" + field);
		sel.html('<option value="" selected disabled>For the Firm</option>');
		$.ajax({
			url : 'getUserById',
			type : 'POST',
			data : JSON.stringify(jsonRecord),
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					var warehouse = data.userWarehouses;
					for (var i = 0; i < warehouse.length; i++) {
						if(wareId == warehouse[i].wareId){
						//sel.append('<option value="' + warehouse[i].firmId + '">'
								//+ warehouse[i].firmId + '</option>');
						sel.val(warehouse[i].firmId);
						}
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the User Firms list');
			}
		});

	}
	
	
	
	function getRates(field, selectedVal) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getRates',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						if(data[i].rateId==21 ||data[i].rateId==22 ||data[i].rateId==23){
							continue;
						}
						if(selectedVal == data[i].rateId){
							sel.append('<option value="' + data[i].rateId + '" selected>'
									+ data[i].rateLabel + '</option>');
						}else{
							sel.append('<option value="' + data[i].rateId + '">'
									+ data[i].rateLabel + '</option>');
						}
						
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the rate name list');
			}
		});
	}
	
	function getItemOption(field,id){
		alert(id);
	}

	function myDateFormatter (dateObject) {
        var d = new Date(dateObject);
        var day = d.getDate();
        var month = d.getMonth() + 1;
        var year = d.getFullYear();
        if (day < 10) {
            day = "0" + day;
        }
        if (month < 10) {
            month = "0" + month;
        }
        var date = day + "/" + month + "/" + year;

        return date;
    }; 
    
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
    
