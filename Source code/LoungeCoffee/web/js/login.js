// Show modal to choose mode when shop-manager logged successful
function showLoginModeDialog() {
    $("#login-mode").modal();
}

$(document).ready(function(){
    // disable auto save login information for more security
    $('#login-form').attr('autocomplete', 'off');
    $("#inp-login-shopID").attr('autocomplete', 'off');
    $("#inp-login-shopPassword").attr('autocomplete', 'off');

    // add place holder for input
    $("#inp-login-shopID").attr('placeholder', "Tên đăng nhập");
    $("#inp-login-shopPassword").attr('placeholder', "Mật khẩu");
});

// Show error message when login fail
function showLoginErrorMessage() {
    $("#login-error-message").css("display", "block");
}