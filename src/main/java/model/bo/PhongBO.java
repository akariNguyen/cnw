package model.bo;

import java.util.List;

import model.bean.Phong;
import model.dao.PhongDAO;

public class PhongBO {

    private PhongDAO phongDAO;

    public PhongBO() {
        phongDAO = new PhongDAO();
    }

    // Lấy tất cả phòng
    public List<Phong> getAll() {
        return phongDAO.getAll();
    }

    // Lấy danh sách phòng theo khách sạn
    public List<Phong> getByKhachSanId(int khachSanId) {
        return phongDAO.getByKhachSanId(khachSanId);
    }

    // Lấy phòng theo id
    public Phong getById(int id) {
        return phongDAO.getById(id);
    }

    // Thêm phòng
    public void insert(Phong p) {
        phongDAO.insert(p);
    }

    // Cập nhật phòng
    public void update(Phong p) {
        phongDAO.update(p);
    }

    // Xóa phòng
    public void delete(int id) {
        phongDAO.delete(id);
    }
}
