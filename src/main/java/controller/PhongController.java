package controller;

import model.bean.Phong;
import model.dao.PhongDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class PhongController extends HttpServlet {

    private PhongDAO phongDAO;

    @Override
    public void init() throws ServletException {
        phongDAO = new PhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                hienThiPhongTheoKhachSan(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void hienThiPhongTheoKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int khachSanId = Integer.parseInt(request.getParameter("khachSanId"));
            List<Phong> listPhong = phongDAO.getByKhachSanId(khachSanId);

            request.setAttribute("listPhong", listPhong);
            request.setAttribute("khachSanId", khachSanId);

            RequestDispatcher rd = request.getRequestDispatcher("/views/phong/danhsach.jsp");
            rd.forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "khachSanId không hợp lệ");
        }
    }
}
