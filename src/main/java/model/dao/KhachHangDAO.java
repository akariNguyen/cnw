package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.KhachHang;

public class KhachHangDAO {

    public List<KhachHang> getAll() {
        List<KhachHang> list = new ArrayList<>();

        String sql = "SELECT * FROM khach_hang";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                KhachHang kh = new KhachHang(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("sdt"),
                        rs.getString("email"),
                        rs.getString("mat_khau")
                );
                list.add(kh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public KhachHang getById(int id) {
        String sql = "SELECT * FROM khach_hang WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new KhachHang(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("sdt"),
                        rs.getString("email"),
                        rs.getString("mat_khau")
                );
            }

            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public KhachHang login(String taiKhoan, String matKhau) {

        String sql = "SELECT * FROM khach_hang WHERE (email = ? OR sdt = ?) AND mat_khau = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, taiKhoan);
            stmt.setString(2, taiKhoan);
            stmt.setString(3, matKhau);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new KhachHang(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("sdt"),
                        rs.getString("email"),
                        rs.getString("mat_khau")
                );
            }

            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void insert(KhachHang kh) {

        String sql = "INSERT INTO khach_hang (ten, sdt, email, mat_khau) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, kh.getTen());
            stmt.setString(2, kh.getSdt());
            stmt.setString(3, kh.getEmail());
            stmt.setString(4, kh.getMatKhau());
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(KhachHang kh) {

        String sql = "UPDATE khach_hang SET ten=?, sdt=?, email=?, mat_khau=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, kh.getTen());
            stmt.setString(2, kh.getSdt());
            stmt.setString(3, kh.getEmail());
            stmt.setString(4, kh.getMatKhau());
            stmt.setInt(5, kh.getId());
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        String sql = "DELETE FROM khach_hang WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
