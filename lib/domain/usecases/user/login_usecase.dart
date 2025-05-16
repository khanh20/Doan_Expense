import 'package:flutter_application_1/domain/entities/user/User.dart';
import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../core/domain/usecase/use_case.dart';
part 'login_usecase.g.dart';

@JsonSerializable()
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}

class LoginUseCase implements UseCase<User?, LoginParams> {
  final UserRepository _userRepository;

  LoginUseCase(this._userRepository);

  @override
  Future<User?> call({required LoginParams params}) async {
    return _userRepository.login(params);
  }
}