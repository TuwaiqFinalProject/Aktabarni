class UserApp {
  String? userid;
  String? email;
  String? name;
  String? image;
  Map? calender;

  UserApp({this.userid, this.name, this.email, this.image});

  UserApp.fromJson(Map<String, dynamic> json) {
    userid = json['user_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    calender = json['calender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userid;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['calender'] = calender;
    return data;
  }
}
