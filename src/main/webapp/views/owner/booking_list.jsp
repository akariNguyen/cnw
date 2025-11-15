<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.bean.*, model.dao.*, model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    KhachSan ks = ksDAO.getByOwnerId(owner.getId());

    DonDatPhongDAO ddpDAO = new DonDatPhongDAO();
    List<DonDatPhong> list = ddpDAO.getByKhachSanId(ks.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đơn đặt phòng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h3>Danh sách đơn đặt phòng</h3>

    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Tên khách</th>
                <th>Phòng</th>
                <th>Ngày nhận</th>
                <th>Ngày trả</th>
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
                </tr>
            <% } %>
        </tbody>
    </table>

</div>

</body>
</html>
