<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.4

Date: Aug 21, 2015

Copyright (c) 2015, name

Describe: Sale screen, this screen is logged by shop manager and used by employee
          Function:
            + User can choose foods in category to add them to orders list
            + Remove added food from orders list
            + Calculate excess cash
            + Complete orders with one click

Modification Logs:
DATE			AUTHOR				DESCRIBE
-------------------------------------------------------------------------------
Aug 21, 2015    AnhCT				Created
Aug 22, 2015    AnhCT               Complete main action
Aug 23, 2015    AnhCT               Re-write all, using ajax to avoid reload all page
Aug 24, 2015    AnhCT               Add style-sheet to page and complete

--%>


<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lounge Coffee Management System</title>

<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<script src="js/sale.js" type="text/javascript"></script>
</head>
<body>
    <div class="login-logo">
        <img alt="logo" src="img/loginLogo.png" />
    </div>

    <div class="container">
        <!-- Left part -->
        <div class="col-md-5" >

            <!-- Category list -->
            <div class="row">
                <html:select name="saleForm" property="foodTypeID"
                    styleId="dpr-sale-food-type" styleClass="form-control">

                    <html:option value="0">Tất cả loại món</html:option>

                    <html:optionsCollection name="saleForm"
                        property="listFoodType" value="foodTypeID"
                        label="foodTypeName" />

                </html:select>
            </div>
            <!-- Category list -->

            <!-- Foods in category -->
            <div class="row">
                <h5>Danh sách món</h5>

                <!-- scrolling table -->
                <div class="scrollable-area-sale-food scrollable-table">
                    <table id="tbl-sale-food" class="table table-striped table-hover tbl-sticky-header">
                        <thead>
                            <tr>
                                <th>Tên món</th>
                                <th id="th-sale-orders-quantity">Số lượng</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                            <logic:notEmpty name="saleForm" property="listFood">
                                <logic:iterate name="saleForm" property="listFood"
                                    id="food">

                                    <bean:define name="food" property="foodID"
                                        id="foodID2" />

                                    <tr>
                                        <td><bean:write name="food"
                                                property="foodName" /></td>

                                        <td><html:text name="saleForm"
                                                property="ordersQuantity"
                                                styleId="inp-sale-add-food-${foodID2 }"
                                                styleClass="inp-sale-add-food form-control"
                                                onfocus="saleGetQuantity(${foodID2 })"/></td>

                                        <td><a href="#"
                                            onclick="saleAddFood(${foodID2})"
                                            class="btn btn-link">Thêm</a></td>
                                    </tr>
                                </logic:iterate>
                            </logic:notEmpty>
                        </tbody>

                    </table>
                </div>
                <!-- scrolling table -->

            </div>
            <!-- Foods in category -->

        </div>
        <!-- Left part -->

        <!-- Right part -->
        <div class="col-md-5 col-md-offset-2">

            <!-- Current orders detail -->
            <div class="row">
                <h5>Hóa đơn hiện tại</h5>

                <!-- scrolling table -->
                <div class="scrollable-area-sale-orders scrollable-table">
                    <table id="tbl-sale-orders" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Tên món</th>
                                <th>Số lượng</th>
                                <th>Đơn giá</th>
                                <th>Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                        </tbody>
                    </table>
                </div>
                <!-- scrolling table -->

            </div>
            <!-- Current orders detail -->


            <!-- Current ordes amount -->
            <div class="row sale-orders-amount">
                <div style="float: left;">TỔNG TIỀN HIỆN TẠI: </div>
                <div style="float: left; margin-left: 20px;"><p id="par-sale-orders-amount">0</p></div>
            </div>
            <!-- Current orders amount -->


            <!-- Excess cash -->
            <div class="row">
                <h5>Tính tiền</h5>

                <div class="form-group">
                    <input type="text" id="inp-sale-input-cash" class="form-control" placeholder="Số tiền khách đưa"/>
                </div>

                <div class="form-group">
                    <button type="button" class="btn btn-danger style-button"
                        aria-label="Left Align" id="btn-sale-cal-cash"
                        onclick="saleCalCash();">

                        <span class="glyphicon glyphicon-usd"
                            aria-hidden="true"></span>

                        Tính tiền
                    </button>
                </div>

                <div class="form-group">
                    <input type="text" id="inp-sale-out-cash" readonly="readonly" class="form-control" placeholder="Số tiền trả lại">
                </div>
            </div>
            <!-- Excess cash -->

            <!-- Complete orders -->
            <div class="row">
                <h5>Xác nhận thanh toán</h5>
                <hr>
                <!-- Complete order -->
                <button class="btn btn-danger style-button" id="btn-sale-complete-orders" onclick="saleCompleteOrder();">Hoàn tất</button>

                <div class="alert alert-dismissible alert-danger sale-alert" id="alert-sale-complete-fail">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <b>Lỗi!</b> Đơn hàng hiện tại đang trống.
                </div>

                <div class="alert alert-dismissible alert-danger sale-alert" id="alert-sale-complete-success">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <b>Thành công!</b> Đã hoàn tất hóa đơn.
                </div>
            </div>
            <!-- Complete orders -->

        </div>
        <!-- Right part -->

        <!-- input temp for number input modal -->
        <input type="hidden" id="inp-num-modal-temp" />

        <!-- MODAL -->
        <div class="modal fade" id="mod-number-input" tabindex="-1" role="dialog" >
            <div class="modal-dialog modal-sm">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Nhập số lượng</h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group" class="inp-cal-value">
                            <input type="text" class="form-control" id="inp-cal-value" />
                        </div>

                        <div class="mod-calculator-button" style="margin-left: 30px;">
                            <button class="btn btn-number">1</button>
                            <button class="btn btn-number">2</button>
                            <button class="btn btn-number">3</button>
                            <br><br>
                            <button class="btn btn-number">4</button>
                            <button class="btn btn-number">5</button>
                            <button class="btn btn-number">6</button>
                            <br><br>
                            <button class="btn btn-number">7</button>
                            <button class="btn btn-number">8</button>
                            <button class="btn btn-number">9</button>
                            <br><br>
                            <button class="btn btn-number">0</button>
                            <button class="btn btn-number">00</button>
                            <button class="btn btn-number">CE</button>
                            <br>
                        </div>

                    </div>
                    <!-- Modal body -->

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="saleHideModal();">Xong</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- MODAL -->

    </div>
    <!-- container -->
</body>

<footer>
    <div class="copyright">
        Copyright (c) 2015 <span class="author">Lounge Coffee</span>. Designed
        and Developed by <span class="author">Team 6th-SVTT072015</span>.
    </div>
</footer>
</html>