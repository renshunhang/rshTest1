package com.springapp.mvc.domain;

import com.sun.istack.internal.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by renshunhang on 2016/7/28.
 */
public class TestDomain implements Serializable {
    private Long id;
    @NotNull()
    private String custNo;
    private String jdCustNo;
    private Integer isFrozed;
    private Integer isInit;
    private Integer isDone;
    private String remark;
    private String operator;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date createTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date updateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date signedContractTime;
    private Integer yn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCustNo() {
        return custNo;
    }

    public void setCustNo(String custNo) {
        this.custNo = custNo;
    }

    public String getJdCustNo() {
        return jdCustNo;
    }

    public void setJdCustNo(String jdCustNo) {
        this.jdCustNo = jdCustNo;
    }

    public Integer getIsFrozed() {
        return isFrozed;
    }

    public void setIsFrozed(Integer isFrozed) {
        this.isFrozed = isFrozed;
    }

    public Integer getIsInit() {
        return isInit;
    }

    public void setIsInit(Integer isInit) {
        this.isInit = isInit;
    }

    public Integer getIsDone() {
        return isDone;
    }

    public void setIsDone(Integer isDone) {
        this.isDone = isDone;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getSignedContractTime() {
        return signedContractTime;
    }

    public void setSignedContractTime(Date signedContractTime) {
        this.signedContractTime = signedContractTime;
    }

    public Integer getYn() {
        return yn;
    }

    public void setYn(Integer yn) {
        this.yn = yn;
    }

    @Override
    public String toString() {
        return "TestDomain{" +
                "id=" + id +
                ", custNo='" + custNo + '\'' +
                ", jdCustNo='" + jdCustNo + '\'' +
                ", isFrozed=" + isFrozed +
                ", isInit=" + isInit +
                ", isDone=" + isDone +
                ", remark='" + remark + '\'' +
                ", operator='" + operator + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", signedContractTime=" + signedContractTime +
                ", yn=" + yn +
                '}';
    }
}
