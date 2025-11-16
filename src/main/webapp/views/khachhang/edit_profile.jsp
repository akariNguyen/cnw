<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.KhachHang" %>

<%
    KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
    if (khachHang == null) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
    String success = (String) session.getAttribute("success");
    if (success != null) {
        session.removeAttribute("success"); // Xóa sau khi dùng
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa hồ sơ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .tab-content .card { border: none; border-radius: 12px; }
        .form-control:focus { box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25); }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Chỉnh sửa hồ sơ cá nhân</h2>
        <a href="index.jsp" class="btn btn-secondary">← Quay lại Trang chủ</a>
    </div>

    <!-- THÔNG BÁO -->
    <% if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    <% if (success != null && !success.isEmpty()) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- TAB -->
    <ul class="nav nav-tabs mb-4" id="editTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile"
                    type="button" role="tab" aria-controls="profile" aria-selected="true">
                Thông tin cá nhân
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#password"
                    type="button" role="tab" aria-controls="password" aria-selected="false">
                Đổi mật khẩu
            </button>
        </li>
    </ul>

    <div class="tab-content" id="editTabsContent">

        <!-- TAB 1: THÔNG TIN CÁ NHÂN -->
        <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
            <form action="khachhang?action=updateProfile" method="post" class="card shadow-sm p-4">
                <input type="hidden" name="id" value="<%= khachHang.getId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ tên <span class="text-danger">*</span></label>
                    <input type="text" name="ten" value="<%= khachHang.getTen() != null ? khachHang.getTen() : "" %>"
                           class="form-control" placeholder="Nhập họ tên" required autocomplete="name">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                    <input type="text" name="sdt" value="<%= khachHang.getSdt() != null ? khachHang.getSdt() : "" %>"
                           class="form-control" placeholder="Ví dụ: 0901234567" required pattern="[0-9]{10,11}"
                           title="Số điện thoại phải có 10-11 chữ số" autocomplete="tel">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" value="<%= khachHang.getEmail() != null ? khachHang.getEmail() : "" %>"
                           class="form-control" placeholder="example@gmail.com" required autocomplete="email">
                </div>

                <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4">Lưu thay đổi</button>
                    <a href="index.jsp" class="btn btn-outline-secondary">Hủy</a>
                </div>
            </form>
        </div>

        <!-- TAB 2: ĐỔI MẬT KHẨU -->
        <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
            <form action="khachhang?action=changePassword" method="post" class="card shadow-sm p-4">
                <input type="hidden" name="id" value="<%= khachHang.getId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu cũ <span class="text-danger">*</span></label>
                    <input type="password" name="matKhauCu" class="form-control" required
                           placeholder="Nhập mật khẩu hiện tại" autocomplete="current-password">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu mới <span class="text-danger">*</span></label>
                    <input type="password" name="matKhauMoi" class="form-control" required minlength="6"
                           placeholder="Tối thiểu 6 ký tự" autocomplete="new-password">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                    <input type="password" name="matKhauXacNhan" class="form-control" required minlength="6"
                           placeholder="Nhập lại mật khẩu mới" autocomplete="new-password">
                </div>

                <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4">Lưu thay đổi</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="document.querySelector('#password form').reset();">
                        Xóa form
                    </button>
                </div>
            </form>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>