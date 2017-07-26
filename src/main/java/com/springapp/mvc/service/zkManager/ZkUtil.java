package com.springapp.mvc.service.zkManager;

import org.I0Itec.zkclient.ZkClient;
import org.apache.zookeeper.ZooKeeper;

/**
 * author：renshunhang
 * date：2017/7/6.
 */
public class ZkUtil {
    public static final String CONFIG_PATH = "/config/ftp";
    public static ZkClient getZkClient() {
        return new ZkClient("172.25.33.98:2181",5000);
    }
}
