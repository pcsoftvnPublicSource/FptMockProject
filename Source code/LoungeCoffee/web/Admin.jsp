<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.0

Date: Aug 19, 2015

Copyright (c) 2015, name

Describe: Admin page

Modification Logs:
DATE                 AUTHOR                DESCRIBE
-------------------------------------------------------------------------------
Aug 19, 2015         AnhCT                Created

--%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang quản trị</title>
<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
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

    <div class="container">
        <div class="col-md-8 col-md-offset-2">
            <h3 style="text-align: center; font-weight: 300; color: #ea1d24;">
            HỆ THỐNG QUẢN LÝ CHUỖI CỬA HÀNG LOUNGE COFFEE
            </h3>

            <div style="margin-top: 30px;">
                <p style="font-size: 16px; font-weight: 300">
                    Xin chào! Đây là trang quản lý của Lounge Coffee <br>
                </p>

                <p>
                   Bắt đầu công việc của bạn bằng menu chức năng ở phía trên bên phải của màn hình. <br>
                   @ Menu <b>Báo cáo - Thống kê</b> cho phép bạn xem thông tin về nguyên liệu tại các cửa hàng, thống kê
                   doanh thu và xem tất cả các hóa đơn nhập kho của mỗi cửa hàng.<br>
                   @ Menu <b>Quản lý thực đơn</b> cho phép bạn quản lý các mặt hàng mà công ty đang kinh doanh.<br>
                   @ Menu <b>Quản lý nguyên liệu</b> cho phép bạn quản lý các loại nguyên liệu để chế biến thành các mặt hàng<br>
                   @ Menu <b>Quản lý cửa hàng</b> cho phép bạn quản lý các thông tin về các cửa hàng, bao gồm cả tài khoản
                   đăng nhập vào hệ thống.
                </p>

                <p style="margin-top: 20px; font-style: italic;">
                    <b>Chú ý quan trọng:</b>
                    Để bảo đảm an toàn thông tin, vui lòng click "Đăng xuất" hoặc đóng cửa sổ trình duyệt sau khi sử dụng.
                    Các thay đổi trong hệ thống diễn ra vào lúc các giao dịch đang được thực hiện có thể xảy ra lỗi hệ
                    thống nghiêm trọng. Hãy thực hiện thay đổi khi không có bất cứ cửa hàng nào đăng nhập vào hệ thống.
                </p>

            </div>
        </div>
    </div>
</body>


<footer>
    <div class="copyright">
        Copyright (c) 2015 <span class="author">Lounge Coffee</span>.
        Designed and Developed by <span class="author">Team 6th-SVTT072015</span>.
    </div>
</footer>
</html>