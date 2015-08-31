<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.0

Date: Aug 19, 2015

Copyright (c) 2015, AnhCT

Describe: Login page for all user

Modification Logs:
DATE			     AUTHOR				DESCRIBE
-------------------------------------------------------------------------------
Aug 19, 2015         AnhCT    			Created

--%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đăng nhập hệ thống</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/login.js" type="text/javascript"></script>
</head>


<body>
    <div class="login-bg">
        <div class="login-logo">
            <img alt="logo" src="img/loginLogo.png" />
        </div>

        <div class="container">
            <div id="login-form" class="col-md-4 col-md-offset-4">
                <html:form action="/login" styleId="frm-login">
                    <html:text property="shopID"
                        styleId="inp-login-shopID"
                        styleClass="form-control form-group" >
                        username
                    </html:text>

                    <html:password property="shopPassword"
                        styleId="inp-login-shopPassword"
                        styleClass="form-control form-group">
                        password
                    </html:password>

                    <html:submit styleId="btn-login-Login"
                        styleClass="btn btn-danger style-button form-group row col-md-4 col-md-offset-4">Đăng nhập</html:submit>
                </html:form>
            </div>
        </div>

        <!-- Show error message if logged-in not successful -->
        <div class="col-md-6 col-md-offset-3 alert alert-dismissible alert-danger"
            id="login-error-message">
            <button type="button" class="close" data-dismiss="alert">×</button>
            Đăng nhập không thành công! <br>
            Vui lòng kiểm tra lại tên đăng nhập và mật khẩu của bạn.
        </div>

        <logic:notEmpty name="permission" scope="session">
        <logic:equal name="permission" value="-1" scope="session">
            <script>
				showLoginErrorMessage();
			</script>
        </logic:equal>
        </logic:notEmpty>


        <div class="coffee-cup">
            <img alt="coffee" src="img/coffeeCup.png" width="100%" />
        </div>
    </div>


    <!-- Show modal dialog to choose login mode if Shop Manager is logged-in -->
    <div class="modal fade" id="login-mode" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="text-align: center;">Lựa chọn tài khoản</h4>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-6 col-xs-offset-3 col-md-3">
                            <html:link action="/sale-init"
                                styleClass="thumbnail">
                                <html:img src="img/employee.png"
                                    alt="Nhân viên bán hàng" />
                            </html:link>

                            <div class="caption">
                                <h6 style="text-align: center;">Nhân viên</h6>
                            </div>
                        </div>

                        <div class="col-xs-6 col-md-3">
                            <html:link forward="managerScreen"
                                styleClass="thumbnail">
                                <html:img src="img/manager.png"
                                    alt="Quản lý cửa hàng" />
                            </html:link>

                            <div class="caption">
                                <h6 style="text-align: center;">Quản lý</h6>
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </div>
    </div>

    <logic:equal name="permission" value="1" scope="session">
        <script>
			showLoginModeDialog();
		</script>
    </logic:equal>

</body>

<footer> </footer>
</html>