class User{
  final int userId;
  final String? firstName;
  final String email;
  final String? lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? password;
  User ({
    required this.userId,
    this.firstName,
    required this.email,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.password,
  });
}
