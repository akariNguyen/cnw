<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký • LUXE STAY</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        /* Background */
        .register-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.94), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .register-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, rgba(6,182,212,0.18), transparent 70%);
            animation: breathe 20s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        /* Register Card */
        .register-card {
            background: rgba(30, 41, 59, 0.88);
            backdrop-filter: blur(18px);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 3.5rem 3rem;
            width: 100%;
            max-width: 560px;
            box-shadow: 0 25px 70px rgba(0,0,0,0.7);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 1s ease-out;
        }
        .register-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .register-header {
            text-align: center;
            margin-bottom: 2.8rem;
        }
        .register-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.6rem;
        }
        .register-header p {
            color: var(--text-muted);
            font-size: 1.15rem;
        }

        /* Input Group */
        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }
        .input-group i {
            position: absolute;
            top: 50%;
            left: 1.1rem;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.3rem;
            z-index: 10;
            transition: all 0.4s;
        }
        .form-control, .form-select {
            background: rgba(15,23,42,0.85) !important;
            border: 1px solid var(--border);
            color: #ffffff !important;
            caret-color: var(--gold);
            border-radius: 16px;
            padding: 0.95rem 1rem 0.95rem 3.2rem;
            font-size: 1rem;
            transition: all 0.4s;
        }
        .form-control::placeholder, .form-select::placeholder {
            color: #94a3b8 !important;
            font-style: italic;
        }
        .form-control:focus, .form-select:focus {
            background: rgba(15,23,42,0.95) !important;
            border-color: var(--accent) !important;
            box-shadow: 0 0 0 4px rgba(6,182,212,0.22);
            color: #ffffff !important;
        }
        .form-control:focus + i,
        .form-select:focus + i {
            color: var(--gold);
            transform: translateY(-50%) scale(1.25);
        }

        /* Role Select */
        .form-select {
            padding-left: 3.2rem !important;
        }

        /* Hotel Info Section */
        #hotelInfo {
            background: rgba(15,23,42,0.6);
            border-radius: 16px;
            padding: 1.8rem;
            margin: 2rem 0;
            border: 1px dashed var(--accent);
            transition: all 0.5s ease;
            opacity: 0;
            transform: translateY(-10px);
        }
        #hotelInfo.show {
            opacity: 1;
            transform: translateY(0);
        }
        #hotelInfo h5 {
            color: var(--gold);
            margin-bottom: 1.2rem;
        }

        /* Button */
        .btn-register {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 1rem;
            font-weight: 600;
            font-size: 1.15rem;
            width: 100%;
            transition: all 0.4s;
            box-shadow: 0 10px 30px rgba(6,182,212,0.4);
        }
        .btn-register:hover {
            transform: translateY(-5px);
            background: linear-gradient(135deg, var(--gold), #d4a017);
            box-shadow: 0 18px 40px rgba(251,191,36,0.5);
            color: #000;
        }

        /* Links */
        .register-links {
            text-align: center;
            margin-top: 2.5rem;
        }
        .register-links a {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.3s;
        }
        .register-links a:hover {
            color: var(--accent);
        }

        /* Error Alert */
        .alert-danger {
            background: rgba(239, 68, 68, 0.22);
            border: 1px solid rgba(239, 68, 68, 0.5);
            color: #fca5a5;
            border-radius: 16px;
            padding: 1rem;
            text-align: center;
            backdrop-filter: blur(8px);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="register-bg"></div>

    <div class="register-card">
        <div class="register-header">
            <h1>Đăng Ký</h1>
            <p>Tham gia ngay để trải nghiệm dịch vụ thượng lưu</p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mb-4">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Email hoặc số điện thoại đã tồn tại!
            </div>
        <% } %>

        <form id="registerForm" action="khachhang" method="post">
            <input type="hidden" name="action" value="register">

            <!-- Họ tên -->
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" class="form-control" name="ten" placeholder="Họ và tên" required>
            </div>

            <!-- SĐT -->
            <div class="input-group">
                <i class="fas fa-phone"></i>
                <input type="text" class="form-control" name="sdt" placeholder="Số điện thoại" required>
            </div>

            <!-- Email -->
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>

            <!-- Mật khẩu -->
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" class="form-control" name="matkhau" placeholder="Mật khẩu (tối thiểu 6 ký tự)" required>
            </div>

            <!-- Vai trò -->
            <div class="input-group">
                <i class="fas fa-user-tag"></i>
                <select name="role" id="roleSelect" class="form-select">
                    <option value="khachhang">Khách hàng</option>
                    <option value="owner">Chủ khách sạn</option>
                </select>
            </div>

            <!-- Thông tin khách sạn (ẩn mặc định) -->
            <div id="hotelInfo">
                <h5>Thông tin khách sạn của bạn</h5>
                <div class="input-group mt-3">
                    <i class="fas fa-hotel"></i>
                    <input type="text" class="form-control" name="ks_ten" placeholder="Tên khách sạn">
                </div>
                <div class="input-group mt-3">
                    <i class="fas fa-map-marker-alt"></i>
                    <input type="text" class="form-control" name="ks_diachi" placeholder="Địa chỉ">
                </div>
                <div class="input-group mt-3">
                    <i class="fas fa-phone-alt"></i>
                    <input type="text" class="form-control" name="ks_sdt" placeholder="Số điện thoại khách sạn">
                </div>
                <div class="input-group mt-3">
                    <i class="fas fa-pen"></i>
                    <textarea class="form-control" name="ks_mota" rows="3" placeholder="Mô tả khách sạn"></textarea>
                </div>
            </div>

            <button type="submit" class="btn-register">
                <i class="fas fa-user-plus me-2"></i>
                Đăng Ký Ngay
            </button>
        </form>

        <div class="register-links">
            <p>Đã có tài khoản? 
                <a href="dangnhap.jsp">Đăng nhập ngay</a>
            </p>
            <p>
                <a href="index.jsp"><i class="fas fa-home me-1"></i>Quay lại trang chủ</a>
            </p>
        </div>
    </div>

    <script>
        const roleSelect = document.getElementById("roleSelect");
        const hotelInfo = document.getElementById("hotelInfo");

        roleSelect.addEventListener("change", function() {
            if (this.value === "owner") {
                hotelInfo.classList.add("show");
            } else {
                hotelInfo.classList.remove("show");
            }
        });

        // Tự focus vào ô tên
        window.onload = () => {
            document.querySelector('input[name="ten"]').focus();
        };
    </script>
</body>
</html>