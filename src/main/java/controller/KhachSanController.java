package controller;

import model.bean.ChuKhachSan;
import model.bean.KhachSan;
import model.bo.ChuKhachSanBO;
import model.bo.KhachSanBO;
import model.dao.KhachSanDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class KhachSanController extends HttpServlet {

    private KhachSanBO ksBO;

    @Override
    public void init() throws ServletException {
        ksBO = new KhachSanBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 FIX ENCODING: Set UTF-8 cho request/response để xử lý tiếng Việt có dấu
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.equals("")) {
            action = "list";
        }

        switch (action) {
            case "list":
                hienThiDanhSach(request, response);
                break;
            case "detail":
                hienThiChiTiet(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hành động không hợp lệ");
        }
    }

    private void hienThiDanhSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<KhachSan> danhSach = ksBO.getAll();
        request.setAttribute("listKhachSan", danhSach);
        RequestDispatcher rd = request.getRequestDispatcher("/views/khachsan/danhsach.jsp");
        rd.forward(request, response);
    }

    private void hienThiChiTiet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            KhachSan ks = ksBO.getById(id);

            if (ks == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách sạn");
                return;
            }
            ChuKhachSan owner = new ChuKhachSanBO().getById(ks.getOwnerId());

            request.setAttribute("khachSan", ks);
            request.setAttribute("owner", owner); // THÊM DÒNG NÀY

            RequestDispatcher rd = request.getRequestDispatcher("/views/khachsan/chitiet.jsp");
            rd.forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
}