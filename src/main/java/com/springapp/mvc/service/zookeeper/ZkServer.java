package com.springapp.mvc.service.zookeeper;

import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;

/**
 * author：renshunhang
 * date：2017/6/8.
 */
public class ZkServer implements Watcher{
    //缓存时间
    private static final int SESSION_TIME   = 2000;
    protected ZooKeeper zooKeeper;
    protected CountDownLatch countDownLatch=new CountDownLatch(1);


    public void connect(String hosts) throws IOException, InterruptedException{
        zooKeeper = new ZooKeeper(hosts,SESSION_TIME,this);
        countDownLatch.await();
    }

    @Override
    public void process(WatchedEvent watchedEvent) {
        // TODO Auto-generated method stub
        if(watchedEvent.getState()== Event.KeeperState.SyncConnected){
            countDownLatch.countDown();
        }
    }


    public void close() throws InterruptedException{
        zooKeeper.close();
    }


}
