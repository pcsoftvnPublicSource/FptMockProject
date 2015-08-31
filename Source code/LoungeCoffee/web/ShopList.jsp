<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.0

Date: 26 Aug 2015

Copyright (c) 2015, name

Describe:

Modification Logs:
DATE			     AUTHOR				DESCRIBE
-------------------------------------------------------------------------------
22 Aug 2015          DuyLN				Created

--%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quản lý cửa hàng</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript" ></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<script src="js/shop.list.js" type="text/javascript" charset="UTF-8"></script>
</head>

<body>
    <div class="header">
        <div class="logo"><img alt="Lounge Coffee Logo" src="img/logo.png"></div>

        <div class="menu">
            <ul class="nav navbar-nav">
                <!-- Menu thống kê -->
                <li class="dropdown" id="menu">
                    <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Báo cáo - Thống kê <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><html:link action="/statistic-sale-init">Thống kê bán hàng</html:link> </li>
                        <li><html:link action="/ware-housing-show-shop">Hóa đơn nhập kho</html:link></li>
                    </ul>
                </li>

                <li><html:link action="/food">Quản lý thực đơn</html:link></li>

                <li><html:link action="/ingredient">Quản lý nguyên liệu</html:link></li>

                <li><html:link action="/shop-list-show-shop-list">Quản lý cửa hàng</html:link></li>

                <li><html:link action="/logout">Đăng xuất</html:link></li>
            </ul>
        </div>
        <div class="clear-float"></div>
    </div>

    <!-- Container -->
	<div class="container">
		<div class="page-title">Quản lý cửa hàng</div>

        <!-- Above part -->
        <div class="row">
            <html:form action="/shop-list-add-shop" styleId="form-shop-add" acceptCharset="UTF-8">

                <!-- Left part -->
                <div class="col-md-5">
                    <div class="row form-group">
                        <label>Mã cửa hàng <span class="request-field">*</span></label>
                        <html:text property="shopID" styleClass="form-control" styleId="inp-shop-id-add"
                            onblur="checkShopID();" value="" tabindex="1" />
                    </div>

                    <div class="row form-group">
                        <label>Tên cửa hàng <span class="request-field">*</span></label>
                        <html:text property="shopName" styleClass="form-control"
                            value=""  styleId="inp-shop-name-add" tabindex="2"/>
                    </div>

                    <div class="row form-group">
                        <label>Địa chỉ cửa hàng <span class="request-field">*</span></label>
                        <html:text property="shopAddress" styleClass="form-control"
                            value="" styleId="inp-shop-address-add" tabindex="3"/>
                    </div>

                    <div class='row form-group'>
                        <label>Số điện thoại cửa hàng <span class="request-field">*</span></label>
                        <html:text property="shopPhoneNumber" styleClass="form-control"
                                styleId="inp-shop-phoneNumber-add" value="" tabindex="4"/>
                    </div>

                </div> <!-- left part -->


                <!-- Right part -->
                <div class="col-md-5 col-md-offset-1">
                    <div class="row form-group">
                        <label>Mật khẩu đăng nhập <span class="request-field">*</span></label>
                        <html:text property="shopPassword" styleClass="form-control"
                            styleId="inp-shop-password-add" value="" tabindex="5"/>
                    </div>

                    <div class="row form-group">
                        <label>Tên nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text property="managerName" styleClass="form-control"
                            styleId="inp-shop-managerName-add" value="" tabindex="6"/>
                    </div>

                    <div class="row form-group">
                        <label>Địa chỉ nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text property="managerAddress" styleClass="form-control"
                            styleId="inp-shop-managerAddress-add" value="" tabindex="7"/>
                    </div>

                    <div class="row form-group">
                        <label>Số điện thoại nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text property="managerPhoneNumber" styleClass="form-control"
                            styleId="inp-shop-managerPhoneNumber-add" value="" tabindex="8"/>
                    </div>

                </div> <!-- right part -->

                <div class="row">
                     <html:button styleClass="col-md-1 col-md-offset-1 btn btn-danger style-button"  property="action" styleId="btn-Add"
                        value="Thêm mới"  onclick="validateFormAdd()" tabindex="9"/>

                    <html:reset styleClass="col-md-1 col-md-offset-1 btn btn-default style-button" value="Hủy bỏ" tabindex="10"/>
                </div>

            </html:form>

        </div> <!-- above part -->


		<!--Bellow part-->
		<div class="row" style="margin-top: 20px;">
            <h3 style="margin-bottom: 20px; font-weight: 300;">Danh sách cửa hàng</h3>

			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>Tên cửa hàng</th>
						<th>Địa chỉ cửa hàng</th>
						<th>Điên thoại cửa hàng</th>
						<th></th>
					</tr>
				</thead>

                <tbody>
					<logic:notEmpty name="shopListForm" property="shopList">
						<logic:iterate name="shopListForm" property="shopList" id="shop">
							<tr>
								<bean:define id="obj" name="shop" />
								<td><bean:write name="obj" property="shopID" /></td>
								<td><bean:write name="obj" property="shopName" /></td>
								<td><bean:write name="obj" property="shopAddress" /></td>
								<td><bean:write name="obj" property="shopPhoneNumber" /></td>
								<td>
                                    <bean:define id="mpl" name="obj" property="shopID" />
									<a class="btn btn-link" onclick="shopShowDetail('${mpl}');"> Chi tiết </a> |
                                    <a class="btn btn-link" onclick="deleteShop('${mpl}')">Xóa</a>
                                </td>
							</tr>
						</logic:iterate>
					</logic:notEmpty>
				</tbody>
			</table>
		</div> <!--bellow part-->

		<!--Form use to update shop  -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
				</button>

                <div class="page-sub-title">Cập nhật thông tin cửa hàng</div>
            </div>

            <div class="modal-body" >
                <html:form action="/shop-list-update-shop" acceptCharset="UTF-8" styleId="form-shop-update" method="post">
                    <div class="form-group">
                        <label>Mã cửa hàng</label>
                        <html:text styleId="inp-shop-id-update" property="shopID" styleClass="form-control" readonly="true"/>
                    </div>

                    <div class="form-group">
                        <label>Tên cửa hàng <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-name-update" property="shopName" styleClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ cửa hàng <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-address-update" property="shopAddress" styleClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Điện thoại cửa hàng <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-phoneNumber-update" property="shopPhoneNumber" styleClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Tên nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-managerName-update" property="managerName" styleClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-managerAddress-update" property="managerAddress" styleClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại nhân viên quản lý <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-managerPhoneNumber-update" property="managerPhoneNumber" styleClass="form-control"/>
                    </div>

                     <div class="form-group">
                        <label>Mật khẩu đăng nhập <span class="request-field">*</span></label>
                        <html:text styleId="inp-shop-password-update" property="shopPassword" styleClass="form-control"/>
                    </div>

                </html:form>
            </div>

            <div class="modal-footer">
                <div class="form-inline">
                    <html:button property="" styleClass="btn btn-default style-button" value="Hủy" onclick="closeModal();"/>

                    <html:button styleClass="btn btn-default style-button" property="action" onclick="validateFormUpdate();" value="Lưu"/>
                </div>
            </div>

        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


		<!--Form use to delete shop  -->
		<div class="modal fade" id="myModalDelete" role="dialog">
		<div class="modal-dialog">
		<div class="modal-content">
		    <div class="modal-header">
                <div class="page-sub-title">Xóa thông tin cửa hàng</div>
            </div>

            <div class="modal-body">
                Xóa thông tin cửa hàng: <span id="shop-id" class="confirm-delete"></span> <br>
                Bạn có thực sự muốn xóa? Thao tác này không thể hoàn tác.
			</div>

			<div class="modal-footer">
				<html:form action="/shop-list-delete-shop">
			        <button type="button" class="btn btn-danger style-button" data-dismiss="modal">Huỷ</button>
				    <html:hidden styleId="deleteShopID" property="shopID" />
					<html:submit styleClass="btn btn-danger style-button">Xoá</html:submit>
				</html:form>
			</div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

		<!--Show alert error validate  -->
		<div id="error" class="modal alert">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
			    <div class="alert alert-dismissible alert-danger">
				    <strong>Thông báo!</strong> Vui lòng kiểm tra lại tất cả thông tin đã nhập.
			    </div>
		    </div>
		</div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


		<!--Show alert to notice shopID is valid  -->
		<div id="errorID" class="modal alert">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-dismissible alert-danger">
    				<strong>Thông báo!</strong> Mã cửa hàng này đã được sử dụng! Vui lòng chọn mã cửa hàng khác.
				</div>
			</div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

		<!--Show alert when a new shop doesn't add success  -->
		<div id="error-add-shop" class="modal">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-dismissible alert-danger">
					<strong>Thông báo!</strong> Thêm không thành công, vui lòng thử lại.
				</div>
			</div>
		</div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


		<!--Show alert when a new shop add success  -->
		<div id="success-add-shop" class="modal">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-dismissible alert-success">
					<strong>Thông báo!</strong> Thêm mới thành công.
				</div>
			</div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


		<!--Show alert when a shop doesn't update success  -->
		<div id="error-update-shopt" class="modal">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-dismissible alert-danger">
					<strong>Thông báo!</strong> Cập nhật không thành công, vui lòng thử lại.
				</div>
			</div>
		</div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


		<!--Show alert when a shop update success  -->
		<div id="success-update-shop" class="modal">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-dismissible alert-success">
					<strong>Thông báo! </strong> Cập nhật thành công.
				</div>
			</div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

    </div>  <!-- Container -->
</body>
</html>