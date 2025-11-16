<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.Phong" %>

<%
    Phong p = (Phong) request.getAttribute("phong");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h3>Chi tiết phòng: <%= p.getTenPhong() %></h3>

    <img src="<%= p.getHinhAnh() %>" class="img-fluid mb-3" style="max-height: 300px;">

    <ul class="list-group">
        <li class="list-group-item"><b>Loại:</b> <%= p.getLoai() %></li>
        <li class="list-group-item"><b>Giá:</b> <%= p.getGia() %>đ</li>
        <li class="list-group-item"><b>Sức chứa:</b> <%= p.getSucChua() %></li>
        <li class="list-group-item"><b>Mô tả:</b> <%= p.getMoTa() %></li>
    </ul>

    <a href="phong?action=ownerList" class="btn btn-secondary mt-3">← Quay lại</a>

</div>

</body>
</html>
