package model.bean;

public class ChuKhachSan {
    private int id;
    private String ten;
    private String sdt;
    private String email;
    private String matkhau;

    public ChuKhachSan() {}

    public ChuKhachSan(int id, String ten, String sdt, String email, String matkhau) {
        this.id = id;
        this.ten = ten;
        this.sdt = sdt;
        this.email = email;
        this.matkhau = matkhau;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMatkhau() {
        return matkhau;
    }

    public void setMatkhau(String matkhau) {
        this.matkhau = matkhau;
    }
}
