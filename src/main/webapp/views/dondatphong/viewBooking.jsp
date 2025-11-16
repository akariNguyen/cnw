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
    <title>Chi tiết đơn đặt phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f4f7fc; font-family: 'Inter', sans-serif; color: #333; }
        .header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white; padding: 3rem 0; text-align: center;
            border-radius: 0 0 20px 20px; box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .header img { max-width: 100%; height: auto; border-radius: 15px; margin-bottom: 1.5rem; opacity: 0.9; }
        .header img:hover { transform: scale(1.02); }
        .header h2 { font-weight: 700; font-size: 2rem; text-transform: uppercase; }

        .detail-container {
            background: white; border-radius: 15px; box-shadow: 0 8px 16px rgba(0,0,0,0.05);
            padding: 2rem; margin: 2rem auto; max-width: 800px;
        }
        .detail-item { margin-bottom: 1rem; }
        .detail-item strong { color: #1e3a8a; font-weight: 600; min-width: 150px; display: inline-block; }
        .btn { border-radius: 25px; padding: 0.5rem 1.5rem; transition: all 0.3s ease; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }

        /* Modal */
        .modal-header { background: #1e3a8a; color: white; }
        .modal-title i { margin-right: 0.5rem; }
        .info-group { margin-bottom: 1.5rem; }
        .info-group h6 { color: #1e3a8a; border-bottom: 2px solid #3b82f6; padding-bottom: 0.5rem; }
        .room-img { max-height: 200px; object-fit: cover; border-radius: 10px; }
        .hotel-img { max-height: 150px; object-fit: cover; border-radius: 10px; }

        @media (max-width: 768px) {
            .header h2 { font-size: 1.5rem; }
            .detail-container { padding: 1.5rem; margin: 1rem; }
            .detail-item strong { display: block; min-width: auto; }
            .btn { width: 100%; margin-bottom: 0.5rem; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <img src="https://images.unsplash.com/photo-1542314831-8f7d16dd2b3b" alt="Hotel" class="img-fluid">
        <h2>Chi Tiết Đơn Đặt Phòng</h2>
    </div>

    <!-- Detail Container -->
    <div class="container detail-container">
        <% if (error != null) { %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <div><%= error %></div>
            </div>
        <% } else if (booking == null) { %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <div>Không tìm thấy đơn đặt phòng.</div>
            </div>
        <% } else { %>
            <div class="text-center mb-4">
                <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#bookingDetailModal">
                    Xem chi tiết đơn
                </button>
            </div>

            <div class="mt-3 text-center">
                <a href="dondatphong?action=list" class="btn btn-outline-secondary">
                    Quay lại danh sách
                </a>
                <a href="dondatphong?action=cancel&bookingId=<%= booking.getId() %>"
                   class="btn btn-danger"
                   onclick="return confirm('Bạn có chắc muốn hủy đơn này?')">
                    Hủy đơn
                </a>
            </div>
        <% } %>
    </div>

    <!-- POPUP: Chi tiết đơn + phòng + khách sạn -->
    <div class="modal fade" id="bookingDetailModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        Chi tiết đơn đặt phòng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <% if (booking != null) { %>
                        <div class="row">
                            <!-- Cột 1: Thông tin đơn -->
                            <div class="col-lg-4 info-group">
                                <h6>Thông tin đặt phòng</h6>
                                <p><strong>Mã đơn:</strong> <span class="text-primary"><%= booking.getMaDon() %></span></p>
                                <p><strong>Khách hàng:</strong> <%= booking.getTenKhachHang() %></p>
                                <p><strong>Nhận phòng:</strong> <%= booking.getNgayNhan() %></p>
                                <p><strong>Trả phòng:</strong> <%= booking.getNgayTra() %></p>
                                <p><strong>Thời gian đặt:</strong> <%= booking.getThoiGianDat() %></p>
                            </div>

                            <!-- Cột 2: Thông tin phòng -->
                            <div class="col-lg-4 info-group">
                                <h6>Thông tin phòng</h6>
                                <% if (phong != null) { %>
                                 
                                    <p><strong>Tên:</strong> <%= phong.getTenPhong() %></p>
                                    <p><strong>Loại:</strong> <%= phong.getLoai() %></p>
                                    <p><strong>Giá:</strong> <span class="text-success fw-bold"><%= String.format("%,d", phong.getGia()) %> VNĐ</span>/đêm</p>
                                    <p><strong>Sức chứa:</strong> <%= phong.getSucChua() %> người</p>
                                    <% if (phong.getMoTa() != null && !phong.getMoTa().isEmpty()) { %>
                                        <p><strong>Mô tả:</strong> <%= phong.getMoTa() %></p>
                                    <% } %>
                                <% } else { %>
                                    <p class="text-muted">Không có thông tin phòng.</p>
                                <% } %>
                            </div>

                            <!-- Cột 3: Thông tin khách sạn -->
                            <div class="col-lg-4 info-group">
                                <h6>Thông tin khách sạn</h6>
                                <% if (khachSan != null) { %>
                                   
                                    <p><strong>Tên:</strong> <%= khachSan.getTen() %></p>
                                    <p><strong>Địa chỉ:</strong> <%= khachSan.getDiaChi() %></p>
                                    <% if (khachSan.getSoDienThoai() != null) { %>
                                        <p><strong>Điện thoại:</strong> <%= khachSan.getSoDienThoai() %></p>
                                    <% } %>
                                   
                                   
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>