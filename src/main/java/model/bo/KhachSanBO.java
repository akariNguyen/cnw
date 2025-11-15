package model.bo;

import java.util.List;

import model.bean.KhachSan;
import model.dao.KhachSanDAO;

public class KhachSanBO {

    private KhachSanDAO ksDAO;

    public KhachSanBO() {
        ksDAO = new KhachSanDAO();
    }

    // Lấy tất cả khách sạn
    public List<KhachSan> getAll() {
        return ksDAO.getAll();
    }

    // Lấy khách sạn theo id
    public KhachSan getById(int id) {
        return ksDAO.getById(id);
    }

    // Lấy khách sạn theo owner_id
    public KhachSan getByOwnerId(int ownerId) {
        return ksDAO.getByOwnerId(ownerId);
    }

    // Thêm
    public void insert(KhachSan ks) {
        ksDAO.insert(ks);
    }

    // Cập nhật
    public void update(KhachSan ks) {
        ksDAO.update(ks);
    }

    // Xóa
    public void delete(int id) {
        ksDAO.delete(id);
    }
}
