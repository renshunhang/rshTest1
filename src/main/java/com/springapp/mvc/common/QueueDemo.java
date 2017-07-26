package com.springapp.mvc.common;

import java.io.Serializable;
import java.util.Arrays;

/**
 * Created by renshunhang on 2017/3/22.
 * com.springapp.mvc.common
 */
public class QueueDemo<T> implements Serializable {
    private int DEFAULT_SIZE=10;
    int capacity;//保存数组长度
    Object[] elementData;//定义一个数组用于保存循环队列的元素
    int front=0;//队头
    int rear=0;//队尾

    //创建循环队列
    public QueueDemo(int num) {
        capacity = 0==num?DEFAULT_SIZE:num;
        elementData = new Object[capacity];
    }
    //指定长度,第一个元素为element,创建循环队列
    public QueueDemo(T element,int intSize){
        this.capacity=intSize;
        elementData = new Object[capacity];
        elementData[0] = element;
        rear++;
    }
    //获取长度
    public int size(){
        if (isEmpty()){
            return 0;
        }
        return rear > front ? rear-front:capacity-(front-rear);
    }

    //是否为空队列
    private boolean isEmpty() {
        return rear==front && elementData[rear]==null;
    }
    //清空循环队列
    public void clear(){
        Arrays.fill(elementData,null);
        front=0;
        rear=0;
    }
    //移除队列

    //返回队顶
    public T backFront(){
        if (isEmpty()){
            throw new IndexOutOfBoundsException("空队列异常");
        }
        return (T)elementData[front];
    }

}
