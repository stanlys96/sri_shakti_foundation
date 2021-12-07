class RegisterResponseModel {
  int? userId;
  String? name;
  int? age;
  String? email;
  String? password;
  String? message;

  RegisterResponseModel(
      {this.userId,
      this.name,
      this.age,
      this.email,
      this.password,
      this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    age = json['age'];
    email = json['email'];
    password = json['password'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    data['password'] = this.password;
    data['message'] = this.message;
    return data;
  }
}
