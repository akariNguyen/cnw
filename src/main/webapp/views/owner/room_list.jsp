<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.*, model.dao.*, java.util.*,model.bo.*" %>

<%
    ChuKhachSan owner = (ChuKhachSan) session.getAttribute("owner");
    if (owner == null) {
        response.sendRedirect("../dangnhap.jsp");
        return;
    }

    KhachSanDAO ksDAO = new KhachSanDAO();
    PhongDAO phongDAO = new PhongDAO();

    KhachSan ks = ksDAO.getByOwnerId(owner.getId());
    List<Phong> list = phongDAO.getByKhachSanId(ks.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý phòng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-4">

    <h3>Phòng trong khách sạn: <%= ks.getTen() %></h3>
    <a href="room_add.jsp" class="btn btn-primary my-3">+ Thêm phòng</a>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Tên phòng</th>
                <th>Loại</th>
                <th>Sức chứa</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th width="150">Hành động</th>
            </tr>
        </thead>

        <tbody>
            <% for (Phong p : list) { %>
                <tr>
                    <td><%= p.getTenPhong() %></td>
                    <td><%= p.getLoai() %></td>
                    <td><%= p.getSucChua() %></td>
                    <td><%= p.getGia() %></td>
                    <td><%= p.getSoLuong() %></td>
                    <td>
                        <a href="room_edit.jsp?id=<%= p.getId() %>" class="btn btn-warning btn-sm">Sửa</a>
                        <a onclick="return confirm('Xóa phòng này?')"
                           href="../owner?action=deleteRoom&id=<%= p.getId() %>"
                           class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

</div>

</body>
</html>
