import 'package:flutter_application_1/core/domain/usecase/use_case.dart';
import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import '../../../core/domain/usecase/use_case.dart';

class IsLoggedInUseCase implements UseCase<bool, void> {
  final UserRepository _userRepository;

  IsLoggedInUseCase(this._userRepository);

  @override
  Future<bool> call({required void params}) async {
    return await _userRepository.isLoggedIn;
  }
}
