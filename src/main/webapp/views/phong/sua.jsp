<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.Phong" %>

<%
    Phong p = (Phong) request.getAttribute("phong");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h3>Sửa phòng: <%= p.getTenPhong() %></h3>

    <form action="phong" method="post">

        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="id" value="<%= p.getId() %>">
        <input type="hidden" name="khachSanId" value="<%= p.getKhachSanId() %>">

        <div class="mb-3">
            <label class="form-label">Tên phòng</label>
            <input type="text" name="tenPhong" class="form-control"
                   value="<%= p.getTenPhong() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Loại</label>
            <input type="text" name="loai" class="form-control"
                   value="<%= p.getLoai() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" name="gia" class="form-control"
                   value="<%= p.getGia() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Sức chứa</label>
            <input type="number" name="sucChua" class="form-control"
                   value="<%= p.getSucChua() %>" required>
        </div>

       

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="moTa" class="form-control"><%= p.getMoTa() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh</label>
            <input type="text" name="hinhAnh" class="form-control"
                   value="<%= p.getHinhAnh() %>">
        </div>

        <button class="btn btn-warning">Cập nhật</button>
        <a href="phong?action=ownerList" class="btn btn-secondary">Hủy</a>

    </form>

</div>

</body>
</html>
