$(document).ready(function() {
    $('#datepicker').datepicker();
    $("#tbl-Detail-Import-Receipt").stickyTableHeaders({
	scrollableArea : $(".scrollable-area-bill-detail-table")[0],
	"fixedOffset" : 2
    });
    $("#tbl-import-receipt").stickyTableHeaders({
	scrollableArea : $(".scrollable-area-bill-table")[0],
	"fixedOffset" : 2
    });
});

function showImportReceipt() {
    if ($('#datepicker').val() == "") {
	$('#error').modal('show');
    } else {
	$('#form-show-import-receipt').submit();
    }
}

function clickShowDetail(id) {
    $.post("ware-housing-show-detail-receipt.lnc?idImportReceipt=" + id,
	    function(result) {
		$(".rowdel").remove();
		if (result == "false") {
		    alert("Không có dữ liệu!");
		} else {
		    var table;
		    var data = result.split("-");
		    for (var i = 0; i < data.length; i++) {
			console.log(data[i]);
		    }
		    for (var i = 0; i < data.length - 1; i++) {
			if (data[i] == "+") {
			    table += "<tr class=\"rowdel\">"
			} else if (data[i] == "#") {
			    table += "</tr>";
			} else {
			    table += "<td>" + data[i] + "</td>";
			}
		    }
		    $('#tbl-Detail-Import-Receipt').append(table);
		}
	    });
};