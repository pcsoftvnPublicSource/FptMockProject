<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quản lý thực đơn</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<script src="js/food.js" charset="UTF-8" type="text/javascript"></script>
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
        <div class="page-title">Quản lý thực đơn</div>

        <div>  <!-- Add new food -->

            <html:form action="/add-food" method="post" acceptCharset="utf-8" styleId="addFoodForm">

                <div class="row"> <!-- row 1 -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Tên món <span class="request-field">*</span></label>
                            <html:text property="foodName" styleClass="form-control" styleId="foodName" />
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Chọn loại món <span class="request-field">*</span></label>
                            <html:select property="chooseFoodTypeId" styleClass="form-control">
                                <html:optionsCollection name="foodForm" property="foodTypeIdList"
                                    label="foodTypeName" value="foodTypeId" />
                            </html:select>
                        </div>
                    </div>
                </div> <!-- row 1 -->

                <div class="row"> <!-- row 2 -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Giá bán <span class="request-field">*</span></label>
                            <html:text property="foodPrice" styleClass="form-control" styleId="foodPrice"/>
                            <script> $("#foodPrice").focus(function(){$(this).val("");}); </script>
                        </div>
                    </div>

                    <div class="col-md-4 cal-md-offset-1" style="margin-top: 18px;">
                        <div class="form-group">
                            <label>Chú ý</label>
                            <p>Các trường <span class="request-field">*</span> là các trường bắt buộc phải nhập/chọn.</p>
                        </div>
                    </div>
                </div> <!-- row 2 -->

            </html:form> <!-- add form -->

            <div>
                <button class="btn btn-danger style-button" onclick="showMsgEFood();">Thêm món mới</button>
            </div>

         </div> <!-- Add new food -->

        <!-- Food list detail -->
        <html:form action="/food" method="post">
            <div class="row">
                <div class="col-md-4" style="margin-top: 20px;">
                    <html:text property="foodSearch" styleClass="form-control"
                        styleId="foodSearch" />
                    <script>$("#foodSearch").attr("placeholder", "Tìm kiếm")</script>
                </div>
            </div>
        </html:form>

            <div class="row" style="margin-top: 20px;">

                <!-- Detail table -->
                <div class="col-md-7 scrollable-area-food scrollable-table">
                    <table class="table table-striped table-hover tbl-sticky-header">
                        <thead>
                            <tr>
                                <th>Tên món</th>
                                <th>Loại món</th>
                                <th>Giá bán</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                            <logic:iterate name="foodForm" property="listFood"
                                id="food">
                                <tr>
                                    <bean:define id="foodId" name="food"
                                        property="foodId" />
                                    <bean:define id="foodName" name="food"
                                        property="foodName" />
                                    <bean:define id="foodType" name="food"
                                        property="foodType" />
                                    <bean:define id="foodPrice" name="food"
                                        property="foodPrice" />

                                    <input id="foodName${foodId}" value="${foodName}" type="hidden" name="foodNameElm" />
                                    <input id="foodType${foodId}" value="${foodType}" type="hidden" />
                                    <input id="foodPrice${foodId}" value="${foodPrice}" type="hidden" />

                                    <td><bean:write name="foodName" /></td>
                                    <td><bean:write name="foodType" /></td>
                                    <td><bean:write name="foodPrice" /></td>
                                    <td>
                                        <a onclick="updateFood(${foodId});" class="btn btn-link"> Chi tiết </a> <span> | </span>
                                        <a onclick="deleteFood(${foodId});" class="btn btn-link"> Xóa </a>
                                    </td>
                                </tr>
                            </logic:iterate>
                        </tbody>
                    </table>
                </div> <!-- detail table -->


                <!-- Food type table -->
                <div class="col-md-4 col-md-offset-1">
                    <h4 style="text-align: center; margin-bottom: 10px;">Quản lý loại món</h4>
                    <div class="row">
                        <html:form action="/add-food-type" styleId="addFoodTypeForm">
                            <div class="form-group">
                                <label>Tên loại món</label>
                                <html:text property="foodTypeNew" styleClass="form-control combWight" styleId="foodTypeNew"/>
                            </div>
                        </html:form>

                        <div class="form-group">
                            <button class="btn btn-danger style-button" onclick="valiFoodTypeName();">Thêm loại món</button>
                        </div>
                    </div>

                    <div class="row scrollable-area scrollable-table">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Loại món</th>
                                    <th></th>
                                </tr>
                            </thead>

                            <tbody>
                                <logic:iterate name="foodForm" property="listNewFoodType" id="foodTypeNew">
                                    <tr>
                                        <bean:define id="foodTypeNewId" name="foodTypeNew"
                                            property="foodTypeNewId"></bean:define>

                                        <bean:define id="foodTypeNewName" name="foodTypeNew"
                                            property="foodTypeNewName"></bean:define>

                                        <input id="foodTypeNewName${foodTypeNewId}" value="${foodTypeNewName}"
                                        type="hidden" name="foodTypeNameElm" />

                                        <td> <bean:write name="foodTypeNewName"/> </td>

                                        <td>
                                            <a onclick="updateFoodType(${foodTypeNewId});" class="btn btn-link"> Chi tiết</a> <span> | </span>
                                            <a onclick="deleteFoodType(${foodTypeNewId});" class="btn btn-link">Xóa</a>
                                        </td>
                                    </tr>
                                </logic:iterate>
                            </tbody>
                        </table>
                    </div>

                </div> <!-- food type table -->

            </div>

        <!-- Update food modal -->
        <div class="modal fade" id="detail-food-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="page-sub-title">Cập nhật thông tin món</div>
            </div>

            <div class="modal-body">
                <div style="margin-bottom: 10px;"> <span class="request-field">*</span> Thông tin bắt buộc</div>

                <div>
                    <html:form action="/update-food" method="post" acceptCharset="utf-8" styleId="updateFoodForm">
                        <div class="form-group">
                            <label>Nhập tên món <span class="request-field">*</span> </label>
                            <html:text styleId="detailFoodName" property="detailFoodName" styleClass="form-control boxWight"/>
                        </div>

                        <div class="form-group">
                            <label>Chọn loại món <span class="request-field">*</span> </label>
                            <html:select styleId="detailChooseFoodType" property="detailChooseFoodType" styleClass="form-control">
                                <html:options  property="foodTypeList" />
                            </html:select>
                        </div>

                        <div class="form-group">
                            <label>Nhập giá bán <span class="request-field">*</span> </label>
                            <html:text styleId="detailFoodPrice"  property="detailFoodPrice" styleClass="form-control"/>
                        </div>

                        <html:hidden styleId="updateFoodId" property="updateFoodId" />
                    </html:form>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger style-button" data-dismiss="modal">Huỷ</button>
                <button class="btn btn-danger style-button" onclick="validateFoodD();">Lưu</button>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Update food type modal -->
        <div class="modal fade" id="detail-food-type-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="page-sub-title">Cập nhật loại món</div>
            </div>

            <div class="modal-body">
                <div>
                    <div style="margin-bottom: 10px;"> <span class="request-field">*</span> Thông tin bắt buộc</div>
                </div>

                <html:form action="/update-food-type" method="post" acceptCharset="utf-8" styleId="updateFoodTypeM">
                    <div class="form-group">
                        <label>Tên loại món <span class="request-field">*</span></label>
                        <html:text styleId="detailFoodTypeName" property="detailFoodTypeName" styleClass="form-control boxWight"/>
                    </div>

                    <html:hidden styleId="updateFoodTypeId" property="updateFoodTypeId" />

                </html:form>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger style-button" data-dismiss="modal">Huỷ</button>
                    <button class="btn btn-danger style-button" onclick="validateFoodTypeName();">Lưu</button>
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

        <!-- Delete food modal -->
        <div class="modal fade" id="delete-food-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header">
                <div class="page-sub-title">Xóa thông tin món</div>
            </div>

            <div class="modal-body">
                Xóa món: <span id="foodNameHeadDelete" class="confirm-delete"></span> <br>
                Bạn có thực sự muốn xóa? Thao tác này không thể hoàn tác.
            </div>

            <div class="modal-footer">
                <html:form action="/delete-food" styleClass="form-inline">
                    <html:hidden styleId="deleteFoodId" property="deleteFoodId" />
                    <button type="button" class="btn btn-danger style-button" data-dismiss="modal"> Huỷ </button>
                    <html:submit styleClass="btn btn-danger style-button">Xoá</html:submit>
                </html:form>
            </div>

        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Delete food type modal -->
        <div class="modal fade" id="delete-food-type-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="page-sub-title">Xóa loại món</div>
            </div>

            <div class="modal-body">
                Xóa loại món: <span id="foodTypeNameHeadDelete" class="confirm-delete"></span> <br>
                Bạn có thực sự muốn xóa? Thao tác này không thể hoàn tác.
            </div>

            <div class="modal-footer">
                <html:form action="/delete-food-type" styleClass="form-inline">
                    <html:hidden styleId="deleteFoodTypeId" property="deleteFoodTypeId" />
                    <button type="button" class="btn btn-danger style-button" data-dismiss="modal">Huỷ</button>
                    <html:submit styleClass="btn btn-danger style-button">Xoá</html:submit>
                </html:form>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Add new food success -->
        <div class="modal fade" id="add-success-food-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Đã thêm thành công món mới.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Update food success -->
        <div class="modal fade" id="success-food-save-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Đã cập nhật thành công thông tin món.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

        <!-- Add new food type success -->
        <div class="modal fade" id="add-success-food-type-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Đã thêm thành công loại món mới.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

        <!-- Duplicate food name -->
        <div class="modal fade" id="exists-food-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-danger">
                    Tên món <span id="foodNameHeadExist" class="confirm-delete"></span> bị trùng. <br>
                    Vui lòng chọn một tên khác hoặc xóa/sửa tên cũ trong hệ thống.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->


        <!-- Duplicate food type name -->
        <div class="modal fade" id="exists-food-type-mode" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-danger">
                    Tên món <span id="foodTypeNameHeadExist" class="confirm-delete"></span> bị trùng. <br>
                    Vui lòng chọn một tên khác hoặc xóa/sửa tên cũ trong hệ thống.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->

    </div> <!-- container -->
</body>
</html>