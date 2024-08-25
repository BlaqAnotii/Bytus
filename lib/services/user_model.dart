class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? emailVerifiedAt;
  final String? securityPin;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? country;
  final String? state;
  final String createdAt;
  final String updatedAt;
  final String? apiToken;
  final String? idFrontPhoto;
  final String? idBackPhoto;
  final String isAdmin;
  final String totalBalance;
  final String btcBalance;
  final String ethBalance;
  final String btcUnit;
  final String ethUnit;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.emailVerifiedAt,
    this.securityPin,
    this.phoneNumber,
    this.dateOfBirth,
    this.country,
    this.state,
    required this.createdAt,
    required this.updatedAt,
    this.apiToken,
    this.idFrontPhoto,
    this.idBackPhoto,
    required this.isAdmin,
    required this.totalBalance,
    required this.btcBalance,
    required this.ethBalance,
    required this.btcUnit,
    required this.ethUnit,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      securityPin: json['security_pin'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      country: json['country'],
      state: json['state'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      apiToken: json['api_token'],
      idFrontPhoto: json['id_front_photo'],
      idBackPhoto: json['id_back_photo'],
      isAdmin: json['is_admin'],
      totalBalance: json['total_balance'],
      btcBalance: json['btc_balance'],
      ethBalance: json['eth_balance'],
      btcUnit: json['btc_unit'],
      ethUnit: json['eth_unit'],
    );
  }
}
