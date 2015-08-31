function updateIngredient(ingredientId) {

	$("#detailIngredientName").val($("#ingName" + ingredientId).val());
	$("#detailChooseIngUnit").val($("#ingUnit" + ingredientId).val());
	$("#updateIngId").val(ingredientId);
	$("#detail-ingredient-mode").modal();
}

function deleteIngredient(ingredientId) {
	$("#ingNameHeadDelete").html($("#ingName" + ingredientId).val());
	$("#deleteIngId").val(ingredientId);
	$("#delete-ingredient-mode").modal();
}

function valiIngName() {

	if (($("#ingNameNew").val() == "")
			|| (validateSpace($("#ingNameNew").val()))) {
		$("#msgNameNull").css("visibility", "visible");
	} else {

		var x = document.getElementsByName("ingElm");
		var i = 0;
		var find = false;
		while ((i < x.length) && (!find)) {
			if ($("#ingNameNew").val().trim() == x[i].value) {
				find = true;
			}
			i++;
		}

		if (find) {
			$("#ingNameHeadExist").html($("#ingNameNew").val());
			$("#exists-ing-mode").modal();
		} else {

			$("#ingNameHead").html($("#ingNameNew").val());
			$("#add-success-ing-mode").modal();
			setTimeout(function() {
				$("#formAddIngredient").submit();
			}, 2000);
		}
	}
}

$(document).ready(function() {
	$("#ingNameNew").click(function() {
		$("#msgNameNull").css("visibility", "hidden");
	});
	
	$("#detailIngredientName").click(function() {
		$("#msgNameNullM").css("visibility", "hidden");
	});
});

function validateSpace(str) {
	var re = /^\s+$/;
	return re.test(str);
}

function valiIngDetail() {
	if (($("#detailIngredientName").val() == "")
			|| (validateSpace($("#detailIngredientName").val()))) {
		$("#msgNameNullM").css("visibility", "visible");
	} else {
		var x = document.getElementsByName("ingElm");
		var i = 0;
		var find = false;
		//
		$("#ingName" + $("#updateIngId").val()).val()
		//
		while ((i < x.length) && (!find)) {
			if (($("#detailIngredientName").val().trim() == x[i].value)
					&& ($("#ingName" + $("#updateIngId").val()).val().trim() != x[i].value)) {
				find = true;
			}
			i++;
		}
		if (find) {
			$("#ingNameHeadExist").html($("#detailIngredientName").val());
			$("#exists-ing-mode").modal();
		} else {
			$("#save-success-ing-mode").modal();
			setTimeout(function() {
				$("#formAddIngredientM").submit();
			}, 2000);
		}

	}
}