<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Báo cáo tiêu thụ nguyên liệu</title>

<link href="css/paper-theme.css" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&subset=latin,vietnamese'	rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/shopCS.js" type="text/javascript" charset="UTF-8"></script>
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
        <div class="page-title">Báo cáo tiêu thụ nguyên liệu trong ngày</div>
		
        <!-- Left part -->
		<div class="col-md-6">
			<div class="row">
				<html:form action="/shop-ingredient-cs" styleId="shopIngCSForm">
					<html:hidden property="listSCS" styleId="listSCS" />
					<html:hidden property="listSCSId" styleId="listSCSId" />
				</html:form>
                <button class="btn btn-danger style-button" style="margin-bottom: 20px;" onclick="getListCS();">Báo cáo</button>
			</div>
            
            
			<div class="row scrollable-area-shop-food scrollable-table">
    			<table class="table table-striped table-hover tbl-sticky-header">
					<thead>
						<tr>
							<th>Tên nguyên liệu</th>
							<th>Đơn vị tính</th>
							<th>Lượng tiêu thụ</th>
						</tr>
					</thead>
					
                    <tbody>
						<logic:iterate id="listShopIng" name="shopIngredientCSForm"	property="listShopIngredient">
							<tr>
								<bean:define id="ingredientId" name="listShopIng" property="ingredientId"></bean:define>

								<td style="width: 40%"> <bean:write name="listShopIng" property="shopIngName" /> </td>
								<td> <bean:write name="listShopIng"	property="shopIngUnit" /> </td>
                                <td> <input value="0" name="cs" class="form-control sics-quantity" style="width: 80px; text-align: center;"/> </td>
								<input value="${ingredientId}" name="csId" hidden="true" />
							</tr>
						</logic:iterate>
                    </tbody>
				</table>
                <script>$(".sics-quantity").focus(function(){$(this).val("")})</script>
			</div>
		</div> <!-- left part -->

        
        <!-- Report success modal -->
		<div class="modal fade" id="input-success-cs-mode" role="dialog">
		<div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-success">
                    <strong>Thông báo! </strong> Báo cáo thành công.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->
		
		<div class="modal fade" id="input-all-zero-mode" role="dialog">
		<div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-body">
                <div class="alert alert-dismissible alert-danger">
                    <strong>Thông báo! </strong> Báo cáo không thành công.<br> 
                    Vui lòng kiểm tra lại số lượng tiêu thụ của bạn.
                </div>
            </div>
        </div> <!-- modal fade -->
        </div> <!-- modal dialog -->
        </div> <!-- modal content -->
	
    </div> <!-- container -->

</body>
</html>