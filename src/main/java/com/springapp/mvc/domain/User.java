package com.springapp.mvc.domain;

import java.io.Serializable;

/**
 * Created by renshunhang on 2016/12/29.
 */
public class User implements Serializable{
    private static final long serialVersionUID = -6579533328390250520L;

    String name;
    int age;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
}
