package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.Phong;

public class PhongDAO {

    // Lấy toàn bộ phòng
    public List<Phong> getAll() {
        List<Phong> list = new ArrayList<>();
        String sql = "SELECT * FROM phong";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Lấy danh sách phòng theo khách sạn
    public List<Phong> getByKhachSanId(int khachSanId) {
        List<Phong> list = new ArrayList<>();
        String sql = "SELECT * FROM phong WHERE khach_san_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, khachSanId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) list.add(map(rs));

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Lấy phòng theo id
    public Phong getById(int id) {
        String sql = "SELECT * FROM phong WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // Insert phòng
    public void insert(Phong p) {
        String sql = "INSERT INTO phong (khach_san_id, ten_phong, loai, gia, suc_chua, so_luong, mo_ta, hinh_anh) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, p.getKhachSanId());
            stmt.setString(2, p.getTenPhong());
            stmt.setString(3, p.getLoai());
            stmt.setInt(4, p.getGia());
            stmt.setInt(5, p.getSucChua());

            stmt.setString(7, p.getMoTa());
            stmt.setString(8, p.getHinhAnh());
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Update phòng
    public void update(Phong p) {
        String sql = "UPDATE phong SET khach_san_id=?, ten_phong=?, loai=?, gia=?, suc_chua=?, so_luong=?, mo_ta=?, hinh_anh=? "
                   + "WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, p.getKhachSanId());
            stmt.setString(2, p.getTenPhong());
            stmt.setString(3, p.getLoai());
            stmt.setInt(4, p.getGia());
            stmt.setInt(5, p.getSucChua());
       
            stmt.setString(7, p.getMoTa());
            stmt.setString(8, p.getHinhAnh());
            stmt.setInt(9, p.getId());
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Delete phòng
    public void delete(int id) {
        String sql = "DELETE FROM phong WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // Mapping chung
    private Phong map(ResultSet rs) throws Exception {
        return new Phong(
                rs.getInt("id"),
                rs.getInt("khach_san_id"),
                rs.getString("ten_phong"),
                rs.getString("loai"),
                rs.getInt("gia"),
                rs.getInt("suc_chua"),
    
                rs.getString("mo_ta"),
                rs.getString("hinh_anh")
        );
    }
}
