<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Phong" %>

<%
    List<Phong> list = (List<Phong>) request.getAttribute("listPhong");
    model.bean.KhachSan ks = (model.bean.KhachSan) request.getAttribute("khachSan");
    if (ks == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
        return;
    }
    String success = (String) session.getAttribute("success");
    if (success != null) session.removeAttribute("success");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phòng • <%= ks.getTen() %></title>
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
            background: url('https://images.unsplash.com/photo-1618776185824-8b52396b3172?w=1920') center/cover no-repeat;
            opacity: 0.25;
            z-index: -1;
        }

        .header-title {
            text-align: center;
            padding: 5rem 1rem 3rem;
            position: relative;
        }
        .header-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .header-title p {
            font-size: 1.4rem;
            color: var(--muted);
            margin-top: 1rem;
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

        .container-main {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .hotel-card {
            background: rgba(30,41,59,0.95);
            backdrop-filter: blur(20px);
            border-radius: 28px;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .hotel-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }
        .hotel-name {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: var(--gold);
            margin: 0;
        }

        .action-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }
        .btn-add-room {
            background: linear-gradient(135deg, var(--success), #059669);
            padding: 1.2rem 3rem;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 700;
            box-shadow: 0 15px 40px rgba(16,185,129,0.4);
            transition: all 0.4s;
        }
        .btn-add-room:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-8px);
        }

        .room-table {
            background: rgba(30,41,59,0.95);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(0,0,0,0.7);
        }
        .room-table thead {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .room-table tbody tr {
            transition: all 0.4s ease;
            background: rgba(15,23,42,0.7);
        }
        .room-table tbody tr:hover {
            background: rgba(6,182,212,0.25);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
        }
        .room-table td {
            vertical-align: middle;
            padding: 1.5rem 1.2rem;
        }
        .price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #ef4444;
        }
        .badge-type {
            background: var(--accent);
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
        }

        .btn-action {
            padding: 0.7rem 1.3rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        .btn-view { background: #3b82f6; }
        .btn-edit { background: #f59e0b; }
        .btn-delete { background: var(--danger); }

        .empty-state {
            text-align: center;
            padding: 6rem 2rem;
            color: var(--muted);
        }
        .empty-state i {
            font-size: 6rem;
            margin-bottom: 2rem;
            opacity: 0.5;
        }

        .alert {
            border-radius: 20px;
            padding: 1.5rem;
            text-align: center;
            font-weight: 600;
            margin-bottom: 2rem;
        }
        .alert-success { background: rgba(16,185,129,0.15); border: 1px solid var(--success); }
        .alert-danger { background: rgba(239,68,68,0.15); border: 1px solid var(--danger); }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3rem; }
            .back-btn { 
                position: static; 
                margin: 1rem auto; 
                display: block; 
                width: fit-content;
            }
            .action-header { flex-direction: column; text-align: center; }
            .hotel-card { padding: 1.5rem; }
            .room-table { font-size: 0.9rem; }
            .btn-action { display: block; width: 100%; margin: 0.4rem 0; }
        }
    </style>
</head>
<body>

<div class="page-bg"></div>

<a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="back-btn">
    Quay lại Dashboard
</a>

<div class="header-title">
    <h1>Quản Lý Phòng</h1>
    <p>Khách sạn: <strong style="color:var(--gold)"><%= ks.getTen() %></strong></p>
</div>

<div class="container-main">

    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <div class="hotel-card">
        <div class="action-header">
            <div>
                <h2 class="hotel-name"><%= ks.getTen() %></h2>
                <p class="text-muted mb-0"><i class="fas fa-map-marker-alt"></i> <%= ks.getDiaChi() %></p>
            </div>
            <a href="${pageContext.request.contextPath}/phong?action=addForm&khachSanId=<%= ks.getId() %>"
               class="btn btn-success btn-add-room">
                Thêm phòng mới
            </a>
        </div>
    </div>

    <% if (list == null || list.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-bed"></i>
            <h3>Chưa có phòng nào được thêm</h3>
            <p>Hãy bắt đầu bằng việc thêm phòng đầu tiên cho khách sạn của bạn</p>
            <a href="${pageContext.request.contextPath}/phong?action=addForm&khachSanId=<%= ks.getId() %>"
               class="btn btn-success btn-lg mt-3 btn-add-room">
                Thêm phòng đầu tiên
            </a>
        </div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover room-table align-middle">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên phòng</th>
                        <th>Loại phòng</th>
                        <th>Giá / đêm</th>
                        <th>Sức chứa</th>
                        <th>Hình ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; for (Phong p : list) { %>
                    <tr>
                        <td class="text-warning fw-bold"><%= i++ %></td>
                        <td><strong class="text-white"><%= p.getTenPhong() %></strong></td>
                        <td><span class="badge-type"><%= p.getLoai() %></span></td>
                        <td class="price"><%= String.format("%,d", p.getGia()) %> VNĐ</td>
                        <td><i class="fas fa-users text-info me-2"></i><%= p.getSucChua() %> người</td>
                        <td>
                            <% if (p.getHinhAnh() != null && !p.getHinhAnh().isEmpty()) { %>
                                <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenPhong() %>"
                                     style="width:100px;height:70px;object-fit:cover;border-radius:12px;box-shadow:0 8px 20px rgba(0,0,0,0.6);">
                            <% } else { %>
                                <span class="text-muted">Chưa có ảnh</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/phong?action=detail&id=<%= p.getId() %>"
                               class="btn btn-info btn-action btn-view">Xem</a>
                            <a href="${pageContext.request.contextPath}/phong?action=editForm&id=<%= p.getId() %>"
                               class="btn btn-warning btn-action btn-edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/phong?action=delete&id=<%= p.getId() %>"
                               onclick="return confirm('Xóa phòng <%= p.getTenPhong() %> vĩnh viễn?')"
                               class="btn btn-danger btn-action btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>