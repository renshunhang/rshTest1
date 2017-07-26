package com.springapp.mvc.common;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by renshunhang on 2017/3/24.
 * com.springapp.mvc.common
 */
public abstract class AbstractCache<K,V> implements Cache<K,V>{
    class CacheObject<K2,V2>{
        final K2 key;
        final V2 value;
        final long tt;
        final long lastAccess;
        public CacheObject(K2 key, V2 value, long tt) {
            this.key=key;
            this.value = value;
            this.tt = tt;
            lastAccess = System.currentTimeMillis();
        }
        V2 getObject(){
            return value;
        }

        boolean isExpire(){
            if (tt == 0){
                return false;
            }
            return lastAccess+tt<System.currentTimeMillis();
        }

    }
    //concurrentHashMap是線程安全
    protected ConcurrentHashMap<K,CacheObject<K,V>> cacheObjectMap = new ConcurrentHashMap<K, CacheObject<K, V>>();
    protected long defaultExpire;
    protected boolean existExpire;//是否設置默認過期時間
//    private final ReentrantReadWriteLock cacheLock = new ReentrantReadWriteLock();
//    private final Lock readLock=cacheLock.readLock();
//    private final Lock writeLock=cacheLock.writeLock();

    @Override
    public int size() {
        return 0;
    }

    @Override
    public void put(K key, V value) {
        put(key,value,defaultExpire);
    }

    @Override
    public void put(K key, V value, long expire) {
//        writeLock.lock();
        try {
            if (expire !=0){
                existExpire=true;
            }
            CacheObject<K,V> co=new CacheObject<K, V>(key,value,expire);
            cacheObjectMap.put(key,co);

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public V get(K key) {
        CacheObject<K,V> co=cacheObjectMap.get(key);
        if (null==co){
            return null;
        }
        if (co.isExpire()==true){
            cacheObjectMap.remove(key);
            return null;
        }
        return co.getObject();
    }

    @Override
    public void clear(K key) {
        cacheObjectMap.remove(key);
    }
}
