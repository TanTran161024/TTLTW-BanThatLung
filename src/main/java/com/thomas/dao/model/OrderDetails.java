package com.thomas.dao.model;

import java.io.Serializable;
import java.util.List;

public class OrderDetails implements Serializable {
    private int id;
    private int orderId;
    private double price;
    private int beltId;
    private int quantity;
    private String beltName;
    private List<String> beltImages;
    private List<Category> categories;

    public OrderDetails() {

    }

    public OrderDetails(int id, int orderId, double price, int beltId, int quantity) {
        this.id = id;
        this.orderId = orderId;
        this.price = price;
        this.beltId = beltId;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getBeltId() {
        return beltId;
    }

    public void setBeltId(int beltId) {
        this.beltId = beltId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getBeltName() {
        return beltName;
    }

    public void setBeltName(String beltName) {
        this.beltName = beltName;
    }

    public List<String> getBeltImages() {
        return beltImages;
    }

    public void setBeltImages(List<String> beltImages) {
        this.beltImages = beltImages;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }
}
