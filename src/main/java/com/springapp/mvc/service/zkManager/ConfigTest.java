package com.springapp.mvc.service.zkManager;

import redis.clients.jedis.Client;

/**
 * author：renshunhang
 * date：2017/7/6.
 */
public class ConfigTest {
    public static void main(String[] args) throws InterruptedException {
        ZkConfigManager zkConfigManager = new ZkConfigManager();
        ClientApp clientApp = new ClientApp();
        zkConfigManager.synConfigToZk();

        //模拟客户端运行
        clientApp.run();

        //模拟配置修改
//        zkConfigManager.updateConfigToDB(23, "10.6.12.34", "newUser", "newPwd");
        FtpConfig ftpConfig = new FtpConfig();
        ftpConfig.setHost("123123123");
        ftpConfig.setUser("123412341234");
        zkConfigManager.synConfigToZk(ftpConfig);

        //模拟客户端自动感知配置变化
        clientApp.run();
    }
}
