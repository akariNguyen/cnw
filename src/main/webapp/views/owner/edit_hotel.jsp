<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.*, model.dao.*,model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    KhachSan ks = ksDAO.getByOwnerId(owner.getId());
    if (ks == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
        return;
    }

    String error = (String) request.getAttribute("error");
    String success = (String) session.getAttribute("success");
    if (success != null) {
        session.removeAttribute("success"); // Xóa sau khi hiển thị
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thông tin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Chỉnh sửa thông tin</h2>
        <a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="btn btn-secondary">← Quay lại Dashboard</a>
    </div>

    <!-- Hiển thị thông báo lỗi hoặc thành công -->
    <% if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (success != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <ul class="nav nav-tabs mb-4" id="editTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="hotel-tab" data-bs-toggle="tab" data-bs-target="#hotel" type="button" role="tab">Khách sạn</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="owner-tab" data-bs-toggle="tab" data-bs-target="#owner" type="button" role="tab">Chủ khách sạn</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#password" type="button" role="tab">Đổi mật khẩu</button>
        </li>
    </ul>

    <div class="tab-content" id="editTabsContent">

        <!-- TAB 1: CHỈNH SỬA KHÁCH SẠN -->
        <div class="tab-pane fade show active" id="hotel" role="tabpanel">
            <form action="${pageContext.request.contextPath}/owner/hotel?action=update" method="post" class="card shadow-sm p-4">

                <!-- Tên -->
                <div class="mb-3">
                    <label class="form-label">Tên khách sạn</label>
                    <input type="text" name="ten" value="<%= ks.getTen() %>" class="form-control" required>
                </div>

                <!-- Địa chỉ -->
                <div class="mb-3">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" name="diachi" value="<%= ks.getDiaChi() %>" class="form-control" required>
                </div>

                <!-- SĐT -->
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" name="sdt" value="<%= ks.getSoDienThoai() %>" class="form-control" required>
                </div>

                <!-- Mô tả -->
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="mota" class="form-control" rows="3"><%= ks.getMoTa() %></textarea>
                </div>

                <!-- Nút -->
                <div class="mt-3 d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4">Lưu thay đổi</button>
                </div>

            </form>
        </div>

        <!-- TAB 2: CHỈNH SỬA CHỦ KHÁCH SẠN -->
        <div class="tab-pane fade" id="owner" role="tabpanel">
            <form action="${pageContext.request.contextPath}/owner/hotel?action=updateOwner" method="post" class="card shadow-sm p-4">

                <input type="hidden" name="ownerId" value="<%= owner.getId() %>">

                <!-- Họ tên -->
                <div class="mb-3">
                    <label class="form-label">Họ tên</label>
                    <input type="text" name="ten" value="<%= owner.getTen() %>" class="form-control" required>
                </div>

                <!-- Số điện thoại -->
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" name="sdt" value="<%= owner.getSdt() %>" class="form-control" required>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" value="<%= owner.getEmail() %>" class="form-control" required>
                </div>

                <!-- Nút -->
                <div class="mt-3 d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4">Lưu thay đổi</button>
                </div>

            </form>
        </div>

        <!-- TAB 3: ĐỔI MẬT KHẨU -->
        <div class="tab-pane fade" id="password" role="tabpanel">
            <form action="${pageContext.request.contextPath}/owner/hotel?action=changePassword" method="post" class="card shadow-sm p-4">

                <input type="hidden" name="ownerId" value="<%= owner.getId() %>">

                <!-- Mật khẩu cũ -->
                <div class="mb-3">
                    <label class="form-label">Mật khẩu cũ</label>
                    <input type="password" name="matKhauCu" class="form-control" required>
                </div>

                <!-- Mật khẩu mới -->
                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" name="matKhauMoi" class="form-control" required minlength="6">
                </div>

                <!-- Xác nhận mật khẩu mới -->
                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" name="matKhauXacNhan" class="form-control" required minlength="6">
                </div>

                <!-- Nút -->
                <div class="mt-3 d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4">Lưu thay đổi</button>
                </div>

            </form>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>