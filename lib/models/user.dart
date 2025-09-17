class User {
  String name;
  DateTime dateOfBirth;
  String email;
  String accountType;

  User({
    required this.name,
    required this.dateOfBirth,
    required this.email,
    required this.accountType,
  });

  // Convert JSON -> User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      email: json['email'],
      accountType: json['accountType'],
    );
  }

  // Convert User object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'email': email,
      'accountType': accountType,
    };
  }

  // ✅ Static dummy user for frontend testing
  static final User dummyUser = User(
    name: "John Doe",
    dateOfBirth: DateTime(1995, 5, 12),
    email: "john.doe@example.com",
    accountType: "Premium",
  );
}
