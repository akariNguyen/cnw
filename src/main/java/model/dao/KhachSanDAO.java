package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.KhachSan;

public class KhachSanDAO {

    public List<KhachSan> getAll() {
        List<KhachSan> list = new ArrayList<>();

        String sql = "SELECT * FROM khach_san";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                KhachSan ks = new KhachSan(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("dia_chi"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("mo_ta")
                );
                list.add(ks);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public KhachSan getById(int id) {

        String sql = "SELECT * FROM khach_san WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                KhachSan ks = new KhachSan(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("dia_chi"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("mo_ta")
                );
                rs.close();
                return ks;
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void insert(KhachSan ks) {

        String sql = "INSERT INTO khach_san (ten, dia_chi, so_dien_thoai, mo_ta) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ks.getTen());
            stmt.setString(2, ks.getDiaChi());
            stmt.setString(3, ks.getSoDienThoai());
            stmt.setString(4, ks.getMoTa());
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(KhachSan ks) {

        String sql = "UPDATE khach_san SET ten=?, dia_chi=?, so_dien_thoai=?, mo_ta=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ks.getTen());
            stmt.setString(2, ks.getDiaChi());
            stmt.setString(3, ks.getSoDienThoai());
            stmt.setString(4, ks.getMoTa());
            stmt.setInt(5, ks.getId());

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        String sql = "DELETE FROM khach_san WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
