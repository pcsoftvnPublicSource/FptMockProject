function validateAdd() {
    var reg_shop_phone = /^(0\d{10})|(0\d{9})$/;
    var reg_manager_phone = /^(01\d{9})|(09\d{8})$/;
    if (($("#inp-shop-id-add").val() == ""))
	return false;
    else if (($("#inp-shop-name-add").val() == ""))
	return false;
    else if (($("#inp-shop-address-add").val() == ""))
	return false;
    else if (($("#inp-shop-phoneNumber-add").val() == ""))
	return false;
    else if (($("#inp-shop-password-add").val() == ""))
	return false;
    else if (($("#inp-shop-managerAddress-add").val() == ""))
	return false;
    else if (($("#inp-shop-managerPhoneNumber-add").val() == ""))
	return false;
    else if (reg_shop_phone.test($("#inp-shop-phoneNumber-add").val()) == false) {
	$("#inp-shop-phoneNumber-add").val("");
	return false;
    }else if (reg_manager_phone.test($("#inp-shop-managerPhoneNumber-add").val()) == false) {
	$("#inp-shop-managerPhoneNumber-add").val("");
	return false;
    }

}
function validateFormAdd() {
    if (validateAdd() == false)
	$("#error").modal('show');
    else {
	action = "shop-list-add-shop.lnc?shopID=" + $("#inp-shop-id-add").val()
		+ "&shopName=" + $("#inp-shop-name-add").val()
		+ "&shopAddress=" + $("#inp-shop-address-add").val()
		+ "&shopPhoneNumber=" + $("#inp-shop-phoneNumber-add").val()
		+ "&shopPassword=" + $("#inp-shop-password-add").val()
		+ "&managerName=" + $("#inp-shop-managerName-add").val()
		+ "&managerAddress=" + $("#inp-shop-managerAddress-add").val()
		+ "&managerPhoneNumber="
		+ $("#inp-shop-managerPhoneNumber-add").val();
	alert(action);
	$.post(action, function(result) {
	    if (result == "true") {
		$("#success-add-shop").modal('show');
		$("#success-add-shop").on('hide.bs.modal', function(e) {
		    $.post('shop-list-show-shop-list.lnc');
		});
		location.reload();

	    } else {
		$("#error-add-shop").modal('show');
		$("#inp-shop-id-add").val("")
		$("#inp-shop-name-add").val("")
		$("#inp-shop-address-add").val("")
		$("#inp-shop-phoneNumber-add").val("")
		$("#inp-shop-password-add").val("")
		$("#inp-shop-managerName-add").val("")
		$("#inp-shop-managerAddress-add").val("")
		$("#inp-shop-managerPhoneNumber-add").val("");
	    }
	});
    };
};

$(document).ready(function() {
    $("#inp-shop-id-add").tooltip({
	placement : "right"
    });
    $("#inp-shop-phoneNumber-add").tooltip({
	placement : "right"
    });
    $("#inp-shop-managerPhoneNumber-add").tooltip({
	placement : "right"
    });
    $("#tbl-shop-list").stickyTableHeaders({
	scrollableArea : $(".scrollable-area-shop-list-table-shop")[0],
	"fixedOffset" : 2
    });
});

$(".xoaBtn").click(function() {
    $('#myModalDelete').modal('show');
    $('#deleteShopId').val($(this).attr("id").substring(6));
});

function deleteShop(id) {
    $('#myModalDelete').modal('show');
    $('#shop-id').text(id);
    $('#deleteShopID').val(id);
};

function closeModalDelete() {
    $('#myModalDelete').modal('hide');
};

function closeModal() {
    $('#myModal').modal('hide');
};

function shopShowDetail(id) {
    $('#myModal').modal('show');
    $.post("shop-list-show-detail-shop.lnc?shopID=" + id, function(result) {
	if (result == "false") {
	    $('#myModal').modal('hide');
	    $(alertDetailShop).attr('display', 'block');
	} else {
	    var data = result.split("-");
	    $("#inp-shop-id-update").val(data[0]);
	    $("#inp-shop-password-update").val(data[1]);
	    $("#inp-shop-name-update").val(data[2]);
	    $("#inp-shop-address-update").val(data[3]);
	    $("#inp-shop-phoneNumber-update").val(data[4]);
	    $("#inp-shop-managerName-update").val(data[5]);
	    $("#inp-shop-managerAddress-update").val(data[6]);
	    $("#inp-shop-managerPhoneNumber-update").val(data[7]);
	}
    });
};

function validateUpdate() {
    var reg_shop_phone = /^(0\d{10})|(0\d{9})$/;
    var reg_manager_phone = /^(01\d{9})|(09\d{8})$/;
    if (($("#inp-shop-id-update").val() == ""))
	return false;
    else if (($("#inp-shop-name-update").val() == ""))
	return false;
    else if (($("#inp-shop-address-update").val() == ""))
	return false;
    else if (($("#inp-shop-phoneNumber-update").val() == ""))
	return false;
    else if (($("#inp-shop-password-update").val() == ""))
	return false;
    else if (($("inp-shop-managerAddress-update").val() == ""))
	return false;
    else if (($("inp-shop-managerPhoneNumber-update").val() == ""))
	return false;
    else if (reg_shop_phone.test($("#inp-shop-phoneNumber-update").val()) == false) {
	$("#inp-shop-phoneNumber-update").val("");
	return false;
    } else if (reg_manager_phone.test($("#inp-shop-managerPhoneNumber-update")
	    .val()) == false) {
	$("#inp-shop-managerPhoneNumber-update").val("");
	return false;
    } else
	return true;
};

function validateFormUpdate() {
    if (validateUpdate() == false)
	$("#error").modal('show');
    else {
	action = "shop-list-update-shop.lnc?shopID="
		+ $("#inp-shop-id-update").val() + "&shopName="
		+ $("#inp-shop-name-update").val() + "&shopAddress="
		+ $("#inp-shop-address-update").val() + "&shopPhoneNumber="
		+ $("#inp-shop-phoneNumber-update").val() + "&shopPassword="
		+ $("#inp-shop-password-update").val() + "$&managerName="
		+ $("#inp-shop-managerName-update").val() + "&managerAddress="
		+ $("#inp-shop-managerAddress-update").val()
		+ "&managerPhoneNumber="
		+ $("#inp-shop-managerPhoneNumber-update").val();
	$.post(action, function(result) {
	    if (result == "true") {
		$("#success-update-shop").modal('show');
		$("#success-update-shop").on('hide.bs.modal', function(e) {
		    $.post('shop-list-show-shop-list.lnc');
		});
		location.reload();
	    } else {
		$("#error-update-shop").modal('show');
		$("#inp-shop-id-update").val("")
		$("#inp-shop-name-update").val("")
		$("#inp-shop-address-update").val("")
		$("#inp-shop-phoneNumber-update").val("")
		$("#inp-shop-password-update").val("")
		$("#inp-shop-managerName-update").val("")
		$("#inp-shop-managerAddress-update").val("")
		$("#inp-shop-managerPhoneNumber-update").val("");
	    }
	});
    }
};

function checkShopID() {
    var id = $('#inp-shop-id-add').val();
    $.post("shop-list-check-shop-id.lnc?shopID=" + id, function(result) {
	var data = result;
	if (data == "true") {
	    $('#errorID').modal('show');
	    $('#inp-shop-id-add').val("");
	} else {
	    $('#errorID').modal('hide');
	}
    });
}
