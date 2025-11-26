<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.KhachSan" %>
<%@ page import="model.bean.ChuKhachSan" %>
<%
    KhachSan ks = (KhachSan) request.getAttribute("khachSan");
    ChuKhachSan owner = (ChuKhachSan) request.getAttribute("owner");
    if (ks == null) {
        response.sendRedirect("khachsan?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= ks.getTen() %> • LUXE STAY</title>
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
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            background-attachment: fixed;
        }

        /* Hero Background */
        .detail-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.92), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1611892441792-ae6af465f35c?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .detail-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top center, rgba(6,182,212,0.18), transparent 70%);
            animation: breathe 20s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        /* Detail Card */
        .detail-card {
            background: rgba(30, 41, 59, 0.88);
            backdrop-filter: blur(18px);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 3.5rem 3rem;
            margin: 2rem auto;
            max-width: 900px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.7);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 1s ease-out;
        }
        .detail-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .hotel-name {
            font-family: 'Playfair Display', serif;
            font-size: 3.8rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin-bottom: 2rem;
            letter-spacing: 1px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.8rem;
            margin: 2.5rem 0;
        }
        .info-item {
            display: flex;
            align-items: center;
            padding: 1.2rem 1.5rem;
            background: rgba(15,23,42,0.6);
            border-radius: 16px;
            border-left: 4px solid var(--accent);
            transition: all 0.4s;
        }
        .info-item:hover {
            transform: translateX(10px);
            background: rgba(15,23,42,0.9);
            border-left-color: var(--gold);
        }
        .info-item i {
            font-size: 1.8rem;
            color: var(--accent);
            margin-right: 1.2rem;
            width: 50px;
            text-align: center;
        }
        .info-item .label {
            font-weight: 600;
            color: var(--gold);
            min-width: 120px;
        }
        .info-item .value {
            color: var(--text);
            font-size: 1.05rem;
        }

        /* Owner Section */
        .owner-box {
            background: linear-gradient(135deg, rgba(251,191,36,0.15), rgba(6,182,212,0.15));
            border: 1px dashed var(--accent);
            border-radius: 20px;
            padding: 2rem;
            margin: 3rem 0;
            text-align: center;
        }
        .owner-box h4 {
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        .owner-info {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        /* Action Buttons */
        .action-buttons {
            text-align: center;
            margin-top: 3rem;
        }
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 1rem 2.5rem;
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0 1rem;
            transition: all 0.4s;
            box-shadow: 0 10px 30px rgba(6,182,212,0.4);
        }
        .btn-primary-custom:hover {
            transform: translateY(-6px);
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            box-shadow: 0 20px 40px rgba(251,191,36,0.5);
        }
        .btn-secondary-custom {
            background: transparent;
            color: var(--text-muted);
            border: 2px solid var(--border);
            border-radius: 50px;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            transition: all 0.4s;
        }
        .btn-secondary-custom:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(6,182,212,0.1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(60px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .hotel-name { font-size: 2.8rem; }
            .info-grid { grid-template-columns: 1fr; }
            .owner-info { flex-direction: column; gap: 1rem; }
            .action-buttons .btn-primary-custom,
            .action-buttons .btn-secondary-custom { display: block; width: 100%; margin: 0.8rem 0; }
        }
    </style>
</head>
<body>

    <div class="detail-bg"></div>

    <div class="container">
        <div class="detail-card">
            <h1 class="hotel-name"><%= ks.getTen() %></h1>

            <div class="info-grid">
                <div class="info-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <div class="label">Địa chỉ</div>
                        <div class="value"><%= ks.getDiaChi() %></div>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fas fa-phone-alt"></i>
                    <div>
                        <div class="label">Liên hệ</div>
                        <div class="value"><%= ks.getSoDienThoai() %></div>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fas fa-hotel"></i>
                    <div>
                        <div class="label">Mô tả</div>
                        <div class="value"><%= ks.getMoTa() != null && !ks.getMoTa().isEmpty() ? ks.getMoTa() : "Khách sạn sang trọng với dịch vụ đẳng cấp 5 sao." %></div>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fas fa-star"></i>
                    <div>
                        <div class="label">Đánh giá</div>
                        <div class="value">4.9 / 5.0 <small>(1280 đánh giá)</small></div>
                    </div>
                </div>
            </div>

            <!-- Chủ khách sạn -->
            <div class="owner-box">
                <h4>Chủ Khách Sạn</h4>
                <div class="owner-info">
                    <div><i class="fas fa-user-tie"></i> <%= owner != null ? owner.getTen() : "Chưa cập nhật" %></div>
                    <div><i class="fas fa-envelope"></i> <%= owner != null ? owner.getEmail() : "Chưa có" %></div>
                    <div><i class="fas fa-mobile-alt"></i> <%= owner != null ? owner.getSdt() : "Chưa có" %></div>
                </div>
            </div>

            <!-- Nút hành động -->
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/phong?action=list&khachSanId=<%= ks.getId() %>" 
                   class="btn-primary-custom">
                    <i class="fas fa-bed me-2"></i> Xem Phòng & Đặt Ngay
                </a>
                <a href="${pageContext.request.contextPath}/khachsan?action=list" 
                   class="btn-secondary-custom">
                    <i class="fas fa-arrow-left me-2"></i> Quay Lại Danh Sách
                </a>
            </div>
        </div>
    </div>

    <script>
        // Tự động scroll mượt khi load
        window.onload = () => {
            document.querySelector('.detail-card').scrollIntoView({ behavior: 'smooth' });
        };
    </script>
</body>
</html>