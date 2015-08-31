/*=================================================================
	BUSSINESS FUNCTION
*=================================================================*/

/*
 * GET ALL SHOPS SALE DATA
 *
 * Display a line chart that present sale data of all shops
 *
 * Pre-condition: user choose time range and click on "Xem biểu đồ" button
 */
function getAllShopSaleData() {
    startDate =  $("#inp-stc-sale-start-date").val();
    endDate = $("#inp-stc-sale-end-date").val();

    // Get new data from server
    action = "statistic-sale-ger.lnc?startDate=" + startDate + "&endDate=" + endDate;
    $.post(action, function(result){
	data = result.split("-");
	numElement = data.length;

	var chartLabel = [];
	var chartData = [];

	// Get chart data
	for(i = 0; i < numElement - 1; i+=2) {
	    if (data[i] != "#") {
		// get label
		chartLabel.push(data[i]);

		// get data
		num = parseInt(data[i+1]).toString();
		str = num.substring(0, num.length-3);
		num = str + "." + num.substring(num.length-3, num.length);
		chartData.push(num);

	    } else {
		break;
	    }
	}

	// Set chart data
	var barChartData = {
	    labels : chartLabel,
	    datasets : [ {
		label : "Doanh thu toàn bộ hệ thống",
		fillColor : "rgba(220,220,220,0.2)",
		strokeColor : "rgba(220,220,220,1)",
		pointColor : "rgba(220,220,220,1)",
		pointStrokeColor : "#fff",
		pointHighlightFill : "#fff",
		pointHighlightStroke : "rgba(220,220,220,1)",
		data : chartData
	    } ]
	};

	// Show chart
	var ctx = document.getElementById("canvas-stc-sale-bar").getContext("2d");
	new Chart(ctx).Bar(barChartData, {responsive : true});
    });
}

/*
 * GET SHOP SALE DATA
 *
 * Get sale data of shop in a time range, list all food, sale quantity and total
 * amount of each
 *
 * Pre-condition: user choose time range and click "Xem chi tiết" button
 */
function getShopSaleData() {
    // get shop-id and time range
    shopID = $("#dpr-stc-sale-shop-id").val();
    startDate =  $("#inp-stc-sale-start-date").val();
    endDate = $("#inp-stc-sale-end-date").val();

    // delete old table data in detail-table
    $("#tbl-stc-sale-detail tbody").remove();

    // do action and get data
    action = "statistic-sale-shop.lnc?shopID=" + shopID + "&startDate=" + startDate + "&endDate=" + endDate;
    $.post (action, function(result){
	// parse result
        saleData = result.split("-");
	len = saleData.length - 1;

	for(i = 0; i < len; i+=3) {
	    $("#tbl-stc-sale-detail").append(
		"<tr>" +
		    "<td>" + saleData[i] + "</td>" +
		    "<td style=\"text-align:center;\">" + saleData[i+1] + "</td>" +
		    "<td>" + saleData[i+2] + "</td>" +
		"</tr>"
	    );
	}
    });
}


/*=================================================================
	BACKGROUND TASKS
*=================================================================*/

$(document).ready(function(){
    // Get date
    $("#inp-stc-sale-start-date").datepicker({format:"yyyy-mm-dd"});
    $("#inp-stc-sale-end-date").datepicker({format:"yyyy-mm-dd"});
});
