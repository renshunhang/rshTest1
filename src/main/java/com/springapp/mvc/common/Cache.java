package com.springapp.mvc.common;

/**
 * Created by renshunhang on 2017/3/24.
 * com.springapp.mvc.common
 */
public interface Cache<K,V> {
    //返回當前大小
    int size();
    //向緩存添加數據，生存時間為默認
    void put(K key,V value);
    //向緩存添加數據，生存時間自定
    void put(K key,V value, long expire);
    //獲取緩存值
    V get(K key);
    //清除緩存
    void clear(K key);
}
