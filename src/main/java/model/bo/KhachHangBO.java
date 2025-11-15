package model.bo;

import java.util.List;

import model.bean.KhachHang;
import model.dao.KhachHangDAO;

public class KhachHangBO {

    private KhachHangDAO khDAO;

    public KhachHangBO() {
        khDAO = new KhachHangDAO();
    }

    // ===========================
    // LẤY TẤT CẢ KHÁCH HÀNG
    // ===========================
    public List<KhachHang> getAll() {
        return khDAO.getAll();
    }

    // ===========================
    // LẤY KHÁCH HÀNG THEO ID
    // ===========================
    public KhachHang getById(int id) {
        return khDAO.getById(id);
    }

    // ===========================
    // LOGIN
    // ===========================
    public KhachHang login(String taiKhoan, String matKhau) {
        return khDAO.login(taiKhoan, matKhau);
    }

    // ===========================
    // THÊM KHÁCH HÀNG
    // ===========================
    public void insert(KhachHang kh) {
        khDAO.insert(kh);
    }

    // ===========================
    // CẬP NHẬT KHÁCH HÀNG
    // ===========================
    public void update(KhachHang kh) {
        khDAO.update(kh);
    }

    // ===========================
    // XÓA KHÁCH HÀNG
    // ===========================
    public void delete(int id) {
        khDAO.delete(id);
    }

    // ===========================
}
