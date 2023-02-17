import '../../application/core/result.dart';
import '../../data/local_data_source/preference/i_pref_helper.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';
import '../../domain/entities/signup_entity/sign_up_entity.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../base/base_state.dart';
import '../base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  late IRegisterRepo _registrationRepo;

  late IPrefHelper _prefHelper;
  BaseLoadingState _state = BaseLoadingState.none;

  late final SignUpEntity signUpEntity;

  updateState() {
    setState();
  }

  RegisterViewModel() {
    signUpEntity = SignUpEntity();
    _registrationRepo = inject<IRegisterRepo>();
    _prefHelper = inject<IPrefHelper>();
  }

  BaseLoadingState get state => _state;

  Future<void> register(Result<User> result) async {
    _state = BaseLoadingState.loading;
    updateState();
    final registerUseCase = RegisterUserUseCase(_registrationRepo);
    final response = await registerUseCase(signUpEntity);
    _state = BaseLoadingState.succeed;
    updateState();
    response.fold((error) {
      result.onError(error);
      return;
    }, (response) async {
      _prefHelper.saveToken(response.token);
      _prefHelper.saveUser(response);
      result.onSuccess(response);
      return;
    });
  }
}
