package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.KhachSan;

public class KhachSanDAO {

    // Lấy tất cả khách sạn
    public List<KhachSan> getAll() {
        List<KhachSan> list = new ArrayList<>();
        String sql = "SELECT * FROM khach_san";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) list.add(map(rs));

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Lấy khách sạn theo id
    public KhachSan getById(int id) {
        String sql = "SELECT * FROM khach_san WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // Lấy khách sạn theo owner_id (1 owner = 1 khách sạn)
    public KhachSan getByOwnerId(int ownerId) {

        String sql = "SELECT * FROM khach_san WHERE owner_id = ? LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, ownerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // Thêm khách sạn
    public void insert(KhachSan ks) {

        String sql = "INSERT INTO khach_san (ten, dia_chi, so_dien_thoai, mo_ta, owner_id) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ks.getTen());
            stmt.setString(2, ks.getDiaChi());
            stmt.setString(3, ks.getSoDienThoai());
            stmt.setString(4, ks.getMoTa());
            stmt.setInt(5, ks.getOwnerId());
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Cập nhật khách sạn
    public void update(KhachSan ks) {

        String sql = "UPDATE khach_san SET ten=?, dia_chi=?, so_dien_thoai=?, mo_ta=?, owner_id=? "
                   + "WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ks.getTen());
            stmt.setString(2, ks.getDiaChi());
            stmt.setString(3, ks.getSoDienThoai());
            stmt.setString(4, ks.getMoTa());
            stmt.setInt(5, ks.getOwnerId());
            stmt.setInt(6, ks.getId());
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Xóa khách sạn
    public void delete(int id) {
        String sql = "DELETE FROM khach_san WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Mapping dùng chung
    private KhachSan map(ResultSet rs) throws Exception {
        return new KhachSan(
            rs.getInt("id"),
            rs.getString("ten"),
            rs.getString("dia_chi"),
            rs.getString("so_dien_thoai"),
            rs.getString("mo_ta"),
            rs.getInt("owner_id")
        );
    }
}
