package model.bo;

import java.util.List;

import model.bean.DonDatPhong;
import model.dao.DonDatPhongDAO;

public class DonDatPhongBO {

    private DonDatPhongDAO ddpDAO;

    public DonDatPhongBO() {
        ddpDAO = new DonDatPhongDAO();
    }

    // ===========================
    // LẤY TẤT CẢ ĐƠN ĐẶT PHÒNG
    // ===========================
    public List<DonDatPhong> getAll() {
        return ddpDAO.getAll();
    }

    // ===========================
    // LẤY ĐƠN THEO ID
    // ===========================
    public DonDatPhong getById(int id) {
        return ddpDAO.getById(id);
    }

    // ===========================
    // THÊM ĐƠN ĐẶT PHÒNG (CÓ CHECK TRÙNG)
    // ===========================
    public void insert(DonDatPhong d) {

        // Có thể thêm logic chống đặt trùng phòng trong BO (tùy bạn)
        // Ví dụ:
        // if (isPhongBiTrung(d.getPhongId(), d.getNgayNhan(), d.getNgayTra())) return false;

        ddpDAO.insert(d);
    }

    // ===========================
    // LẤY ĐƠN THEO KHÁCH HÀNG
    // ===========================
    public List<DonDatPhong> getByKhachHangId(int khachHangId) {
        return ddpDAO.getByKhachHangId(khachHangId);
    }

    // ===========================
    // XÓA
    // ===========================
    public void delete(int id) {
        ddpDAO.delete(id);
    }

    // ===========================
    // LẤY ĐƠN THEO CHỦ KHÁCH SẠN (OWNER)
    // ===========================
    public List<DonDatPhong> getByKhachSanId(int khachSanId) {
        return ddpDAO.getByKhachSanId(khachSanId);
    }
}
