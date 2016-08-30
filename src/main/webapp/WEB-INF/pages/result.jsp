<%--
  Created by IntelliJ IDEA.
  User: renshunhang
  Date: 2016/7/28
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试结果</title>
  <body>
<div id="sssss">
  <input id="id" name="id" value="${id}">
  <button onclick="queryInfo();">查询</button>
    <span id = "msg"></span>
</div>
<div id="res" >
  <input id="ress" value="${custNo}">
</div>
</body>
</head>
<body>

</body>
</html>

<script type="text/JavaScript" src="../resources/jquery/jquery-1.3.2.js"></script>
<script type="text/javascript" language="JavaScript">
  function queryInfo(id){
      id=$("#id").val();
      $.ajax({
         type:"POST",
          url:"/view/queryResult",
          data:{"id":id},
          dataType:"json",
          success:function(result){
              document.getElementById("ress").value="即将隐藏...";
              alert(result.message);
              document.getElementById("ress").style.display="none";
          },
          error:function(){
              alert("error");
          }
      });
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
