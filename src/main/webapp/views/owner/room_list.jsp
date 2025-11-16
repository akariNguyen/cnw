<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Phong" %>

<%
    List<Phong> list = (List<Phong>) request.getAttribute("listPhong");
    model.bean.KhachSan ks = (model.bean.KhachSan) request.getAttribute("khachSan");
    if (ks == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>
            Phòng thuộc khách sạn: <span class="text-primary"><%= ks.getTen() %></span>
        </h3>
        <div>
            <a href="${pageContext.request.contextPath}/khachhang?action=logout" class="btn btn-outline-danger me-2">Đăng xuất</a>
            <a href="${pageContext.request.contextPath}/owner/hotel?action=view" class="btn btn-secondary">← Quay lại Dashboard</a>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/phong?action=addForm&khachSanId=<%= ks.getId() %>" class="btn btn-success mb-3">
        + Thêm phòng mới
    </a>

    <% if (list == null || list.isEmpty()) { %>
        <div class="alert alert-info">
            Chưa có phòng nào. <a href="${pageContext.request.contextPath}/phong?action=addForm&khachSanId=<%= ks.getId() %>" class="btn btn-sm btn-outline-primary">Thêm phòng đầu tiên</a>
        </div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>Tên phòng</th>
                        <th>Loại</th>
                        <th>Giá</th>
                        <th>Sức chứa</th>
           
                        <th width="180">Hành động</th>
                    </tr>
                </thead>

                <tbody>
                    <% for (Phong p : list) { %>
                    <tr>
                        <td><%= p.getTenPhong() %></td>
                        <td><%= p.getLoai() %></td>
                        <td><%= String.format("%,d", p.getGia()) %>đ</td>
                        <td><%= p.getSucChua() %></td>
                    

                        <td>
                            <a class="btn btn-info btn-sm me-1"
                               href="${pageContext.request.contextPath}/phong?action=detail&id=<%= p.getId() %>">
                                Xem
                            </a>

                            <a class="btn btn-warning btn-sm me-1"
                               href="${pageContext.request.contextPath}/phong?action=editForm&id=<%= p.getId() %>">
                                Sửa
                            </a>

                            <a class="btn btn-danger btn-sm"
                               onclick="return confirm('Xóa phòng này?')"
                               href="${pageContext.request.contextPath}/phong?action=delete&id=<%= p.getId() %>">
                                Xóa
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>

</div>

</body>
</html>