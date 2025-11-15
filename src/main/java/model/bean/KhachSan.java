package model.bean;

public class KhachSan {
    private int id;
    private String ten;
    private String diaChi;
    private String soDienThoai;
    private String moTa;
    private int ownerId;   // <-- thêm mới

    public KhachSan() {}

    public KhachSan(int id, String ten, String diaChi, String soDienThoai, String moTa, int ownerId) {
        this.id = id;
        this.ten = ten;
        this.diaChi = diaChi;
        this.soDienThoai = soDienThoai;
        this.moTa = moTa;
        this.ownerId = ownerId;
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

    public String getDiaChi() { 
        return diaChi; 
    }
    public void setDiaChi(String diaChi) { 
        this.diaChi = diaChi; 
    }

    public String getSoDienThoai() { 
        return soDienThoai; 
    }
    public void setSoDienThoai(String soDienThoai) { 
        this.soDienThoai = soDienThoai; 
    }

    public String getMoTa() { 
        return moTa; 
    }
    public void setMoTa(String moTa) { 
        this.moTa = moTa; 
    }

    public int getOwnerId() { 
        return ownerId; 
    }
    public void setOwnerId(int ownerId) { 
        this.ownerId = ownerId; 
    }
}
