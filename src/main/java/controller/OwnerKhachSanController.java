package controller;

import model.bean.ChuKhachSan;
import model.bean.KhachSan;
import model.bo.KhachSanBO;
import model.dao.KhachSanDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class OwnerKhachSanController extends HttpServlet {

    private KhachSanBO ksBO;

    @Override
    public void init() throws ServletException {
        ksBO = new KhachSanBO();
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

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            capNhatKhachSan(request, response);
        }
    }

    // ============================
    // HIỂN THỊ THÔNG TIN KHÁCH SẠN
    // ============================
    private void hienThiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ChuKhachSan owner = (ChuKhachSan) request.getSession().getAttribute("owner");
        if (owner == null) {
            response.sendRedirect("../dangnhap.jsp");
            return;
        }

        KhachSan ks = ksBO.getByOwnerId(owner.getId());
        request.setAttribute("khachSan", ks);

        request.getRequestDispatcher("/views/owner/hotel_detail.jsp")
                .forward(request, response);
    }

    // ============================
    // HIỂN THỊ FORM SỬA
    // ============================
    private void hienThiFormSua(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        KhachSan ks = ksBO.getById(id);

        request.setAttribute("khachSan", ks);
        request.getRequestDispatcher("/views/owner/hotel_edit.jsp")
                .forward(request, response);
    }

    // ============================
    // XỬ LÝ SỬA
    // ============================
    private void capNhatKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        KhachSan ks = new KhachSan();
        ks.setId(id);
        ks.setTen(request.getParameter("ten"));
        ks.setDiaChi(request.getParameter("diachi"));
        ks.setSoDienThoai(request.getParameter("sdt"));
        ks.setMoTa(request.getParameter("mota"));
        ks.setOwnerId(Integer.parseInt(request.getParameter("ownerId")));

        ksBO.update(ks);

        response.sendRedirect("OwnerKhachSanController?action=view");
    }

    // ============================
    // XÓA KHÁCH SẠN
    // ============================
    private void xoaKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        ksBO.delete(id);

        response.sendRedirect("OwnerKhachSanController?action=view");
    }
}
