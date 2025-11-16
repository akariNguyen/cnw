<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.bean.*, model.dao.*, model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    KhachSan ks = ksDAO.getByOwnerId(owner.getId());

    if (ks == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
        return;
    }

    DonDatPhongDAO ddpDAO = new DonDatPhongDAO();
    List<DonDatPhong> list = ddpDAO.getByKhachSanId(ks.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đơn đặt phòng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Danh sách đơn đặt phòng - <%= ks.getTen() %></h3>
        <a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="btn btn-secondary">← Quay lại Dashboard</a>
    </div>

    <% if (list == null || list.isEmpty()) { %>
        <div class="alert alert-info">
            Chưa có đơn đặt phòng nào cho khách sạn này.
        </div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Tên khách</th>
                        <th>Phòng</th>
                        <th>Ngày nhận</th>
                        <th>Ngày trả</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (DonDatPhong d : list) { %>
                    <tr>
                        <td><%= d.getMaDon() %></td>
                        <td><%= d.getTenKhachHang() %></td>
                        <td><%= d.getTenPhong() %></td>
                        <td><%= d.getNgayNhan() %></td>
                        <td><%= d.getNgayTra() %></td>
                        <td>
                            <button class="btn btn-info btn-sm" onclick="openDetailModal(<%= d.getKhachHangId() %>, <%= d.getPhongId() %>, '<%= d.getMaDon() %>')">
                                Xem chi tiết
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>
</div>

<!-- Modal Popup với 2 Tab: Khách hàng & Phòng -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">Chi tiết đơn đặt phòng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs" id="detailTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="customer-tab" data-bs-toggle="tab" data-bs-target="#customer" type="button" role="tab">Thông tin khách hàng</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="room-tab" data-bs-toggle="tab" data-bs-target="#room" type="button" role="tab">Thông tin phòng</button>
                    </li>
                </ul>
                <div class="tab-content mt-3" id="detailTabsContent">
                    <!-- Tab Khách hàng -->
                    <div class="tab-pane fade show active" id="customer" role="tabpanel">
                        <div id="customerContent">
                            <p class="text-muted">Đang tải thông tin khách hàng...</p>
                        </div>
                    </div>
                    <!-- Tab Phòng -->
                    <div class="tab-pane fade" id="room" role="tabpanel">
                        <div id="roomContent">
                            <p class="text-muted">Đang tải thông tin phòng...</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeModalAndRefresh()">Quay lại</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    function openDetailModal(khachHangId, phongId, maDon) {
        // Load thông tin khách hàng
        fetch('${pageContext.request.contextPath}/khachhang?action=detail&id=' + khachHangId)
            .then(response => response.text())
            .then(html => {
                document.getElementById('customerContent').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('customerContent').innerHTML = '<div class="alert alert-danger">Lỗi tải thông tin khách hàng</div>';
            });

        // Load thông tin phòng
        fetch('${pageContext.request.contextPath}/phong?action=detail&id=' + phongId)
            .then(response => response.text())
            .then(html => {
                document.getElementById('roomContent').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('roomContent').innerHTML = '<div class="alert alert-danger">Lỗi tải thông tin phòng</div>';
            });

        // Set title
        document.getElementById('detailModalLabel').textContent = 'Chi tiết đơn đặt phòng: ' + maDon;

        // Show modal
        var modal = new bootstrap.Modal(document.getElementById('detailModal'));
        modal.show();
    }

    function closeModalAndRefresh() {
        var modal = bootstrap.Modal.getInstance(document.getElementById('detailModal'));
        modal.hide();
        // Refresh trang sau khi đóng modal
        location.reload();
    }
</script>

</body>
</html>