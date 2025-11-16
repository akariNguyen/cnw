package controller;

import model.bean.KhachHang;
import model.bean.ChuKhachSan;
import model.bean.KhachSan;
import model.bo.ChuKhachSanBO;
import model.bo.KhachHangBO;
import model.bo.KhachSanBO;
import model.dao.KhachHangDAO;
import model.dao.ChuKhachSanDAO;
import model.dao.KhachSanDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class KhachHangController extends HttpServlet {

    private KhachHangBO khBO;
    private ChuKhachSanBO ownerBO;
    private KhachSanBO ksBO;

    @Override
    public void init() throws ServletException {
        khBO = new KhachHangBO();
        ownerBO = new ChuKhachSanBO();
        ksBO = new KhachSanBO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // 1. ĐĂNG KÝ
        if ("register".equals(action)) {
            String role = request.getParameter("role");
            String ten = request.getParameter("ten");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String matKhau = request.getParameter("matkhau");

            if ("khachhang".equals(role)) {
                KhachHang kh = new KhachHang();
                kh.setTen(ten);
                kh.setSdt(sdt);
                kh.setEmail(email);
                kh.setMatKhau(matKhau);

                try {
                    khBO.insert(kh);
                    response.sendRedirect("dangnhap.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("dangky.jsp?error=1");
                }
                return;
            }

            if ("owner".equals(role)) {
                ChuKhachSan cks = new ChuKhachSan();
                cks.setTen(ten);
                cks.setSdt(sdt);
                cks.setEmail(email);
                cks.setMatkhau(matKhau);

                int ownerId = ownerBO.insert(cks);
                if (ownerId <= 0) {
                    response.sendRedirect("dangky.jsp?error=1");
                    return;
                }

                KhachSan ks = new KhachSan();
                ks.setTen(request.getParameter("ks_ten"));
                ks.setDiaChi(request.getParameter("ks_diachi"));
                ks.setSoDienThoai(request.getParameter("ks_sdt"));
                ks.setMoTa(request.getParameter("ks_mota"));
                ks.setOwnerId(ownerId);

                ksBO.insert(ks);

                HttpSession session = request.getSession();
                session.setAttribute("ownerId", ownerId);
                session.setAttribute("role", "owner");
                response.sendRedirect("views/owner/dashboard.jsp");
                return;
            }

            response.sendRedirect("dangky.jsp?error=1");
            return;
        }

        // 2. ĐĂNG NHẬP
        else if ("login".equals(action)) {
            String taiKhoan = request.getParameter("taikhoan");
            String matKhau = request.getParameter("matkhau");

            if (taiKhoan == null || matKhau == null || taiKhoan.trim().isEmpty()) {
                response.sendRedirect("dangnhap.jsp?error=1");
                return;
            }

            KhachHang kh = khBO.login(taiKhoan.trim(), matKhau);
            if (kh != null) {
                HttpSession session = request.getSession();
                session.setAttribute("khachHang", kh);
                session.setAttribute("role", "khachhang");
                response.sendRedirect("index.jsp");
                return;
            }

            ChuKhachSan owner = ownerBO.login(taiKhoan.trim(), matKhau);
            if (owner != null) {
                HttpSession session = request.getSession();
                session.setAttribute("owner", owner);
                session.setAttribute("role", "owner");
                response.sendRedirect("views/owner/dashboard.jsp");
                return;
            }

            response.sendRedirect("dangnhap.jsp?error=1");
            return;
        }

        // 3. CẬP NHẬT HỒ SƠ
        else if ("updateProfile".equals(action)) {
            capNhatProfile(request, response);
            return;
        }

        // 4. ĐỔI MẬT KHẨU
        else if ("changePassword".equals(action)) {
            doiMatKhauKhachHang(request, response);
            return;
        }

        // Không có action
        else {
            response.sendRedirect("index.jsp");
        }
    }

    //---------------------------------------------------
    // LOGOUT + EDIT PROFILE + DETAIL KHÁCH HÀNG
    //---------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect("index.jsp");
        } else if ("editProfile".equals(action)) {
            hienThiFormEditProfile(request, response);
        } else if ("detail".equals(action)) {
            xemChiTietKhachHang(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // XEM CHI TIẾT KHÁCH HÀNG (cho modal hoặc full page)
    private void xemChiTietKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
            return;
        }

        KhachHang kh = khBO.getById(id);
        if (kh == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách hàng");
            return;
        }

        request.setAttribute("khachHang", kh);
        // Forward đến partial JSP cho modal (không full HTML)
        request.getRequestDispatcher("/views/khachhang/chitiet_partial.jsp").forward(request, response);
    }

    // FORM CHỈNH SỬA HỒ SƠ
    private void hienThiFormEditProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        KhachHang kh = (KhachHang) request.getSession().getAttribute("khachHang");
        if (kh == null) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }
        request.setAttribute("khachHang", kh);
        request.getRequestDispatcher("/views/khachhang/edit_profile.jsp").forward(request, response);
    }

    // UPDATE PROFILE
    private void capNhatProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        KhachHang kh = (KhachHang) request.getSession().getAttribute("khachHang");
        if (kh == null) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        if (id != kh.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền cập nhật");
            return;
        }

        kh.setTen(request.getParameter("ten"));
        kh.setSdt(request.getParameter("sdt"));
        kh.setEmail(request.getParameter("email"));

        khBO.update(kh);

        request.getSession().setAttribute("khachHang", kh);
        request.getSession().setAttribute("success", "Cập nhật hồ sơ thành công!");
        response.sendRedirect("khachhang?action=editProfile");
    }

    // CHANGE PASSWORD
    private void doiMatKhauKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        KhachHang kh = (KhachHang) request.getSession().getAttribute("khachHang");
        if (kh == null) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        if (id != kh.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền thay đổi");
            return;
        }

        String matKhauCu = request.getParameter("matKhauCu");
        String matKhauMoi = request.getParameter("matKhauMoi");
        String matKhauXacNhan = request.getParameter("matKhauXacNhan");

        // Kiểm tra mật khẩu cũ
        if (!matKhauCu.equals(kh.getMatKhau())) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            hienThiFormEditProfile(request, response);
            return;
        }

        // Kiểm tra xác nhận
        if (!matKhauMoi.equals(matKhauXacNhan)) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            hienThiFormEditProfile(request, response);
            return;
        }

        if (matKhauMoi.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải ít nhất 6 ký tự!");
            hienThiFormEditProfile(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        kh.setMatKhau(matKhauMoi);
        khBO.update(kh);

        request.getSession().setAttribute("khachHang", kh);
        request.getSession().setAttribute("success", "Đổi mật khẩu thành công!");
        response.sendRedirect("khachhang?action=editProfile");
    }
}