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
						.alert('Error Unable to pull the warehouse list');
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
				BootstrapDialog.alert('Error Unable to pull the Firm list');
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
						.alert('Error Unable to pull the warehouse list');
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
	function getUnits(field) {
		var sel = $("#" + field);
		$.ajax({
			url : 'getUnits',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',

			success : function(data) {
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						sel.append('<option value="' + data[i].unitId + '">'
								+ data[i].unitName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the unit list');
			}
		});
	}
	
	function getUserFirms(field, userId) {
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
						sel.append('<option value="' + firms[i].firmId + '">'
								+ firms[i].firmName + '</option>');
					}
				}
			},
			error : function(data) {
				BootstrapDialog.alert('Error Unable to pull the User Firms list');
			}
		});

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
    
