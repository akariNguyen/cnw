package controller;

import model.bean.KhachSan;
import model.bean.Phong;
import model.bo.KhachSanBO;
import model.bo.PhongBO;
import model.bo.DonDatPhongBO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.*;

public class TinhTrangPhongController extends HttpServlet {

    private final KhachSanBO ksBO = new KhachSanBO();
    private final PhongBO phongBO = new PhongBO();
    private final DonDatPhongBO ddpBO = new DonDatPhongBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fromStr = request.getParameter("from");
        String toStr = request.getParameter("to");

        // Nếu chưa chọn ngày → chỉ hiện form
        if (fromStr == null || toStr == null || fromStr.isEmpty() || toStr.isEmpty()) {
            request.getRequestDispatcher("/views/tinhtrangphong/danhsach.jsp").forward(request, response);
            return;
        }

        Date from, to;
        try {
            from = Date.valueOf(fromStr);
            to = Date.valueOf(toStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày không hợp lệ!");
            request.getRequestDispatcher("/views/tinhtrangphong/danhsach.jsp").forward(request, response);
            return;
        }

        if (to.before(from)) {
            request.setAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu!");
            request.getRequestDispatcher("/views/tinhtrangphong/danhsach.jsp").forward(request, response);
            return;
        }

        // Kết quả: KhachSan → List phòng còn trống TOÀN BỘ từ "from" đến "to"
        Map<KhachSan, List<Map<String, Object>>> ketQua = new LinkedHashMap<>();

        for (KhachSan ks : ksBO.getAll()) {
            List<Phong> dsPhong = phongBO.getByKhachSanId(ks.getId());
            List<Map<String, Object>> phongTrong = new ArrayList<>();

            for (Phong p : dsPhong) {
                // Kiểm tra phòng này có bị đặt bất kỳ ngày nào trong khoảng [from, to] không
                boolean daDat = ddpBO.isPhongDaDat(p.getId(), from, to);

                if (!daDat) { // trống toàn bộ khoảng ngày
                    Map<String, Object> info = new HashMap<>();
                    info.put("tenPhong", p.getTenPhong());
                    info.put("loai", p.getLoai());
                    info.put("gia", p.getGia());
                    phongTrong.add(info);
                }
            }

            if (!phongTrong.isEmpty()) {
                ketQua.put(ks, phongTrong);
            }
        }

        request.setAttribute("ketQua", ketQua);
        request.setAttribute("from", fromStr);
        request.setAttribute("to", toStr);

        request.getRequestDispatcher("/views/tinhtrangphong/danhsach.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}