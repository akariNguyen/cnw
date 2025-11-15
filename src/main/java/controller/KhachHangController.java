package controller;

import model.bean.KhachHang;
import model.dao.KhachHangDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class KhachHangController extends HttpServlet {

    private KhachHangDAO khDAO;

    @Override
    public void init() throws ServletException {
        khDAO = new KhachHangDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String ten = request.getParameter("ten");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String matKhau = request.getParameter("matkhau");

            KhachHang kh = new KhachHang();
            kh.setTen(ten);
            kh.setSdt(sdt);
            kh.setEmail(email);
            kh.setMatKhau(matKhau);

            try {
                khDAO.insert(kh);
                response.sendRedirect("dangnhap.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("dangky.jsp?error=1");
            }

        } else {
            String taiKhoan = request.getParameter("taikhoan");
            String matKhau = request.getParameter("matkhau");

            KhachHang kh = khDAO.login(taiKhoan, matKhau);
            if (kh != null) {
                HttpSession session = request.getSession();
                session.setAttribute("khachHang", kh);
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("dangnhap.jsp?error=1");
            }
        }
    }

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
