<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.Phong" %>

<%
    Phong p = (Phong) request.getAttribute("phong");
    if (p == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy phòng");
        return;
    }
    String error = (String) request.getAttribute("error");
    String success = (String) session.getAttribute("success");
    if (success != null) session.removeAttribute("success");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa phòng • <%= p.getTenPhong() %> • LUXE OWNER</title>
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

        .edit-bg {
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1618776185824-8b52396b3172?w=1920') center/cover no-repeat;
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
            font-size: 4.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        .room-title {
            font-size: 1.8rem;
            color: var(--gold);
            font-weight: 700;
            margin-top: 1rem;
        }

        .container-edit {
            max-width: 1100px;
            margin: 0 auto 6rem;
            padding: 2rem;
        }

        .form-card {
            background: rgba(30,41,59,0.96);
            backdrop-filter: blur(22px);
            border-radius: 36px;
            padding: 4rem;
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
            border-radius: 36px 36px 0 0;
        }

        .form-label {
            color: var(--gold);
            font-weight: 700;
            font-size: 1.15rem;
            margin-bottom: 0.9rem;
            letter-spacing: 0.5px;
        }

        .form-control, .form-control:focus {
            background: rgba(15,23,42,0.95);
            border: 1px solid var(--border);
            color: white;
            border-radius: 18px;
            padding: 1.1rem 1.4rem;
            font-size: 1.1rem;
            transition: all 0.4s;
        }
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 5px rgba(6,182,212,0.3);
            background: rgba(15,23,42,1);
        }
        textarea.form-control {
            min-height: 160px;
            resize: vertical;
        }

        .current-img {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.7);
            margin-top: 1.5rem;
            border: 3px solid var(--accent);
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 4rem;
            flex-wrap: wrap;
        }
        .btn-save {
            background: linear-gradient(135deg, var(--success), #059669);
            padding: 1.4rem 5rem;
            border-radius: 60px;
            font-size: 1.4rem;
            font-weight: 700;
            min-width: 260px;
            box-shadow: 0 20px 50px rgba(16,185,129,0.5);
            transition: all 0.5s;
        }
        .btn-save:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 30px 70px rgba(251,191,36,0.6);
        }
        .btn-cancel {
            background: rgba(100,100,100,0.7);
            padding: 1.4rem 4rem;
            border-radius: 60px;
            font-size: 1.3rem;
            font-weight: 600;
            min-width: 200px;
        }
        .btn-cancel:hover {
            background: var(--danger);
            transform: translateY(-6px);
        }

        .alert {
            border-radius: 24px;
            padding: 1.8rem;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            border: none;
        }
        .alert-success { background: rgba(16,185,129,0.18); border: 1px solid var(--success); }
        .alert-danger { background: rgba(239,68,68,0.18); border: 1px solid var(--danger); }

        @media (max-width: 768px) {
            .header-title h1 { font-size: 3rem; }
            .back-btn { position: static; margin: 1.5rem auto; display: block; width: fit-content; }
            .form-card { padding: 2.5rem; border-radius: 28px; }
            .btn-group { flex-direction: column; }
            .btn-save, .btn-cancel { width: 100%; }
            .current-img { height: 250px; }
        }
    </style>
</head>
<body>

<div class="edit-bg"></div>

<a href="${pageContext.request.contextPath}/phong?action=ownerList" class="back-btn">
    Danh sách phòng
</a>

<div class="header-title">
    <h1>Chỉnh sửa phòng</h1>
    <p class="room-title">Phòng: <%= p.getTenPhong() %> (ID: <%= p.getId() %>)</p>
</div>

<div class="container-edit">

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>
    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/phong" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="<%= p.getId() %>">
            <input type="hidden" name="khachSanId" value="<%= p.getKhachSanId() %>">

            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">Tên phòng</label>
                    <input type="text" name="tenPhong" class="form-control" value="<%= p.getTenPhong() %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Loại phòng</label>
                    <input type="text" name="loai" class="form-control" value="<%= p.getLoai() %>" required placeholder="Ví dụ: Deluxe, Suite, Standard...">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Giá mỗi đêm (VNĐ)</label>
                    <input type="number" name="gia" class="form-control" value="<%= p.getGia() %>" min="500000" step="10000" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Sức chứa (người)</label>
                    <input type="number" name="sucChua" class="form-control" value="<%= p.getSucChua() %>" min="1" max="20" required>
                </div>

                <div class="col-12">
                    <label class="form-label">Mô tả chi tiết phòng</label>
                    <textarea name="moTa" class="form-control" rows="6" placeholder="View biển tuyệt đẹp, ban công riêng, giường king size, nội thất cao cấp, phòng tắm đá marble..."><%= p.getMoTa() != null ? p.getMoTa() : "" %></textarea>
                </div>

                <div class="col-12">
                    <label class="form-label">Link hình ảnh phòng (dán link từ Imgur, Postimages...)</label>
                    <input type="text" name="hinhAnh" class="form-control" value="<%= p.getHinhAnh() != null ? p.getHinhAnh() : "" %>" placeholder="https://i.imgur.com/abc123.jpg">
                    <% if (p.getHinhAnh() != null && !p.getHinhAnh().isEmpty()) { %>
                        <div class="mt-4 text-center">
                            <p class="text-info mb-3 fs-5">Hình ảnh hiện tại của phòng:</p>
                            <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenPhong() %>" class="current-img">
                        </div>
                    <% } else { %>
                        <small class="text-muted d-block mt-2">Chưa có ảnh – hãy dán link ảnh mới để hiển thị</small>
                    <% } %>
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-save">
                    Cập nhật phòng ngay
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