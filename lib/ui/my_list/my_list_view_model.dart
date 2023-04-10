import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../application/core/result.dart';
import '../../common/logger/log.dart';
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

  bool _inActiveProducts = false;

  Filter _selectedFilter = Filter.retailer;

  Filter get selectedFilter => _selectedFilter;

  set selectedFilter(Filter value) {
    _selectedFilter = value;
    applyFilter(queryList);
  }

  bool get isDec => _isDec;

  bool get inActiveProducts => _inActiveProducts;

  applyFilter(List<Product> products) {
    if (selectedFilter == Filter.price) {
      sortByPrice(products);
    }
    if (selectedFilter == Filter.retailer) {
      setByRetailer(products);
    }
    if (selectedFilter == Filter.period) {
      sortByPeriod(products);
    }
  }

  set isDec(bool value) {
    _isDec = value;
    applyFilter(queryList);
  }

  set inActiveProducts(bool value) {
    _inActiveProducts = value;
    applyFilter(queryList);
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

  sortByPrice(List<Product> products) {
    if (_isDec) {
      products.sort((a, b) => b.price!.compareTo(a.price!));
    } else {
      products.sort((a, b) => a.price!.compareTo(b.price as double));
    }
    d(products.map((e) => print(e.price)));
    setState();
  }

  sortByPeriod(List<Product> products) {
    List<Product> hours = [];
    List<Product> days = [];
    for (var element in products) {
      if (element.getRemainingDaysOrHours().split(' ')[1] == 'hours') {
        hours.add(element);
      } else {
        days.add(element);
      }
    }
    products.clear();
    if (!_isDec) {
      hours.sort((a, b) => int.parse(a.getRemainingDaysOrHours().split(' ')[0])
          .compareTo(int.parse(b.getRemainingDaysOrHours().split(' ')[0])));
      days.sort((a, b) => int.parse(a.getRemainingDaysOrHours().split(' ')[0])
          .compareTo(int.parse(b.getRemainingDaysOrHours().split(' ')[0])));
      products.addAll(hours);
      products.addAll(days);
    } else {
      hours.sort((a, b) => int.parse(b.getRemainingDaysOrHours().split(' ')[0])
          .compareTo(int.parse(a.getRemainingDaysOrHours().split(' ')[0])));
      days.sort((a, b) => int.parse(b.getRemainingDaysOrHours().split(' ')[0])
          .compareTo(int.parse(a.getRemainingDaysOrHours().split(' ')[0])));
      products.addAll(days);
      products.addAll(hours);
    }
    setState();
  }

  setByRetailer(List<Product> products) {
    if (!_isDec) {
      products.sort((a, b) => a.retailer!.compareTo(b.retailer!));
    } else {
      products.sort((a, b) {
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
      setDocuments(_currentProducts);
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
      setDocuments(_currentProducts);
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

  //search
  List<Product> fixList = [];
  List<Product> queryList = [];

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Product> dummyListData = [];
      dummyListData.addAll(fixList.where((item) {
        return item.retailer!.toLowerCase().contains(query.toLowerCase()) ||
            item.productName!.toLowerCase().contains(query.toLowerCase());
      }));
      updateList(dummyListData);
      update();
      return;
    } else {
      updateList(fixList);
      update();
    }
  }

  setDocuments(List<Product> products) {
    queryList.clear();
    fixList.clear();
    fixList.addAll(products);
    queryList.addAll(products);
  }

  updateList(List<Product> newList) {
    queryList.clear();
    applyFilter(newList);
    queryList.addAll(newList);
  }

  update() {
    notifyListeners();
  }
}
