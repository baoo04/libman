package com.libman.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ImportOrder {
    private int id;
    private Supplier supplier;
    private String createdBy;
    private double totalAmount;
    private Timestamp createdAt;
    private List<ImportOrderItem> items = new ArrayList<>();

    public ImportOrder() {
    }

    // getters & setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier s) {
        this.supplier = s;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String c) {
        this.createdBy = c;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double t) {
        this.totalAmount = t;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp t) {
        this.createdAt = t;
    }

    public List<ImportOrderItem> getItems() {
        return items;
    }

    public void setItems(List<ImportOrderItem> items) {
        this.items = items;
    }
}
