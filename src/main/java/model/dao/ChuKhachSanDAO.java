package model.dao;

import java.sql.*;
import model.bean.ChuKhachSan;

public class ChuKhachSanDAO {

    // Insert và trả về ID
    public int insert(ChuKhachSan cks) {
        String sql = "INSERT INTO chu_khach_san (ten, sdt, email, matkhau) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cks.getTen());
            stmt.setString(2, cks.getSdt());
            stmt.setString(3, cks.getEmail());
            stmt.setString(4, cks.getMatkhau());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Login bằng email hoặc SĐT
    public ChuKhachSan login(String taikhoan, String matkhau) {
        String sql = "SELECT * FROM chu_khach_san WHERE (email = ? OR sdt = ?) AND matkhau = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, taikhoan);
            stmt.setString(2, taikhoan);
            stmt.setString(3, matkhau);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToChuKhachSan(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật toàn bộ (có mật khẩu)
    public void update(ChuKhachSan cks) {
        String sql = "UPDATE chu_khach_san SET ten = ?, sdt = ?, email = ?, matkhau = ? WHERE id = ?";
        executeUpdate(sql, cks.getTen(), cks.getSdt(), cks.getEmail(), cks.getMatkhau(), cks.getId());
    }

    // Cập nhật KHÔNG đổi mật khẩu
    public void updateWithoutPassword(ChuKhachSan cks) {
        String sql = "UPDATE chu_khach_san SET ten = ?, sdt = ?, email = ? WHERE id = ?";
        executeUpdate(sql, cks.getTen(), cks.getSdt(), cks.getEmail(), cks.getId());
    }

    // Lấy theo ID
    public ChuKhachSan getById(int id) {
        String sql = "SELECT * FROM chu_khach_san WHERE id = ?";
        return executeQuery(sql, id);
    }

    // Lấy theo email
    public ChuKhachSan getByEmail(String email) {
        String sql = "SELECT * FROM chu_khach_san WHERE email = ?";
        return executeQuery(sql, email);
    }

    // Lấy theo SĐT
    public ChuKhachSan getBySdt(String sdt) {
        String sql = "SELECT * FROM chu_khach_san WHERE sdt = ?";
        return executeQuery(sql, sdt);
    }

    // === HÀM HỖ TRỢ ===
    private ChuKhachSan executeQuery(String sql, Object... params) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToChuKhachSan(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void executeUpdate(String sql, Object... params) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private ChuKhachSan mapRowToChuKhachSan(ResultSet rs) throws SQLException {
        return new ChuKhachSan(
                rs.getInt("id"),
                rs.getString("ten"),
                rs.getString("sdt"),
                rs.getString("email"),
                rs.getString("matkhau")
        );
    }
}