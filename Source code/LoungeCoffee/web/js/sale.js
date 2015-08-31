/* IMPORTANCE NOTE
 *
 * If using NumberInput modal to set value for quantity or/and input cash, an error will be occurred.
 * if you set quantity is 10, input cash is also set to 10
 * if you set input cash is 20, quantity is also set to 20 too.
 *
 * To prevent this error, you need an element that hold "flag" value to decide what element will receive
 * after modal hide. In this case, I use an hidden input type to hold flag value, it will hold two value:
 * "quantity" or "cash".
 *
 * How to use?
 * Before show modal, set value for hidden input.
 * 	ex: $("#inp-num-modal-temp").val("quantity");
 * On event close modal, before set value for element, add check hidden input value statement.
 * 	ex:
 * 	    var val = $("#inp-num-modal-temp").val();
 * 	    if (val == "quantity")
 */

/*=================================================================
	Business Functions
*=================================================================*/

/*
 * GET FOOD QUANTITY
 *
 * Open Number Input Modal then get quantity of selected food in selected row
 *
 * This function is set for each row in table food, parameter id is foodID and set automaticaly
 */
function saleGetQuantity(id){
    // show modal and change inputCase
    $("#inp-num-modal-temp").val("quantity");
    showNumberInputModal();

    // clear current input
    $("#inp-sale-add-food-"+id).val("");

    // show modal to type input
    $("#mod-number-input").on("hide.bs.modal", function () {
	// get current value
	str = $("#mod-number-input #inp-cal-value").val();

	// restore to original value
	value =  restoreSalePrice(str);

	// get value
	var val = $("#inp-num-modal-temp").val();
	if (val == "quantity")
	    $("#inp-sale-add-food-"+id).val(value);
    });
}

/*
 * ADD FOOD TO ORDERS
 *
 * Add selected food to current orders when user click "Thêm" button.
 * Each food is on a row, each row has an id follow format #inp-sale-add-food-"id"
 * "id" is food's ID on database (field name: foodID)
 */
function saleAddFood(foodID) {
    // get parameter for action
    ordersQuantity = $("#inp-sale-add-food-" + foodID).val();
    action = "sale-add-food.lnc?foodID=" + foodID + "&ordersQuantity=" + ordersQuantity;

    // do add food action
    $.post(action, function(result) {
	//parse result
	array = result.split("-");

	/* note: if user type quantity less than 1, "result" is "#-#" and add-action can not be execute
	 * in this case, array[0] value is "#"
	 */
	if (array[0] != "#") {

	    /* add new row to order table, the new row contain detail of last added food
	     * the result follow ordering: id, foodID, foodName,ordersQuantity, foodPrice, odersTotalPrice, ordersAmount
	     */
	    $("#tbl-sale-orders").append(

		/*
		 * array[0] contain id of current row in CusOrdersDetail table, this field type is decimal
		 * which has ".0" last. This can cause an error when delete its row, to prevent it, remove
		 * ".0" of its.
		 */
		"<tr id=\"row-sale-order-" + array[0].replace(".0", "") + "\">" +
		    "<td>" + array[2] + "</td>" +
		    "<td>" + array[3] + "</td>"	+
		    "<td>" + array[4] + "</td>" +
		    "<td>" + array[5] + "</td>" +
		    "<td > <a href=\"#\" onclick=\"saleRemoveFood(" + array[0] + ")\" class=\"btn btn-link\"> Xóa </a></td>" +
		"</tr>"
	    );

	    // update orders amount
	    $("#par-sale-orders-amount").html(array[6]);

	} else {
	    // do some things
	}
    });

    // reset quantity input
    $('#inp-sale-add-food-' + foodID).val("0");
};


/*
 * REMOVE A FOOD FROM CURRENT ORDERS
 *
 * Remove a food from current orders and database when user click on "Xóa" button
 */
function saleRemoveFood(id) {
    // get parameter for action
    action = "sale-remove-food.lnc?id=" + id;

    // do delete action
    $.post(action, function(result) {
	// remove selected row from orders table
	$("#row-sale-order-"+id).remove();

	// update orders amount
	$("#par-sale-orders-amount").html(result);
    });
};


/*
 * CALCULATE EXCESS CASH
 *
 * Calculate excess cash when user type press "Tính tiền" button after type customer total amount
 */
function saleCalCash(){
    ordersAmount = restoreSalePrice($("#par-sale-orders-amount").text());
    inputAmount = restoreSalePrice($("#inp-sale-input-cash").val());

    cash = inputAmount - ordersAmount;
    $("#inp-sale-out-cash").val(formatSalePrice(cash.toString()));
}


/*
 * COMPLETE CURRENT ORDERS
 *
 * Complete current orders when user click "Hoàn tất" button.
 */
function saleCompleteOrder() {
    	// complete orders
	$.post("sale-complete-orders.lnc", function(result){
	    if (result == "success") {
		// show success message
		$("#alert-sale-complete-success").css("display", "block");

	    } else {
		// show fail message
		$("#alert-sale-complete-fail").css("display", "block");
	    }
	});

	// delete orders table
	$("#tbl-sale-orders tbody").remove();

	// reset orders amount
	$("#par-sale-orders-amount").text("0");

	// reset excess cash area
	$("#inp-sale-input-cash").val("");
	$("#inp-sale-out-cash").val("");
}

