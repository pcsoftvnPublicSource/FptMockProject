function getListCS() {
	var x = document.getElementsByName("cs");
	var y = document.getElementsByName("csId");
	var i = 0;
	var s1 = "_";
	var s2 = "_";
	var allright = true;
	var allzero = true;
	while ((i < x.length)) {
		
		if ((x[i].value == "")
				|| (validateSpace(x[i].value)) || !validatePrice(x[i].value)) {
			allright = false;
		}
		
		if(x[i].value != "0"){
			allzero = false;
		}
		s1 += x[i].value + "_";
		s2 += y[i].value + "_";
		i++;
	}

	if ((allright) && (!allzero)) {
		$("#listSCS").val(s1);
		$("#listSCSId").val(s2);

		$("#input-success-cs-mode").modal();
		setTimeout(function() {
			$("#shopIngCSForm").submit();
		}, 2000);

	} else {
		$("#input-all-zero-mode").modal();
	}

}

function validateSpace(str) {
	var re = /^\s+$/;
	return re.test(str);
}

function validatePrice(price) {
	var re = /^[0-9][0-9]{0,6}$/;
	return re.test(price);
}