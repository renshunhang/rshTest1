<%--
<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-on" uri="http://www.springframework.org/tags/form" %>
&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: renshunhang
  Date: 2016/7/28
  Time: 16:57
  To change this template use File | Settings | File Templates.
&ndash;%&gt;
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>测试结果</title>
  <body>
<div id="whole">
<div id="sssss">
  <input id="id" name="id" value="${id}">
  <button onclick="queryInfo(id)">查询</button>

    <button v-on:click="toAsync">异步调用</button>
    <span id = "msg"></span>
</div>


  <div id="ress"></div>


</div>
</body>
</head>
<body>

</body>
</html>
<script src="../resources/jquery/jquery.min.js"></script>
<script src="../resources/jquery/qrcode.js"></script>
<script type="text/javascript" src="../resources/js/vue.js"></script>
<script type="text/javascript">
  var qrcode = new QRCode(document.getElementById("qrcode"),{
    width : 100,
    height : 100
  });

  function makeCode () {
    var elText="http://loan.jd.com/scf/company/collect"
    qrcode.makeCode(elText.value);
  }

  makeCode();

  $("#text").
  on("blur", function () {
    makeCode();
  }).
  on("keydown", function (e) {
    if (e.keyCode == 13) {
      makeCode();
    }
  });
</script>

<script type="text/javascript" language="JavaScript">

  function queryInfo(id){
      id=$("#id").val();
      $.ajax({
         type:"POST",
          url:"/view/queryResult",
          data:{"id":id},
          dataType:"json",
          success:function(result){
              document.getElementById("ress").value=result.message;
//              document.getElementById("ress").style.display="none";
          },
          error:function(){
              alert("error");
          }
      });
  }

  function toAsync(){
     window.location.href = "/view/async";
  }
 /*var xmlHttp;
  function createXMLHttp(){
      if(window.XMLHttpRequest){
          xmlHttp=new XMLHttpRequest();
      }else{
          xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
  }
    function queryInfo1(){
        createXMLHttp();
        xmlHttp.open("POST","/view/queryResult");
        xmlHttp.onreadystatechange=showMsg;
        xmlHttp.send(1);
    }
    function showMsg(){
        if(xmlHttp.readyState == 4){
            if(xmlHttp.status == 200){
                var text = xmlHttp.responseText;
//                document.getElementById("msg").className="yanghsi";
                document.getElementById("msg").innerHTML=result.message;
            }
        }
    }*/
</script>
--%>


<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8">
  <title>layer-更懂你的web弹窗解决方案</title>
  <script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
  <script src="layer.js"></script>

  <style>
    html{background-color:#E3E3E3; font-size:14px; color:#000; font-family:'微软雅黑'}
    a,a:hover{ text-decoration:none;}
    pre{font-family:'微软雅黑'}
    .box{padding:20px; background-color:#fff; margin:50px 100px; border-radius:5px;}
    .box a{padding-right:15px;}
    #about_hide{display:none}
    .layer_text{background-color:#fff; padding:20px;}
    .layer_text p{margin-bottom: 10px; text-indent: 2em; line-height: 23px;}
    .button{display:inline-block; *display:inline; *zoom:1; line-height:30px; padding:0 20px; background-color:#56B4DC; color:#fff; font-size:14px; border-radius:3px; cursor:pointer; font-weight:normal;}
    .photos-demo img{width:200px;}
  </style>
</head>
<body>
<div class="box">
<pre>
 @Name：layer-v<script>document.write(layer.v)</script> 弹层组件说明
 @Author：贤心
 @Blog：<a href="http://sentsin.com" target="_blank">http://sentsin.com</a>
 @Site：<a href="http://layer.layui.com/?form=local"  target="_blank">http://layer.layui.com</a>
 @Github：<a href="https://github.com/sentsin/layer"  target="_blank">https://github.com/sentsin/layer</a>


<strong>【注意事项】</strong>
一、使用时，请把文件夹layer整个放置在您站点的任何一个目录，只需引入layer.js即可，除jQuery外，其它文件无需再引入。
二、如果您的js引入是通过合并处理或者您不想采用layer自动获取的绝对路径，您可以通过layer.config()来配置（详见官网API页）
三、jquery需1.8+
四、更多使用说明与演示，请参见layer官网。
五、使用时请务必保留来源，请勿用于违反我国法律的web平台。
六、layer遵循LGPL协议，将永久性提供无偿服务。版权最终解释权：贤心。
</pre>
</div>

<div class="box">
  <h2 style="padding-bottom:20px;">扩展模块：图片查看器（相册层）</h2>
  <div id="photosDemo" class="photos-demo">
    <!-- layer-src表示大图  layer-pid表示图片id  src表示缩略图-->

    <img layer-src="http://static.oschina.net/uploads/space/2014/0516/012728_nAh8_1168184.jpg" layer-pid="" src="http://static.oschina.net/uploads/space/2014/0516/012728_nAh8_1168184.jpg" alt="layer宣传图">
    <img layer-src="http://sentsin.qiniudn.com/sentsinmy5.jpg" layer-pid="" src="http://sentsin.qiniudn.com/sentsinmy5.jpg" alt="我入互联网这五年">
    <img layer-src="" layer-pid="" src="http://sentsin.qiniudn.com/sentsin_39101a660cf4671b7ec297a74cc652c74152104f.jpg" alt="微摄影">
    <img layer-src="http://sentsin.qiniudn.com/sentsinsan01.jpg" layer-pid="" src="http://sentsin.qiniudn.com/sentsinsan01.jpg" alt="三清山">
    <img layer-src="http://ww2.sinaimg.cn/mw1024/5db11ff4jw1ehcyirr6quj20q00ex42w.jpg" layer-pid="" src="http://ww2.sinaimg.cn/mw1024/5db11ff4jw1ehcyirr6quj20q00ex42w.jpg" alt="国足">
  </div>

</div>


<div class="box" style="text-align:center">
  <a href="http://layer.layui.com/?form=local" target="_blank">更多示例</a>
  <a href="http://layer.layui.com/api.html" target="_blank">使用文档</a>
  <a href="http://fly.layui.com" target="_blank" title="Fly">交流反馈</a>
  <a href="javascript:;" id="about">关于</a>
</div>

<script>
  ;!function(){

//加载扩展模块
    layer.config({
      extend: 'extend/layer.ext.js'
    });

//页面一打开就执行，放入ready是为了layer所需配件（css、扩展模块）加载完毕
    layer.ready(function(){
      //官网欢迎页
      layer.open({
        type: 2,
        //skin: 'layui-layer-lan',
        title: 'layer弹层组件',
        fix: false,
        shadeClose: true,
        maxmin: true,
        area: ['1000px', '500px'],
        content: 'http://layer.layui.com/?form=local',
        end: function(){
          layer.tips('试试相册模块？', '#photosDemo', {tips: 1})
        }
      });

      //layer.msg('欢迎使用layer');

      //使用相册
      layer.photos({
        photos: '#photosDemo'
      });
    });

//关于
    $('#about').on('click', function(){
      layer.alert(layer.v + ' - 贤心出品 sentsin.com');
    });

  }();
</script>
</body>
</html>
