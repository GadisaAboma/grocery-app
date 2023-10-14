class Auth {
  String? phone;
  String? password;
  String? country;

  Auth({
    required this.phone,
    required this.password,
    required this.country,
  });

  Map mapData(Auth data) {
    return {
      "phone": data.phone,
      "password": data.password,
      "country": data.country
    };
  }
}
