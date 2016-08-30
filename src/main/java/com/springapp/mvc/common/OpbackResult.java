package com.springapp.mvc.common;

import java.io.Serializable;

/**
 * Created by renshunhang on 2016/8/25.
 */
public class OpbackResult implements Serializable{
    public static final Boolean SUCCESS = true;
    public static final Boolean FAIL = false;


    private boolean status;

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
