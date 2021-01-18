<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Template</title>

    <%@ include file="../../shop/inc/header.jsp" %>
    <style>
    .loader {
        border: 16px solid #f3f3f3;
        border-radius: 50%;
        border-top: 16px solid red;
        border-bottom: 16px solid black;
        border-left: 16px solid black;
        border-right: 16px solid black;
        width: 120px;
        height: 120px;
        -webkit-animation: spin 2s linear infinite; /* Safari */
        animation: spin 2s linear infinite;
        position: absolute;
        left: 50%;
        top: 50%;
        margin-left:-60px;
        margin-top:-60px;
      }
      
      /* Safari */
      @-webkit-keyframes spin {
        0% { -webkit-transform: rotate(0deg); }
        100% { -webkit-transform: rotate(360deg); }
      }
      
      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
      }
      
      #overlay {
        position: fixed; /* Sit on top of the page content */
        display: none; /* Hidden by default */
        width: 100%; /* Full width (cover the whole page) */
        height: 100%; /* Full height (cover the whole page) */
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0,0,0,0.5); /* Black background with opacity */
        z-index: 2; /* Specify a stack order in case you're using a different order for other elements */
        cursor: pointer; /* Add a pointer on hover */
      }
    </style>
    <script>
      var empIdFlag;
      var idFlag;
      var passFlag;
      var conPassFlag;
      
   $(function(){
      $("#emp_id").blur(function() {
    	  empIdFlag = nullCheck();
      });
      
      $("#user_id").blur(function() {
         idCheck();
      });
      
      $("#pass").blur(function() {
         passFlag = passCheck();
      });
      
      $("#con_pass").blur(function() {
         conPassFlag = conPassCheck();
      });
         
      //회원가입 처리
      $("#register_btn").click(function(){
         if(registCheck()){
            regist();
         }
      });
      
      //주소찾기 api 호출
      $("#addr_serch").click(function(){
         serchAddr();
      });
      
   });
   
   function registCheck(){
      if(empIdFlag && idFlag && passFlag && conPassFlag){
         return true;
      }else{
         alert("양식을 확인해 주세요.");
         console.log("사원 아이디 "+empIdFlag);
         console.log("아이디 "+idFlag);
         console.log("비번 "+passFlag);
         console.log("비번체크 "+conPassFlag);
         return false;
      }
   }
   
   //ID 중복 체크   
   function idCheck(){
      // id = "id_reg" / name = "userId"
      var user_id = $("#user_id").val();
      console.log(user_id);
      $.ajax({
         url : "/admin/idCheck?user_id="+user_id,
         type : "get",
         success : function(responseData) {
            console.log("1 = 중복o / 0 = 중복x : "+ responseData);                     
            
            if (responseData >= 1) {
                  // 1 : 아이디가 중복되는 문구
                  $("#id_check").text("사용중인 아이디입니다 :p");
                  console.log(idFlag+"로 바뀜");
                  $("#id_check").css("color", "red");
                  idFlag = false;
                  
            } else {
               if(user_id == ""){
                  $('#id_check').text('아이디를 입력해주세요 :)');
                  console.log(idFlag+"로 바뀜");
                  $('#id_check').css('color', 'red');
                  idFlag = false;
                  
               } else if(user_id != null){
                  if(user_id.length < 4 || user_id.length > 12){
                     $('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :)");
                     console.log(idFlag+"로 바뀜");
                     $('#id_check').css('color', 'red');
                     idFlag = false;
                     
                  } else{
                     $('#id_check').text("사용 가능한 아이디 입니다! ;)");
                     console.log(idFlag+"로 바뀜");
                     $('#id_check').css('color', 'green');
                     idFlag = true;
                     
                  }
               }
               
            }
         }, 
         error : function() {
               console.log("실패");
         }
      });
   }
   
   //비밀번호 유효성 체크
   function passCheck(){
      var pass = $("#pass").val();
      var id = $("#id").val();
      var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
      var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
      
      if(false === reg.test(pass)) {
         $('#pass_check').text('비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다 :)');
         $('#pass_check').css('color', 'red');
         
          return false;
          
      }else if(/(\w)\1\1\1/.test(pass)){
         $('#pass_check').text('같은 문자를 4번 이상 사용하실 수 없습니다 :)');
         $('#pass_check').css('color', 'red');
         
          return false;
          
       }else if(pass.search(/\s/) != -1){
         $('#pass_check').text('비밀번호는 공백 없이 입력해주세요 :)');
         $('#pass_check').css('color', 'red');
         
          return false;
          
       }else if(hangulcheck.test(pass)){
         $('#pass_check').text('비밀번호에 한글을 사용 할 수 없습니다 :)');
         $('#pass_check').css('color', 'red');
         
          return false;
          
       }else {
         $('#pass_check').text("사용 가능한 비밀번호 입니다! ;)");
         $('#pass_check').css('color', 'green');
         
          return true;
       }
   }
   
   //비밀번호 동일성 체크
   function conPassCheck(){
      var pass = $("#pass").val();
      var con_pass = $("#con_pass").val();
      console.log(passFlag);
      if(passFlag){
         if(con_pass == ""){
            $('#con_pass_check').text('비밀번호 확인을 진행해주세요 :)');
            $('#con_pass_check').css('color', 'red');
            
            return false;         
            
         } else if(con_pass != null){
            if(pass != con_pass){
               $('#con_pass_check').text("비밀번호가 일치하지 않습니다 :)");
               $('#con_pass_check').css('color', 'red');
               
               return false;
               
            } else{
               $('#con_pass_check').text("비밀번호가 일치합니다! ;)");
               $('#con_pass_check').css('color', 'green');
               
               return true;
            }
         }
      }
   }
   
   //양식 null 체크
   function nullCheck(){
	  var emp_id = $("#emp_id").val();
      if(emp_id == ""){
         $('#null_check').text("사원 ID를 입력해 주세요 :)");
         $('#null_check').css('color', 'red');
         
         return false;
         
      }else{
         $('#null_check').text("사원 ID가 입력되었습니다! ;)");
         $('#null_check').css('color', 'green');
         
         return true;
      }
   }
   
   //요청이 완료되는 시점에 프로그래스바를 감춘다!!
   function regist(){
      //로딩바 시작
      $("#loader").addClass("loader"); //class 동적 적용
      document.getElementById("overlay").style.display = "block";
      
      //data의 키 값으로 form태그의 파라미터들을 전송할 수 있는 상태로 둬야 data 키 값에 form 자체를 넣을 수 있다.
      var formData = $("#member_form").serialize(); //전부 문자열화 시킨다!!
      
      $.ajax({
         url:"/shop/admin/regist",
         type:"post",
         data:formData,
         success:function(responseData){
            //서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
            $("#loader").removeClass("loader"); //class 동적 제거
            document.getElementById("overlay").style.display = "none";
            var json = JSON.parse(responseData);
            if(json.result == 1){
               alert(json.msg);
               location.href="/"; //추후 로그인 페이지로 보낼예정
            }else{
               alert(json.msg);
            }
         }
      });
   }
</script>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
   <%@include file="../../shop/inc/top.jsp" %>
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>Register</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->

    <!-- Register Section Begin -->
    <div class="register-login-section spad">
         <div id="overlay">
            <div id="loader"></div>
         </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                        <h2>Register</h2>
                        <form id="member_form">
                            <input type="hidden" name="member_type_id" value="1">
                            <div class="group-input">
                                <label for="user_id">Emp ID *</label>
                                <input type="text" id="emp_id" name="emp_id" placeholder="사원 ID를 입력해주세요">
	                            <div id="null_check"></div>
                            </div>
                            <div class="group-input">
                                <label for="user_id">User ID *</label>
                                <input type="text" id="user_id" name="user_id" placeholder="아이디는 소문자와 숫자 4~12자리만 가능합니다">
                                <div id="id_check"></div>
                            </div>
                            <div class="group-input">
                                <label for="pass">Password *</label>
                                <input type="password" id="pass" name="password" placeholder="비밀번호는 대소문자/숫자/기호를 포함 8자리 이상 가능합니다">
                                <div id="pass_check"></div>
                            </div>
                            <div class="group-input">
                                <label for="con_pass">Confirm Password *</label>
                                <input type="password" id="con_pass" placeholder="위와 동일한 비밀번호를 입력해주세요">
                                <div id="con_pass_check"></div>
                            </div>
                            <input type="button" id="register_btn" class="site-btn register-btn" value="REGISTER">
                        </form>
                        <div class="switch-login">
                            <a href="/petshop/login" class="or-login">Or Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
    
    <!-- Footer Section Begin -->
   <%@ include file="../../shop/inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
   <%@ include file="../../shop/inc/footerscript.jsp" %>
</body>

</html>