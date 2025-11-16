<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.DonDatPhong" %>
<%@ page import="model.bean.KhachHang" %>
<%
    KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
    if (khachHang == null) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn đặt phòng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f4f7fc; font-family: 'Inter', sans-serif; color: #333; }
        .header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white; padding: 3rem 0; text-align: center;
            border-radius: 0 0 20px 20px; box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            position: relative; overflow: hidden;
        }
        .header img { max-width: 100%; height: auto; border-radius: 15px; margin-bottom: 1.5rem; opacity: 0.9; }
        .header img:hover { transform: scale(1.02); }
        .header h2 { font-weight: 700; font-size: 2rem; text-transform: uppercase; letter-spacing: 1px; }
        .table-container {
            background: white; border-radius: 15px; box-shadow: 0 8px 16px rgba(0,0,0,0.05);
            padding: 2rem; margin: 2rem auto; max-width: 1200px;
        }
        .search-bar { position: relative; max-width: 500px; }
        .search-bar input {
            padding-left: 2.5rem; border-radius: 25px; border: 1px solid #d1d5db;
            transition: all 0.3s ease;
        }
        .search-bar input:focus {
            border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        .search-bar i {
            position: absolute; top: 50%; left: 0.75rem; transform: translateY(-50%); color: #6b7280;
        }
        .table th { background: #3b82f6; color: white; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; padding: 1rem; }
        .table td { background: #fff; padding: 1rem; vertical-align: middle; }
        .table tbody tr:hover td { background: #f1f5f9; }
        .action-buttons a, .action-buttons button {
            margin-right: 0.5rem; padding: 0.5rem 1rem; border-radius: 25px;
            transition: all 0.3s ease;
        }
        .action-buttons a:hover, .action-buttons button:hover {
            transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        @media (max-width: 768px) {
            .header h2 { font-size: 1.5rem; }
            .table-container { padding: 1rem; }
            .search-bar { max-width: 100%; }
            .action-buttons a, .action-buttons button { display: block; margin: 0.5rem 0; text-align: center; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/images/hotel1.jpg" alt="Hotel" class="img-fluid">
        <h2>Đơn Đặt Phòng Của Tôi</h2>
    </div>

    <!-- Table Container -->
    <div class="container table-container">
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <div><%= error %></div>
            </div>
        <% } else if (success != null) { %>
            <div class="alert alert-success d-flex align-items-center" role="alert">
                <div><%= success %></div>
            </div>
        <% } %>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold">Xin chào, <span class="text-primary"><%= khachHang.getTen() %></span></h4>
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="form-control" placeholder="Tìm mã đơn hoặc tên phòng...">
            </div>
        </div>

        <%
            List<DonDatPhong> list = (List<DonDatPhong>) request.getAttribute("listDonDat");
            if (list == null || list.isEmpty()) {
        %>
            <div class="alert alert-info d-flex align-items-center" role="alert">
                <div>Bạn chưa có đơn đặt phòng nào.</div>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover table-bordered" id="bookingTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Mã đơn</th>
                            <th>Phòng</th>
                            <th>Ngày nhận</th>
                            <th>Ngày trả</th>
                            <th>Thời gian đặt</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int i = 1;
                            for (DonDatPhong d : list) {
                        %>
                            <tr>
                                <td><%= i++ %></td>
                                <td><strong><%= d.getMaDon() != null ? d.getMaDon() : "N/A" %></strong></td>
                                <td><%= d.getTenPhong() != null ? d.getTenPhong() : "N/A" %></td>
                                <td><%= d.getNgayNhan() != null ? d.getNgayNhan() : "N/A" %></td>
                                <td><%= d.getNgayTra() != null ? d.getNgayTra() : "N/A" %></td>
                                <td><%= d.getThoiGianDat() != null ? d.getThoiGianDat() : "N/A" %></td>
                                <td class="action-buttons">
                                    <a href="dondatphong?action=view&bookingId=<%= d.getId() %>" class="btn btn-sm btn-primary">
										    Xem
										</a>
                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal<%= d.getId() %>">
                                        <i class="fas fa-trash me-1"></i> Hủy
                                    </button>

                                    <!-- Modal Xác nhận hủy -->
                                    <div class="modal fade" id="cancelModal<%= d.getId() %>" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xác nhận hủy đơn</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Bạn có chắc muốn <strong class="text-danger">hủy đơn <%= d.getMaDon() %></strong>?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <a href="dondatphong?action=cancel&bookingId=<%= d.getId() %>" class="btn btn-danger">
                                                        <i class="fas fa-trash me-1"></i> Hủy đơn
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

        <p class="mt-4">
            <a href="index.jsp" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i> Quay lại trang chủ
            </a>
        </p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const text = e.target.value.toLowerCase();
            document.querySelectorAll('#bookingTable tbody tr').forEach(row => {
                const maDon = row.cells[1].textContent.toLowerCase();
                const tenPhong = row.cells[2].textContent.toLowerCase();
                row.style.display = (maDon.includes(text) || tenPhong.includes(text)) ? '' : 'none';
            });
        });
    </script>
</body>
</html>