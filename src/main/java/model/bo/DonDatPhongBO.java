package model.bo;

import java.sql.Date;
import java.util.List;
import model.bean.DonDatPhong;
import model.dao.DonDatPhongDAO;

public class DonDatPhongBO {
    private DonDatPhongDAO ddpDAO;

    public DonDatPhongBO() {
        ddpDAO = new DonDatPhongDAO();
    }

    public List<DonDatPhong> getAll() {
        return ddpDAO.getAll();
    }

    public DonDatPhong getById(int id) {
        return ddpDAO.getById(id);
    }

    public void insert(DonDatPhong d) {
        ddpDAO.insert(d);
    }

    public List<DonDatPhong> getByKhachHangId(int khachHangId) {
        return ddpDAO.getByKhachHangId(khachHangId);
    }

    public void delete(int id) {
        ddpDAO.delete(id);
    }

    public List<DonDatPhong> getByKhachSanId(int khachSanId) {
        return ddpDAO.getByKhachSanId(khachSanId);
    }

    // THÊM MỚI: Kiểm tra quyền sở hữu đơn
    public DonDatPhong getByIdAndKhachHangId(int id, int khachHangId) {
        DonDatPhong d = ddpDAO.getById(id);
        if (d != null && d.getKhachHangId() == khachHangId) {
            return d;
        }
        return null;
    }
    public boolean isPhongDaDat(int phongId, Date ngayNhan, Date ngayTra) {
        return ddpDAO.isPhongDaDat(phongId, ngayNhan, ngayTra);
    }
}