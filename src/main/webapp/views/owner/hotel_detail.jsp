<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.KhachSan" %>

<%
    KhachSan ks = (KhachSan) request.getAttribute("khachSan");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin khách sạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">Khách sạn của bạn</h2>

    <div class="card shadow-sm p-4">

        <h4 class="mb-3">Thông tin khách sạn</h4>

        <p><b>Tên:</b> <%= ks.getTen() %></p>
        <p><b>Địa chỉ:</b> <%= ks.getDiaChi() %></p>
        <p><b>Số điện thoại:</b> <%= ks.getSoDienThoai() %></p>
        <p><b>Mô tả:</b> <%= ks.getMoTa() %></p>

        <div class="mt-4">
            <!-- CHUYỂN SANG FORM EDIT -->
            <a href="OwnerKhachSanController?action=edit&id=<%= ks.getId() %>"
               class="btn btn-warning">Chỉnh sửa khách sạn</a>

            <a href="phong?action=ownerList" class="btn btn-primary">Quản lý phòng</a>

            <a href="dondatphong?action=ownerList" class="btn btn-success">Xem đơn đặt phòng</a>
        </div>

    </div>
</div>

</body>
</html>
