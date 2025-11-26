<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int ksId = (int) request.getAttribute("khachSanId");
    String error = (String) request.getAttribute("error");
    String success = (String) session.getAttribute("success");
    if (success != null) session.removeAttribute("success");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm phòng mới • LUXE OWNER</title>
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
            --text: #f1f5f9;        /* TRẮNG SÁNG HƠN */
            --text-light: #e2e8f0;   /* XÁM TRẮNG SÁNG */
            --muted: #cbd5e1;        /* XÁM TRẮNG RẤT SÁNG */
            --success: #10b981;
            --danger: #ef4444;
        }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);                    /* CHỮ CHÍNH SÁNG BẬT */
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        .add-bg {
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1611892441792-ae6af465f0d4?w=1920') center/cover no-repeat;
            opacity: 0.3;
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
            color: var(--text-light);
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s;
        }
        .back-btn:hover {
            background: var(--accent);
            border-color: var(--accent);
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(6,182,212,0.4);
        }

        .header-title {
            text-align: center;
            padding: 5rem 1rem 3rem;
        }
        .header-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 5rem;
            font-weight: 900;
            background: linear-gradient(90deg, #06b6d4, #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        .header-title p {
            font-size: 1.5rem;
            color: var(--muted);        /* MÀU XÁM TRẮNG SÁNG */
        }

        .container-add {
            max-width: 1100px;
            margin: 0 auto 6rem;
            padding: 2rem;
        }

        .form-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(22px);
            border-radius: 36px;
            padding: 4.5rem;
            box-shadow: 0 50px 120px rgba(0,0,0,0.8);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }
        .form-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 12px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
        }

        .form-label {
            color: var(--gold);
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1rem;
        }

        .form-control, .form-select {
            background: rgba(15,23,42,0.95);
            border: 1px solid #475569;
            color: #f8fafc !important;           /* CHỮ TRONG INPUT TRẮNG SÁNG */
            border-radius: 18px;
            padding: 1.1rem 1.4rem;
            font-size: 1.1rem;
        }
        .form-control::placeholder, .form-select::placeholder {
            color: #94a3b8 !important;           /* PLACEHOLDER SÁNG HƠN */
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 5px rgba(6,182,212,0.3);
            background: rgba(15,23,42,1);
            color: #ffffff !important;
        }
        .form-select option {
            background: #1e293b;
            color: #f1f5f9;
        }
        textarea.form-control {
            min-height: 180px;
            resize: vertical;
        }

        .btn-add {
            background: linear-gradient(135deg, var(--success), #059669);
            padding: 1.5rem 6rem;
            border-radius: 60px;
            font-size: 1.5rem;
            font-weight: 700;
            min-width: 280px;
            box-shadow: 0 20px 50px rgba(16,185,129,0.5);
            color: white;
        }
        .btn-add:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 35px 80px rgba(251,191,36,0.7);
        }
        .btn-cancel {
            background: rgba(100,100,100,0.7);
            padding: 1.5rem 4rem;
            border-radius: 60px;
            font-size: 1.3rem;
            font-weight: 600;
            min-width: 220px;
            color: var(--text-light);
        }
        .btn-cancel:hover {
            background: var(--danger);
            color: white;
        }

        .alert {
            border-radius: 24px;
            padding: 1.8rem;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            color: white;
        }
        .alert-success { background: rgba(16,185,129,0.25); border: 1px solid var(--success); }
        .alert-danger { background: rgba(239,68,68,0.25); border: 1px solid var(--danger); }

        .tip-box {
            background: rgba(6,182,212,0.2);
            border: 1px solid var(--accent);
            border-radius: 16px;
            padding: 1.4rem;
            margin-top: 1rem;
            font-size: 1rem;
            color: var(--text-light);
        }
        .tip-box a {
            color: #a5f3fc;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3.2rem; }
            .back-btn { position: static; margin: 1.5rem auto; display: block; width: fit-content; }
            .form-card { padding: 2.5rem; }
            .btn-group { flex-direction: column; }
            .btn-add, .btn-cancel { width: 100%; }
        }
    </style>
</head>
<body>

<div class="add-bg"></div>

<a href="${pageContext.request.contextPath}/phong?action=ownerList" class="back-btn">
    Danh sách phòng
</a>

<div class="header-title">
    <h1>Thêm phòng mới</h1>
    <p>Tạo phòng mới cho khách sạn của bạn – sang trọng, đẳng cấp</p>
</div>

<div class="container-add">

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>
    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/phong" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="khachSanId" value="<%= ksId %>">

            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">Tên phòng</label>
                    <input type="text" name="tenPhong" class="form-control" placeholder="Ví dụ: Phòng Deluxe Biển, Suite Tổng Thống..." required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Loại phòng</label>
                    <select name="loai" class="form-select" required>
                        <option value="">-- Chọn loại phòng --</option>
                        <option value="Standard">Standard</option>
                        <option value="Superior">Superior</option>
                        <option value="Deluxe">Deluxe</option>
                        <option value="Suite">Suite</option>
                        <option value="Presidential">Presidential</option>
                        <option value="Family">Gia đình</option>
                        <option value="VIP">VIP</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Giá mỗi đêm (VNĐ)</label>
                    <input type="number" name="gia" class="form-control" min="500000" step="10000" placeholder="1.800.000" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Sức chứa (người)</label>
                    <input type="number" name="sucChua" class="form-control" min="1" max="20" value="2" required>
                </div>

                <div class="col-12">
                    <label class="form-label">Mô tả chi tiết phòng</label>
                    <textarea name="moTa" class="form-control" rows="6" placeholder="View biển tuyệt đẹp, ban công riêng, giường king size 2m, nội thất cao cấp nhập khẩu..."></textarea>
                </div>

                <div class="col-12">
                    <label class="form-label">Link hình ảnh phòng</label>
                    <input type="text" name="hinhAnh" class="form-control" placeholder="https://i.imgur.com/abc123.jpg">
                    <div class="tip-box">
                        Mẹo: Upload ảnh lên <a href="https://imgur.com" target="_blank">imgur.com</a> → chuột phải → Copy link → dán vào đây
                    </div>
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-add">
                    Thêm phòng ngay
                </button>
                <a href="${pageContext.request.contextPath}/phong?action=ownerList" class="btn btn-cancel">
                    Hủy bỏ
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>