import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:savyor/application/network/client/api_service.dart';
import 'package:savyor/application/network/client/iApService.dart';
import 'package:savyor/application/network/external_values/iExternalValue.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/data/remote_data_source/app_api/app_api.dart';
import 'package:savyor/data/remote_data_source/app_api/i_app_api.dart';
import 'package:savyor/data/remote_data_source/login_api/i_login_api.dart';
import 'package:savyor/data/remote_data_source/url_api.dart';
import 'package:savyor/data/remote_data_source/user_api/i_user_api.dart';
import 'package:savyor/data/remote_data_source/user_api/user_api.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';
import 'package:savyor/services/media_service/i_media_service.dart';
import 'package:savyor/services/navService/i_navigation_service.dart';
import 'package:savyor/services/navService/nav_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../application/network/external_values/ExternalValues.dart';
import '../common/utils.dart';
import '../data/local_data_source/jwt/jwt_local_access_token.dart';
import '../data/local_data_source/preference/i_pref_helper.dart';
import '../data/local_data_source/preference/pref_helper.dart';
import '../data/remote_data_source/jwt_remote_access_token.dart';
import '../data/remote_data_source/login_api/login_api.dart';
import '../data/remote_data_source/product_api/i_product_api.dart';
import '../data/remote_data_source/product_api/product_api.dart';
import '../data/remote_data_source/register_api/i_register_api.dart';
import '../data/remote_data_source/register_api/register_api.dart';
import '../data/repo/app_repo.dart';
import '../data/repo/jwt_access_repo.dart';
import '../data/repo/login_repo.dart';
import '../data/repo/product_repo.dart';
import '../data/repo/register_repo.dart';
import '../data/repo/user_repo.dart';
import '../domain/interfaces/i_app_repo_.dart';
import '../domain/interfaces/i_login_repo_.dart';
import '../domain/interfaces/i_product_repo.dart';
import '../domain/interfaces/i_register_repo_.dart';
import '../services/media_service/media_service.dart';

final inject = GetIt.instance;

Future<void> setupLocator() async {
  inject.registerSingletonAsync(() => SharedPreferences.getInstance());
  inject.registerLazySingleton<JwtLocalAccessToken>(() => JwtLocalAccessToken());
  inject.registerLazySingleton<IPrefHelper>(() => PrefHelper(inject()));
  inject.registerLazySingleton<Utils>(() => Utils());
  inject.registerLazySingleton<IExternalValues>(() => ExternalValues());

  // inject.registerLazySingleton<JwtRemoteAccessToken>(() => JwtRemoteAccessToken(externalValues: ExternalValues()));
  // inject.registerLazySingleton<JwtAccessRepo>(() => JwtAccessRepo(jwtLocalAccessToken: inject(), jwtRemoteAccessToken: inject()));
  inject.registerLazySingleton<IApiService>(() => ApiService.create(externalValues: ExternalValues()));
  inject.registerLazySingleton<UrlApi>(() => UrlApi(iApiService: inject()));

  inject.registerLazySingleton<IRegisterApi>(() => RegisterApi(inject()));
  inject.registerLazySingleton<IMediaService>(() => MediaService());
  inject.registerLazySingleton<IRegisterRepo>(() => RegisterRepo(api: inject()));
  inject.registerLazySingleton<ILoginRepo>(() => LoginRepo(api: inject()));
  inject.registerLazySingleton<ILoginApi>(() => LoginApi(inject()));

  inject.registerLazySingleton<IAppRepo>(() => AppRepo(api: inject()));
  inject.registerLazySingleton<IAppApi>(() => AppApi(inject()));

  inject.registerLazySingleton<IProductRepo>(() => ProductRepo(api: inject()));
  inject.registerLazySingleton<IProductApi>(() => ProductApi(inject()));

  inject.registerLazySingleton<IUserRepo>(() => UserRepo(api: inject()));
  inject.registerLazySingleton<IUserApi>(() => UserApi(inject()));

  inject.registerLazySingleton<Px>(() => Px());
  inject.registerLazySingleton<INavigationService>(() => NavigationService());
}
