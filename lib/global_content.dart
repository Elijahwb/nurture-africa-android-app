class User {
  String name;
  String phone;
  String password;
  String email;

  User({
    this.name,
    this.phone,
    this.password,
    this.email,
  });
}

User globalUser = User();

String apiMainUrl = "https://damgroup.000webhostapp.com";

validateText<bool>(String text) {
  if (text != null && text != " " && text != "") {
    return true;
  } else {
    return false;
  }
}
