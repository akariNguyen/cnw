<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.KhachHang" %>
<%
    KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
    String phongId = request.getParameter("phongId");

    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    String phongIdVal = request.getParameter("phong_id");
    if (phongIdVal == null) phongIdVal = (String) request.getAttribute("phongId");
    if (phongIdVal == null) phongIdVal = phongId;

    String ngayNhanVal = request.getParameter("ngay_nhan");
    if (ngayNhanVal == null) ngayNhanVal = (String) request.getAttribute("ngayNhan");

    String ngayTraVal = request.getParameter("ngay_tra");
    if (ngayTraVal == null) ngayTraVal = (String) request.getAttribute("ngayTra");

    String maDonVal = request.getParameter("ma_don");
    if (maDonVal == null || maDonVal.isEmpty()) {
        maDonVal = "MD" + System.currentTimeMillis();
    }
    if (request.getAttribute("maDon") != null) {
        maDonVal = (String) request.getAttribute("maDon");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt phòng • LUXE HOTEL</title>
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

        .header {
            text-align: center;
            padding: 6rem 1rem 4rem;
            position: relative;
        }
        .header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 5.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }
        .header p {
            font-size: 1.8rem;
            color: var(--gold);
            margin-top: 1rem;
            font-weight: 600;
        }

        .container-main {
            max-width: 600px;
            margin: 0 auto 8rem;
            padding: 2rem;
        }

        .booking-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(25px);
            border-radius: 40px;
            padding: 4rem 3.5rem;
            box-shadow: 0 60px 140px rgba(0,0,0,0.9);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .booking-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 14px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            border-radius: 40px 40px 0 0;
        }

        .form-label {
            color: var(--gold);
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 0.8rem;
        }

        .form-control {
            background: rgba(15,23,42,0.9);
            border: 1px solid var(--border);
            color: var(--text);
            border-radius: 20px;
            padding: 1.3rem 1.8rem 1.3rem 4rem;
            font-size: 1.1rem;
            transition: all 0.4s;
        }
        .form-control:focus {
            background: rgba(15,23,42,1);
            border-color: var(--accent);
            box-shadow: 0 0 0 0.3rem rgba(6,182,212,0.3);
            color: var(--text);
        }

        .input-group {
            position: relative;
        }
        .input-group i {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.4rem;
            z-index: 5;
        }

        .btn-book {
            background: linear-gradient(135deg, var(--success), #059669);
            color: white;
            padding: 1.4rem 4rem;
            border-radius: 60px;
            font-size: 1.4rem;
            font-weight: 700;
            width: 100%;
            margin-top: 2rem;
            transition: all 0.5s;
            box-shadow: 0 20px 40px rgba(16,185,129,0.4);
        }
        .btn-book:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 30px 60px rgba(16,185,129,0.6);
        }

        .alert {
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: none;
            font-weight: 600;
        }
        .alert-success {
            background: rgba(16,185,129,0.2);
            border: 1px solid var(--success);
            color: white;
        }
        .alert-danger {
            background: rgba(239,68,68,0.2);
            border: 1px solid var(--danger);
            color: white;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 3rem;
            color: var(--muted);
            font-size: 1.1rem;
            transition: color 0.3s;
        }
        .back-link:hover {
            color: var(--accent);
        }

        @media (max-width: 768px) {
            .header h1 { font-size: 3.5rem; }
            .header p { font-size: 1.5rem; }
            .booking-card { padding: 3rem 2rem; border-radius: 30px; }
            .btn-book { font-size: 1.2rem; padding: 1.2rem; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<!-- Header siêu sang -->
<div class="header">
    <h1>Đặt Phòng Ngay</h1>
    <p>Trải nghiệm dịch vụ thượng lưu • LUXE HOTEL</p>
</div>

<div class="container-main">

    <% if (khachHang == null) { %>
        <div class="booking-card text-center py-5">
            <i class="fas fa-user-lock Rồi, giờ chỉ cần đăng nhập để đặt phòng nhé!" style="font-size: 4rem; color: var(--danger); margin-bottom: 2rem;"></i>
            <h3>Bạn chưa đăng nhập</h3>
            <p>Vui lòng <a href="dangnhap.jsp" style="color: var(--accent); font-weight:700;">đăng nhập</a> để tiếp tục đặt phòng.</p>
        </div>
    <% } else if (phongIdVal == null) { %>
        <div class="booking-card text-center py-5">
            <i class="fas fa-exclamation-triangle" style="font-size: 4rem; color: var(--danger); margin-bottom: 2rem;"></i>
            <h3>Thiếu thông tin phòng</h3>
            <p>Không thể đặt phòng. Vui lòng quay lại và chọn phòng.</p>
        </div>
    <% } else { %>

        <div class="booking-card">

            <!-- Thông báo -->
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <strong>Lỗi:</strong> <%= error %>
                </div>
            <% } %>
            <% if (success != null) { %>
                <div class="alert alert-success">
                    <strong>Thành công!</strong> <%= success %>
                </div>
            <% } %>

            <form id="bookingForm" action="dondatphong" method="post">
                <input type="hidden" name="phong_id" value="<%= phongIdVal %>">
                <input type="hidden" name="khach_hang_id" value="<%= khachHang.getId() %>">

                <div class="mb-4">
                    <label class="form-label">Ngày nhận phòng</label>
                    <div class="input-group">
                        <i class="fas fa-calendar-check"></i>
                        <input type="date" class="form-control" id="ngay_nhan" name="ngay_nhan"
                               value="<%= ngayNhanVal != null ? ngayNhanVal : "" %>" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Ngày trả phòng</label>
                    <div class="input-group">
                        <i class="fas fa-calendar-times"></i>
                        <input type="date" class="form-control" id="ngay_tra" name="ngay_tra"
                               value="<%= ngayTraVal != null ? ngayTraVal : "" %>" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Mã đơn đặt (tự động nếu để trống)</label>
                    <div class="input-group">
                        <i class="fas fa-hashtag"></i>
                        <input type="text" class="form-control" id="ma_don" name="ma_don"
                               value="<%= maDonVal %>" placeholder="MD123456789">
                    </div>
                </div>

                <button type="submit" class="btn btn-book">
                    Xác nhận đặt phòng
                </button>
            </form>

            <a href="index.jsp" class="back-link">
                Quay lại trang chủ
            </a>
        </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Giữ nguyên toàn bộ logic validate cũ của đại ca
    document.getElementById('bookingForm')?.addEventListener('submit', function(e) {
        let isValid = true;
        const ngayNhan = document.getElementById('ngay_nhan')?.value;
        const ngayTra = document.getElementById('ngay_tra')?.value;

        const today = new Date().toISOString().split('T')[0];
        if (!ngayNhan || ngayNhan < today) {
            alert('Ngày nhận phòng phải từ hôm nay trở đi.');
            isValid = false;
        }
        if (!ngayTra || ngayTra <= ngayNhan) {
            alert('Ngày trả phòng phải sau ngày nhận phòng.');
            isValid = false;
        }

        if (!isValid) e.preventDefault();
    });
</script>
</body>
</html>