package com.springapp.mvc.service.zookeeper;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooDefs;
import redis.clients.jedis.Jedis;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * author：renshunhang
 * date：2017/6/8.
 */
public class ZkOperator extends ZkServer {

    /**
     *<b>function:</b>创建持久态的znode,比支持多层创建.比如在创建/parent/child的情况下,无/parent.无法通过
     */
    public void create(String path,byte[] data)throws KeeperException, InterruptedException{
        /**
         * 此处采用的是CreateMode是PERSISTENT  表示The znode will not be automatically deleted upon client's disconnect.
         * EPHEMERAL 表示The znode will be deleted upon the client's disconnect.
         */
        this.zooKeeper.create(path, data, ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
    }


    /**
     *<b>function:</b>获取节点信息
     */
    public void getChild(String path) throws KeeperException, InterruptedException{
        try{
            List<String> list=this.zooKeeper.getChildren(path, false);
            if(list.isEmpty()){
                System.out.println(path+"中没有节点");
            }else{
                System.out.println(path+"中存在节点");
                for(String child:list){
                    System.out.println("节点为："+child);
                }
            }
        }catch (KeeperException.NoNodeException e) {
            // TODO: handle exception
            throw e;
        }
    }

    public byte[] getData(String path) throws KeeperException, InterruptedException {
        return  this.zooKeeper.getData(path, false,null);
    }


        public static void main(String[] args) throws InterruptedException {

            //连接本地的 Redis 服务
            Jedis jedis = new Jedis("localhost");
            System.out.println("Connection to server sucessfully");


            System.out.print(jedis.setnx("rrr","123123"));
            jedis.expire("rrr",1);

            Thread.sleep(2000);

            System.out.print(jedis.exists("rrr"));
            System.out.print(jedis.setnx("rrr","444444"));
            System.out.print(jedis.get("rrr"));
//            Thread.sleep(100l);
//            jedis.setnx("rrr","123123");

            // 获取数据并输出
//            Set<String> keys = jedis.keys("*");
//            Iterator<String> it=keys.iterator() ;
//            while(it.hasNext()){
//                String key = it.next();
//                System.out.println(key);
//            }


//            //连接本地的 Redis 服务
//            Jedis jedis = new Jedis("localhost");
//            System.out.println("Connection to server sucessfully");
//            //存储数据到列表中
//            jedis.lpush("tutorial-list", "Redis");
//            jedis.lpush("tutorial-list", "Mongodb");
//            jedis.lpush("tutorial-list", "Mysql");
//            // 获取存储的数据并输出
//            List<String> list = jedis.lrange("tutorial-list", 0 ,5);
//            for(int i=0; i<list.size(); i++) {
//                System.out.println("Stored string in redis:: "+list.get(i));
//            }

        }

//    public static void main(String[] args) {
//        try {
//            ZkOperator zkoperator = new ZkOperator();
//            zkoperator.connect("172.0.0.1:2181");
//            byte[] data = new byte[]{'a', 'b', 'c', 'd'};
//
//            String zktest = "ZooKeeper的Java API测试";
//            zkoperator.create("/root/child3", zktest.getBytes());
//            System.out.println("获取设置的信息：" + new String(zkoperator.getData("/root/child3")));
//
//            System.out.println("节点孩子信息:");
//            zkoperator.getChild("/root");
//            zkoperator.close();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
