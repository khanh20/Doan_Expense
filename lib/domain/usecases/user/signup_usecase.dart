import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_application_1/domain/repositories/user/user_signup.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../core/domain/usecase/use_case.dart';

part 'signup_usecase.g.dart';

@JsonSerializable()
class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime dateOfBirth;

  RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}

class RegisterUseCase implements UseCase<User?, RegisterParams> {
  final UserSignupRepository _userSignupRepository;

  RegisterUseCase(this._userSignupRepository);

  @override
  Future<User?> call({required RegisterParams params}) async {
  
    // Gọi repository để thực hiện đăng ký
    return _userSignupRepository.register(params);
  }
}
