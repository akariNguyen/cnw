<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.KhachHang" %>

<%
    KhachHang kh = (KhachHang) request.getAttribute("khachHang");
    if (kh == null) {
        out.print("<small class='text-muted'>Không có thông tin khách hàng</small>");
        return;
    }
%>

<!-- CARD THÔNG TIN KHÁCH HÀNG SIÊU ĐẸP TRONG MODAL -->
<div class="text-center p-4 rounded-4" 
     style="background: linear-gradient(135deg, rgba(15,25,50,0.95), rgba(30,15,60,0.9)); 
            backdrop-filter: blur(12px); 
            border: 1px solid #06b6d4; 
            box-shadow: 0 10px 30px rgba(6,182,212,0.3);">

    <!-- Avatar tròn to -->
    <div class="mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow-lg"
         style="width: 90px; height: 90px; 
                background: linear-gradient(135deg, #06b6d4, #3b82f6); 
                font-size: 2.5rem;">
        <%= kh.getTen().trim().isEmpty() ? "K" : kh.getTen().trim().charAt(0) %>
    </div>

    <!-- Tên khách -->
    <h5 class="text-warning fw-bold mb-1" style="font-size: 1.5rem;">
        <%= kh.getTen() %>
    </h5>
    <p class="text-info small mb-4">
        Khách hàng thân thiết • <span style="color:#06b6d4">LUXE HOTEL</span>
    </p>

    <div class="mt-4 text-start">
        <!-- Số điện thoại -->
        <div class="d-flex align-items-center mb-3 p-3 rounded-3" 
             style="background: rgba(0,0,0,0.4); border-left: 5px solid #fbbf24;">
            <i class="fas fa-phone-alt text-warning me-3 fs-4"></i>
            <div>
                <small class="text-muted d-block">Số điện thoại</small>
                <strong class="text-white fs-5"><%= kh.getSdt() %></strong>
            </div>
        </div>

        <!-- Email -->
        <div class="d-flex align-items-center mb-3 p-3 rounded-3" 
             style="background: rgba(0,0,0,0.4); border-left: 5px solid #06b6d4;">
            <i class="fas fa-envelope text-info me-3 fs-4"></i>
            <div>
                <small class="text-muted d-block">Email</small>
                <strong class="text-white fs-5 text-break"><%= kh.getEmail() %></strong>
            </div>
        </div>

        <!-- Mật khẩu -->
        <div class="d-flex align-items-center p-3 rounded-3" 
             style="background: rgba(0,0,0,0.4); border-left: 5px solid #10b981;">
            <i class="fas fa-shield-alt text-success me-3 fs-4"></i>
            <div>
                <small class="text-muted d-block">Mật khẩu</small>
                <strong class="text-success fs-5">••••••••••••</strong>
                <span class="text-success-emphasis small ms-2">(Đã được bảo mật)</span>
            </div>
        </div>
    </div>
</div>