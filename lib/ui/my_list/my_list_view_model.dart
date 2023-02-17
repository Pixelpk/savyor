import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/domain/interfaces/i_app_repo_.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../application/core/result.dart';
import '../../data/local_data_source/preference/i_pref_helper.dart';
import '../../data/models/active_product.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';
import '../../domain/entities/signup_entity/sign_up_entity.dart';
import '../../domain/entities/update_product_entity/track_product_entity.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../../domain/use_cases/active_product_usecase.dart';
import '../../domain/use_cases/get_stores_usecase.dart';
import '../../domain/use_cases/inactive_products_usecase.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../../domain/use_cases/update_product_usecase.dart';
import '../base/base_state.dart';
import '../base/base_view_model.dart';

enum Filter { retailer, price, period }

class MyListViewModel extends BaseViewModel {
  late IProductRepo _iProductRepo;
  bool _isDec = true;
  Filter _selectedFilter = Filter.retailer;

  Filter get selectedFilter => _selectedFilter;

  set selectedFilter(Filter value) {
    _selectedFilter = value;
    applyFilter();
  }

  bool get isDec => _isDec;

  applyFilter() {
    if (selectedFilter == Filter.price) {
      sortByPrice();
    }
    if (selectedFilter == Filter.retailer) {
      setByRetailer();
    }
    if (selectedFilter == Filter.period) {
      sortByPeriod();
    }
  }

  set isDec(bool value) {
    _isDec = value;
    setState();
    applyFilter();
  }

  BaseLoadingState _state = BaseLoadingState.none;
  BaseLoadingState _updateProductState = BaseLoadingState.none;

  set updateProductState(BaseLoadingState value) {
    _updateProductState = value;
  }

  BaseLoadingState get updateProductState => _updateProductState;
  late Map<int?, Product> _activeProducts;

  List<Product> get products => _activeProducts.values.toList();

  List<Product> _currentProducts = [];

  List<Product> get currentProducts => _currentProducts;

  set currentProducts(List<Product> value) {
    _currentProducts = value;
    setState();
  }

  sortByPrice() {
    if (_isDec) {
      currentProducts.sort((a, b) => a.price!.compareTo(b.price as num));
    } else {
      currentProducts.sort((a, b) => b.price!.compareTo(a.price as num));
    }
    setState();
  }

  sortByPeriod() {
    if (_isDec) {
      currentProducts.sort((a, b) => a.period!.compareTo(b.period as num));
    } else {
      currentProducts.sort((a, b) => b.period!.compareTo(a.period as num));
    }
    setState();
  }

  setByRetailer() {
    currentProducts = products;
    setState();
  }

  updateState() {
    setState();
  }

  MyListViewModel() {
    _activeProducts = {};
    _iProductRepo = inject<IProductRepo>();
  }

  BaseLoadingState get state => _state;

  Future<void> getActiveProducts({Result? result}) async {
    _state = BaseLoadingState.loading;
    setState();
    final useCase = GetActiveProductUseCase(_iProductRepo);
    final res = await useCase(NoParams());
    res.fold((error) {
      _state = BaseLoadingState.error;
      updateState();
      return result?.onError(error);
    }, (response) async {
      _activeProducts = response.products ?? {};
      _state = BaseLoadingState.succeed;
      _currentProducts = products;
      applyFilter();
      updateState();
      return result?.onSuccess(response);
    });
  }

  Future<void> getInActiveProducts({Result? result}) async {
    _state = BaseLoadingState.loading;
    setState();
    final useCase = GetInActiveProductUseCase(_iProductRepo);
    final res = await useCase(NoParams());
    res.fold((error) {
      _state = BaseLoadingState.error;
      updateState();
      return result?.onError(error);
    }, (response) async {
      _activeProducts = response.products ?? {};
      _state = BaseLoadingState.succeed;
      _currentProducts = products;
      applyFilter();
      updateState();
      return result?.onSuccess(response);
    });
  }

  Future<void> updateProduct(Result result, UpdateProductEntity params) async {
    _updateProductState = BaseLoadingState.loading;
    setState();
    final useCase = UpdateProductUseCase(_iProductRepo);
    final res = await useCase(params);
    res.fold((error) {
      _state = BaseLoadingState.error;
      updateState();
      return result.onError(error);
    }, (response) async {
      _state = BaseLoadingState.succeed;
      updateState();
      getActiveProducts();
      return result.onSuccess(response);
    });
  }
}
