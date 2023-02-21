import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../application/core/result.dart';
import '../../data/models/active_product.dart';
import '../../di/di.dart';
import '../../domain/entities/update_product_entity/track_product_entity.dart';
import '../../domain/use_cases/active_product_usecase.dart';
import '../../domain/use_cases/inactive_products_usecase.dart';
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
      _currentProducts.sort((a, b) => b.price!.compareTo(a.price!));
    } else {
      _currentProducts.sort((a, b) => a.price!.compareTo(b.price as double));
    }
    setState();
  }

  sortByPeriod() {
    List<Product> hours = [];
    List<Product> days = [];

    for (var element in _currentProducts) {
      if (element.getRemainingDaysOrHours().split(' ')[1] == 'hours') {
        hours.add(element);
      } else {
        days.add(element);
      }
    }

    if (!_isDec) {
      hours.sort(
          (a, b) => a.getRemainingDaysOrHours().split(' ')[0].compareTo(b.getRemainingDaysOrHours().split(' ')[0]));
      days.sort(
          (a, b) => a.getRemainingDaysOrHours().split(' ')[0].compareTo(b.getRemainingDaysOrHours().split(' ')[0]));
      _currentProducts = hours + days;
    } else {
      hours.sort(
          (a, b) => b.getRemainingDaysOrHours().split(' ')[0].compareTo(a.getRemainingDaysOrHours().split(' ')[0]));
      days.sort(
          (a, b) => b.getRemainingDaysOrHours().split(' ')[0].compareTo(a.getRemainingDaysOrHours().split(' ')[0]));
      _currentProducts = days + hours;
    }
    setState();
  }

  setByRetailer() {
    if (!_isDec) {
      _currentProducts.sort((a, b) => a.retailer!.compareTo(b.retailer!));
    } else {
      _currentProducts.sort((a, b) {
        return b.retailer!.compareTo(a.retailer!);
      });
    }
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
