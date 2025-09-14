package com.libman.model;

public class ImportOrderItem {
    private int id;
    public Book book;
    private int quantity;
    private double unitPrice;
    private double lineTotal;

    public ImportOrderItem() {
    }

    // getters / setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int q) {
        this.quantity = q;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double p) {
        this.unitPrice = p;
    }

    public double getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(double l) {
        this.lineTotal = l;
    }
}
