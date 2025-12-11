import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamprogect/model/user.dart';
import 'package:teamprogect/vm/logindatabasehandler.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController idcontroller;
  late Logindatabasehandler handler;
  late TextEditingController namecontroller;
  late TextEditingController pwccontroller;
  late TextEditingController pwcheckcontroller;
  late TextEditingController phonecontroller;

final ImagePicker picker =ImagePicker();
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    idcontroller =TextEditingController();
    handler=Logindatabasehandler();
    namecontroller=TextEditingController();
    pwccontroller=TextEditingController();
    pwcheckcontroller=TextEditingController();
    phonecontroller=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.grey,
                  child: Center(
                    child: imageFile ==null
                    ?Icon(Icons.face)
                    :Image.file(File(imageFile!.path)),
                    
                  ),
                
                ),
              ),
              Padding(
               padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ElevatedButton(
                  onPressed: () =>  getImageFromGallery(ImageSource.gallery),
                  child: Text("이미지 가져오기"),
                  style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(220, 40),
            ),
                  
                  ),
              ),
          
                Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:namecontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "이름"
                      ),
                    ),
                  ),
                ),
                Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      
                      controller:idcontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "id"
                      ),
                    ),
                  ),
                ),
                Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      
                      controller:pwccontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "비밀번호"
                      ),
                    ),
                  ),
                ),
                Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:pwcheckcontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "비밀번호확인"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:phonecontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "전화번호"
                      ),
                    ),
                  ),
                ),
          
                ElevatedButton(
                  onPressed: () {
                    if(namecontroller.text.trim().isEmpty||
                      idcontroller.text.trim().isEmpty||
                      pwccontroller.text.trim().isEmpty||
                      pwcheckcontroller.text.trim().isEmpty||
                      phonecontroller.text.trim().isEmpty ){
                      Get.snackbar("회원가입실패", "빈칸을 전부 채워주세요",
                       backgroundColor: Colors.red,);
                                      
                    }else if(
                      pwccontroller.text.trim() != pwcheckcontroller.text.trim()
                      
                    ){
                     Get.snackbar("회원가입실패", "비밀번호가 일치하지않습니다 다시 입력해주세요",
                                backgroundColor: Colors.red,);

                    }else if(imageFile ==null){
                      Get.snackbar("회원가입실패", "프로필 사진을 넣어주세요",
                       backgroundColor: Colors.red,);
                    }else{
                      insertAction();
                    }
                  },
                  child: Text("회원가입"),
                  style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(120, 40),
            ),
                  
                  ),
          
          
            ],
          ),
        ),
      ),
    );
  }//build

  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
    ); //파일경로
    if (pickedFile == null) {
      return; //취소하면 빠져나감
    } else {
      imageFile = XFile(pickedFile.path); //IOS에도 돌아가고 안드로이드에서도 돌아감
      setState(() {});
    }
  }

Future insertAction() async {
    //File Type Byte Type으로 변환하기
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    var userInsert = User(
      u_id: idcontroller.text,
      u_name: phonecontroller.text,
      u_password: pwccontroller.text,
      u_phone: phonecontroller.text,
      u_image: getImage,
    );

    int check = await handler.insertUser(userInsert);
    if (check == 0) {
      //Error
    } else {
      _showDialog();
    }
  }

 _showDialog() {
    Get.defaultDialog(
      title: '입력결과',
      middleText: '회원가입이 완료되었습니다',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text("OK"),
        ),
      ],
    );
  }

}//class