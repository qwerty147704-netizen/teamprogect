class Pickup {
  int? pic_seq;
  String? pic_date;
  int? b_seq;

  Pickup(
    {
      this.pic_seq,
      this.pic_date,
      this.b_seq
    }
  );

  Pickup.fromMap(Map<String, dynamic> res)
  : pic_seq = res['pic_seq'],
    pic_date = res['pic_date'],
    b_seq = res['b_seq'];
}