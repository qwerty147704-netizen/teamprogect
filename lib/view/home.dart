import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogect/model/user.dart';
import 'package:teamprogect/view/signup.dart';
import 'package:teamprogect/vm/logindatabasehandler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController idcontroller;
  late TextEditingController pwcontroller;
  late Logindatabasehandler  handler;

  @override
  void initState() {
    super.initState();
  idcontroller=TextEditingController();
  pwcontroller=TextEditingController();
  handler =Logindatabasehandler();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ID",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    controller: idcontroller,
                    decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                       
                        borderSide: BorderSide(
                          
                          color: Colors.black
                        )
                      ),
                      labelText: "ID",
                    ),
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Password"),
                ),
                SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    controller: pwcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      labelText: "PW",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    
                    onPressed: () {
                      logincheck();
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                     
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(220, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4)
                      )
                    ),
                    ),
                ),
                GestureDetector(
                  onTap: () => Get.to(Signup()),
                  child: Text("회원가입"))
              ],
            ),
          
          ),
          ],
        ),
      ),
    );
  }//build

  logincheck() async{
  
 int count=await handler.queryLogincheck(
  idcontroller.text,
   pwcontroller.text
   );

  if(idcontroller.text.trim().isEmpty||pwcontroller.text.isEmpty){
    Get.snackbar("로그인실패", "아이디 또는 비밀번호를 입력해주세요",
    backgroundColor: Colors.red,

    );
  }else if(count==0){
   Get.snackbar("로그인실패", "아이디 또는 비밀번호가 틀립니다",
    backgroundColor: Colors.red,

    );
  }else{
     Get.snackbar("로그인성공", "환영합니다",
    

    );
  }

      

  }
}//class