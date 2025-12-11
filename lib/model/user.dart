import 'dart:typed_data';

class User {
  int? u_seq;
  String u_id;
  String? u_name;
  String u_password;
  String? u_phone;
  Uint8List? u_image;

  User(
    {
    this.u_seq,
    required this.u_id,
    this.u_name,
    required this.u_password,
    this.u_phone,
    this.u_image
  
  
  
    } 


  
  );
User.fromMap(Map<String,dynamic>res)
  :u_seq =res['seq'],
  u_id=res['id'],
  u_name=res['name'],
  u_password =res['password'],
  u_phone =res['phone'],
  u_image =res['image'];




}
