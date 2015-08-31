<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%--

Version: 1.0

Date: 22 Aug 2015

Copyright (c) 2015, name

Describe:

Modification Logs:
DATE			AUTHOR				DESCRIBE
-------------------------------------------------------------------------------
22 Aug 2015     DuyLN				Created

--%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lịch sử nhập kho</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href="plugin/datepicker/datepicker.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="plugin/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="plugin/jquery.stickytableheaders.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<script src="js/ware.housing.bill.js" type="text/javascript"></script>
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
        <div class="page-title">Lịch sử nhập kho các cửa hàng</div>
        
        <!-- Left part -->
        <div class="col-md-5">
            <html:form styleId="form-show-import-receipt" action="/ware-housing-bill-shop-receipt">
                <div class="row form-group">
                    <label>Lựa chọn cửa hàng</label>
                    <html:select property="shopID" value="0" name="wareHousingBillForm" styleClass="form-control">
                        <html:option value="0">Tất cả cửa hàng</html:option>
                        <html:optionsCollection name="wareHousingBillForm" property="shopList" value="shopID" label="shopName"/>
                    </html:select>
                </div>
                
                <div class="row form-group">
                    <label>Chọn ngày xem</label>
                    <html:text property="dateTime" styleClass="form-control" styleId="datepicker" readonly="true"/>
                </div>
                
                <div class="form-group">
                    <html:button styleClass="btn btn-default btn style-button" value="Tìm lịch sử" property="xem" onclick="showImportReceipt()" />
                </div>
            </html:form>
        
            <div class="scrollable-area-bill-table scrollable-table">
                <table id="tbl-import-receipt" class="table table-striped table-hover tbl-sticky-header">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Ngày lập</th>
                            <th>Cửa hàng</th>
                            <th></th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <logic:notEmpty name="wareHousingBillForm" property="importReceiptList">
                        <logic:iterate name="wareHousingBillForm" property="importReceiptList" id="importReceipt">
                            <tr>
                                <bean:define id="obj" name="importReceipt" />
                                <td id="row"><bean:write name="obj" property="id" /></td>
                                <td><bean:write name="obj" property="dateTime" /></td>
                                <td><bean:write name="obj" property="shopName" /></td>
                                <td>
                                    <bean:define id="mpl" name="obj" property="id"></bean:define>
                                    <a class="btn btn-link" onClick="clickShowDetail('${mpl}');">Chi tiết</a>
                                </td>
                            </tr>
                        </logic:iterate>
                        </logic:notEmpty>
                    </tbody>
                </table>
            </div>
        
        </div> <!-- left part -->
       
        <!-- Right part -->
        <div class="col-md-6 col-md-offset-1">
            <h4 style="font-weight: 300;">Chi tiết nhập kho</h4>
            <div class="scrollable-table scrollable-area-bill-detail-table">
                <table id="tbl-Detail-Import-Receipt" class="table table-striped table-hover tbl-sticky-header">
                    <thead>
                        <tr>
                            <th>Nguyên liệu</th>
                            <th>Đơn vị</th>
                            <th>Số lượng</th>
                        </tr>
                    </thead>

                    <tbody>
                    </tbody>
                </table>
            </div>
        </div> <!-- Right part -->
                
    </div> <!-- container -->
    
	<!--Show alert when date don't select  -->
	<div id="error" class="modal alert">
    <div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-danger">
				<strong>Thông báo!</strong> Bạn chưa chọn ngày lập hóa đơn.
			</div>
		</div>
	</div>
	</div>
	</div>
    
	<logic:equal name="wareHousingBillForm" property="valid" value="-1">
		<script type="text/javascript">
	    $('#error-detail-import-receipt').modal('show');
	</script>
	</logic:equal>
    
	<!--Show alert when import receipt is null  -->
	<div id="error-import-receipt" class="modal alert">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-danger">
				<strong>Thông báo!</strong> Bạn chưa chọn ngày lập hóa đơn.
			</div>
		</div>
	</div>
	</div>
	</div>

	<!--Show alert when data is null  -->
	<div id="error-detail-import-receipt" class="modal">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<div class="alert alert-dismissible alert-danger">
				<strong>Thông báo!</strong> Không có dữ liệu cho ngày được chọn.
			</div>
		</div>
	</div>
	</div>
	</div>

</body>
</html>