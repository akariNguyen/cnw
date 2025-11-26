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
        session.removeAttribute("success");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thông tin • LUXE OWNER</title>
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
            --text: #e2e8f0;
            --muted: #94a3b8;
            --success: #10b981;
        }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        /* Background nhẹ nhàng, không che hết */
        .edit-bg {
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=1920') center/cover no-repeat;
            opacity: 0.25;
            z-index: -1;
        }

        .edit-header {
            text-align: center;
            padding: 4rem 1rem 2rem;
            position: relative;
        }
        .edit-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .edit-header p {
            color: var(--muted);
            font-size: 1.3rem;
            margin-top: 1rem;
        }

        .back-btn {
            position: fixed;
            top: 2rem;
            left: 2rem;
            z-index: 100;
            background: rgba(30,41,59,0.9);
            backdrop-filter: blur(12px);
            border: 2px solid var(--border);
            color: var(--text);
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .back-btn:hover {
            background: var(--accent);
            border-color: var(--accent);
            transform: translateY(-4px);
            box-shadow: 0 10px 30px rgba(6,182,212,0.4);
        }

        .container-edit {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Tab đẹp như dashboard */
        .nav-tabs {
            background: rgba(30,41,59,0.7);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 0.8rem;
            border: none;
            justify-content: center;
            margin-bottom: 3rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
        }
        .nav-tabs .nav-link {
            color: var(--muted);
            border: none;
            padding: 1rem 3rem;
            border-radius: 16px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.4s;
        }
        .nav-tabs .nav-link.active {
            background: linear-gradient(135deg, var(--accent), var(--gold));
            color: #000;
            font-weight: 700;
            box-shadow: 0 10px 30px rgba(6,182,212,0.5);
        }
        .nav-tabs .nav-link:hover {
            color: white;
            transform: translateY(-4px);
        }

        .tab-card {
            background: rgba(30,41,59,0.95);
            backdrop-filter: blur(20px);
            border-radius: 32px;
            padding: 3.5rem;
            box-shadow: 0 30px 80px rgba(0,0,0,0.6);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .tab-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            border-radius: 32px 32px 0 0;
        }

        .form-label {
            color: var(--gold);
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.8rem;
        }
        .form-control {
            background: rgba(15,23,42,0.9);
            border: 1px solid var(--border);
            color: white;
            border-radius: 16px;
            padding: 1rem 1.3rem;
            font-size: 1.1rem;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(6,182,212,0.25);
            background: rgba(15,23,42,1);
        }
        textarea.form-control { min-height: 130px; resize: vertical; }

        .btn-save {
            background: linear-gradient(135deg, var(--success), #059669);
            border: none;
            padding: 1.2rem 4rem;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 700;
            color: white;
            box-shadow: 0 15px 40px rgba(16,185,129,0.4);
            transition: all 0.4s;
        }
        .btn-save:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(251,191,36,0.5);
        }

        .alert {
            border-radius: 20px;
            padding: 1.5rem;
            text-align: center;
            font-weight: 600;
            margin-bottom: 2rem;
            border: none;
        }
        .alert-success { background: rgba(16,185,129,0.15); border: 1px solid var(--success); }
        .alert-danger { background: rgba(239,68,68,0.15); border: 1px solid #ef4444; }

        @media (max-width: 768px) {
            .edit-header h1 { font-size: 2.8rem; }
            .back-btn { 
                position: static; 
                display: block; 
                width: fit-content; 
                margin: 1rem auto;
            }
            .nav-tabs { flex-direction: column; padding: 0.5rem; }
            .nav-tabs .nav-link { margin: 0.5rem 0; text-align: center; }
            .tab-card { padding: 2rem; }
            .btn-save { width: 100%; padding: 1.2rem; }
        }
    </style>
</head>
<body>

    <div class="edit-bg"></div>

    <a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="back-btn">
        Quay lại Dashboard
    </a>

    <div class="edit-header">
        <h1>Chỉnh sửa thông tin</h1>
        <p>Cập nhật thông tin khách sạn & tài khoản của bạn</p>
    </div>

    <div class="container-edit">

        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>

        <ul class="nav nav-tabs" id="editTabs">
            <li class="nav-item">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#hotel">Khách sạn</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#owner">Chủ khách sạn</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#password">Đổi mật khẩu</button>
            </li>
        </ul>

        <div class="tab-content mt-4">
            <div class="tab-pane fade show active" id="hotel">
                <div class="tab-card">
                    <form action="${pageContext.request.contextPath}/owner/hotel?action=update" method="post">
                        <div class="row g-4">
                            <div class="col-md-6"><label class="form-label">Tên khách sạn</label>
                                <input type="text" name="ten" value="<%= ks.getTen() %>" class="form-control" required></div>
                            <div class="col-md-6"><label class="form-label">Số điện thoại</label>
                                <input type="text" name="sdt" value="<%= ks.getSoDienThoai() %>" class="form-control" required></div>
                            <div class="col-12"><label class="form-label">Địa chỉ</label>
                                <input type="text" name="diachi" value="<%= ks.getDiaChi() %>" class="form-control" required></div>
                            <div class="col-12"><label class="form-label">Mô tả</label>
                                <textarea name="mota" class="form-control" rows="5"><%= ks.getMoTa() != null ? ks.getMoTa() : "" %></textarea></div>
                        </div>
                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-save">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="tab-pane fade" id="owner">
                <div class="tab-card">
                    <form action="${pageContext.request.contextPath}/owner/hotel?action=updateOwner" method="post">
                        <input type="hidden" name="ownerId" value="<%= owner.getId() %>">
                        <div class="row g-4">
                            <div class="col-md-6"><label class="form-label">Họ và tên</label>
                                <input type="text" name="ten" value="<%= owner.getTen() %>" class="form-control" required></div>
                            <div class="col-md-6"><label class="form-label">Số điện thoại</label>
                                <input type="text" name="sdt" value="<%= owner.getSdt() %>" class="form-control" required></div>
                            <div class="col-12"><label class="form-label">Email</label>
                                <input type="email" name="email" value="<%= owner.getEmail() %>" class="form-control" required></div>
                        </div>
                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-save">Cập nhật thông tin</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="tab-pane fade" id="password">
                <div class="tab-card">
                    <form action="${pageContext.request.contextPath}/owner/hotel?action=changePassword" method="post">
                        <input type="hidden" name="ownerId" value="<%= owner.getId() %>">
                        <div class="row g-4">
                            <div class="col-12"><label class="form-label">Mật khẩu cũ</label>
                                <input type="password" name="matKhauCu" class="form-control" required></div>
                            <div class="col-md-6"><label class="form-label">Mật khẩu mới</label>
                                <input type="password" name="matKhauMoi" class="form-control" required minlength="6"></div>
                            <div class="col-md-6"><label class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" name="matKhauXacNhan" class="form-control" required minlength="6"></div>
                        </div>
                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-save">Đổi mật khẩu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>