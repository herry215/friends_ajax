package com.javaex.vo;

public class FriendVo {

    private int id;
    private String name;
    private String phone;
    private String email;
    private String memo;

    public FriendVo() {
    }

    public FriendVo(String name, String phone, String email, String memo) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.memo = memo;
    }

    public FriendVo(int id, String name, String phone, String email, String memo) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.memo = memo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\":" + id + "," +
                "\"name\":\"" + name + "\"," +
                "\"phone\":\"" + phone + "\"," +
                "\"email\":\"" + email + "\"," +
                "\"memo\":\"" + memo + "\"" +
                "}";
    }
}
