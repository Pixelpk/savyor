import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:savyor/application/network/client/api_service.dart';
import 'package:savyor/application/network/client/iApService.dart';
import 'package:savyor/application/network/external_values/iExternalValue.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/data/remote_data_source/url_api.dart';
import 'package:savyor/services/navService/i_navigation_service.dart';
import 'package:savyor/services/navService/nav_service.dart';

import '../application/network/external_values/ExternalValues.dart';
import '../data/local_data_source/jwt/jwt_local_access_token.dart';
import '../data/remote_data_source/jwt_remote_access_token.dart';
import '../data/repo/jwt_access_repo.dart';


final inject = GetIt.instance;

Future<void> setupLocator() async {
  inject.registerLazySingleton<JwtLocalAccessToken>(() => JwtLocalAccessToken());
  inject.registerLazySingleton<JwtRemoteAccessToken>(() => JwtRemoteAccessToken(externalValues: ExternalValues()));
  inject.registerLazySingleton<JwtAccessRepo>(() => JwtAccessRepo(jwtLocalAccessToken: inject(), jwtRemoteAccessToken: inject()));
  inject.registerLazySingleton<IApiService>(() => ApiService.create(externalValues: ExternalValues(), jwtAccessRepo: inject(),));
  inject.registerLazySingleton<UrlApi>(() => UrlApi(iApiService: inject()));
  inject.registerLazySingleton<Px>(() => Px());
  inject.registerLazySingleton<INavigationService>(() => NavigationService());
}
