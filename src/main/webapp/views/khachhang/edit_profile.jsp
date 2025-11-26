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
        session.removeAttribute("success");
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ • <%= khachHang.getTen() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #0f172a;
            --card: #1e293b;
            --border: #334155;
            --accent: #06b6d4;
            --gold: #fbbf24;
            --text: #f1f5f9;
            --muted: #cbd5e1;
            --success: #10b981;
            --danger: #ef4444;
        }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        .page-bg {
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1618775575982-8a5c6077e7e8?w=1920') center/cover no-repeat;
            opacity: 0.28;
            z-index: -1;
        }

        .back-btn {
            position: fixed;
            top: 2rem;
            left: 2rem;
            z-index: 100;
            background: rgba(30,41,59,0.95);
            backdrop-filter: blur(15px);
            border: 2px solid var(--border);
            color: var(--text);
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .back-btn:hover {
            background: var(--accent);
            border-color: var(--accent);
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(6,182,212,0.4);
        }

        .header-title {
            text-align: center;
            padding: 5rem 1rem 3rem;
        }
        .header-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4.8rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .user-name {
            font-size: 2rem;
            color: var(--gold);
            font-weight: 700;
            margin-top: 1rem;
        }

        .container-main {
            max-width: 1000px;
            margin: 0 auto 8rem;
            padding: 2rem;
        }

        .main-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(25px);
            border-radius: 36px;
            padding: 4rem;
            box-shadow: 0 50px 120px rgba(0,0,0,0.8);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .main-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 12px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .nav-tabs {
            border-bottom: 2px solid var(--border);
            margin-bottom: 3rem;
            justify-content: center;
        }
        .nav-tabs .nav-link {
            color: var(--muted);
            font-weight: 600;
            font-size: 1.2rem;
            padding: 1.2rem 3rem;
            border-radius: 50px;
            margin: 0 1rem;
            transition: all 0.4s;
        }
        .nav-tabs .nav-link:hover {
            color: var(--accent);
            border-color: var(--accent);
        }
        .nav-tabs .nav-link.active {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            box-shadow: 0 10px 30px rgba(6,182,212,0.4);
        }

        .form-control, .form-select {
            background: rgba(15,23,42,0.8);
            border: 1px solid var(--border);
            color: var(--text);
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-size: 1.1rem;
        }
        .form-control:focus {
            background: rgba(15,23,42,0.9);
            border-color: var(--accent);
            box-shadow: 0 0 0 0.25rem rgba(6,182,212,0.3);
            color: var(--text);
        }
        .form-label {
            color: var(--gold);
            font-weight: 700;
            font-size: 1.15rem;
            margin-bottom: 0.8rem;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--success), #059669);
            color: white;
            padding: 1rem 3rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.2rem;
            transition: all 0.5s;
        }
        .btn-submit:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(16,185,129,0.5);
        }

        .btn-cancel, .btn-reset {
            background: rgba(100,100,100,0.5);
            color: var(--text);
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .btn-cancel:hover, .btn-reset:hover {
            background: var(--accent);
            color: white;
            transform: translateY(-5px);
        }

        .alert-success {
            background: rgba(16,185,129,0.18);
            border: 1px solid var(--success);
            color: white;
            border-radius: 20px;
            padding: 1.5rem;
        }
        .alert-danger {
            background: rgba(239,68,68,0.18);
            border: 1px solid var(--danger);
            color: white;
            border-radius: 20px;
            padding: 1.5rem;
        }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3.2rem; }
            .back-btn { position: static; margin: 1.5rem auto; display: block; width: fit-content; }
            .main-card { padding: 2.5rem; border-radius: 28px; }
            .nav-tabs .nav-link { padding: 1rem 2rem; font-size: 1rem; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<a href="index.jsp" class="back-btn">
    Quay lại Trang chủ
</a>

<div class="header-title">
    <h1>Chỉnh sửa hồ sơ</h1>
    <p class="user-name"><%= khachHang.getTen() %></p>
</div>

<div class="container-main">
    <div class="main-card">

        <!-- THÔNG BÁO -->
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Lỗi:</strong> <%= error %>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>Thành công!</strong> <%= success %>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- TAB -->
        <ul class="nav nav-tabs" id="editTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile">
                    Thông tin cá nhân
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#password">
                    Đổi mật khẩu
                </button>
            </li>
        </ul>

        <div class="tab-content mt-4">

            <!-- TAB 1: THÔNG TIN CÁ NHÂN -->
            <div class="tab-pane fade show active" id="profile">
                <form action="khachhang?action=updateProfile" method="post">
                    <input type="hidden" name="id" value="<%= khachHang.getId() %>">

                    <div class="mb-4">
                        <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                        <input type="text" name="ten" value="<%= khachHang.getTen() != null ? khachHang.getTen() : "" %>"
                               class="form-control" placeholder="Nhập họ tên" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" name="sdt" value="<%= khachHang.getSdt() != null ? khachHang.getSdt() : "" %>"
                               class="form-control" placeholder="0901234567" required pattern="[0-9]{10,11}">
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" value="<%= khachHang.getEmail() != null ? khachHang.getEmail() : "" %>"
                               class="form-control" placeholder="example@gmail.com" required>
                    </div>

                    <div class="d-flex gap-3 justify-content-center mt-5">
                        <button type="submit" class="btn btn-submit">Lưu thay đổi</button>
                        <a href="index.jsp" class="btn btn-cancel">Hủy</a>
                    </div>
                </form>
            </div>

            <!-- TAB 2: ĐỔI MẬT KHẨU -->
            <div class="tab-pane fade" id="password">
                <form action="khachhang?action=changePassword" method="post">
                    <input type="hidden" name="id" value="<%= khachHang.getId() %>">

                    <div class="mb-4">
                        <label class="form-label">Mật khẩu cũ <span class="text-danger">*</span></label>
                        <input type="password" name="matKhauCu" class="form-control" required placeholder="••••••••">
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                        <input type="password" name="matKhauMoi" class="form-control" required minlength="6" placeholder="Tối thiểu 6 ký tự">
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                        <input type="password" name="matKhauXacNhan" class="form-control" required minlength="6" placeholder="Nhập lại mật khẩu mới">
                    </div>

                    <div class="d-flex gap-3 justify-content-center mt-5">
                        <button type="submit" class="btn btn-submit">Lưu thay đổi</button>
                        <button type="button" class="btn btn-reset" onclick="this.closest('form').reset();">
                            Xóa form
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>