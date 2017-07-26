package com.springapp.mvc.service.zkManager;

import org.I0Itec.zkclient.ZkClient;
import sun.dc.pr.PRError;

/**
 * author：renshunhang
 * date：2017/7/6.
 */
public class ZkConfigManager {
    private FtpConfig ftpConfig;

    public void loadFromDB(){
        //// TODO: 2017/7/6 从数据库查询配置信息
//        ftpConfig = new FtpConfig(21, "192.168.1.1", "test", "123456");
    }

    public void updateConfigToDB(int port, String host, String user, String password){
        //// TODO: 2017/7/6 更新数据库
    }

    public void synConfigToZk(){
        ZkClient zkClient = ZkUtil.getZkClient();
        if (!zkClient.exists(ZkUtil.CONFIG_PATH)){
            zkClient.createPersistent(ZkUtil.CONFIG_PATH,true);
        }
        zkClient.writeData(ZkUtil.CONFIG_PATH,new FtpConfig(21, "127.0.0.1", "test123", "444444"));
        zkClient.close();
    }

    public void synConfigToZk(FtpConfig ftpConfig){
        ZkClient zkClient = ZkUtil.getZkClient();
        if (!zkClient.exists(ZkUtil.CONFIG_PATH)){
            zkClient.createPersistent(ZkUtil.CONFIG_PATH,true);
        }
        zkClient.writeData(ZkUtil.CONFIG_PATH,ftpConfig);
        zkClient.close();
    }
}
