<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập • LUXE STAY</title>
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
        .login-bg {
            position: fixed;
            inset: 0;
            background: linear-gradient(rgba(15,23,42,0.92), rgba(15,23,42,0.98)),
                        url('https://images.unsplash.com/photo-1611892441792-ae6af465f35c?w=1920&q=80') center/cover no-repeat;
            z-index: -2;
        }
        .login-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, rgba(6,182,212,0.15), transparent 70%);
            animation: breathe 18s infinite;
        }
        @keyframes breathe { 0%,100% { opacity: 0.4; } 50% { opacity: 0.8; } }

        /* Login Card */
        .login-card {
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.6);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.9s ease-out;
        }
        .login-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        .login-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.2rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        .login-header p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* Form Input - CHỮ TRẮNG SÁNG 100% */
        .form-control {
            background: rgba(15,23,42,0.8) !important;
            border: 1px solid var(--border);
            color: #ffffff !important;                    /* CHỮ TRẮNG SÁNG */
            caret-color: var(--gold);                      /* Con trỏ nháy vàng gold */
            border-radius: 16px;
            padding: 0.9rem 1rem 0.9rem 3rem;
            font-size: 1rem;
            transition: all 0.4s;
        }
        .form-control::placeholder {
            color: #94a3b8 !important;                    /* Placeholder xám nhẹ, dễ đọc */
            font-style: italic;
        }
        .form-control:focus {
            background: rgba(15,23,42,0.95) !important;
            border-color: var(--accent) !important;
            box-shadow: 0 0 0 4px rgba(6,182,212,0.2);
            color: #ffffff !important;
        }

        .input-group {
            position: relative;
        }
        .input-group i {
            position: absolute;
            top: 50%;
            left: 1rem;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.3rem;
            z-index: 10;
            transition: all 0.3s;
        }
        .form-control:focus + i {
            color: var(--gold);
            transform: translateY(-50%) scale(1.2);
        }

        /* Button */
        .btn-login {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.9rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            margin-top: 1.5rem;
            transition: all 0.4s;
            box-shadow: 0 8px 25px rgba(6,182,212,0.4);
        }
        .btn-login:hover {
            transform: translateY(-4px);
            background: linear-gradient(135deg, var(--gold), #d4a017);
            box-shadow: 0 15px 35px rgba(251,191,36,0.5);
            color: #000;
        }

        /* Links */
        .login-links {
            text-align: center;
            margin-top: 2rem;
        }
        .login-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.95rem;
            transition: all 0.3s;
            position: relative;
        }
        .login-links a:hover {
            color: var(--accent);
        }
        .login-links a::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent);
            transition: width 0.3s;
        }
        .login-links a:hover::after {
            width: 100%;
        }

        /* Error Alert */
        .alert-danger {
            background: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.4);
            color: #fca5a5;
            border-radius: 16px;
            padding: 1rem;
            text-align: center;
            backdrop-filter: blur(8px);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="login-bg"></div>

    <div class="login-card">
        <div class="login-header">
            <h1>Đăng Nhập</h1>
            <p>Chào mừng trở lại • Trải nghiệm thượng lưu đang chờ bạn</p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mb-4">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Sai tài khoản hoặc mật khẩu. Vui lòng thử lại!
            </div>
        <% } %>

        <form action="khachhang" method="post">
            <input type="hidden" name="action" value="login">

            <div class="mb-4 input-group">
                <i class="fas fa-user"></i>
                <input type="text" class="form-control" name="taikhoan" placeholder="Email hoặc Số điện thoại" required>
            </div>

            <div class="mb-4 input-group">
                <i class="fas fa-lock"></i>
                <input type="password" class="form-control" name="matkhau" placeholder="Mật khẩu" required>
            </div>

            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt me-2"></i>
                Đăng Nhập Ngay
            </button>
        </form>

        <div class="login-links">
            <p>Chưa có tài khoản? 
                <a href="dangky.jsp">Đăng ký miễn phí</a>
            </p>
            <p>
                <a href="index.jsp"><i class="fas fa-home me-1"></i>Quay lại trang chủ</a>
            </p>
        </div>
    </div>

    <script>
        window.onload = () => {
            document.querySelector('input[name="taikhoan"]').focus();
        };
    </script>
</body>
</html>