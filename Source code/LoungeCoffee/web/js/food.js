function updateFood(foodId) {
	$("#detailFoodName").val($("#foodName" + foodId).val());
	$("#detailChooseFoodType").val($("#foodType" + foodId).val());
	$("#detailFoodPrice").val($("#foodPrice" + foodId).val());
	$("#updateFoodId").val(foodId);
	$("#detail-food-mode").modal();
}

function deleteFood(foodId) {
	$("#deleteFoodId").val(foodId);
	$("#foodNameHeadDelete").html($("#foodName" + foodId).val());
	$("#delete-food-mode").modal();
}

function updateFoodType(foodTypeId) {
	$("#detailFoodTypeName").val($("#foodTypeNewName" + foodTypeId).val());
	$("#updateFoodTypeId").val(foodTypeId);
	$("#detail-food-type-mode").modal();
}

function deleteFoodType(foodTypeId) {
	$("#deleteFoodTypeId").val(foodTypeId);
	$("#foodTypeNameHeadDelete").html($("#foodTypeNewName" + foodTypeId).val());
	$("#delete-food-type-mode").modal();
}

function showMsgEFood() {
	var test = true;
	if (($("#foodName").val() == "") || (validateSpace($("#foodName").val()))) {
		$("#msgNameFNull").css("visibility", "visible");
		test = false;
	}
	if (!validatePrice($("#foodPrice").val())) {
		$("#msgPriceFall").css("visibility", "visible");
		test = false;
	}
	if (test) {
		var x = document.getElementsByName("foodNameElm");
		var i = 0;
		var find = false;
		while ((i < x.length) && (!find)) {
			if ($("#foodName").val().trim() == x[i].value) {
				find = true;
			}
			i++;
		}
		if (find) {
			$("#foodNameHeadExist").html($("#foodName").val());
			$("#exists-food-mode").modal();
		} else {
			$("#foodNameHead").html($("#foodName").val());
			$("#add-success-food-mode").modal();
			setTimeout(function() {
				$("#addFoodForm").submit();
			}, 2000);
		}

	}
}

function validatePrice(price) {
	var re = /^[1-9][0-9]{0,6}$/;
	return re.test(price);
}

function validateSpace(str) {
	var re = /^\s+$/;
	return re.test(str);
}

$(document).ready(function() {
	$("#foodName").click(function() {
		$("#msgNameFNull").css("visibility", "hidden");
	});
	$("#foodPrice").click(function() {
		$("#msgPriceFall").css("visibility", "hidden");
	});
	$("#foodTypeNew").click(function() {
		$("#msgNameFTNull").css("visibility", "hidden");
	});
	$("#detailFoodName").click(function() {
		$("#msgNameFNullD").css("visibility", "hidden");
	});
	$("#detailFoodPrice").click(function() {
		$("#msgPriceFallD").css("visibility", "hidden");
	});
	$("#detailFoodTypeName").click(function() {
		$("#msgNameFTNullD").css("visibility", "hidden");
	});
});

function valiFoodTypeName() {
	if (($("#foodTypeNew").val() == "")
			|| (validateSpace($("#foodTypeNew").val()))) {
		$("#msgNameFTNull").css("visibility", "visible");
	} else {
		var x = document.getElementsByName("foodTypeNameElm");
		var i = 0;
		var find = false;
		while ((i < x.length) && (!find)) {
			if ($("#foodTypeNew").val().trim() == x[i].value) {
				find = true;
			}
			i++;
		}
		if (find) {
			$("#foodTypeNameHeadExist").html($("#foodTypeNew").val());
			$("#exists-food-type-mode").modal();
		} else {
			$("#foodTypeNameHead").html($("#foodTypeNew").val());
			$("#add-success-food-type-mode").modal();
			setTimeout(function() {
				$("#addFoodTypeForm").submit();
			}, 2000);
		}
	}
}

function validateFoodD() {
	var test = true;
	if (($("#detailFoodName").val() == "")
			|| (validateSpace($("#detailFoodName").val()))) {
		$("#msgNameFNullD").css("visibility", "visible");
		test = false;
	}
	if (!validatePrice($("#detailFoodPrice").val())) {
		$("#msgPriceFallD").css("visibility", "visible");
		test = false;
	}
	if (test) {
		var x = document.getElementsByName("foodNameElm");
		var i = 0;
		var find = false;
		while ((i < x.length) && (!find)) {
			if (($("#detailFoodName").val().trim() == x[i].value)
					&& ($("#foodName" + $("#updateFoodId").val()).val().trim() != x[i].value)) {
				find = true;
			}
			i++;
		}
		if (find) {
			$("#foodNameHeadExist").html($("#detailFoodName").val());
			$("#exists-food-mode").modal();
		} else {
			$("#foodNameHead").html($("#foodName").val());
			$("#success-food-save-mode").modal();
			setTimeout(function() {
				$("#updateFoodForm").submit();
			}, 2000);
		}
	}
}

function validateFoodTypeName() {
	if (($("#detailFoodTypeName").val() == "")
			|| (validateSpace($("#detailFoodTypeName").val()))) {
		$("#msgNameFTNullD").css("visibility", "visible");
	} else {
		var x = document.getElementsByName("foodTypeNameElm");
		var i = 0;
		var find = false;
		while ((i < x.length) && (!find)) {
			if (($("#detailFoodTypeName").val().trim() == x[i].value)
					&& ($("#foodTypeNewName" + $("#updateFoodTypeId").val()).val().trim() != x[i].value)) {
				find = true;
			}
			i++;
		}
		if (find) {
			$("#foodTypeNameHeadExist").html($("#detailFoodTypeName").val());
			$("#exists-food-type-mode").modal();
		} else {
			$("#success-food-save-mode").modal();
			setTimeout(function() {
				$("#updateFoodTypeM").submit();
			}, 2000);
		}
	}
}
