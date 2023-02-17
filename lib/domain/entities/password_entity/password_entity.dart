class PasswordEntity {
  String? confirmPassword;
  String? password;

  PasswordEntity({this.confirmPassword, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["confirm_new_pass"] = confirmPassword;
    data["new_pass"] = password;
    return data;
  }
}
