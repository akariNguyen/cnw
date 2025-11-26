<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.bean.KhachHang" %>
<%
    KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LUXE STAY - Hệ Thống Đặt Phòng Cao Cấp</title>
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

        /* Hero */
        .hero {
            height: 100vh;
            min-height: 680px;
            background: linear-gradient(rgba(15,23,42,0.92), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1611892441792-ae6af465f35c?w=1920&q=80') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, rgba(6,182,212,0.2), transparent 70%);
            animation: breathe 15s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 6.5rem;
            font-weight: 900;
            letter-spacing: -2px;
            background: linear-gradient(90deg, #06b6d4, #fbbf24, #06b6d4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: glow 5s ease-in-out infinite alternate;
        }
        @keyframes glow {
            from { filter: drop-shadow(0 0 20px #06b6d460); }
            to { filter: drop-shadow(0 0 50px #06b6d490); }
        }

        /* Top Bar */
        .top-bar {
            position: fixed;
            top: 0; left: 0; right: 0;
            background: rgba(15,23,42,0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(6,182,212,0.3);
            z-index: 9999;
            padding: 1rem 0;
            transition: all 0.4s;
        }
        .top-bar.scrolled { padding: 0.7rem 0; background: rgba(15,23,42,0.98); }

        /* Welcome Alert */
        .welcome-alert {
            background: rgba(30,41,59,0.9);
            border: 1px solid var(--border);
            border-left: 5px solid var(--accent);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            animation: slideDown 0.8s ease-out;
        }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }

        /* Ticker Banner */
        .ticker-wrapper {
            background: rgba(6, 182, 212, 0.15);
            backdrop-filter: blur(10px);
            border-top: 1px solid rgba(6, 182, 212, 0.3);
            border-bottom: 1px solid rgba(6, 182, 212, 0.3);
            overflow: hidden;
            padding: 14px 0;
            margin: 0;
        }
        .ticker {
            display: flex;
            animation: scroll-left 35s linear infinite;
            white-space: nowrap;
        }
        .ticker-item {
            display: flex;
            align-items: center;
            margin-right: 5rem;
            font-weight: 600;
            color: #fbbf24;
            font-size: 1.15rem;
        }
        .ticker-item i {
            color: #06b6d4;
            margin-right: 12px;
            font-size: 1.5rem;
            animation: pulse 2s infinite;
        }
        @keyframes scroll-left {
            0% { transform: translateX(100%); }
            100% { transform: translateX(-100%); }
        }
        @keyframes pulse { 0%,100% { opacity: 0.7; } 50% { opacity: 1; } }
        .ticker:hover { animation-play-state: paused; }

        .ticker-reverse {
            background: rgba(251, 191, 36, 0.12);
            border-top: 1px solid rgba(251, 191, 36, 0.3);
            border-bottom: 1px solid rgba(251, 191, 36, 0.3);
            margin: 2rem 0;
        }
        .ticker-reverse .ticker { animation: scroll-right 40s linear infinite; }
        @keyframes scroll-right {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        /* Feature Cards */
        .feature-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            transition: all 0.5s cubic-bezier(0.23,1,0.32,1);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(8px);
        }
        .feature-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            transform: scaleX(0); transition: transform 0.6s;
        }
        .feature-card:hover::before { transform: scaleX(1); }
        .feature-card:hover {
            transform: translateY(-15px) scale(1.03);
            border-color: var(--accent);
            box-shadow: 0 25px 50px rgba(6,182,212,0.25);
        }
        .feature-card i {
            font-size: 3.8rem;
            background: linear-gradient(135deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.2rem;
            transition: transform 0.4s;
        }
        .feature-card:hover i { transform: scale(1.2) rotate(8deg); }
        .feature-card a {
            display: inline-block;
            margin-top: 1rem;
            color: var(--accent);
            font-weight: 600;
            text-decoration: none;
            position: relative;
        }
        .feature-card a::after {
            content: ' →'; opacity: 0; transform: translateX(-10px); transition: all 0.3s;
        }
        .feature-card a:hover::after { opacity: 1; transform: translateX(8px); }

        /* Footer */
        .footer {
            background: #0f172a;
            border-top: 1px solid var(--border);
            padding: 3rem 0 2rem;
            text-align: center;
            margin-top: 5rem;
        }
        .footer a {
            color: #cbd5e1;
            font-size: 1.6rem;
            margin: 0 1rem;
            transition: all 0.4s;
        }
        .footer a:hover {
            color: var(--gold);
            transform: translateY(-8px) scale(1.3);
        }
    </style>
</head>
<body>

    <!-- Top Bar -->
    <div class="top-bar" id="topBar">
        <div class="container d-flex justify-content-between align-items-center text-white">
            <div>
                <%
                    if (khachHang != null) {
                %>
                    <i class="fas fa-crown text-warning me-2"></i>
                    Xin chào <strong style="color:#fbbf24;"><%= khachHang.getTen() %></strong>
                    <small class="mx-3">|</small>
                    <a href="khachhang?action=editProfile" class="text-info">Hồ sơ</a>
                    <small class="mx-2">|</small>
                    <a href="khachhang?action=logout" class="text-danger">Đăng xuất</a>
                <%
                    } else {
                %>
                    <i class="fas fa-user-circle me-2"></i>
                    <a href="dangnhap.jsp" class="text-info fw-semibold">Đăng nhập</a>
                    <span class="mx-2 text-muted">hoặc</span>
                    <a href="dangky.jsp" class="text-warning fw-bold">Đăng ký ngay</a>
                    <span class="ms-3 text-muted">để nhận ưu đãi VIP</span>
                <%
                    }
                %>
            </div>
            <small class="text-muted">LUXE STAY © 2025</small>
        </div>
    </div>

    <!-- Hero -->
    <section class="hero">
        <div class="container position-relative z-1">
            <h1>LUXE STAY</h1>
            <p class="mt-4 fs-3 text-white opacity-90">Trải nghiệm nghỉ dưỡng thượng lưu • Đặt phòng ngay hôm nay</p>
        </div>
    </section>

    <!-- Banner Chạy Ngang 1 -->
    <div class="ticker-wrapper">
        <div class="ticker">
            <div class="ticker-item"><i class="fas fa-gift"></i> Giảm 30% cho đặt phòng đầu tiên!</div>
            <div class="ticker-item"><i class="fas fa-star"></i> Khách sạn 5 sao mới khai trương tại Đà Nẵng</div>
            <div class="ticker-item"><i class="fas fa-bolt"></i> Flash Sale 11.11 – Chỉ từ 899k/đêm</div>
            <div class="ticker-item"><i class="fas fa-crown"></i> Thành viên VIP nhận thêm 10% hoàn tiền</div>
            <div class="ticker-item"><i class="fas fa-plane"></i> Ưu đãi đặc biệt cho khách từ Hà Nội & TP.HCM</div>
            <div class="ticker-item"><i class="fas fa-gift"></i> Giảm 30% cho đặt phòng đầu tiên!</div>
        </div>
    </div>

    <!-- Welcome Message -->
    <div class="container my-5">
        <div class="welcome-alert p-4">
            <%
                if (khachHang != null) {
            %>
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle text-success fs-3 me-3"></i>
                    <div>
                        Chào mừng quay lại, <strong class="text-warning"><%= khachHang.getTen() %></strong>! 
                        Bạn đã sẵn sàng cho kỳ nghỉ tiếp theo chưa?
                    </div>
                </div>
            <%
                } else {
            %>
                <div class="d-flex align-items-center">
                    <i class="fas fa-gift text-info fs-3 me-3"></i>
                    <div>
                        <strong>Đăng nhập</strong> ngay để nhận <span class="text-warning">ưu đãi độc quyền</span> 
                        và trải nghiệm dịch vụ cao cấp nhất!
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Banner Chạy Ngược -->
    <div class="ticker-reverse">
        <div class="ticker">
            <div class="ticker-item"><i class="fas fa-fire"></i> HOT DEAL: Villa biển Phú Quốc chỉ 2.990k/đêm</div>
            <div class="ticker-item"><i class="fas fa-heart"></i> Ưu đãi dành riêng cho cặp đôi trăng mật</div>
            <div class="ticker-item"><i class="fas fa-clock"></i> Chỉ còn 48 giờ để đặt giá siêu hời!</div>
            <div class="ticker-item"><i class="fas fa-shield-alt"></i> Bảo hiểm hủy phòng miễn phí 100%</div>
            <div class="ticker-item"><i class="fas fa-fire"></i> HOT DEAL: Villa biển Phú Quốc chỉ 2.990k/đêm</div>
        </div>
    </div>

    <!-- Features -->
    <div class="container my-5">
        <h2 class="text-center mb-5" style="font-family:'Playfair Display',serif; font-size:3.2rem; color:#fff;">
            Khám Phá Tính Năng
        </h2>
        <div class="row g-5 justify-content-center">
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-hotel"></i>
                    <h5 class="mt-3">Khách Sạn Cao Cấp</h5>
                    <p class="text-muted">Hàng trăm khách sạn 4-5 sao đang chờ bạn khám phá</p>
                    <a href="khachsan?action=list">Xem danh sách</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-calendar-check"></i>
                    <h5 class="mt-3">Quản Lý Đơn Phòng</h5>
                    <p class="text-muted">Theo dõi và quản lý mọi đơn đặt phòng của bạn</p>
                    <a href="dondatphong?action=list">Vào ngay</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-search-location"></i>
                    <h5 class="mt-3">Kiểm Tra Phòng Trống</h5>
                    <p class="text-muted">Tìm phòng phù hợp theo ngày một cách nhanh chóng</p>
                    <a href="tinhtrangphong?action=list">Kiểm tra</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p class="mb-3">© 2025 Hệ Thống Đặt Phòng Khách Sạn Cao Cấp - LUXE STAY</p>
            <div>
                <a href="https://www.facebook.com/haoo.ayy/" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-tiktok"></i></a>
            </div>
            <p class="mt-3 text-muted small">Liên hệ: haoo.ayy@gmail.com</p>
        </div>
    </footer>

    <script>
        window.addEventListener('scroll', () => {
            document.getElementById('topBar').classList.toggle('scrolled', window.scrollY > 80);
        });
    </script>
</body>
</html>