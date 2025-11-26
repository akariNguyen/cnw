<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.Phong" %>
<%@ page import="model.bean.KhachSan" %>
<%
    Phong p = (Phong) request.getAttribute("phong");
    KhachSan ks = (KhachSan) request.getAttribute("khachSan"); // nếu có truyền từ servlet
    if (p == null) {
        response.sendRedirect("khachsan?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= p.getTenPhong() %> • <%= ks != null ? ks.getTen() : "LUXE STAY" %></title>
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
            --text-muted: #94a3b8;
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

        /* Background */
        .room-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.94), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1618778616588-7e9d2c0e2c6c?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .room-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, rgba(251,191,36,0.15), transparent 70%);
            animation: pulse 15s infinite;
        }
        @keyframes pulse { 0%,100% { opacity: 0.4; } 50% { opacity: 0.7; } }

        /* Room Detail Card */
        .room-detail {
            background: rgba(30,41,59,0.92);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 32px;
            overflow: hidden;
            max-width: 1000px;
            margin: 3rem auto;
            box-shadow: 0 40px 100px rgba(0,0,0,0.7);
            position: relative;
        }
        .room-detail::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .room-image {
            height: 500px;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)),
                        url('<%= p.getHinhAnh() != null && !p.getHinhAnh().isEmpty() ? p.getHinhAnh() : "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=1200&q=80" %>') center/cover no-repeat;
            position: relative;
        }
        .room-title {
            position: absolute;
            bottom: 2rem;
            left: 3rem;
            color: white;
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 900;
            text-shadow: 0 6px 20px rgba(0,0,0,0.8);
        }
        .room-price {
            position: absolute;
            top: 2rem;
            right: 3rem;
            background: var(--gold);
            color: #000;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 2rem;
            font-weight: 700;
            box-shadow: 0 10px 30px rgba(251,191,36,0.4);
        }

        .room-info {
            padding: 3rem;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }
        .info-item {
            background: rgba(15,23,42,0.6);
            padding: 1.8rem;
            border-radius: 20px;
            border-left: 5px solid var(--accent);
            transition: all 0.4s;
        }
        .info-item:hover {
            transform: translateY(-8px);
            background: rgba(15,23,42,0.9);
            border-left-color: var(--gold);
        }
        .info-item i {
            font-size: 2.2rem;
            color: var(--accent);
            margin-bottom: 1rem;
        }
        .info-item .label {
            font-size: 0.9rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .info-item .value {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--gold);
            margin-top: 0.5rem;
        }

        .description {
            background: rgba(15,23,42,0.6);
            padding: 2.5rem;
            border-radius: 20px;
            margin: 2.5rem 0;
            line-height: 1.8;
            font-size: 1.1rem;
            color: var(--text);
        }

        .action-buttons {
            text-align: center;
            margin: 3rem 0;
        }
        .btn-book {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 1.5rem 4rem;
            border-radius: 50px;
            font-size: 1.5rem;
            font-weight: 700;
            box-shadow: 0 15px 40px rgba(16,185,129,0.4);
            transition: all 0.4s;
        }
        .btn-book:hover {
            transform: translateY(-10px);
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            box-shadow: 0 25px 50px rgba(251,191,36,0.5);
        }
        .btn-back {
            background: transparent;
            color: var(--text-muted);
            border: 2px solid var(--border);
            padding: 1rem 3rem;
            border-radius: 50px;
            margin-left: 1rem;
            transition: all 0.4s;
        }
        .btn-back:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(6,182,212,0.1);
        }

        @media (max-width: 768px) {
            .room-title { font-size: 2.8rem; left: 1.5rem; bottom: 1.5rem; }
            .room-price { font-size: 1.5rem; top: 1rem; right: 1rem; padding: 0.8rem 1.5rem; }
            .room-image { height: 400px; }
            .room-info { padding: 2rem; }
            .info-grid { grid-template-columns: 1fr; }
            .action-buttons { flex-direction: column; }
            .btn-book, .btn-back { width: 100%; margin: 1rem 0; }
        }
    </style>
</head>
<body>

    <div class="room-bg"></div>

    <div class="container">
        <div class="room-detail">
            <!-- Ảnh phòng + tên + giá -->
            <div class="room-image">
                <div class="room-title"><%= p.getTenPhong() %></div>
                <div class="room-price">
                    <%= String.format("%,d", p.getGia()) %> ₫ <small>/đêm</small>
                </div>
            </div>

            <div class="room-info">
                <!-- Thông tin chính -->
                <div class="info-grid">
                    <div class="info-item">
                        <i class="fas fa-bed"></i>
                        <div class="label">Loại phòng</div>
                        <div class="value"><%= p.getLoai() %></div>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-users"></i>
                        <div class="label">Sức chứa</div>
                        <div class="value"><%= p.getSucChua() %> người</div>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-ruler-combined"></i>
                        <div class="label">Diện tích</div>
                        <div class="value">45 m²</div>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-wifi"></i>
                        <div class="label">Tiện ích</div>
                        <div class="value">Wifi · TV · Minibar</div>
                    </div>
                </div>

                <!-- Mô tả chi tiết -->
                <div class="description">
                    <h4><i class="fas fa-info-circle me-2"></i>Mô tả phòng</h4>
                    <p><%= p.getMoTa() != null && !p.getMoTa().isEmpty() ? p.getMoTa() : "Phòng được thiết kế sang trọng với nội thất cao cấp, tầm nhìn hướng biển/TP, mang đến trải nghiệm nghỉ dưỡng tuyệt đối." %></p>
                </div>

                <!-- Nút hành động -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/datphong?phongId=<%= p.getId() %>" 
                       class="btn btn-book">
                        <i class="fas fa-calendar-check me-3"></i> ĐẶT PHÒNG NGAY
                    </a>
                    <a href="javascript:history.back()" class="btn btn-back">
                        <i class="fas fa-arrow-left me-2"></i> Quay Lại
                    </a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>