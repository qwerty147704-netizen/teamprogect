import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogect/model/user.dart';

class Logindatabasehandler {

/*
 int? seq;
  String id;
  String password;
  String phone;
  Uint8List image;

*/

Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table user
        (
        u_seq integer primary key autoincrement,
        u_id text,
        u_name text,
        u_password text,
        u_phone text,
        u_image blob
        
        
        )

        """
      );
    },
    version: 1,
  );
}
//로그인
Future<int> queryLogincheck(String u_id,String u_password)async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select count(u_id) as cnt
      from user
      where u_id=? and u_password=?

      """,
      [u_id,u_password],
    );
    int count = result.first['cnt'] as int;
    return count;
   }

//회원가입
Future<int> insertUser(User user) async{
  int result=0;
  final Database db =await initializeDB();
  result=await db.rawInsert(
    """
    insert into user
    (u_id,u_name,u_password,u_phone,u_image)
    values
    (?,?,?,?,?)

    """,

    [
      user.u_id,
      user.u_name,
      user.u_password,
      user.u_phone,
      user.u_image


    ]

  );
  return result;
}//build




}//class