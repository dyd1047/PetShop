<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <%@ include file="../inc/header.jsp" %>
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
      var idFlag;
      var passFlag;
      var conPassFlag;
      var emailIdFlag;
      var emailServerFlag;
      var nameFlag;
      var phoneFlag;
      var zipCodeFlag;
      var addrFlag;
      
   $(function(){
      $("#user_id").blur(function() {
         idCheck();
      });
      
      $("#pass").blur(function() {
         passFlag = passCheck();
      });
      
      $("#con_pass").blur(function() {
         conPassFlag = conPassCheck();
      });
      
      $("#email_id").blur(function() {
         emailIdFlag = nullCheck($("#email_id").val(), "이메일");
      });
      
      $("#email_server").blur(function() {
         emailServerFlag = nullCheck($("#email_server").val(), "이메일");
      });
      
      $("#name").blur(function() {
         nameFlag = nullCheck($("#name").val(), "이름");
      });
      
      $("#phone").blur(function() {
         phoneFlag = nullCheck($("#phone").val(), "연락처");
      });
      
      $("#sample6_postcode").blur(function() {
         zipCodeFlag = nullCheck($("#sample6_postcode").val(), "우편번호");
      });
      
      $("#sample6_address").blur(function() {
         addrFlag = nullCheck($("#sample6_address").val(), "주소");
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
      if(idFlag && passFlag && conPassFlag && emailIdFlag && emailServerFlag && nameFlag && phoneFlag && zipCodeFlag && addrFlag){
         return true;
      }else{
         alert("양식을 확인해 주세요.");
         console.log("아이디 "+idFlag);
         console.log("비번 "+passFlag);
         console.log("비번체크 "+conPassFlag);
         console.log("이메일ID "+emailIdFlag);
         console.log("이메일 서버 "+emailServerFlag);
         console.log("이름 "+nameFlag);
         console.log("연락처 "+phoneFlag);
         console.log("우편번호 "+zipCodeFlag);
         console.log("주소 "+addrFlag);
         return false;
      }
   }
   
   //ID 중복 체크   
   function idCheck(){
      // id = "id_reg" / name = "userId"
      var user_id = $("#user_id").val();
      console.log(user_id);
      $.ajax({
         url : "/user/idCheck?user_id="+user_id,
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
   function nullCheck(val, msg){
      console.log(val);
      console.log(msg);
      if(val == ""){
         $('#null_check').text(msg+"을(를) 확인해 주세요 :)");
         $('#null_check').css('color', 'red');
         
         return false;
         
      }else{
         $('#null_check').text("");
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
         url:"/shop/member/regist",
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                zipCodeFlag = true;
                addrFlag = true;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
   <%@include file="../inc/top.jsp" %>
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
                            <input type="hidden" name="member_type_id" value="2">
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
                            <div class="group-input">
                                <label for="email_id">Email *</label>
                                <input type="text" id="email_id" name="email_id" style="width:47%;" placeholder="이메일 아이디 입력"> @
                               <select id="email_server" name="email_server" style="width:47%; height: 50px; border:1px solid; border-color:lightgray;">
                           <option value="">선택하세요</option>
                           <option value="gmail.com">gmail.com</option>
                           <option value="daum.net">daum.net</option>
                           <option value="naver.com">naver.com</option>
                        </select>
                            </div>
                            <div class="group-input">
                                <label for="name">Name *</label>
                                <input type="text" id="name" name="name" placeholder="성함">
                            </div>
                            <div class="group-input">
                                <label for="phone">Phone *</label>
                                <input type="text" id="phone" name="phone" placeholder="연락처">
                            </div>
                            <div class="group-input">
                                <label for="sample6_postcode">Address *</label>
                        <input type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호" style="width:49%;">
                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="site-btn" style="width:49%"><br>
                        <input type="text" id="sample6_address" name="addr" placeholder="주소"><br>
                        <input type="text" id="sample6_detailAddress" name="addr_detail" placeholder="상세주소">
                        <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                            </div>
                            <div id="null_check"></div>
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
    
    <!-- Partner Logo Section Begin -->
    <div class="partner-logo">
        <div class="container">
            <div class="logo-carousel owl-carousel">
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="/resources/img/logo-carousel/logo-1.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="/resources/img/logo-carousel/logo-2.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="/resources/img/logo-carousel/logo-3.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="/resources/img/logo-carousel/logo-4.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="/resources/img/logo-carousel/logo-5.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Partner Logo Section End -->

    <!-- Footer Section Begin -->
   <%@ include file="../inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
   <%@ include file="../inc/footerscript.jsp" %>
</body>

</html>