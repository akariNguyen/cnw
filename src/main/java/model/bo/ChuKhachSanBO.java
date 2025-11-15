package model.bo;

import model.bean.ChuKhachSan;
import model.dao.ChuKhachSanDAO;

public class ChuKhachSanBO {

    private ChuKhachSanDAO cksDAO;

    public ChuKhachSanBO() {
        cksDAO = new ChuKhachSanDAO();
    }

    // Insert chủ khách sạn, trả về id
    public int insert(ChuKhachSan cks) {
        return cksDAO.insert(cks);
    }

    // Login chủ khách sạn
    public ChuKhachSan login(String taikhoan, String pass) {
        return cksDAO.login(taikhoan, pass);
    }
}
