package com.java.web_ecommerce_spring.models;

public class ChangeNumber {
    int giaCu;
    int giaMoi;
    int total;
    int tamTinh;

    public int getGiaCu() {
        return giaCu;
    }

    public void setGiaCu(int giaCu) {
        this.giaCu = giaCu;
    }

    public int getGiaMoi() {
        return giaMoi;
    }

    public void setGiaMoi(int giaMoi) {
        this.giaMoi = giaMoi;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTamTinh() {
        return tamTinh;
    }

    public void setTamTinh(int tamTinh) {
        this.tamTinh = tamTinh;
    }

    public ChangeNumber() {
    }

    public ChangeNumber(int giaCu, int giaMoi, int total, int tamTinh) {
        this.giaCu = giaCu;
        this.giaMoi = giaMoi;
        this.total = total;
        this.tamTinh = tamTinh;
    }

    @Override
    public String toString() {
        return "ChangeNumber{" +
                "giaCu=" + giaCu +
                ", giaMoi=" + giaMoi +
                ", total=" + total +
                ", tamTinh=" + tamTinh +
                '}';
    }
}
