<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.KhachHang" %>

<%
    KhachHang kh = (KhachHang) request.getAttribute("khachHang");
    if (kh == null) {
        out.print("<div class='alert alert-warning'>Không tìm thấy thông tin khách hàng.</div>");
        return;
    }
%>

<div class="container-fluid">
    <h5>Thông tin khách hàng: <%= kh.getTen() %></h5>

    <ul class="list-group list-group-flush">
        <li class="list-group-item">
            <span class="fw-medium">Số điện thoại:</span> <%= kh.getSdt() %>
        </li>
        <li class="list-group-item">
            <span class="fw-medium">Email:</span> <%= kh.getEmail() %>
        </li>
        <li class="list-group-item">
            <span class="fw-medium">Mật khẩu:</span> ******** (ẩn)
        </li>
    </ul>
</div>