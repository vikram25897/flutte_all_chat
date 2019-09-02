class Member {
  String name;
  String ip;
  int port;

  Member({this.name, this.ip, this.port});

  Map toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = this.name;
    data["ip"] = this.ip;
    data["port"] = this.port;
    return data;
  }

  factory Member.fromJson(Map map){
    return Member(
      name: map['name'] as String ?? "John Doe",
      ip: map['ip'] as String,
      port: map['port'] as int,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
