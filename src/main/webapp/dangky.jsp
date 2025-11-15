<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Inter', sans-serif;
        }

        .header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white;
            padding: 3rem 0;
            text-align: center;
            border-radius: 0 0 20px 20px;
        }

        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.05);
            padding: 2rem;
            margin: 2rem auto;
            max-width: 500px;
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 0.75rem;
            transform: translateY(-50%);
            color: #6b7280;
        }

        .input-group input {
            padding-left: 2.5rem;
        }
    </style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <h2><i class="fas fa-user-plus me-2"></i>Đăng Ký Tài Khoản</h2>
</div>

<!-- FORM -->
<div class="container form-container">

    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">
            Email hoặc số điện thoại đã tồn tại!
        </div>
    <% } %>

    <form id="registerForm" action="khachhang?action=register" method="post">

        <!-- Họ tên -->
        <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="ten" class="form-control" name="ten" required>
            </div>
            <small class="text-danger" id="tenError"></small>
        </div>

        <!-- Số điện thoại -->
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group">
                <i class="fas fa-phone"></i>
                <input type="text" id="sdt" class="form-control" name="sdt" required>
            </div>
            <small class="text-danger" id="sdtError"></small>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" class="form-control" name="email" required>
            </div>
            <small class="text-danger" id="emailError"></small>
        </div>

        <!-- Mật khẩu -->
        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="matkhau" class="form-control" name="matkhau" required>
            </div>
            <small class="text-danger" id="matkhauError"></small>
        </div>

        <!-- ROLE -->
        <div class="mb-3">
            <label class="form-label">Đăng ký vai trò</label>
            <select name="role" id="roleSelect" class="form-select">
                <option value="khachhang">Khách hàng</option>
                <option value="owner">Chủ khách sạn</option>
            </select>
        </div>

        <!-- INFO KHÁCH SẠN -->
        <div id="hotelInfo" style="display:none; transition:0.3s;">

            <h5 class="text-primary"><i class="fas fa-hotel me-2"></i>Thông tin khách sạn</h5>

            <div class="mb-3">
                <label class="form-label">Tên khách sạn</label>
                <input type="text" id="ks_ten" class="form-control" name="ks_ten">
            </div>

            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <input type="text" id="ks_diachi" class="form-control" name="ks_diachi">
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại khách sạn</label>
                <input type="text" id="ks_sdt" class="form-control" name="ks_sdt">
            </div>

            <div class="mb-3">
                <label class="form-label">Mô tả</label>
                <textarea id="ks_mota" class="form-control" name="ks_mota" rows="3"></textarea>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 mt-3">
            <i class="fas fa-user-plus me-2"></i>Đăng ký
        </button>
    </form>

    <div class="mt-3">
        <p>Đã có tài khoản? <a href="dangnhap.jsp">Đăng nhập</a></p>
        <p><a href="index.jsp"><i class="fas fa-arrow-left me-1"></i> Quay lại trang chủ</a></p>
    </div>

</div>

<!-- JS HIỆN/ẨN HOTEL INFO -->
<script>
    const role = document.getElementById("roleSelect");
    const hotelInfo = document.getElementById("hotelInfo");

    role.addEventListener("change", function () {
        hotelInfo.style.display = (role.value === "owner") ? "block" : "none";
    });
</script>

<!-- VALIDATION -->
<script>
document.getElementById('registerForm').addEventListener('submit', function(e) {
    let isValid = true;

    const ten = document.getElementById('ten').value.trim();
    const sdt = document.getElementById('sdt').value.trim();
    const email = document.getElementById('email').value.trim();
    const matkhau = document.getElementById('matkhau').value.trim();

    document.querySelectorAll(".text-danger").forEach(e => e.textContent = "");

    if (ten === "") {
        document.getElementById("tenError").textContent = "Vui lòng nhập họ và tên";
        isValid = false;
    }

    if (!/^[0-9]{10,11}$/.test(sdt)) {
        document.getElementById("sdtError").textContent = "Số điện thoại không hợp lệ";
        isValid = false;
    }

    if (!email.includes("@") || !email.includes(".")) {
        document.getElementById("emailError").textContent = "Email không hợp lệ";
        isValid = false;
    }

    if (matkhau.length < 6) {
        document.getElementById("matkhauError").textContent = "Mật khẩu tối thiểu 6 ký tự";
        isValid = false;
    }

    if (!isValid) e.preventDefault();
});
</script>

</body>
</html>
