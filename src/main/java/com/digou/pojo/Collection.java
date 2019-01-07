package com.digou.pojo;

public class Collection {
    private Integer scid;

    private String scuname;

    private Integer pid;

    public Integer getScid() {
        return scid;
    }

    public void setScid(Integer scid) {
        this.scid = scid;
    }

    public String getScuname() {
        return scuname;
    }

    public void setScuname(String scuname) {
        this.scuname = scuname == null ? null : scuname.trim();
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }
}