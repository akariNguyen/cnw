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

        String action = request.getParameter("action");

        //---------------------------------------------------
        // 1) REGISTER
        //---------------------------------------------------
        if ("register".equals(action)) {

            String role = request.getParameter("role"); // khách hàng / owner

            String ten = request.getParameter("ten");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String matKhau = request.getParameter("matkhau");

            //---------------------------------------------------
            // CASE 1: ĐĂNG KÝ KHÁCH HÀNG
            //---------------------------------------------------
            if (role.equals("khachhang")) {

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

            //---------------------------------------------------
            // CASE 2: ĐĂNG KÝ CHỦ KHÁCH SẠN
            //---------------------------------------------------
            if (role.equals("owner")) {

                // ---------------------------
                // 1) Lưu chủ khách sạn
                // ---------------------------
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

                // ---------------------------
                // 2) Lưu khách sạn
                // ---------------------------
                KhachSan ks = new KhachSan();
                ks.setTen(request.getParameter("ks_ten"));
                ks.setDiaChi(request.getParameter("ks_diachi"));
                ks.setSoDienThoai(request.getParameter("ks_sdt"));
                ks.setMoTa(request.getParameter("ks_mota"));
                ks.setOwnerId(ownerId);

                ksBO.insert(ks);

                // ---------------------------
                // 3) Tạo session cho OWNER
                // ---------------------------
                HttpSession session = request.getSession();
                session.setAttribute("ownerId", ownerId);
                session.setAttribute("role", "owner");

                // ---------------------------
                // 4) Redirect về dashboard
                // ---------------------------
                response.sendRedirect("views/owner/dashboard.jsp");
                return;
            }

        }

        //---------------------------------------------------
        // 2) LOGIN
        //---------------------------------------------------
        else {

            String taiKhoan = request.getParameter("taikhoan");
            String matKhau = request.getParameter("matkhau");

            // LOGIN khách hàng
            KhachHang kh = khBO.login(taiKhoan, matKhau);

            if (kh != null) {
                HttpSession session = request.getSession();
                session.setAttribute("khachHang", kh);
                session.setAttribute("role", "khachhang");
                response.sendRedirect("index.jsp");
                return;
            }

            // LOGIN chủ khách sạn
            ChuKhachSan owner = ownerBO.login(taiKhoan, matKhau);
            if (owner != null) {
                HttpSession session = request.getSession();
                session.setAttribute("owner", owner);
                session.setAttribute("role", "owner");
                response.sendRedirect("views/owner/dashboard.jsp");
                return;
            }

            response.sendRedirect("dangnhap.jsp?error=1");
        }
    }

    //---------------------------------------------------
    // LOGOUT
    //---------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect("index.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
