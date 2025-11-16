<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.*, model.dao.*,model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    KhachSan ks = ksDAO.getByOwnerId(owner.getId()); // <-- hàm mới

    String success = (String) session.getAttribute("success");
    if (success != null) {
        session.removeAttribute("success"); // Xóa sau khi hiển thị
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Chủ Khách Sạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Xin chào, <%= owner.getTen() %> 👋</h3>
        <a href="${pageContext.request.contextPath}/khachhang?action=logout" class="btn btn-outline-danger">Đăng xuất</a>
    </div>

    <!-- Hiển thị thông báo thành công -->
    <% if (success != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

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

            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/owner/hotel?action=edit" class="btn btn-warning me-2">Chỉnh sửa khách sạn</a>
                <a href="${pageContext.request.contextPath}/phong?action=ownerList" class="btn btn-primary me-2">Quản lý phòng</a>
                <a href="${pageContext.request.contextPath}/views/owner/booking_list.jsp" class="btn btn-success">Xem đơn đặt phòng</a>
            </div>
        </div>
    </div>

</div>

</body>
</html>