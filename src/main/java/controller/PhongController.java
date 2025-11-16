package controller;

import model.bean.Phong;
import model.bean.KhachSan;
import model.bean.ChuKhachSan;
import model.bo.PhongBO;
import model.bo.KhachSanBO;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class PhongController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PhongBO phongBO;
    private KhachSanBO ksBO;

    @Override
    public void init() throws ServletException {
        phongBO = new PhongBO();
        ksBO = new KhachSanBO();
    }

    // ======================================================
    // Helper: đọc int an toàn
    // ======================================================
    private Integer getInt(HttpServletRequest req, HttpServletResponse resp, String key)
            throws IOException {

        String raw = req.getParameter(key);
        if (raw == null || raw.trim().isEmpty()) {
            resp.sendError(400, key + " bị thiếu");
            return null;
        }

        try {
            return Integer.parseInt(raw.trim());
        } catch (NumberFormatException e) {
            resp.sendError(400, key + " không hợp lệ");
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "list":
                hienThiPhongTheoKhachSan(request, response);
                break;

            case "ownerList":
                hienThiPhongChoOwner(request, response);
                break;

            case "addForm":
                hienThiFormThem(request, response);
                break;

            case "editForm":
                hienThiFormSua(request, response);
                break;

            case "detail":
                xemChiTietPhong(request, response);
                break;

            case "delete":
                xoaPhong(request, response);
                break;

            default:
                response.sendError(404);
        }
    }

    // ======================================================
    // CLIENT XEM PHÒNG
    // ======================================================
    private void hienThiPhongTheoKhachSan(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer ksId = getInt(req, resp, "khachSanId");
        if (ksId == null) return;

        List<Phong> list = phongBO.getByKhachSanId(ksId);

        req.setAttribute("listPhong", list);
        req.setAttribute("khachSanId", ksId);

        req.getRequestDispatcher("/views/phong/danhsach.jsp").forward(req, resp);
    }

    // ======================================================
    // OWNER QUẢN LÝ PHÒNG
    // ======================================================
    private void hienThiPhongChoOwner(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        ChuKhachSan owner = (session != null) ? (ChuKhachSan) session.getAttribute("owner") : null;

        if (owner == null) {
            resp.sendRedirect("dangnhap.jsp");
            return;
        }

        KhachSan ks = ksBO.getByOwnerId(owner.getId());
        if (ks == null) {
            req.setAttribute("error", "Bạn chưa tạo khách sạn nào!");
            req.getRequestDispatcher("/views/owner/dashboard.jsp").forward(req, resp);
            return;
        }

        List<Phong> list = phongBO.getByKhachSanId(ks.getId());

        req.setAttribute("khachSan", ks);
        req.setAttribute("listPhong", list);

        req.getRequestDispatcher("/views/owner/room_list.jsp").forward(req, resp);
    }

    // ======================================================
    // FORM THÊM PHÒNG
    // ======================================================
    private void hienThiFormThem(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer ksId = getInt(req, resp, "khachSanId");
        if (ksId == null) return;

        req.setAttribute("khachSanId", ksId);
        req.getRequestDispatcher("/views/phong/them.jsp").forward(req, resp);
    }

    // ======================================================
    // FORM SỬA PHÒNG
    // ======================================================
    private void hienThiFormSua(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer id = getInt(req, resp, "id");
        if (id == null) return;

        Phong p = phongBO.getById(id);
        if (p == null) {
            resp.sendError(404, "Phòng không tồn tại");
            return;
        }

        req.setAttribute("phong", p);
        req.getRequestDispatcher("/views/phong/sua.jsp").forward(req, resp);
    }

    // ======================================================
    // XEM CHI TIẾT PHÒNG
    // ======================================================
    private void xemChiTietPhong(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer id = getInt(req, resp, "id");
        if (id == null) return;

        Phong p = phongBO.getById(id);
        if (p == null) {
            resp.sendError(404, "Không tìm thấy phòng");
            return;
        }

        req.setAttribute("phong", p);
        req.getRequestDispatcher("/views/phong/chitiet.jsp").forward(req, resp);
    }

    // ======================================================
    // XÓA PHÒNG
    // ======================================================
    private void xoaPhong(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Integer id = getInt(req, resp, "id");
        if (id == null) return;

        phongBO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/phong?action=ownerList");

    }

    // ======================================================
    // POST (ADD + EDIT)
    // ======================================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔥 FIX ENCODING: Set UTF-8 cho request để xử lý tiếng Việt có dấu
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            themPhong(req, resp);
        } else if ("edit".equals(action)) {
            capNhatPhong(req, resp);
        } else {
            resp.sendError(400);
        }
    }

    private void themPhong(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Integer ksId = getInt(req, resp, "khachSanId");
        if (ksId == null) return;

        Phong p = new Phong(
                0,
                ksId,
                req.getParameter("tenPhong"),
                req.getParameter("loai"),
                Integer.parseInt(req.getParameter("gia")),
                Integer.parseInt(req.getParameter("sucChua")),
                req.getParameter("moTa"),
                req.getParameter("hinhAnh")
        );

        phongBO.insert(p);
        resp.sendRedirect(req.getContextPath() + "/phong?action=ownerList");

    }

    private void capNhatPhong(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Integer id = getInt(req, resp, "id");
        Integer ksId = getInt(req, resp, "khachSanId");
        if (id == null || ksId == null) return;

        Phong p = new Phong(
                id,
                ksId,
                req.getParameter("tenPhong"),
                req.getParameter("loai"),
                Integer.parseInt(req.getParameter("gia")),
                Integer.parseInt(req.getParameter("sucChua")),
                req.getParameter("moTa"),
                req.getParameter("hinhAnh")
        );

        phongBO.update(p);
        resp.sendRedirect(req.getContextPath() + "/phong?action=ownerList");

    }
}