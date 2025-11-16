package controller;

import model.bean.DonDatPhong;
import model.bean.KhachHang;
import model.bean.KhachSan;
import model.bean.Phong;
import model.bo.DonDatPhongBO;
import model.bo.KhachSanBO;
import model.bo.PhongBO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class DonDatPhongController extends HttpServlet {

    private DonDatPhongBO ddpBO;

    @Override
    public void init() throws ServletException {
        ddpBO = new DonDatPhongBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        KhachHang khachHang = (KhachHang) request.getSession().getAttribute("khachHang");
        if (khachHang == null) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                hienThiDanhSach(request, response, khachHang.getId());
                break;
            case "view":
                xemChiTiet(request, response, khachHang.getId());
                break;
            case "cancel":
                huyDonDatPhong(request, response, khachHang.getId());
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void hienThiDanhSach(HttpServletRequest request, HttpServletResponse response, int khachHangId)
            throws ServletException, IOException {
        List<DonDatPhong> list = ddpBO.getByKhachHangId(khachHangId);
        request.setAttribute("listDonDat", list);
        request.getRequestDispatcher("/views/dondatphong/danhsach.jsp").forward(request, response);
    }

    private void xemChiTiet(HttpServletRequest request, HttpServletResponse response, int khachHangId)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("bookingId"));
            DonDatPhong booking = ddpBO.getByIdAndKhachHangId(id, khachHangId);

            if (booking == null) {
                request.setAttribute("error", "Không tìm thấy đơn hoặc bạn không có quyền xem.");
            } else {
                request.setAttribute("booking", booking);

                // LẤY PHÒNG
                PhongBO phongBO = new PhongBO();
                Phong phong = phongBO.getById(booking.getPhongId());
                request.setAttribute("phong", phong);

                // LẤY KHÁCH SẠN (qua phòng)
                if (phong != null) {
                    KhachSanBO ksBO = new KhachSanBO();
                    KhachSan khachSan = ksBO.getById(phong.getKhachSanId());
                    request.setAttribute("khachSan", khachSan);
                }
            }
            request.getRequestDispatcher("/views/dondatphong/viewBooking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ.");
            request.getRequestDispatcher("/views/dondatphong/viewBooking.jsp").forward(request, response);
        }
    }

    private void huyDonDatPhong(HttpServletRequest request, HttpServletResponse response, int khachHangId)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("bookingId"));
            DonDatPhong booking = ddpBO.getByIdAndKhachHangId(id, khachHangId);

            if (booking == null) {
                request.setAttribute("error", "Không tìm thấy đơn hoặc bạn không có quyền hủy.");
            } else {
                ddpBO.delete(id);
                request.setAttribute("success", "Hủy đơn thành công!");
            }
            hienThiDanhSach(request, response, khachHangId);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ.");
            hienThiDanhSach(request, response, khachHangId);
        }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        KhachHang khachHang = (KhachHang) request.getSession().getAttribute("khachHang");
        if (khachHang == null) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }

        try {
            int phongId = Integer.parseInt(request.getParameter("phong_id"));
            Date ngayNhan = Date.valueOf(request.getParameter("ngay_nhan"));
            Date ngayTra = Date.valueOf(request.getParameter("ngay_tra"));
            String maDon = request.getParameter("ma_don");

            // KIỂM TRA TRÙNG THỜI GIAN
            if (ddpBO.isPhongDaDat(phongId, ngayNhan, ngayTra)) {
                request.setAttribute("error", "Phòng đã được đặt trong khoảng thời gian này. Vui lòng chọn ngày khác.");
                request.setAttribute("phongId", phongId);
                request.setAttribute("ngayNhan", ngayNhan.toString());
                request.setAttribute("ngayTra", ngayTra.toString());
                request.setAttribute("maDon", maDon);
                request.getRequestDispatcher("form_datphong.jsp").forward(request, response);
                return;
            }

            DonDatPhong don = new DonDatPhong(
                0, phongId, khachHang.getId(), ngayNhan, ngayTra,
                new Timestamp(System.currentTimeMillis()), maDon
            );

            ddpBO.insert(don);
            request.setAttribute("success", "Đặt phòng thành công!");

            // THÀNH CÔNG → CHUYỂN VỀ DANH SÁCH
            hienThiDanhSach(request, response, khachHang.getId());

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày không hợp lệ. Vui lòng kiểm tra lại.");
            request.setAttribute("phongId", request.getParameter("phong_id"));
            request.getRequestDispatcher("form_datphong.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi đặt phòng: " + e.getMessage());
            request.getRequestDispatcher("form_datphong.jsp").forward(request, response);
        }
    }
}