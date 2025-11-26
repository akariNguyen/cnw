<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.bean.*, model.dao.*" %>

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

    DonDatPhongDAO ddpDAO = new DonDatPhongDAO();
    List<DonDatPhong> list = ddpDAO.getByKhachSanId(ks.getId());
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn đặt phòng • <%= ks.getTen() %></title>
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
            background: url('https://images.unsplash.com/photo-1611892441792-ae6af465f0d4?w=1920') center/cover no-repeat;
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
        .hotel-name {
            font-size: 2rem;
            color: var(--gold);
            font-weight: 700;
            margin-top: 1rem;
        }

        .container-main {
            max-width: 1300px;
            margin: 0 auto 6rem;
            padding: 2rem;
        }

        .main-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(22px);
            border-radius: 36px;
            padding: 3.5rem;
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

        .table-orders {
            background: rgba(15,23,42,0.95);
            border-radius: 20px;
            overflow: hidden;
        }
        .table-orders thead {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .table-orders tbody tr {
            transition: all 0.4s;
        }
        .table-orders tbody tr:hover {
            background: rgba(6,182,212,0.22);
            transform: translateY(-6px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.6);
        }

        .btn-detail {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
            padding: 0.7rem 1.8rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.95rem;
            box-shadow: 0 10px 25px rgba(59,130,246,0.4);
            transition: all 0.4s;
        }
        .btn-detail:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow: 0 20px 40px rgba(59,130,246,0.6);
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

        .modal-content {
            background: rgba(30,41,59,0.98);
            border: 1px solid var(--border);
            border-radius: 28px;
            backdrop-filter: blur(20px);
        }
        .modal-header {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border-bottom: none;
        }
        .nav-tabs .nav-link {
            color: var(--muted);
            border-radius: 16px;
            padding: 1rem 2rem;
            font-weight: 600;
        }
        .nav-tabs .nav-link.active {
            background: var(--accent);
            color: white;
            border-color: var(--accent);
        }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3rem; }
            .back-btn { position: static; margin: 1.5rem auto; display: block; width: fit-content; }
            .main-card { padding: 2rem; border-radius: 28px; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="back-btn">
    Quay lại Dashboard
</a>

<div class="header-title">
    <h1>Đơn đặt phòng</h1>
    <p class="hotel-name"><%= ks.getTen() %></p>
</div>

<div class="container-main">
    <div class="main-card">

        <% if (list == null || list.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h3>Chưa có đơn đặt phòng nào</h3>
                <p>Khách sạn đang chờ những vị khách đầu tiên!</p>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover table-orders align-middle">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Tên khách</th>
                            <th>Phòng</th>
                            <th>Ngày nhận</th>
                            <th>Ngày trả</th>
                            <th>Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DonDatPhong d : list) { %>
                        <tr>
                            <td><strong class="text-info">#<%= d.getMaDon() %></strong></td>
                            <td><strong><%= d.getTenKhachHang() %></strong></td>
                            <td><%= d.getTenPhong() %></td>
                            <td><%= d.getNgayNhan() %></td>
                            <td><%= d.getNgayTra() %></td>
                            <td>
                                <button class="btn btn-detail" 
                                        onclick="openDetailModal(<%= d.getKhachHangId() %>, <%= d.getPhongId() %>, '<%= d.getMaDon() %>')">
                                    Xem chi tiết
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>
</div>

<!-- Modal giữ nguyên logic cũ 100% -->
<div class="modal fade" id="detailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">Chi tiết đơn đặt phòng</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs mb-4">
                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#customer">Thông tin khách hàng</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#room">Thông tin phòng</button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="customer">
                        <div id="customerContent" class="p-3">Đang tải...</div>
                    </div>
                    <div class="tab-pane fade" id="room">
                        <div id="roomContent" class="p-3">Đang tải...</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openDetailModal(khachHangId, phongId, maDon) {
        document.getElementById('detailModalLabel').textContent = 'Chi tiết đơn đặt phòng: ' + maDon;

        fetch('${pageContext.request.contextPath}/khachhang?action=detail&id=' + khachHangId)
            .then(r => r.text())
            .then(html => document.getElementById('customerContent').innerHTML = html)
            .catch(() => document.getElementById('customerContent').innerHTML = '<div class="alert alert-danger">Lỗi tải thông tin khách hàng</div>');

        fetch('${pageContext.request.contextPath}/phong?action=detail&id=' + phongId)
            .then(r => r.text())
            .then(html => document.getElementById('roomContent').innerHTML = html)
            .catch(() => document.getElementById('roomContent').innerHTML = '<div class="alert alert-danger">Lỗi tải thông tin phòng</div>');

        new bootstrap.Modal(document.getElementById('detailModal')).show();
    }
</script>

</body>
</html>