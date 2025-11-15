<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.*, model.dao.*,model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    KhachSan ks = ksDAO.getByOwnerId(owner.getId()); // <-- hàm mới
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Chủ Khách Sạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">

    <h3>Xin chào, <%= owner.getTen() %> 👋</h3>

    <div class="card mt-4 shadow-sm">
        <div class="card-body">
            <h4 class="mb-3">Khách sạn của bạn</h4>

            <% if (ks == null) { %>
                <p>Bạn chưa có khách sạn nào.</p>
            <% } else { %>
                <p><strong>Tên:</strong> <%= ks.getTen() %></p>
                <p><strong>Địa chỉ:</strong> <%= ks.getDiaChi() %></p>
                <p><strong>Số điện thoại:</strong> <%= ks.getSoDienThoai() %></p>
                <p><strong>Mô tả:</strong> <%= ks.getMoTa() %></p>
            <% } %>

            <a href="edit_hotel.jsp" class="btn btn-warning mt-3">Chỉnh sửa khách sạn</a>
            <a href="room_list.jsp" class="btn btn-primary mt-3">Quản lý phòng</a>
            <a href="booking_list.jsp" class="btn btn-success mt-3">Xem đơn đặt phòng</a>
        </div>
    </div>

</div>

</body>
</html>
