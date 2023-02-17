import 'package:savyor/application/network/external_values/iExternalValue.dart';

class ExternalValues implements IExternalValues {
  @override
  String getBaseUrl() {
    return 'https://savyor.co';
  }
}
