<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thống kê bán hàng</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href="plugin/datepicker/datepicker.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/datepicker/bootstrap-datepicker.js" type="text/javascript" ></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript" ></script>
<script src="plugin/Chart.min.js" type="text/javascript" ></script>
<script src="js/script.js" type="text/javascript" ></script>
<script src="js/statistic-sale.js" type="text/javascript" ></script>
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

        <!-- Left part -->
        <div class="col-md-6">
            <!-- Shop selection -->
            <div class="row form-group">
                <label>Chọn cửa hàng để xem chi tiết</label>
                <html:select name="statisticSaleForm" property="shopID"
                    styleClass="form-control" styleId="dpr-stc-sale-shop-id">
                    <html:option value="0">Lựa chọn cửa hàng</html:option>
                    <html:optionsCollection name="statisticSaleForm" property="listShop"
                        value="shopID" label="shopName" />
                 </html:select>
            </div> <!-- shop selection -->

            <!-- Date chooser -->
            <div class="row form-group">
                <div class="row">
                    <label style="margin-left: 18px;">Chọn khoảng ngày thống kê</label>
                </div>


                <!-- Start datde -->
                <div class="col-md-4 input-group" style="float:left;">
                    <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                    <input type="text" class="form-control" id="inp-stc-sale-start-date" readonly="readonly">
                </div> <!-- start datde -->

                <div class="col-md-2" style="text-align: center; margin-top: 12px;"><b>đến</b></div>

                <!-- End datde -->
                <div class="col-md-4 input-group" style="float:left;">
                    <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                    <input type="text" class="form-control" id="inp-stc-sale-end-date" readonly="readonly">
                </div> <!-- end datde -->
            </div> <!-- Date chooser -->

            <div class="row" style="margin-top: 20px;">
                 <button class="btn btn-danger style-button" onclick="getAllShopSaleData();">Xem biểu đồ</button>
                 <button class="btn btn-danger style-button" onclick="getShopSaleData();">Xem báo cáo chi tiết</button>
            </div>

            <!-- Chart -->
            <div class="row" style="margin-top: 50px;">
                <canvas id="canvas-stc-sale-bar"></canvas>
            </div> <!-- chart -->

        </div> <!-- left part -->


        <!-- Right part -->
        <div class="col-md-5 col-md-offset-1">
             <!-- Detail table -->
            <div class="scrollable-table">
                <table id="tbl-stc-sale-detail" class="table table-striped table-hover tbl-sticky-header">
                    <thead>
                        <tr>
                            <td><b>Tên món</b></td>
                            <td><b>Số lượng bán</b></td>
                            <td><b>Tổng tiền</b></td>
                        </tr>
                    </thead>

                    <tbody>
                    </tbody>
                </table>
            </div>  <!-- detail table -->
        </div>

    </div> <!-- container -->

</body>
</html>