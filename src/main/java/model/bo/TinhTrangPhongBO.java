package model.bo;

import java.sql.Date;
import java.util.List;

import model.bean.TinhTrangPhong;
import model.dao.TinhTrangPhongDAO;

public class TinhTrangPhongBO {

    private TinhTrangPhongDAO ttpDAO;

    public TinhTrangPhongBO() {
        ttpDAO = new TinhTrangPhongDAO();
    }

    // Lấy toàn bộ (đã join tên phòng)
    public List<TinhTrangPhong> getAll() {
        return ttpDAO.getAll();
    }

    // Lấy tình trạng 1 phòng theo ngày
    public TinhTrangPhong getByPhongIdAndNgay(int phongId, Date ngay) {
        return ttpDAO.getByPhongIdAndNgay(phongId, ngay);
    }

    // Insert nếu chưa có – Update nếu đã tồn tại
    public void insertOrUpdate(TinhTrangPhong ttp) {
        ttpDAO.insertOrUpdate(ttp);
    }

    // Xóa theo id
    public void delete(int id) {
        ttpDAO.delete(id);
    }
}
