<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.DonDatPhong" %>
<%@ page import="model.bean.KhachHang" %>
<%
    KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
    if (khachHang == null) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn đặt phòng • <%= khachHang.getTen() %> • LUXE HOTEL</title>
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
        .welcome-text {
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

        .main-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(25px);
            border-radius: 40px;
            padding: 4rem;
            box-shadow: 0 60px 140px rgba(0,0,0,0.9);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .main-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 14px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .search-box {
            position: relative;
            max-width: 500px;
            margin-left: auto;
        }
        .search-box input {
            background: rgba(15,23,42,0.9);
            border: 1px solid var(--border);
            color: var(--text);
            border-radius: 50px;
            padding: 1.2rem 1.8rem 1.2rem 4.5rem;
            font-size: 1.1rem;
        }
        .search-box input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.3rem rgba(6,182,212,0.3);
        }
        .search-box i {
            position: absolute;
            left: 1.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.4rem;
        }

        .table-bookings {
            background: rgba(15,23,42,0.95);
            border-radius: 24px;
            overflow: hidden;
            margin-top: 3rem;
        }
        .table-bookings thead {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .table-bookings tbody tr {
            transition: all 0.5s;
        }
        .table-bookings tbody tr:hover {
            background: rgba(6,182,212,0.25);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
        }

        .btn-view {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 700;
        }
        .btn-view:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(59,130,246,0.5);
        }

        .btn-cancel {
            background: linear-gradient(135deg, var(--danger), #dc2626);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 700;
        }
        .btn-cancel:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(239,68,68,0.5);
        }

        .empty-state {
            text-align: center;
            padding: 8rem 2rem;
            color: var(--muted);
        }
        .empty-state i {
            font-size: 6rem;
            margin-bottom: 2rem;
            opacity: 0.6;
        }

        .back-home {
            display: block;
            width: fit-content;
            margin: 3rem auto 0;
            padding: 1.2rem 3rem;
            background: rgba(100,100,100,0.6);
            color: white;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .back-home:hover {
            background: var(--accent);
            transform: translateY(-5px);
        }

        .alert {
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: none;
        }
        .alert-success { background: rgba(16,185,129,0.2); border: 1px solid var(--success); }
        .alert-danger { background: rgba(239,68,68,0.2); border: 1px solid var(--danger); }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3.5rem; }
            .welcome-text { font-size: 1.6rem; }
            .main-card { padding: 3rem 2rem; border-radius: 28px; }
            .search-box { max-width: 100%; margin: 2rem 0; }
            .table-bookings { font-size: 0.9rem; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<div class="header-title">
    <h1>Đơn đặt phòng</h1>
    <p class="welcome-text">Xin chào, <%= khachHang.getTen() %>!</p>
</div>

<div class="container-main">
    <div class="main-card">

        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="alert alert-danger text-center">
                <strong>Lỗi:</strong> <%= error %>
            </div>
        <% } else if (success != null) { %>
            <div class="alert alert-success text-center">
                <strong>Thành công!</strong> <%= success %>
            </div>
        <% } %>

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
            <h3 class="text-gold fw-bold">Danh sách đơn của bạn</h3>
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="form-control" placeholder="Tìm mã đơn hoặc tên phòng...">
            </div>
        </div>

        <%
            List<DonDatPhong> list = (List<DonDatPhong>) request.getAttribute("listDonDat");
            if (list == null || list.isEmpty()) {
        %>
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h3>Chưa có đơn đặt phòng nào</h3>
                <p>Hãy khám phá và đặt phòng ngay hôm nay!</p>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover table-bookings align-middle" id="bookingTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Mã đơn</th>
                            <th>Phòng</th>
                            <th>Nhận phòng</th>
                            <th>Trả phòng</th>
                            <th>Thời gian đặt</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int i = 1;
                            for (DonDatPhong d : list) {
                        %>
                        <tr>
                            <td><strong class="text-info"><%= i++ %></strong></td>
                            <td><strong class="text-gold">#<%= d.getMaDon() != null ? d.getMaDon() : "N/A" %></strong></td>
                            <td><%= d.getTenPhong() != null ? d.getTenPhong() : "N/A" %></td>
                            <td><%= d.getNgayNhan() != null ? d.getNgayNhan() : "N/A" %></td>
                            <td><%= d.getNgayTra() != null ? d.getNgayTra() : "N/A" %></td>
                            <td><%= d.getThoiGianDat() != null ? d.getThoiGianDat() : "N/A" %></td>
                            <td>
                                <a href="dondatphong?action=view&bookingId=<%= d.getId() %>" class="btn btn-view btn-sm">
                                    Xem
                                </a>
                                <button type="button" class="btn btn-cancel btn-sm" data-bs-toggle="modal" data-bs-target="#cancelModal<%= d.getId() %>">
                                    Hủy
                                </button>

                                <!-- Modal xác nhận hủy -->
                                <div class="modal fade" id="cancelModal<%= d.getId() %>" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content bg-dark text-light border-accent">
                                            <div class="modal-header border-0">
                                                <h5 class="modal-title text-gold">Xác nhận hủy đơn</h5>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-center py-4">
                                                <i class="fas fa-exclamation-triangle text-danger" style="font-size: 3rem;"></i>
                                                <p class="mt-3">Bạn có chắc chắn muốn <strong class="text-danger">hủy đơn #<%= d.getMaDon() %></strong> không?</p>
                                            </div>
                                            <div class="modal-footer border-0 justify-content-center">
                                                <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                                                <a href="dondatphong?action=cancel&bookingId=<%= d.getId() %>" class="btn btn-danger px-5">
                                                    Xác nhận hủy
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

        <a href="index.jsp" class="back-home">
            Quay lại trang chủ
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tìm kiếm realtime (giữ nguyên logic cũ)
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const text = e.target.value.toLowerCase();
        document.querySelectorAll('#bookingTable tbody tr').forEach(row => {
            const maDon = row.cells[1].textContent.toLowerCase();
            const tenPhong = row.cells[2].textContent.toLowerCase();
            row.style.display = (maDon.includes(text) || tenPhong.includes(text)) ? '' : 'none';
        });
    });
</script>
</body>
</html>