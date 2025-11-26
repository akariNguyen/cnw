<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.DonDatPhong" %>
<%@ page import="model.bean.Phong" %>
<%@ page import="model.bean.KhachSan" %>
<%
    DonDatPhong booking = (DonDatPhong) request.getAttribute("booking");
    Phong phong = (Phong) request.getAttribute("phong");
    KhachSan khachSan = (KhachSan) request.getAttribute("khachSan");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn • <%= booking != null ? booking.getMaDon() : "" %> • LUXE HOTEL</title>
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
            background: url('https://images.unsplash.com/photo-1522708323590-d24dbb6b03e7?w=1920') center/cover no-repeat;
            opacity: 0.35;
            z-index: -1;
        }

        .header-title {
            text-align: center;
            padding: 6rem 1rem 4rem;
        }
        .header-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 5.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }
        .order-id {
            font-size: 2.2rem;
            color: var(--gold);
            font-weight: 700;
            margin-top: 1rem;
        }

        .container-main {
            max-width: 1400px;
            margin: 0 auto 8rem;
            padding: 2rem;
        }

        .detail-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(25px);
            border-radius: 40px;
            padding: 5rem;
            box-shadow: 0 60px 140px rgba(0,0,0,0.9);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .detail-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 14px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .btn-detail {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            padding: 1.5rem 4rem;
            border-radius: 70px;
            font-size: 1.5rem;
            font-weight: 700;
            box-shadow: 0 20px 50px rgba(6,182,212,0.5);
            transition: all 0.6s;
        }
        .btn-detail:hover {
            transform: translateY(-12px) scale(1.08);
            box-shadow: 0 35px 80px rgba(6,182,212,0.7);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 4rem;
            flex-wrap: wrap;
        }
        .btn-action {
            padding: 1.3rem 3.5rem;
            border-radius: 60px;
            font-weight: 700;
            font-size: 1.2rem;
            min-width: 260px;
            transition: all 0.5s;
        }
        .btn-back {
            background: rgba(100,100,100,0.6);
            color: white;
        }
        .btn-back:hover {
            background: var(--accent);
            transform: translateY(-8px);
        }
        .btn-cancel {
            background: linear-gradient(135deg, var(--danger), #dc2626);
            color: white;
        }
        .btn-cancel:hover {
            transform: translateY(-8px) scale(1.05);
            box-shadow: 0 25px 50px rgba(239,68,68,0.6);
        }

        /* Modal siêu sang */
        .modal-content {
            background: rgba(30,41,59,0.98);
            border: 1px solid var(--border);
            border-radius: 32px;
            backdrop-filter: blur(20px);
        }
        .modal-header {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border-radius: 32px 32px 0 0;
            padding: 2rem;
        }
        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
        }

        .info-section {
            background: rgba(15,23,42,0.8);
            border-radius: 24px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border);
            transition: all 0.4s;
        }
        .info-section:hover {
            border-color: var(--accent);
            box-shadow: 0 20px 40px rgba(6,182,212,0.3);
            transform: translateY(-8px);
        }
        .info-section h5 {
            color: var(--gold);
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            font-family: 'Playfair Display', serif;
        }
        .info-item {
            margin-bottom: 1.2rem;
            font-size: 1.15rem;
        }
        .info-label {
            color: var(--gold);
            font-weight: 700;
            min-width: 160px;
            display: inline-block;
        }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3.5rem; }
            .order-id { font-size: 1.6rem; }
            .detail-card { padding: 3rem 2rem; border-radius: 28px; }
            .action-buttons { flex-direction: column; align-items: center; }
            .btn-action { width: 90%; }
            .info-section { padding: 2rem; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<div class="header-title">
    <h1>Chi tiết đơn đặt</h1>
    <% if (booking != null) { %>
        <p class="order-id">#<%= booking.getMaDon() %></p>
    <% } %>
</div>

<div class="container-main">

    <% if (error != null) { %>
        <div class="detail-card text-center py-5">
            <i class="fas fa-exclamation-triangle" style="font-size: 5rem; color: var(--danger); margin-bottom: 2rem;"></i>
            <h3>Lỗi hệ thống</h3>
            <p><%= error %></p>
        </div>
    <% } else if (booking == null) { %>
        <div class="detail-card text-center py-5">
            <i class="fas fa-times-circle" style="font-size: 5rem; color: var(--danger); margin-bottom: 2rem;"></i>
            <h3>Không tìm thấy đơn đặt phòng</h3>
        </div>
    <% } else { %>

        <div class="detail-card text-center">
            <button type="button" class="btn btn-detail" data-bs-toggle="modal" data-bs-target="#bookingDetailModal">
                Xem chi tiết đơn đặt phòng
            </button>

            <div class="action-buttons">
                <a href="dondatphong?action=list" class="btn btn-action btn-back">
                    Quay lại danh sách
                </a>
                <a href="dondatphong?action=cancel&bookingId=<%= booking.getId() %>"
                   class="btn btn-action btn-cancel"
                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn này không?')">
                    Hủy đơn đặt phòng
                </a>
            </div>
        </div>
    <% } %>

</div>

<!-- Modal Chi Tiết Siêu Sang -->
<% if (booking != null) { %>
<div class="modal fade" id="bookingDetailModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    Chi tiết đơn đặt phòng
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-5">

                <div class="row g-4">

                    <!-- Thông tin đặt phòng -->
                    <div class="col-lg-4">
                        <div class="info-section">
                            <h5>Thông tin đặt phòng</h5>
                            <div class="info-item"><span class="info-label">Mã đơn:</span> <strong class="text-info">#<%= booking.getMaDon() %></strong></div>
                            <div class="info-item"><span class="info-label">Khách hàng:</span> <%= booking.getTenKhachHang() %></div>
                            <div class="info-item"><span class="info-label">Nhận phòng:</span> <%= booking.getNgayNhan() %></div>
                            <div class="info-item"><span class="info-label">Trả phòng:</span> <%= booking.getNgayTra() %></div>
                            <div class="info-item"><span class="info-label">Thời gian đặt:</span> <%= booking.getThoiGianDat() %></div>
                        </div>
                    </div>

                    <!-- Thông tin phòng -->
                    <div class="col-lg-4">
                        <div class="info-section">
                            <h5>Thông tin phòng</h5>
                            <% if (phong != null) { %>
                                <div class="info-item"><span class="info-label">Tên phòng:</span> <%= phong.getTenPhong() %></div>
                                <div class="info-item"><span class="info-label">Loại phòng:</span> <%= phong.getLoai() %></div>
                                <div class="info-item"><span class="info-label">Giá/đêm:</span> 
                                    <strong class="text-success"><%= String.format("%,d", phong.getGia()) %> VNĐ</strong>
                                </div>
                                <div class="info-item"><span class="info-label">Sức chứa:</span> <%= phong.getSucChua() %> người</div>
                                <% if (phong.getMoTa() != null && !phong.getMoTa().isEmpty()) { %>
                                    <div class="info-item"><span class="info-label">Mô tả:</span> <%= phong.getMoTa() %></div>
                                <% } %>
                            <% } else { %>
                                <p class="text-muted">Không có thông tin phòng.</p>
                            <% } %>
                        </div>
                    </div>

                    <!-- Thông tin khách sạn -->
                    <div class="col-lg-4">
                        <div class="info-section">
                            <h5>Thông tin khách sạn</h5>
                            <% if (khachSan != null) { %>
                                <div class="info-item"><span class="info-label">Tên:</span> <%= khachSan.getTen() %></div>
                                <div class="info-item"><span class="info-label">Địa chỉ:</span> <%= khachSan.getDiaChi() %></div>
                                <% if (khachSan.getSoDienThoai() != null) { %>
                                    <div class="info-item"><span class="info-label">Điện thoại:</span> <%= khachSan.getSoDienThoai() %></div>
                                <% } %>
                            <% } else { %>
                                <p class="text-muted">Không có thông tin khách sạn.</p>
                            <% } %>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary px-5 py-3" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>