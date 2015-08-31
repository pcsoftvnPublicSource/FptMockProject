<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>


<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Quản lý nguyên liệu</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js"  type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" charset="UTF-8" type="text/javascript"></script>
<script src="js/ingredient.js" charset="UTF-8" type="text/javascript"></script>
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
        <div class="page-title">Quản lý nguyên liệu</div>

        <!-- Left part -->
        <div class="col-md-6">

            <!-- Add new ingerdient -->
            <div class="row">
                <html:form action="/add-ingredient" method="post" acceptCharset="utf-8" styleId="formAddIngredient">
                    <div class="form-group">
                        <label>Tên nguyên liệu <span class="request-field">*</span> </label>
                        <html:text property="ingredientName" styleClass="form-control boxWight" styleId="ingNameNew" />
                    </div>

                    <div class="form-group">
                        <label>Chọn đơn vị tính <span class="request-field">*</span> </label>
                        <html:select property="chooseIngUnit" styleClass="form-control combWight">
                            <html:options property="ingUnitList" />
                        </html:select>
                    </div>
                </html:form>
            </div>

            <div class="row">
                <div class="form-group">
                    <p>
                        <b>Lưu ý:</b> Các trường <span class="request-field">*</span> là các
                        trường bắt buộc phải nhập/chọn.
                    </p>
                </div>
            </div>

            <div class="row">
                <button class="col-md-3 btn btn-danger style-button" onclick="valiIngName();">THÊM</button>
            </div>

            <html:form action="/ingredient" method="post">
                <div class="row" style="margin: 20px 0;">
                    <html:text property="ingredientSearch" styleClass="form-control" styleId="ingredientSearch"/>
                    <script> $("#ingredientSearch").attr("placeholder", "Tìm kiếm tên nguyên liệu") </script>
                </div>

                <div class="row scrollable-area-ingredient scrollable-table">
                    <table class="table table-striped table-hover tbl-sticky-header">
                        <thead>
                            <tr>
                                <th>Tên nguyên liệu</th>
                                <th>Đơn vị tính</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                            <logic:iterate name="ingredientForm" property="listIngredient" id="ingredient">
                                <tr>
                                    <bean:define id="ingId" name="ingredient"
                                        property="ingredientId"></bean:define>

                                    <bean:define id="ingName" name="ingredient"
                                        property="ingredientName"></bean:define>

                                    <bean:define id="ingUnit" name="ingredient"
                                        property="ingredientUnit"></bean:define>

                                    <input id="ingName${ingId}" value="${ingName}" type="hidden"  name="ingElm"/>
                                    <input id="ingUnit${ingId}" value="${ingUnit}" type="hidden"/>

                                    <td><bean:write name="ingName" /></td>
                                    <td><bean:write name="ingUnit" /></td>
                                    <td>
                                        <a onclick="updateIngredient(${ingId});" class="btn btn-link"> Chi tiết</a> <span> | </span>
                                        <a onclick="deleteIngredient(${ingId});" class="btn btn-link"> Xóa </a>
                                    </td>
                                </tr>
                            </logic:iterate>
                        </tbody>
                    </table>
                    <html:hidden property="listIngLeng" styleId="listIngLeng" />
                </div>
            </html:form>

        </div> <!-- left part -->


        <!-- Update ingredient modal -->
        <div class="modal fade" id="detail-ingredient-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="page-sub-title">Cập nhật thông tin nguyên liệu</div>
            </div>

            <div class="modal-body">
                <div style="margin-bottom: 10px;"> <span class="request-field">*</span> Thông tin bắt buộc</div>

                <html:form action="/update-ingredient" method="post" acceptCharset="utf-8" styleId="formAddIngredientM">
                    <div class="form-group">
                        <label>Tên nguyên liệu <span class="request-field">*</span> </label>
                        <html:text styleId="detailIngredientName" property="detailIngredientName" styleClass="form-control boxWight"/>
                    </div>

                    <div class="form-group">
                        <label>Chọn đơn vị tính <span class="request-field">*</span> </label>
                        <html:select styleId="detailChooseIngUnit" property="detailChooseIngUnit" styleClass="form-control combWight">
                            <html:options property="ingUnitList" />
                        </html:select>
                        <html:hidden styleId="updateIngId" property="updateIngredientId" />
                    </div>
                </html:form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger style-button" data-dismiss="modal">Huỷ</button>
                <button class="btn btn-danger style-button" value="Lưu" onclick="valiIngDetail();">Lưu</button>
            </div>

        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Delete ingredient modal -->
        <div class="modal fade" id="delete-ingredient-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="page-sub-title">Xóa nguyên liệu</div>
            </div>

            <div class="modal-body">
                Xóa nguyên liệu: <span id="ingNameHeadDelete" class="confirm-delete"></span> <br>
                Bạn có thực sự muốn xóa? Thao tác này không thể hoàn tác.
            </div>

            <div class="modal-footer">
                <html:form action="/delete-ingredient" method="post" styleClass="form-inline">
                    <button type="button" class="btn btn-danger style-button" data-dismiss="modal"> Huỷ </button>
                    <html:submit styleClass="btn btn-danger style-button"> Xoá </html:submit>
                    <html:hidden styleId="deleteIngId" property="deleteIngredientId" />
                </html:form>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Add new ingredient success -->
        <div class="modal fade" id="add-success-ing-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Đã thêm thành công nguyên liệu mới.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Duplicate ingredient name -->
        <div class="modal fade" id="exists-ing-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    Tên nguyên liệu <span id="ingNameHeadExist" class="confirm-delete"></span> bị trùng. <br>
                    Vui lòng chọn một tên khác hoặc xóa/sửa tên cũ trong hệ thống.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

        <!-- Update ingredient success -->
        <div class="modal fade" id="save-success-ing-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Đã cập nhật thành công thông tin nguyên liệu.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

    </div> <!-- container -->

</body>
</html>