$(document).ready(function() {
    $('#datepicker').datepicker({
	format : "yyyy-mm-dd"
    });
    
    $("#tbl-Tmp-Import-Receipt").stickyTableHeaders({
	scrollableArea : $(".scrollable-area-tableIngredient")[0],
	"fixedOffset" : 2
    });
    $("#ingQuantity").tooltip({
	placement : "bottom"
    });
    $("#ingPrice").tooltip({
	placement : "bottom"
    });
});

function insertImportReceipt() {
    var s = $('#datepicker').val();

    if (s == "")
	$('#errorDate').modal('show');
    else {
	action = "ware-housing-add-Import-Receipt.lnc?dateTime=" + s;
	$.post(action, function(result) {
	    console.log(result);
	    if (result == "true") {
		$('#success-add-import-receipt').modal('show');
		$('#datepicker').val("");
		$('#tbody').remove();
	    } else {
		$('#error-add-import-receipt').modal('show');
		$('#datepicker').val("");
		$('#tbody').remove();
	    }
	});
    }
}

/* <!-- ----ajax insert----- --> */
function insertTmpImportReceipt() {
    $.post("ware-housing-insert-Tmp-Import-Receipt.lnc?ingID="
			    + $('#ingredientID').val() + "&quantity="
			    + $('#ingQuantity').val() + "&price="
			    + $('#ingPrice').val(),
		    function(result) {
			var data = result;
			if (data == "false") {
			    alert("Them khong thanh cong!")
			} else {
			    var data = result.split("-");

			    var table = "<tr class=\"row_"
				    + data[0]
				    + "\">"
				    + "<td> <input type=\"hidden\" name=\"idTmpImportReceipt\" value=\""
				    + data[0] + "\"/></td>";
			    // <td><input type="hidem"//
			    // name="idTmpImportReceipt"//
			    // value="data[0]"/></td>
			    for (var i = 1; i < data.length; i++) {
				if (data[i] != "#") {
				    table += "<td>" + data[i] + "</td>";
				} else {
				    table += "<td><a href=\"#\" class=\"btn btn-link\" onClick=\"clickDelete("
					    + data[0] + "); \"> Xóa</a></td>"
					    /*
					     * // <td><a// href="#"//
					     * class="row_delete"//
					     * onClick="clickDelete(data[0]);">Xoa</a></td>
					     */+ "</tr>";
				}
			    }
			    $('#tbl-Tmp-Import-Receipt').append(table);
			}
			$('#ingredientID').val("0");
			$('#ingQuantity').val("0");
			$('#ingPrice').val("0");

		    });
}

function valid() {
    var reg_space = /^\s+$/;
    var reg_quantity = /^[0-9][0-9]{0,1}$/;
    var reg_price = /^[0-9][0-9]{0,8}$/;
    if ($('#ingredientID').val() == "") {
	$('#ingredientID').val("");
	return false;
    } else if (reg_space.test($('#ingQuantity').val())) {
	$('#ingQuantity').val("");
	return false;
    } else if (reg_space.test($('#ingPrice').val())) {
	$('#ingPrice').val("");
	return false;
    } else if (!reg_quantity.test($('#ingQuantity').val())) {
	$('#ingQuantity').val("");
	return false;
    } else if (!reg_price.test($('#ingPrice').val())) {
	$('#ingPrice').val("");
	return false;
    } else {
	return true;
    }
}

function checkAndInsert() {
    if (valid() == true) {
	insertTmpImportReceipt();
    } else {
	$('#error').modal('show');
    }
}

/* <!-- ----ajax delete----- --> */
function clickDelete(idTmpImportReceipt) {
    $.post("ware-housing-delete-Tmp-Import-Receipt.lnc?idTmpImportReceipt="
	    + idTmpImportReceipt, function(result) {
	if (result == "true") {
	    $('.row_' + idTmpImportReceipt).remove();

	} else {

	}
    });
};

