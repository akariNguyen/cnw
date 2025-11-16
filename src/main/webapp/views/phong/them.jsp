<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int ksId = (int) request.getAttribute("khachSanId");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">
    
    <h3>Thêm phòng mới</h3>

    <form action="phong" method="post">

        <input type="hidden" name="action" value="add">
        <input type="hidden" name="khachSanId" value="<%= ksId %>">

        <div class="mb-3">
            <label class="form-label">Tên phòng</label>
            <input type="text" name="tenPhong" class="form-control" required>
        </div>

        <!-- LOẠI PHÒNG -->
        <div class="mb-3">
            <label class="form-label">Loại phòng</label>
            <select name="loai" class="form-control" required>
                <option value="">-- Chọn loại phòng --</option>
                <option value="Đơn">Đơn</option>
                <option value="Đôi">Đôi</option>
                <option value="Gia đình">Gia đình</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá (VNĐ)</label>
            <input type="number" name="gia" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Sức chứa</label>
            <input type="number" name="sucChua" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="moTa" class="form-control"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh (URL)</label>
            <input type="text" name="hinhAnh" class="form-control">
        </div>

        <button class="btn btn-success">Lưu phòng</button>
        <a href="phong?action=ownerList" class="btn btn-secondary">Hủy</a>

    </form>

</div>

</body>
</html>
