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
    <title>Dashboard • LUXE OWNER</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --danger: #ef4444;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            background-attachment: fixed;
        }

        /* Background hiệu ứng */
        .owner-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.94), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1566073772329-2436e0e9479f?w=1920') center/cover no-repeat;
            z-index: -2;
        }
        .owner-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top right, rgba(251,191,36,0.15), transparent 60%);
            animation: pulse 20s infinite;
        }
        @keyframes pulse { 0%,100% { opacity: 0.3; } 50% { opacity: 0.6; } }

        /* Header chào mừng */
        .welcome-header {
            text-align: center;
            padding: 5rem 1rem 3rem;
            position: relative;
        }
        .welcome-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        .welcome-header p {
            font-size: 1.4rem;
            color: var(--muted);
            font-weight: 300;
        }

        /* Dashboard Card */
        .dashboard-card {
            background: rgba(30,41,59,0.92);
            backdrop-filter: blur(20px);
            border-radius: 32px;
            overflow: hidden;
            max-width: 900px;
            margin: 2rem auto;
            box-shadow: 0 40px 100px rgba(0,0,0,0.7);
            border: 1px solid var(--border);
            position: relative;
        }
        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .card-header {
            background: linear-gradient(135deg, rgba(6,182,212,0.2), rgba(251,191,36,0.2));
            padding: 2.5rem;
            text-align: center;
            border-bottom: 1px solid var(--border);
        }
        .card-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--gold);
        }
        .owner-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--gold);
            color: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: bold;
            margin: 0 auto 1rem;
            box-shadow: 0 15px 40px rgba(251,191,36,0.4);
        }

        .card-body {
            padding: 3rem;
        }
        .hotel-info {
            background: rgba(15,23,42,0.6);
            padding: 2rem;
            border-radius: 20px;
            margin-bottom: 2.5rem;
            border-left: 5px solid var(--accent);
        }
        .hotel-info h4 {
            color: var(--gold);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            font-family: 'Playfair Display', serif;
        }
        .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }
        .info-row i {
            width: 40px;
            color: var(--accent);
            font-size: 1.3rem;
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            justify-content: center;
            margin-top: 2rem;
        }
        .btn-action {
            padding: 1.2rem 2.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            min-width: 220px;
            transition: all 0.4s;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
        }
        .btn-edit { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .btn-rooms { background: linear-gradient(135deg, var(--accent), #0891b2); }
        .btn-bookings { background: linear-gradient(135deg, var(--success), #059669); }
        .btn-logout {
            background: linear-gradient(135deg, var(--danger), #dc2626);
            position: absolute;
            top: 2rem;
            right: 2rem;
            padding: 0.8rem 1.8rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .btn-action:hover, .btn-logout:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
        }

        .alert-success {
            background: rgba(16,185,129,0.15);
            border: 1px solid var(--success);
            color: var(--text);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            font-weight: 500;
        }

        .no-hotel {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--muted);
        }
        .no-hotel i {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            color: #475569;
        }

        @media (max-width: 768px) {
            .welcome-header h1 { font-size: 3rem; }
            .dashboard-card { margin: 1rem; border-radius: 24px; }
            .card-header { padding: 2rem; }
            .action-buttons { flex-direction: column; align-items: center; }
            .btn-action { width: 100%; max-width: 300px; }
            .btn-logout { position: static; margin: 2rem auto 0; display: block; width: fit-content; }
        }
    </style>
</head>
<body>

    <div class="owner-bg"></div>

    <!-- Chào mừng -->
    <div class="welcome-header">
        <h1>Xin chào, <%= owner.getTen() %>!</h1>
        <p>Chào mừng quay lại hệ thống quản trị khách sạn cao cấp</p>
    </div>

    <div class="container position-relative">
        <!-- Nút đăng xuất -->
        <a href="${pageContext.request.contextPath}/khachhang?action=logout" class="btn btn-logout">
            Đăng xuất
        </a>

        <!-- Thông báo thành công -->
        <% if (success != null) { %>
            <div class="alert alert-success mt-4">
                <%= success %>
            </div>
        <% } %>

        <!-- Dashboard Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <div class="owner-avatar">
                    <%= owner.getTen().substring(0,1).toUpperCase() %>
                </div>
                <h3>Dashboard Chủ Khách Sạn</h3>
            </div>

            <div class="card-body">
                <div class="hotel-info">
                    <h4>Thông tin khách sạn của bạn</h4>

                    <% if (ks == null) { %>
                        <div class="no-hotel">
                            <p>Bạn chưa đăng ký khách sạn nào.</p>
                            <a href="${pageContext.request.contextPath}/owner/hotel?action=add" class="btn btn-action btn-edit mt-3">
                                Đăng ký khách sạn ngay
                            </a>
                        </div>
                    <% } else { %>
                        <div class="info-row"><i class="fas fa-hotel"></i> <strong>Tên:</strong> <%= ks.getTen() %></div>
                        <div class="info-row"><i class="fas fa-map-marker-alt"></i> <strong>Địa chỉ:</strong> <%= ks.getDiaChi() %></div>
                        <div class="info-row"><i class="fas fa-phone"></i> <strong>SĐT:</strong> <%= ks.getSoDienThoai() %></div>
                        <div class="info-row"><i class="fas fa-info-circle"></i> <strong>Mô tả:</strong> <%= ks.getMoTa() != null ? ks.getMoTa() : "Chưa có mô tả" %></div>
                    <% } %>
                </div>

                <% if (ks != null) { %>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/owner/hotel?action=edit" class="btn btn-action btn-edit">
                        Chỉnh sửa khách sạn
                    </a>
                    <a href="${pageContext.request.contextPath}/phong?action=ownerList" class="btn btn-action btn-rooms">
                        Quản lý phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/views/owner/booking_list.jsp" class="btn btn-action btn-bookings">
                        Xem đơn đặt phòng
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>