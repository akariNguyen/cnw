package model.bo;

import model.bean.ChuKhachSan;
import model.dao.ChuKhachSanDAO;

public class ChuKhachSanBO {
    private final ChuKhachSanDAO cksDAO;

    public ChuKhachSanBO() {
        this.cksDAO = new ChuKhachSanDAO();
    }

    // Insert chủ khách sạn, trả về ID
    public int insert(ChuKhachSan cks) {
        if (cks == null || cks.getTen() == null || cks.getEmail() == null || cks.getSdt() == null) {
            return -1;
        }
        return cksDAO.insert(cks);
    }

    // Login chủ khách sạn (email hoặc SĐT)
    public ChuKhachSan login(String taikhoan, String matkhau) {
        if (taikhoan == null || taikhoan.trim().isEmpty() || matkhau == null) {
            return null;
        }
        return cksDAO.login(taikhoan.trim(), matkhau);
    }

    // Cập nhật toàn bộ (bao gồm mật khẩu)
    public boolean update(ChuKhachSan cks) {
        if (cks == null || cks.getId() <= 0) return false;
        cksDAO.update(cks);
        return true;
    }

    // Cập nhật thông tin KHÔNG đổi mật khẩu
    public boolean updateWithoutPassword(ChuKhachSan cks) {
        if (cks == null || cks.getId() <= 0) return false;
        cksDAO.updateWithoutPassword(cks);
        return true;
    }

    // Lấy chủ theo ID
    public ChuKhachSan getById(int id) {
        if (id <= 0) return null;
        return cksDAO.getById(id);
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return cksDAO.getByEmail(email.trim()) != null;
    }

    // Kiểm tra SĐT đã tồn tại chưa
    public boolean isSdtExists(String sdt) {
        if (sdt == null || sdt.trim().isEmpty()) return false;
        return cksDAO.getBySdt(sdt.trim()) != null;
    }
}