/*=================================================================
	Utilis Functions
*=================================================================*/

/*
 * FORMAT SALE PRICE
 *
 * Auto add "." seperator for number that present as sale currency
 *
 * price: number need to format, not support decimal number
 *
 * This method return a string
 */
function formatSalePrice(price){
    var str = price.toString();
    var len = price.length;
    var value = "";

    // remove all "."
    for(var i = 0; i < len; i++){
        if(str.charAt(i) != '.')
            value += (str.charAt(i));
    }

    return value.replace(/(\d)(?=(\d{3})+(?!\d))/g,"$1.");
}


/*
 * CONVERT SALE PRICE TO NUMBER
 *
 * Convert a string formated by "formatSalePrice" method to it original value
 *
 * price: string that is result after call "formatSalePrice" method
 *
 * This method return an integer number
 */
function restoreSalePrice(price) {
    // remove all "." in price string
    var str = price.toString();
    len = str.length;
    var value = "";

    for(var i = 0; i < len; i++){
        if(str.charAt(i) != '.')
            value += (str.charAt(i));
    }

    // convert to original number
    number = parseInt(value);

    // return value
    if (isNaN(number))
	return 0;
    else
	return number;
}

/*
 * SHOW NUMBER INPUT MODAL
 *
 * Show NumberInput modal, clear old content and auto focus to input frame
 *
 */
function showNumberInputModal() {
    // show modal
    $("#mod-number-input").modal("show");

    $("#mod-number-input").on("shown.bs.modal", function(){
	// clear input frame
	$("#mod-number-input #inp-cal-value").val("");

	// auto focus to input frame
	$("#mod-number-input #inp-cal-value").focus();
    });
};


// Hide modal
function saleHideModal() {
    $("#mod-number-input").modal("hide");
}


/*=================================================================
	BACKGROUND TASKS
*=================================================================*/
$(document).ready(function(){

    /*
     * GET FOODS OF SELECTED CATEGORY
     *
     * Get all foods in its category when user change category in drop-down list
     */
    $('#dpr-sale-food-type').change(function() {
	// get selected-category id
	foodTypeID = $('#dpr-sale-food-type').val();

	// remove all previous data in food table of old category
	$("#tbl-sale-food tbody").remove();

	// do action to get food information of new category using ajax
	$.post("sale-get-food.lnc?foodTypeID=" + foodTypeID, function(result) {

	    /* parse "result" variable to get data
	     *
	     * result is text that returned from server, its structure is:
	     * foodID1-foodName1-foodID2-foodName2-....-foodIDn-foodNamen-#
	     * "#" is used to notice the end of text
	     */
	    array = result.split("-");

	    for (var i = 0; i < array.length - 1; i+=2) {
		// array[i] contain foodID, array[i+1] contain foodName
		if (array[i] != "#") {
		    $("#tbl-sale-food").append (
                        "<tr>" +
                            "<td>" + array[i+1] + "</td>" +
                            "<td> <input type=\"text\" name=\"ordersQuantity\" id=\"inp-sale-add-food-" + array[i] + "\" value=0 class=\"inp-sale-add-food form-control\" " +
                            		"onfocus=\"saleGetQuantity("+array[i]+");\"></td>" +
                            "<td><a href=\"#\" class=\"btn btn-link\" onclick=\"saleAddFood(" +array[i]+ ");\" > Thêm </a> </td>" +
                        "</tr>"
		    );
		}
	    }
	});
    });


    /*
     * SET NUMBER INPUT MODAL VALUE ON CLICK
     *
     * Set value for input frame in NumberInput modal if user click on its number buttons
     */
    $("#mod-number-input .btn-number").click(function(){
	// get press number button value
	num = $(this).text();

	// check if not click "CE" button
	if (num != "CE") {
	    var str = $("#mod-number-input #inp-cal-value").val() + num;
	    $("#mod-number-input #inp-cal-value").val(formatSalePrice(str));

	} else
	    $("#mod-number-input #inp-cal-value").val("");
    });


    /*
     * VALIDATE NUMBER INPUT
     *
     * Make sure that user can only type number into input frame of Number Input modal
     */
    $("#mod-number-input #inp-cal-value").keyup(function(event){
	// get pressed key
	var keyCode = (event.keyCode ? event.keyCode : event.which);
	var str = $(this).val();

	// remove key if it is'nt a number
	if ((keyCode < 48) || (keyCode > 57)){
	    $(this).val(str.replace(/\D/g,''));
	}

	// format value as currency
	var value = $(this).val();
	$(this).val(formatSalePrice(value));

	// if press enter key, close modal
	if (keyCode == 13)
	    $("#mod-number-input").modal('hide');
    });


    /*
     *  GET CUSTOMER TOTAL CASH
     *
     *  Show NumberInput modal to type total amount that customer give to user
     */
    $("#inp-sale-input-cash").focus(function(){
	// show modal and change input case
	$("#inp-num-modal-temp").val("cash");
	showNumberInputModal();

	// clear current input
	$(this).val("");

	// show modal to type input
	$("#mod-number-input").on("hide.bs.modal", function () {
	    // get current value
	    value = $("#mod-number-input #inp-cal-value").val();

	    // get value
	    var val = $("#inp-num-modal-temp").val();
	    if (val == "cash")
		$("#inp-sale-input-cash").val(formatSalePrice(value));
	});
    });
});