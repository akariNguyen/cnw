<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Phong" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách phòng - Khách sạn ID: <%= request.getAttribute("khachSanId") %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
        }
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            color: white;
            padding: 4rem 0;
            text-align: center;
            border-radius: 0 0 30px 30px;
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
            position: relative;
            overflow: hidden;
        }
        .header::before {
            content: '';
            position: absolute;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1542314831-8f7d16dd2b3b?w=1920') center/cover no-repeat;
            opacity: 0.15;
        }
        .header h2 {
            font-size: 2.6rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            z-index: 1;
        }

        .table-container {
            background: rgba(30, 41, 59, 0.95);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            padding: 2.5rem;
            margin: -4rem auto 3rem;
            max-width: 1400px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
            border: 1px solid var(--border);
            position: relative;
        }
        .table-container::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--gold));
            border-radius: 20px 20px 0 0;
        }

        .search-bar {
            position: relative;
        }
        .search-bar input {
            background: rgba(15,23,42,0.9);
            border: 1px solid var(--border);
            color: white;
            padding-left: 3rem;
            border-radius: 50px;
            height: 54px;
            font-size: 1.1rem;
        }
        .search-bar input::placeholder { color: var(--muted); opacity: 0.8; }
        .search-bar i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.4rem;
            z-index: 1;
        }

        .table {
            color: var(--text);
            margin-bottom: 0;
        }
        .table thead {
            background: linear-gradient(135deg, var(--accent), #0891b2);
            color: white;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }
        .table tbody tr {
            background: rgba(15,23,42,0.7);
            transition: all 0.4s ease;
            border-radius: 12px;
            margin-bottom: 1rem;
        }
        .table tbody tr:hover {
            background: rgba(6,182,212,0.25);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
        }
        .table td {
            vertical-align: middle;
            border: none;
            padding: 1.5rem 1rem;
        }

        /* Sửa ảnh trong bảng - TO RÕ ĐẸP */
        .room-thumb {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.6);
            transition: transform 0.4s;
        }
        .room-thumb:hover {
            transform: scale(1.2);
        }

        /* Sửa badge loại phòng - DÙNG BG-PRIMARY CHUẨN BOOTSTRAP */
        .badge-type {
            background: var(--accent);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .btn-book {
            background: linear-gradient(135deg, #10b981, #059669);
            border: none;
            border-radius: 50px;
            padding: 0.8rem 2rem;
            font-weight: 700;
            color: white;
            box-shadow: 0 10px 25px rgba(16,185,129,0.4);
            transition: all 0.4s;
        }
        .btn-book:hover {
            background: linear-gradient(135deg, var(--gold), #d4a017);
            color: #000;
            transform: translateY(-5px);
        }

        .alert-info {
            background: rgba(6,182,212,0.15);
            border: 1px solid var(--accent);
            color: var(--text);
            border-radius: 16px;
            padding: 3rem;
            text-align: center;
        }

        .pagination .page-link {
            background: rgba(15,23,42,0.8);
            border: none;
            color: var(--text);
            border-radius: 50% !important;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 8px;
            font-weight: 600;
        }
        .pagination .page-item.active .page-link {
            background: var(--gold);
            color: #000;
            font-weight: bold;
        }

        .btn-outline-secondary {
            border-radius: 50px;
            padding: 1rem 3rem;
            border: 2px solid var(--border);
            color: var(--text);
            font-weight: 600;
            font-size: 1.1rem;
        }
        .btn-outline-secondary:hover {
            background: var(--accent);
            border-color: var(--accent);
            color: white;
        }

        @media (max-width: 768px) {
            .header h2 { font-size: 1.9rem; }
            .table-container { padding: 1.5rem; margin: -3rem auto 2rem; }
            .room-thumb { width: 100px; height: 70px; }
            .btn-book { width: 100%; padding: 1rem; }
        }
    </style>
</head>
<body>

    <div class="header">
        <div class="container position-relative">
            <h2>Danh Sách Phòng - Khách Sạn ID: <%= request.getAttribute("khachSanId") %></h2>
        </div>
    </div>

    <div class="container table-container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-5 gap-3">
            <h4 class="fw-bold mb-0 text-info">Danh Sách Phòng</h4>
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm theo tên, loại hoặc giá">
            </div>
        </div>

        <%
            List<Phong> list = (List<Phong>) request.getAttribute("listPhong");
            if (list == null || list.isEmpty()) {
        %>
            <div class="alert alert-info">
                <i class="fas fa-bed fa-4x mb-4 text-info"></i>
                <h3>Chưa có phòng nào được đăng ký</h3>
                <p>Chủ khách sạn đang cập nhật danh sách phòng...</p>
            </div>
        <%
            } else {
        %>
            <div class="table-responsive">
                <table class="table table-hover align-middle" id="roomTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tên Phòng</th>
                            <th>Loại</th>
                            <th>Giá</th>
                            <th>Sức Chứa</th>
                            <th>Mô Tả</th>
                            <th>Hình Ảnh</th>
                            <th>Đặt Phòng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int i = 1;
                            for (Phong p : list) {
                        %>
                            <tr>
                                <td class="text-warning fw-bold"><%= i++ %></td>
                                <td><strong class="text-gold"><%= p.getTenPhong() %></strong></td>
                                <td><span class="badge-type"><%= p.getLoai() %></span></td>
                                <td><strong class="text-danger fs-4"><%= String.format("%,.0f", (double) p.getGia()) %> VNĐ</strong></td>
                                <td><i class="fas fa-users text-info me-2"></i><%= p.getSucChua() %> người</td>
                                <td class="text-muted"><%= p.getMoTa() != null ? p.getMoTa() : "Chưa có mô tả" %></td>
                                <td>
                                    <% if (p.getHinhAnh() != null && !p.getHinhAnh().isEmpty()) { %>
                                        <img src="<%= p.getHinhAnh() %>" alt="Phòng <%= p.getTenPhong() %>" class="room-thumb">
                                    <% } else { %>
                                        <div class="bg-secondary text-center text-white rounded-4 p-3">Không có ảnh</div>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="form_datphong.jsp?phongId=<%= p.getId() %>" class="btn btn-book">
                                        Đặt phòng
                                    </a>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">Trước</a></li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                </ul>
            </nav>
        <%
            }
        %>

        <div class="text-center mt-5">
            <a href="khachsan?action=list" class="btn btn-outline-secondary">
                Quay lại danh sách khách sạn
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchText = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#roomTable tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchText) ? '' : 'none';
            });
        });
    </script>
</body>
</html>