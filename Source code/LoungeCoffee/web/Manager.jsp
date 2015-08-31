<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nhân viên quản lý</title>

<link href="./css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="./css/style.css" rel="stylesheet" type="text/css">

<script src="./js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
</head>


<body>
	<div class="header">
        <div class="logo"><img alt="Lounge Coffee Logo" src="img/logo.png"></div>

        <div class="menu">
            <ul class="nav navbar-nav">
                <li><html:link action="/shop-ingredient-cs">Báo cáo tiêu thụ nguyên liệu</html:link></li>
                <li><html:link action="/ware-housing-show">Nhập kho</html:link></li>
                <li><html:link action="/logout">Đăng xuất</html:link></li>
            </ul>
        </div>
        <div class="clear-float"></div>
    </div>
    
    
    <!-- Containner -->
    <div class="container">
        <div class="col-md-8 col-md-offset-2">
            <h3 style="text-align: center; font-weight: 300; color: #ea1d24;">
                HỆ THỐNG QUẢN LÝ CHUỖI CỬA HÀNG LOUNGE COFFEE
            </h3>
            
            <div style="margin-top: 30px;">
                <p style="font-weight: 300; font-size: 16px;">
                    <b>Hướng dẫn nhanh</b>
                </p>
                
                <p>
                    <b>Báo cáo nguyên liệu tiêu thụ</b> <br>
                    Nhập thông tin về lượng nguyên liệu tiêu thụ trong ngày vào hệ thống để người quản lý cấp cao có thể nắm
                    bắt được tình hình của cửa hàng. 
                </p>
                
                <p>
                    <b>Nhập kho</b> <br>
                    Tạo một hóa đơn nhập kho khi cửa hàng nhận được nguyên liệu do người quản lý cung cấp để thực hiện
                    quản lý, so sánh, đối chiếu.
                    
                </p>
                
                <p style="margin-top: 20px; font-style: italic;">
                    Đây là trang dành cho nhân viên quản lý tại cửa hàng (chi nhánh). Vui lòng click "Đăng xuất" hoặc đóng
                    cửa sổ trình duyệt sau khi sử dụng.
                </p>
                
            </div>
        </div>
        
    </div> <!-- container -->
</body>


<footer>
    <div class="copyright">
        Copyright (c) 2015 <span class="author">Lounge Coffee</span>.
        Designed and Developed by <span class="author">Team 6th-SVTT072015</span>.
    </div>
</footer>
</html>