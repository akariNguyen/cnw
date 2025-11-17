<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.KhachSan" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phòng trống từ ngày đến ngày</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        body { background: #f8fafc; font-family: 'Segoe UI', sans-serif; color: #2d3748; }
        .header {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            padding: 4rem 0;
            text-align: center;
            border-radius: 0 0 30px 30px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
        }
        .header h1 { font-weight: 800; font-size: 2.8rem; }
        .search-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 2.5rem;
            margin: -4rem auto 3rem;
            max-width: 900px;
            position: relative;
            z-index: 10;
        }
        .result-header {
            background: #eef2ff;
            border-left: 6px solid #6366f1;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .hotel-card {
            background: white;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            overflow: hidden;
            margin-bottom: 1.8rem;
            transition: all 0.3s ease;
        }
        .hotel-card:hover { transform: translateY(-8px); box-shadow: 0 15px 40px rgba(0,0,0,0.15); }
        .hotel-name {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            padding: 1.2rem 2rem;
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }
        .room-count {
            background: #10b981;
            color: white;
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        .table thead { background: #6366f1; color: white; }
        .table td { vertical-align: middle; }
        .price { font-size: 1.3rem; color: #dc2626; font-weight: 700; }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <div class="container">
        <h1><i class="fas fa-calendar-check me-3"></i> Phòng Trống Từ Ngày Đến Ngày</h1>
        <p class="lead mb-0">Xem tất cả phòng còn trống toàn bộ khoảng thời gian bạn chọn</p>
    </div>
</div>

<div class="container">

    <!-- Form tìm kiếm -->
    <div class="search-card">
        <form action="tinhtrangphong" method="get" class="row g-4">
            <div class="col-md-5">
                <label class="form-label fs-5 fw-bold text-primary"><i class="fas fa-sign-in-alt"></i> Từ ngày</label>
                <input type="date" name="from" class="form-control form-control-lg" required
                       value="<%= request.getParameter("from") != null ? request.getParameter("from") : "" %>">
            </div>
            <div class="col-md-5">
                <label class="form-label fs-5 fw-bold text-primary"><i class="fas fa-sign-out-alt"></i> Đến ngày</label>
                <input type="date" name="to" class="form-control form-control-lg" required
                       value="<%= request.getParameter("to") != null ? request.getParameter("to") : "" %>">
            </div>
            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary btn-lg w-100 shadow">
                    <i class="fas fa-search"></i> Tìm
                </button>
            </div>
        </form>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger text-center fs-5"><i class="fas fa-exclamation-triangle"></i> <%= error %></div>
    <%
        }

        Map<KhachSan, List<Map<String, Object>>> ketQua = (Map<KhachSan, List<Map<String, Object>>>) request.getAttribute("ketQua");
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        if (from != null && to != null) {
    %>
        <!-- Kết quả -->
        <div class="result-header text-center">
            <h3 class="mb-0">
                <i class="fas fa-check-circle text-success"></i>
                Phòng trống từ <strong class="text-primary"><%= from %></strong> đến <strong class="text-primary"><%= to %></strong>
            </h3>
            <p class="mb-0 mt-2 text-muted">
                Tổng cộng <%= (java.sql.Date.valueOf(to).getTime() - java.sql.Date.valueOf(from).getTime()) / 86400000 + 1 %> ngày
            </p>
        </div>

        <% if (ketQua == null || ketQua.isEmpty()) { %>
            <div class="text-center py-5">
                <i class="fas fa-bed fa-6x text-muted mb-4"></i>
                <h2 class="text-muted">Không có phòng nào trống toàn bộ khoảng thời gian này</h2>
            </div>
        <% } else {
            for (Map.Entry<KhachSan, List<Map<String, Object>>> entry : ketQua.entrySet()) {
                KhachSan ks = entry.getKey();
                List<Map<String, Object>> dsPhong = entry.getValue();
        %>
            <div class="hotel-card">
                <h3 class="hotel-name">
                    <%= ks.getTen() %>
                    <span class="room-count float-end">
                        <i class="fas fa-bed"></i> <%= dsPhong.size() %> phòng trống
                    </span>
                </h3>
                <div class="p-4">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Tên phòng</th>
                                    <th>Loại phòng</th>
                                    <th>Giá/đêm</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Map<String, Object> p : dsPhong) { %>
                                    <tr>
                                        <td><strong><%= p.get("tenPhong") %></strong></td>
                                        <td><%= p.get("loai") %></td>
                                        <td><span class="price"><%= String.format("%,d", p.get("gia")) %> ₫</span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <% 
                }
            }
        %>
    <% } %>

    <div class="text-center mt-5">
        <a href="index.jsp" class="btn btn-outline-secondary btn-lg px-5">
            <i class="fas fa-home"></i> Về trang chủ
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>