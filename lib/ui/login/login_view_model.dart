import 'package:savyor/domain/interfaces/i_login_repo_.dart';

import '../../application/core/result.dart';
import '../../data/local_data_source/preference/i_pref_helper.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';
import '../../domain/entities/login_entity/login_enityt.dart';
import '../../domain/entities/signup_entity/sign_up_entity.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../../domain/use_cases/forgot_password.dart';
import '../../domain/use_cases/login_user_usecase.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../base/base_state.dart';
import '../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  late ILoginRepo _iLoginRepo;

  late IPrefHelper _prefHelper;
  BaseLoadingState _state = BaseLoadingState.none;

  updateState() {
    setState();
  }

  LoginViewModel() {
    _iLoginRepo = inject<ILoginRepo>();
    _prefHelper = inject<IPrefHelper>();
  }

  BaseLoadingState get state => _state;

  Future<void> login(LoginEntity params, Result<User> result) async {
    _state = BaseLoadingState.loading;
    updateState();
    final loginUseCase = LoginUserUseCase(_iLoginRepo);
    final response = await loginUseCase(params);
    _state = BaseLoadingState.succeed;
    updateState();
    response.fold((error) {
      result.onError(error);
      return;
    }, (response) async {
      response.username = params.userName;
      _prefHelper.saveToken(response.token);
      _prefHelper.saveUser(response);
      result.onSuccess(response);
      return;
    });
  }

  Future<void> forgotPassword(String email, Result result) async {
    _state = BaseLoadingState.loading;
    updateState();
    final loginUseCase = ForgotPasswordUseCase(_iLoginRepo);
    final response = await loginUseCase(email);
    _state = BaseLoadingState.succeed;
    updateState();
    response.fold((error) {
      result.onError(error);
      return;
    }, (response) async {
      result.onSuccess(response);
      return;
    });
  }
}
