package controller;

import model.bean.TinhTrangPhong;
import model.dao.TinhTrangPhongDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TinhTrangPhongController extends HttpServlet {

    private TinhTrangPhongDAO ttpDAO;

    @Override
    public void init() throws ServletException {
        ttpDAO = new TinhTrangPhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            hienThiDanhSach(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void hienThiDanhSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<TinhTrangPhong> list = ttpDAO.getAll();
        request.setAttribute("listTinhTrang", list);

        RequestDispatcher rd =
                request.getRequestDispatcher("/views/tinhtrangphong/danhsach.jsp");
        rd.forward(request, response);
    }
}
