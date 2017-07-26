package com.springapp.mvc.service.zkManager;

import org.I0Itec.zkclient.IZkDataListener;
import org.I0Itec.zkclient.ZkClient;

import javax.annotation.PostConstruct;
import java.util.concurrent.TimeUnit;

/**
 * author：renshunhang
 * date：2017/7/6.
 */
public class ClientApp {
    FtpConfig ftpConfig;

    @PostConstruct
    private FtpConfig getFtpConfig(){
        if (ftpConfig == null){
            //首次获取时，连接zk取得配置，并配置监听
            ZkClient zkClient = ZkUtil.getZkClient();
            ftpConfig = zkClient.readData(ZkUtil.CONFIG_PATH);
            System.out.println("ftpConfig===" + ftpConfig);

            //配置监听
            zkClient.subscribeDataChanges(ZkUtil.CONFIG_PATH, new IZkDataListener() {
                @Override
                public void handleDataChange(String s, Object o) throws Exception {
                    System.out.println("ftpConfig is changed !");
                    System.out.println("node:" + s);
                    System.out.println("o:" + o.toString());
                    ftpConfig = (FtpConfig) o;//重新加载FtpConfig
                }

                @Override
                public void handleDataDeleted(String s) throws Exception {
                    System.out.println("ftpConfig is deleted !");
                    System.out.println("node:" + s);
                    ftpConfig = null;
                }
            });
        }
        return ftpConfig;
    }



    /**
     * 模拟程序运行
     *
     * @throws InterruptedException
     */
    public void run() throws InterruptedException {

        getFtpConfig();

        System.out.println(ftpConfig);
//        upload();
//
//        download();

    }

//    public void upload() throws InterruptedException {
//        System.out.println("..............");
//        System.out.println(ftpConfig);
//        TimeUnit.SECONDS.sleep(10);
//    }
//
//
//    public void download() throws InterruptedException {
//        System.out.println("-------------");
//        System.out.println(ftpConfig);
//        TimeUnit.SECONDS.sleep(10);
//    }


}
