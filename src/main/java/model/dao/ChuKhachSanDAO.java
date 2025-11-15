package model.dao;

import java.sql.*;
import model.bean.ChuKhachSan;

public class ChuKhachSanDAO {

    public int insert(ChuKhachSan cks) {
        String sql = "INSERT INTO chu_khach_san (ten, sdt, email, matkhau) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cks.getTen());
            stmt.setString(2, cks.getSdt());
            stmt.setString(3, cks.getEmail());
            stmt.setString(4, cks.getMatkhau());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ChuKhachSan login(String taikhoan, String pass) {
        String sql = "SELECT * FROM chu_khach_san WHERE (email = ? OR sdt = ?) AND matkhau = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, taikhoan);
            stmt.setString(2, taikhoan);
            stmt.setString(3, pass);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ChuKhachSan(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("sdt"),
                        rs.getString("email"),
                        rs.getString("matkhau")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
