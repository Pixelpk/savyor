import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/domain/entities/track_product_entity/track_product_entity.dart';
import 'package:savyor/domain/interfaces/i_app_repo_.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';

import '../../application/core/result.dart';
import '../../data/local_data_source/preference/i_pref_helper.dart';
import '../../data/models/UserProfileImage.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';
import '../../domain/entities/password_entity/password_entity.dart';
import '../../domain/entities/signup_entity/sign_up_entity.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/get_stores_usecase.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../../domain/use_cases/track_product_usecase.dart';
import '../../domain/use_cases/update_profile_image_usecase.dart';
import '../../domain/use_cases/user_profile_usecase.dart';
import '../../services/navService/i_navigation_service.dart';
import '../base/base_state.dart';
import '../base/base_view_model.dart';

class AccountViewModel extends BaseViewModel {
  User? _user;
  late final IUserRepo _iUserRepo;

  User? get user => _user;
  late final IPrefHelper _iPrefHelper;
  late final INavigationService _inav;

  BaseLoadingState _state = BaseLoadingState.none;

  loadUser() async {
    _user = _iPrefHelper.retrieveUser();
    setState();
    if (_user != null) {
      final userProfile = await getUserProfile();
      _user?.imageUrl = userProfile?.profilePic;
      precacheImage(
        NetworkImage(userProfile?.profilePic ?? ''),
        _inav.key().currentState!.context,
      );
      setState();
    }
  }

  updateState() {
    setState();
  }

  logout() {
    _iPrefHelper.clear();
  }

  AccountViewModel() {
    _inav = inject();
    _iPrefHelper = inject();
    _iUserRepo = inject();
    loadUser();
  }

  BaseLoadingState get state => _state;

  Future<GetUserProfile?> getUserProfile() async {
    final useCase = GetUserProfileUseCase(_iUserRepo);
    final res = await useCase(NoParams());
    return res.fold((error) {
      return null;
    }, (response) async {
      return response;
    });
  }

  Future<void> updateProfileImage(FormData data) async {
    final useCase = UpdateProfileImageUseCase(_iUserRepo);
    final res = await useCase(data);
    return res.fold((error) {
      return;
    }, (response) {
      return loadUser();
    });
  }

  Future<void> changePassword(PasswordEntity params, Result result) async {
    _state = BaseLoadingState.loading;
    setState();
    final useCase = ChangePasswordUseCase(_iUserRepo);
    final res = await useCase(params);
    _state = BaseLoadingState.succeed;
    setState();
    return res.fold((error) {
      return result.onError(error);
    }, (response) {
      return result.onSuccess(response);
    });
  }
}
