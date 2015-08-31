<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.0

Date: 21 Aug 2015

Copyright (c) 2015, name

Describe:

Modification Logs:
DATE                AUTHOR                  DESCRIBE
-------------------------------------------------------------------------------
21 Aug 2015         DuyLN                   Created
22 Aug 2015         DuyLN                   Boostrap
23 Aug 2015         DuyLN                   JavaScript,Ajax
21 Aug 2015         DuyLN                   Complete
--%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nhập kho</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href="plugin/datepicker/datepicker.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<script src="js/ware.housing.js" type="text/javascript" charset="UTF-8"></script>
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
    
    <!-- Container -->
	<div class="container">
        <div class="page-title">HÓA ĐƠN NHẬP KHO</div>
        
		<html:form>
            <div class="row">
    			<div class="col-md-4">
                    <div class="form-group">
                        <label>Ngày lập hóa đơn</label>
                        <div class='input-group'>
                            <span class="input-group-addon" style="margin-top: 10px;"> 
                                <span class="glyphicon glyphicon-calendar"></span> 
                            </span>
                            
                            <html:text property="dateTime" styleClass="form-control text-input" styleId="datepicker" readonly="true" />
                        </div>
                    </div>
                </div>
            </div>
            
            <hr>
            
            <div class="row">
                <!-- Left part -->
                <div class="col-md-5">
                    <h4 style="font-weight: 300; margin-bottom: 20px;">Nhập chi tiết hóa đơn</h4>
                    
                    <div class="form-group">
                        <label>Chọn loại nguyên liệu</label>
                        
                        <html:select styleClass="form-control text-input" name="wareHousingForm" property="ingID" styleId="ingredientID" value="">
                            <html:optionsCollection name="wareHousingForm" property="ingredientList" label="ingName" value="ingID" />
                        </html:select>
                    </div>
                    
                    <div class="form-group">
                        <label>Số lượng nhập</label>
                        <html:text styleId="ingQuantity" styleClass="form-control" property="quantity"   value="0"
                            title="Giá trị nhập vào là một số nguyên và nhỏ hơn 100."/>
                        <script>$("#ingQuantity").focus(function(){$(this).val("")})</script>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá nhập kho</label>
                        <html:text styleId="ingPrice" property="price" styleClass="form-control" value="0"
                            title="Giá trị nhập vào là một số nguyên nhỏ hơn 1.000.000.000."/>
                        <script>$("#ingPrice").focus(function(){$(this).val("")})</script>
                    </div>
                    
                    <div class="form-group">
                        <html:button styleClass="btn btn-default style-button"
                            property="action" onclick="checkAndInsert();" value="Thêm vào hóa đơn"/>
                    </div>
                    
                </div> <!-- left part -->
                
                
                <!-- Right part -->
                <div class="col-md-6 col-md-offset-1">
                    <div class="row scrollable-area-tableIngredient scrollable-table">
                        <table id="tbl-Tmp-Import-Receipt" class="table table-striped table-hover tbl-sticky-header">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Nguyên liệu</th>
                                    <th>Đơn vị</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th></th>
                                </tr>
                            </thead>
                            
                            <tbody id="tbody">

                            </tbody>
                        </table>
                    </div>
                    
                    <div class="row" style="margin-top: 20px;">
                        <html:button styleClass="btn btn-default style-button" value="Hoàn tất nhập kho" 
                        onclick="insertImportReceipt();" property="them"/>
                    </div>
                    
                </div> <!-- right part -->
                
            </div>
		</html:form>
	
    </div> <!-- container -->

	<!--Show alert when date don't select  -->
	<div id="errorDate" class="modal alert">
    <div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-danger">
			     <b>Thông báo!</b> Bạn chưa chọn ngày lập hóa đơn!
			</div>
		</div>
	</div>
	</div>
	</div>

	<!--Show alert error validate  -->
	<div id="error" class="modal alert">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
	       	<div class="alert alert-dismissible alert-danger">
			     <b>Thông báo!</b>Hãy kiểm tra lại tất cả thông tin đã nhập!
			</div>
		</div>
	</div>
	</div>
	</div>

	<!--Show alert when import receipt doesn't add success  -->
	<div id="error-add-import-receipt" class="modal">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-danger">
				<b>Thông báo!</b> Thêm không thành công!
			</div>
		</div>
	</div>
	</div>
	</div>


	<!--Show alert when import receipt add success  -->
	<div id="success-add-import-receipt" class="modal">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-success">
				<b>Thông báo!</b> Thêm thành công!
			</div>
		</div>
	</div>
	</div>
	</div>

</body>

<footer></footer>
</html>