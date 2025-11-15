package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.TinhTrangPhong;

public class TinhTrangPhongDAO {

    // Lấy toàn bộ + join tên phòng
    public List<TinhTrangPhong> getAll() {
        List<TinhTrangPhong> list = new ArrayList<>();

        String sql = "SELECT ttp.*, p.ten_phong " +
                     "FROM tinh_trang_phong ttp " +
                     "JOIN phong p ON ttp.phong_id = p.id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                TinhTrangPhong ttp = new TinhTrangPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        rs.getDate("ngay"),
                        rs.getInt("so_luong_con")
                );

                ttp.setTenPhong(rs.getString("ten_phong"));

                list.add(ttp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy tình trạng của 1 phòng theo ngày
    public TinhTrangPhong getByPhongIdAndNgay(int phongId, Date ngay) {

        String sql = "SELECT * FROM tinh_trang_phong WHERE phong_id = ? AND ngay = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, phongId);
            stmt.setDate(2, ngay);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                TinhTrangPhong ttp = new TinhTrangPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        rs.getDate("ngay"),
                        rs.getInt("so_luong_con")
                );
                rs.close();
                return ttp;
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Insert nếu chưa có — Update nếu đã tồn tại
    public void insertOrUpdate(TinhTrangPhong ttp) {

        String checkSql = "SELECT id FROM tinh_trang_phong WHERE phong_id = ? AND ngay = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, ttp.getPhongId());
            checkStmt.setDate(2, ttp.getNgay());

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Tồn tại → Update
                String updateSql = "UPDATE tinh_trang_phong SET so_luong_con = ? WHERE phong_id = ? AND ngay = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, ttp.getSoLuongCon());
                    updateStmt.setInt(2, ttp.getPhongId());
                    updateStmt.setDate(3, ttp.getNgay());
                    updateStmt.executeUpdate();
                }
            } else {
                // Chưa tồn tại → Insert
                String insertSql = "INSERT INTO tinh_trang_phong (phong_id, ngay, so_luong_con) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, ttp.getPhongId());
                    insertStmt.setDate(2, ttp.getNgay());
                    insertStmt.setInt(3, ttp.getSoLuongCon());
                    insertStmt.executeUpdate();
                }
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        String sql = "DELETE FROM tinh_trang_phong WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
