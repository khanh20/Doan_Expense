import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import '../../../core/domain/usecase/use_case.dart';


class SaveLoginStatusUseCase implements UseCase<void, bool> {
  final UserRepository _userRepository;

  SaveLoginStatusUseCase(this._userRepository);

  @override
  Future<void> call({required bool params}) async {
    return _userRepository.saveIsLoggedIn(params);
  }
}