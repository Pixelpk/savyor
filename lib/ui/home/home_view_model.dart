

import 'dart:math';

import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/domain/entities/track_product_entity/track_product_entity.dart';
import 'package:savyor/domain/interfaces/i_app_repo_.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../application/core/result.dart';
import '../../common/logger/log.dart';
import '../../data/local_data_source/preference/i_pref_helper.dart';
import '../../data/models/scrapping_instruction.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';
import '../../domain/entities/signup_entity/sign_up_entity.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../../domain/use_cases/get_scrapping_instruction_usecase.dart';
import '../../domain/use_cases/get_stores_usecase.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../../domain/use_cases/track_product_usecase.dart';
import '../base/base_state.dart';
import '../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  late  IAppRepo _iAppRepo;
  late  IProductRepo _iProductRepo;
  List<ScrappingInstruction> scrapInstruction = [] ;

  BaseLoadingState _state = BaseLoadingState.none;
  late List<Store> _stores;


  List<Store> get stores => _stores;

  updateState(){
    setState();
  }

  HomeViewModel() {
    _stores = [];
    _iAppRepo = inject<IAppRepo>();
    _iProductRepo = inject<IProductRepo>();
  }

  BaseLoadingState get state => _state;


  Future<void> getSupportedStores() async {
    final storeUseCase = GetStoreUseCase(_iAppRepo);
    final res = await storeUseCase(NoParams());
    res.fold((error) {
      return;
    }, (response)async {
      _stores = response.stores ?? [] ;
      updateState();
      return;
    });
  }
  Future<void> getInstruction(String url) async {
    scrapInstruction.clear();
    final useCase = GetScrapInstructionUseCase(_iAppRepo);
    final res = await useCase(url);
    res.fold((error) {
      return;
    }, (response)async {
      d("INSTRUCTION ${response.instruction.length}");
      scrapInstruction = response.instruction ?? [] ;
      return;
    });
  }

  Future<void> trackProduct(TrackProductEntity params,Result result) async {
    final storeUseCase = TrackProductUseCase(_iProductRepo);
    d(scrapInstruction.length);
    if(scrapInstruction.isNotEmpty) {
      params.instruction = scrapInstruction.first.toJson();
    }
    final res = await storeUseCase(params);
    res.fold((error) {
      return result.onError(error);
    }, (response)async {
      return result.onSuccess(response);
    });
  }
}
