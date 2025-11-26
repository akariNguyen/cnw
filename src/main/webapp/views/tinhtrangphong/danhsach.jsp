<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.KhachSan" %>
<%
    Map<KhachSan, List<Map<String, Object>>> ketQua = (Map<KhachSan, List<Map<String, Object>>>) request.getAttribute("ketQua");
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phòng Trống • LUXE STAY</title>
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
            --success: #10b981;
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
        .bg-search {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.94), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .bg-search::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, rgba(6,182,212,0.2), transparent 70%);
            animation: breathe 22s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        /* Header */
        .search-header {
            text-align: center;
            padding: 5rem 1rem 3rem;
            position: relative;
            z-index: 1;
        }
        .search-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4.2rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }
        .search-header p {
            font-size: 1.3rem;
            color: var(--text-muted);
        }

        /* Search Card */
        .search-card {
            background: rgba(30, 41, 59, 0.92);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 2.8rem;
            max-width: 960px;
            margin: -4rem auto 3rem;
            box-shadow: 0 30px 80px rgba(0,0,0,0.7);
            position: relative;
            z-index: 10;
        }
        .search-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            border-radius: 28px 28px 0 0;
        }

        .form-control, .form-control:focus {
            background: rgba(15,23,42,0.9) !important;
            border: 1px solid var(--border);
            color: #ffffff !important;
            caret-color: var(--gold);
            border-radius: 16px;
            padding: 1rem 1.2rem;
            font-size: 1.1rem;
        }
        .form-control::placeholder {
            color: #94a3b8 !important;
            font-style: italic;
        }
        .btn-search {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 1rem 3rem;
            font-size: 1.2rem;
            font-weight: 600;
            box-shadow: 0 10px 30px rgba(6,182,212,0.4);
            transition: all 0.4s;
        }
        .btn-search:hover {
            transform: translateY(-5px);
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            box-shadow: 0 20px 40px rgba(251,191,36,0.5);
        }

        /* Result Header */
        .result-header {
            background: rgba(16,185,129,0.15);
            border-left: 6px solid var(--success);
            padding: 2rem;
            border-radius: 20px;
            text-align: center;
            margin: 3rem 0 2.5rem;
            backdrop-filter: blur(10px);
        }
        .result-header h3 {
            color: var(--gold);
            font-size: 2rem;
            font-weight: 700;
        }

        /* Hotel Card */
        .hotel-card {
            background: rgba(30, 41, 59, 0.9);
            border: 1px solid var(--border);
            border-radius: 24px;
            overflow: hidden;
            margin-bottom: 2.5rem;
            transition: all 0.5s ease;
            box-shadow: 0 15px 40px rgba(0,0,0,0.5);
        }
        .hotel-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 30px 70px rgba(6,182,212,0.3);
        }
        .hotel-name {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            padding: 1.8rem 2.5rem;
            font-size: 2rem;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
            position: relative;
        }
        .room-count {
            position: absolute;
            top: 1rem; right: 2rem;
            background: var(--gold);
            color: #000;
            padding: 0.6rem 1.4rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
        }

        .table {
            margin: 0;
            background: transparent;
        }
        .table thead {
            background: rgba(15,23,42,0.8);
            color: var(--gold);
        }
        .table tbody tr {
            transition: all 0.3s;
        }
        .table tbody tr:hover {
            background: rgba(6,182,212,0.15);
            transform: scale(1.02);
        }
        .price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #f87171;
            text-shadow: 0 0 10px rgba(248,113,113,0.4);
        }

        .no-result {
            text-align: center;
            padding: 6rem 2rem;
            color: var(--text-muted);
        }
        .no-result i {
            font-size: 6rem;
            color: #475569;
            margin-bottom: 2rem;
        }

        .back-home {
            display: inline-block;
            background: transparent;
            color: var(--text-muted);
            border: 2px solid var(--border);
            padding: 1rem 3rem;
            border-radius: 50px;
            font-size: 1.1rem;
            transition: all 0.4s;
            margin-top: 3rem;
        }
        .back-home:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(6,182,212,0.1);
        }

        @media (max-width: 768px) {
            .search-header h1 { font-size: 3rem; }
            .search-card { padding: 2rem; margin: -3rem auto 2rem; }
            .hotel-name { font-size: 1.6rem; padding: 1.5rem; }
            .room-count { position: static; display: inline-block; margin-top: 1rem; }
        }
    </style>
</head>
<body>

    <div class="bg-search"></div>

    <!-- Header -->
    <div class="search-header">
        <h1>Phòng Trống</h1>
        <p>Tìm phòng còn trống toàn bộ khoảng thời gian bạn chọn</p>
    </div>

    <div class="container">
        <!-- Form tìm kiếm -->
        <div class="search-card">
            <form action="${pageContext.request.contextPath}/tinhtrangphong" method="get" class="row g-4 align-items-end">
                <div class="col-md-5">
                    <label class="form-label fs-5 fw-bold text-info"><i class="fas fa-calendar-alt me-2"></i>Từ ngày</label>
                    <input type="date" name="from" class="form-control form-control-lg" required
                           value="<%= from != null ? from : "" %>">
                </div>
                <div class="col-md-5">
                    <label class="form-label fs-5 fw-bold text-info"><i class="fas fa-calendar-alt me-2"></i>Đến ngày</label>
                    <input type="date" name="to" class="form-control form-control-lg" required
                           value="<%= to != null ? to : "" %>">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-search w-100">
                        <i class="fas fa-search me-2"></i>Tìm Ngay
                    </button>
                </div>
            </form>
        </div>

        <% if (error != null) { %>
            <div class="alert alert-danger text-center fs-4 rounded-4 shadow">
                <i class="fas fa-exclamation-triangle me-3"></i><%= error %>
            </div>
        <% } %>

        <% if (from != null && to != null) { %>
            <div class="result-header">
                <h3>
                    Phòng trống từ <span class="text-accent"><%= from %></span> → <span class="text-accent"><%= to %></span>
                </h3>
                <p class="mt-2">
                    Tổng <%= (java.sql.Date.valueOf(to).getTime() - java.sql.Date.valueOf(from).getTime()) / 86400000 + 1 %> ngày
                </p>
            </div>

            <% if (ketQua == null || ketQua.isEmpty()) { %>
                <div class="no-result">
                    <i class="fas fa-bed"></i>
                    <h2>Không có phòng nào trống toàn bộ thời gian này</h2>
                    <p>Hãy thử chọn khoảng ngày khác nhé!</p>
                </div>
            <% } else { %>
                <% for (Map.Entry<KhachSan, List<Map<String, Object>>> entry : ketQua.entrySet()) {
                    KhachSan ks = entry.getKey();
                    List<Map<String, Object>> dsPhong = entry.getValue();
                %>
                    <div class="hotel-card">
                        <h3 class="hotel-name">
                            <%= ks.getTen() %>
                            <span class="room-count">
                                <%= dsPhong.size() %> phòng trống
                            </span>
                        </h3>
                        <div class="p-4">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
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
                                                <td><strong class="text-gold"><%= p.get("tenPhong") %></strong></td>
                                                <td><%= p.get("loai") %></td>
                                                <td><span class="price"><%= String.format("%,d", p.get("gia")) %> ₫</span></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } %>
        <% } %>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/index.jsp" class="back-home">
                <i class="fas fa-home me-2"></i> Về Trang Chủ
            </a>
        </div>
    </div>

</body>
</html>