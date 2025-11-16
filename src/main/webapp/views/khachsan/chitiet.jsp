<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.KhachSan" %>
<%@ page import="model.bean.ChuKhachSan" %>
<%
    KhachSan ks = (KhachSan) request.getAttribute("khachSan");
    ChuKhachSan owner = (ChuKhachSan) request.getAttribute("owner");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết khách sạn - <%= ks.getTen() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f4f7fc; font-family: 'Inter', sans-serif; color: #333; }
        .header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white; padding: 3rem 0; text-align: center;
            border-radius: 0 0 20px 20px; box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            position: relative; overflow: hidden;
        }
        .header img { max-width: 100%; height: auto; border-radius: 15px; margin-bottom: 1.5rem; opacity: 0.9; }
        .header img:hover { transform: scale(1.02); }
        .header h2 { font-weight: 700; font-size: 2rem; text-transform: uppercase; letter-spacing: 1px; }
        .card-container {
            background: white; border-radius: 15px; box-shadow: 0 8px 16px rgba(0,0,0,0.05);
            padding: 2rem; margin: 2rem auto; max-width: 800px;
        }
        .card-title { font-size: 1.6rem; font-weight: 600; color: #1e3a8a; margin-bottom: 1.5rem; }
        .info-item { display: flex; align-items: center; margin-bottom: 1rem; }
        .info-item i { color: #3b82f6; margin-right: 1rem; font-size: 1.2rem; width: 24px; }
        .info-item strong { min-width: 130px; color: #333; }
        .info-item span { color: #555; }
        .owner-section { background: #f8f9fa; padding: 1.5rem; border-radius: 12px; margin-top: 1.5rem; border-left: 4px solid #3b82f6; }
        .owner-section h5 { color: #1e3a8a; font-weight: 600; margin-bottom: 1rem; }
        .action-buttons a {
            margin-right: 1rem; padding: 0.5rem 1.5rem; border-radius: 25px;
            transition: all 0.3s ease;
        }
        .action-buttons a:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        @media (max-width: 768px) {
            .header h2 { font-size: 1.5rem; }
            .card-container { padding: 1.5rem; }
            .action-buttons a { display: block; margin: 0.5rem 0; text-align: center; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <img src="https://images.unsplash.com/photo-1542314831-8f7d16dd2b3b" alt="Hotel Banner" class="img-fluid">
        <h2>Chi Tiết Khách Sạn</h2>
    </div>

    <!-- Card Container -->
    <div class="container card-container">
        <h3 class="card-title"><%= ks.getTen() %></h3>

        <!-- Thông tin khách sạn -->
        <div class="info-item">
            <i class="fas fa-map-marker-alt"></i>
            <strong>Địa chỉ:</strong>
            <span><%= ks.getDiaChi() %></span>
        </div>
        <div class="info-item">
            <i class="fas fa-phone"></i>
            <strong>Liên hệ:</strong>
            <span><%= ks.getSoDienThoai() %></span>
        </div>
        <div class="info-item">
            <i class="fas fa-info-circle"></i>
            <strong>Mô tả:</strong>
            <span><%= ks.getMoTa() != null ? ks.getMoTa() : "Chưa có mô tả" %></span>
        </div>

        <!-- Thông tin chủ khách sạn -->
        <div class="owner-section">
            <h5>Chủ khách sạn</h5>
            <div class="info-item">
                <i class="fas fa-user-tie"></i>
                <strong>Họ tên:</strong>
                <span><%= owner != null ? owner.getTen() : "Chưa có" %></span>
            </div>
            <div class="info-item">
                <i class="fas fa-envelope"></i>
                <strong>Email:</strong>
                <span><%= owner != null ? owner.getEmail() : "Chưa có" %></span>
            </div>
            <div class="info-item">
                <i class="fas fa-mobile-alt"></i>
                <strong>SĐT:</strong>
                <span><%= owner != null ? owner.getSdt() : "Chưa có" %></span>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons mt-4">
            <a href="phong?action=list&khachSanId=<%= ks.getId() %>" class="btn btn-primary">
                Xem phòng
            </a>
            <a href="khachsan?action=list" class="btn btn-outline-secondary">
                Quay lại danh sách
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>