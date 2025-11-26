package controller;

import model.bean.ChuKhachSan;
import model.bean.KhachSan;
import model.bo.ChuKhachSanBO;
import model.bo.KhachSanBO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class OwnerKhachSanController extends HttpServlet {

    private KhachSanBO ksBO;
    private ChuKhachSanBO ownerBO;

    @Override
    public void init() throws ServletException {
        ksBO = new KhachSanBO();
        ownerBO = new ChuKhachSanBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "view":
                hienThiKhachSan(request, response);
                break;

            case "edit":
                hienThiFormSua(request, response);
                break;

            case "delete":
                xoaKhachSan(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 FIX ENCODING: Set UTF-8 cho request để xử lý tiếng Việt có dấu
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            capNhatKhachSan(request, response);
        } else if ("updateOwner".equals(action)) {
            capNhatChuKhachSan(request, response);
        } else if ("changePassword".equals(action)) {
            doiMatKhau(request, response);
        }
    }

    // ==========================
    // HIỂN THỊ DASHBOARD
    // ==========================
    private void hienThiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        KhachSan ks = ksBO.getByOwnerId(owner.getId());
        request.setAttribute("khachSan", ks);

        request.getRequestDispatcher("/views/owner/dashboard.jsp")
                .forward(request, response);
    }

    // ==========================
    // FORM CHỈNH SỬA
    // ==========================
    private void hienThiFormSua(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        KhachSan ks = ksBO.getByOwnerId(owner.getId());

        if (ks == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
            return;
        }

        request.setAttribute("khachSan", ks);
	        request.getRequestDispatcher("/views/owner/edit_hotel.jsp")
                .forward(request, response);
    }

    // ==========================
    // XỬ LÝ CẬP NHẬT KHÁCH SẠN
    // ==========================
    private void capNhatKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        KhachSan ks = ksBO.getByOwnerId(owner.getId());
        if (ks == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
            return;
        }

        ks.setTen(request.getParameter("ten"));
        ks.setDiaChi(request.getParameter("diachi"));
        ks.setSoDienThoai(request.getParameter("sdt"));
        ks.setMoTa(request.getParameter("mota"));
        // ownerId giữ nguyên

        ksBO.update(ks);

        // 🔥 QUAY VỀ DASHBOARD SAU KHI LƯU
        response.sendRedirect(request.getContextPath() + "/owner/hotel?action=view");
    }

    // ==========================
    // XỬ LÝ CẬP NHẬT CHỦ KHÁCH SẠN
    // ==========================
    private void capNhatChuKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        if (ownerId != owner.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền cập nhật");
            return;
        }

        // Cập nhật thông tin
        owner.setTen(request.getParameter("ten"));
        owner.setSdt(request.getParameter("sdt"));
        owner.setEmail(request.getParameter("email"));

        ownerBO.update(owner);

        // Cập nhật session để refresh dữ liệu
        request.getSession().setAttribute("owner", owner);

        // 🔥 QUAY VỀ DASHBOARD SAU KHI LƯU
        response.sendRedirect(request.getContextPath() + "/owner/hotel?action=view");
    }

    // ==========================
    // XỬ LÝ ĐỔI MẬT KHẨU
    // ==========================
    private void doiMatKhau(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        if (ownerId != owner.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền thay đổi");
            return;
        }

        String matKhauCu = request.getParameter("matKhauCu");
        String matKhauMoi = request.getParameter("matKhauMoi");
        String matKhauXacNhan = request.getParameter("matKhauXacNhan");

        // Kiểm tra mật khẩu cũ
        if (!matKhauCu.equals(owner.getMatkhau())) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            hienThiFormSua(request, response); // Quay lại form với error
            return;
        }

        // Kiểm tra xác nhận
        if (!matKhauMoi.equals(matKhauXacNhan)) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            hienThiFormSua(request, response); // Quay lại form với error
            return;
        }

        if (matKhauMoi.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải ít nhất 6 ký tự!");
            hienThiFormSua(request, response);
            return;
        }

        // Cập nhật mật khẩu mới (không hash)
        owner.setMatkhau(matKhauMoi);
        ownerBO.update(owner);

        // Cập nhật session
        request.getSession().setAttribute("owner", owner);

        // Redirect với success message (có thể dùng session attribute)
        request.getSession().setAttribute("success", "Đổi mật khẩu thành công!");
        response.sendRedirect(request.getContextPath() + "/owner/hotel?action=view");
    }

    // ==========================
    // XÓA
    // ==========================
    private void xoaKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect(request.getContextPath() + "/dangnhap.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        KhachSan ks = ksBO.getById(id);

        if (ks == null || ks.getOwnerId() != owner.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        ksBO.delete(id);

        response.sendRedirect(request.getContextPath() + "/owner/hotel?action=view");
    }
}