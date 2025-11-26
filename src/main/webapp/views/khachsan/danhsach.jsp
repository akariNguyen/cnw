<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.KhachSan" %>
<%
    List<KhachSan> list = (List<KhachSan>) request.getAttribute("listKhachSan");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Khách Sạn • LUXE STAY</title>
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

        /* Background */
        .list-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.94), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1611892441792-ae6af465f35c?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .list-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top center, rgba(6,182,212,0.18), transparent 70%);
            animation: breathe 20s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        /* Header */
        .list-header {
            text-align: center;
            padding: 6rem 1rem 4rem;
        }
        .list-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }
        .list-header p { font-size: 1.3rem; color: var(--text-muted); }

        /* Search Bar */
        .search-container {
            max-width: 700px;
            margin: 0 auto 3rem;
            position: relative;
            z-index: 10;
        }
        .search-box {
            background: rgba(30,41,59,0.9);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 50px;
            padding: 1rem 1.5rem;
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
        }
        .search-box input {
            background: transparent;
            border: none;
            color: white;
            font-size: 1.2rem;
            width: 100%;
            padding-left: 3.5rem;
        }
        .search-box input::placeholder { color: #94a3b8; font-style: italic; }
        .search-box i {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.5rem;
        }

        /* Hotel Grid */
        .hotel-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 2.5rem;
            padding: 0 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Hotel Card */
        .hotel-card {
            background: rgba(30,41,59,0.92);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
            transition: all 0.5s ease;
            position: relative;
            border: 1px solid var(--border);
        }
        .hotel-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }
        .hotel-card:hover {
            transform: translateY(-20px) scale(1.03);
            box-shadow: 0 40px 80px rgba(6,182,212,0.4);
        }

        .hotel-img {
            height: 220px;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.6)),
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&q=80') center/cover;
            position: relative;
        }
        .hotel-name {
            position: absolute;
            bottom: 1.5rem;
            left: 1.5rem;
            color: white;
            font-size: 2rem;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
            text-shadow: 0 4px 10px rgba(0,0,0,0.8);
        }

        .hotel-info {
            padding: 2rem;
        }
        .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            color: var(--text-muted);
        }
        .info-row i {
            color: var(--accent);
            margin-right: 1rem;
            font-size: 1.3rem;
            width: 30px;
        }
        .info-row strong { color: var(--gold); min-width: 100px; }

        .hotel-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        .btn-detail {
            flex: 1;
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .btn-detail:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-5px);
        }
        .btn-rooms {
            flex: 1;
            background: transparent;
            color: var(--text);
            border: 2px solid var(--border);
            padding: 1rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .btn-rooms:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(6,182,212,0.1);
        }

        .no-data {
            text-align: center;
            padding: 8rem 2rem;
            color: var(--text-muted);
        }
        .no-data i { font-size: 6rem; margin-bottom: 2rem; color: #475569; }

        .back-home {
            display: block;
            text-align: center;
            margin: 4rem auto 2rem;
            max-width: 300px;
            background: transparent;
            color: var(--text-muted);
            border: 2px solid var(--border);
            padding: 1rem 3rem;
            border-radius: 50px;
            font-size: 1.1rem;
            transition: all 0.4s;
        }
        .back-home:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(6,182,212,0.1);
        }

        @media (max-width: 768px) {
            .list-header h1 { font-size: 3rem; }
            .hotel-grid { grid-template-columns: 1fr; padding: 0 1rem; }
            .hotel-actions { flex-direction: column; }
        }
    </style>
</head>
<body>

    <div class="list-bg"></div>

    <!-- Header -->
    <div class="list-header">
        <h1>Khách Sạn Sang Trọng</h1>
        <p>Khám phá những điểm đến đẳng cấp nhất Việt Nam</p>
    </div>

    <div class="container">
        <!-- Search Bar -->
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Tìm khách sạn theo tên hoặc địa chỉ...">
            </div>
        </div>

        <!-- Hotel Grid -->
        <div class="hotel-grid">
            <% if (list == null || list.isEmpty()) { %>
                <div class="no-data">
                    <i class="fas fa-hotel"></i>
                    <h2>Chưa có khách sạn nào trong hệ thống</h2>
                    <p>Hãy đăng ký làm chủ khách sạn ngay hôm nay!</p>
                </div>
            <% } else { %>
                <% for (KhachSan ks : list) { %>
                    <div class="hotel-card">
                        <div class="hotel-img">
                            <div class="hotel-name"><%= ks.getTen() %></div>
                        </div>
                        <div class="hotel-info">
                            <div class="info-row">
                                <i class="fas fa-map-marker-alt"></i>
                                <div>
                                    <strong>Địa chỉ</strong><br>
                                    <span><%= ks.getDiaChi() %></span>
                                </div>
                            </div>
                            <div class="info-row">
                                <i class="fas fa-phone-alt"></i>
                                <div>
                                    <strong>Liên hệ</strong><br>
                                    <span><%= ks.getSoDienThoai() %></span>
                                </div>
                            </div>
                            <div class="info-row">
                                <i class="fas fa-info-circle"></i>
                                <div>
                                    <strong>Mô tả</strong><br>
                                    <span><%= ks.getMoTa() != null && !ks.getMoTa().isEmpty() ? ks.getMoTa().substring(0, Math.min(ks.getMoTa().length(), 80)) + "..." : "Khách sạn sang trọng với dịch vụ 5 sao" %></span>
                                </div>
                            </div>

                            <div class="hotel-actions">
                                <a href="${pageContext.request.contextPath}/khachsan?action=detail&id=<%= ks.getId() %>" 
                                   class="btn-detail">
                                    <i class="fas fa-eye me-2"></i> Xem Chi Tiết
                                </a>
                                <a href="${pageContext.request.contextPath}/phong?action=list&khachSanId=<%= ks.getId() %>" 
                                   class="btn-rooms">
                                    <i class="fas fa-bed me-2"></i> Xem Phòng
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>

        <!-- Back to Home -->
        <a href="${pageContext.request.contextPath}/index.jsp" class="back-home">
            <i class="fas fa-home me-2"></i> Về Trang Chủ
        </a>
    </div>

    <script>
        // Live Search
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const text = e.target.value.toLowerCase();
            document.querySelectorAll('.hotel-card').forEach(card => {
                const name = card.querySelector('.hotel-name').textContent.toLowerCase();
                const address = card.querySelector('.info-row span').textContent.toLowerCase();
                card.style.display = (name.includes(text) || address.includes(text)) ? '' : 'none';
            });
        });
    </script>
</body>
</html>