package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.bean.DonDatPhong;

public class DonDatPhongDAO {

    // ===========================
    // LẤY TẤT CẢ ĐƠN ĐẶT PHÒNG
    // ===========================
    public List<DonDatPhong> getAll() {
        List<DonDatPhong> list = new ArrayList<>();

        String sql = "SELECT ddp.*, p.ten_phong, kh.ten AS ten_khach_hang " +
                     "FROM don_dat_phong ddp " +
                     "JOIN phong p ON ddp.phong_id = p.id " +
                     "JOIN khach_hang kh ON ddp.khach_hang_id = kh.id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                DonDatPhong d = new DonDatPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        rs.getInt("khach_hang_id"),
                        rs.getDate("ngay_nhan"),
                        rs.getDate("ngay_tra"),
                        rs.getTimestamp("thoi_gian_dat"),
                        rs.getString("ma_don")
                );
                d.setTenPhong(rs.getString("ten_phong"));
                d.setTenKhachHang(rs.getString("ten_khach_hang"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===========================
    // LẤY ĐƠN ĐẶT PHÒNG THEO ID
    // ===========================
    public DonDatPhong getById(int id) {

        String sql = "SELECT * FROM don_dat_phong WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                DonDatPhong d = new DonDatPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        rs.getInt("khach_hang_id"),
                        rs.getDate("ngay_nhan"),
                        rs.getDate("ngay_tra"),
                        rs.getTimestamp("thoi_gian_dat"),
                        rs.getString("ma_don")
                );
                rs.close();
                return d;
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ===========================
    // THÊM ĐƠN ĐẶT PHÒNG
    // ===========================
    public void insert(DonDatPhong d) {

        String sql = "INSERT INTO don_dat_phong (phong_id, khach_hang_id, ngay_nhan, ngay_tra, thoi_gian_dat, ma_don) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, d.getPhongId());
            stmt.setInt(2, d.getKhachHangId());
            stmt.setDate(3, d.getNgayNhan());
            stmt.setDate(4, d.getNgayTra());
            stmt.setTimestamp(5, d.getThoiGianDat());
            stmt.setString(6, d.getMaDon());

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ===========================
    // LẤY ĐƠN ĐẶT PHÒNG THEO KHÁCH HÀNG
    // ===========================
 // ... (giữ nguyên phần cũ)

    public List<DonDatPhong> getByKhachHangId(int khachHangId) {
        List<DonDatPhong> list = new ArrayList<>();
        String sql = """
            SELECT ddp.*, p.ten_phong 
            FROM don_dat_phong ddp 
            JOIN phong p ON ddp.phong_id = p.id 
            WHERE ddp.khach_hang_id = ? 
            ORDER BY ddp.thoi_gian_dat DESC
            """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, khachHangId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DonDatPhong d = new DonDatPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        khachHangId,
                        rs.getDate("ngay_nhan"),
                        rs.getDate("ngay_tra"),
                        rs.getTimestamp("thoi_gian_dat"),
                        rs.getString("ma_don")
                    );
                    d.setTenPhong(rs.getString("ten_phong"));
                    list.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===========================
    // XÓA ĐƠN ĐẶT PHÒNG
    // ===========================
    public void delete(int id) {
        String sql = "DELETE FROM don_dat_phong WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===========================
    // LẤY ĐƠN ĐẶT PHÒNG THEO KHÁCH SẠN (OWNER)
    // ===========================
    public List<DonDatPhong> getByKhachSanId(int khachSanId) {
        List<DonDatPhong> list = new ArrayList<>();

        String sql = "SELECT ddp.*, p.ten_phong, kh.ten AS ten_khach_hang " +
                     "FROM don_dat_phong ddp " +
                     "JOIN phong p ON ddp.phong_id = p.id " +
                     "JOIN khach_hang kh ON ddp.khach_hang_id = kh.id " +
                     "WHERE p.khach_san_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, khachSanId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                DonDatPhong d = new DonDatPhong(
                        rs.getInt("id"),
                        rs.getInt("phong_id"),
                        rs.getInt("khach_hang_id"),
                        rs.getDate("ngay_nhan"),
                        rs.getDate("ngay_tra"),
                        rs.getTimestamp("thoi_gian_dat"),
                        rs.getString("ma_don")
                );

                d.setTenPhong(rs.getString("ten_phong"));
                d.setTenKhachHang(rs.getString("ten_khach_hang"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean isPhongDaDat(int phongId, Date ngayNhan, Date ngayTra) {
        String sql = """
            SELECT COUNT(*) 
            FROM don_dat_phong 
            WHERE phong_id = ? 
              AND ngay_nhan < ? 
              AND ngay_tra > ?
            """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, phongId);
            stmt.setDate(2, ngayTra);   // Đơn cũ kết thúc sau ngày nhận mới
            stmt.setDate(3, ngayNhan);  // Đơn cũ bắt đầu trước ngày trả mới
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===========================
    // HÀM HỖ TRỢ: Map ResultSet → DonDatPhong
    // ===========================
    private DonDatPhong mapRow(ResultSet rs) throws SQLException {
        return new DonDatPhong(
            rs.getInt("id"),
            rs.getInt("phong_id"),
            rs.getInt("khach_hang_id"),
            rs.getDate("ngay_nhan"),
            rs.getDate("ngay_tra"),
            rs.getTimestamp("thoi_gian_dat"),
            rs.getString("ma_don")
        );
    }
    
}
