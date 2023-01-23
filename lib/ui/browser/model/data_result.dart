import 'package:html/dom.dart';
import 'package:html/parser.dart';

class DataResult {
  Element? _result;
  DocumentFragment? _dom;

  DataResult(result) {
    _result = result;
    if (result != null) {
      _dom = parseFragment(result.outerHtml);
    }
  }

  String? get html => _result?.outerHtml;

  String? get text => _result?.text;

  String? get innerHTML => _result?.innerHtml;

  String? get id => _result?.id;

  String? get classe => _result?.className;

  String? get src => attr('src');

  String? get href => attr('href');

  String? get alt => attr('alt');

  String? get width => attr('width');

  String? get height => attr('height');

  String? get title => attr('title');

  String? get action => attr('action');

  String? get hidden => attr('hidden');

  //Return Element's atribut according [attr] param
  String? attr(String? attr) {
    final res = _result?.outerHtml;
    var regex = RegExp('^.*$attr=\"(.*?)\"');
    final regexResult = regex.firstMatch(res.toString())?.group(1);
    return regexResult;
  }

  DataResult? querySelector(selector) {
    final result = _dom?.querySelector(selector);
    if (result != null) return DataResult(result);
    return null;
  }

  List<DataResult>? querySelectorAll(selector) {
    final results = _dom?.querySelectorAll(selector);
    return _extractResults(results);
  }

  //Organize results into a list of result
  List<DataResult>? _extractResults(List<Element>? data) {
    List<DataResult>? results = <DataResult>[];

    data?.forEach((item) {
      final result = DataResult(item);
      results.add(result);
    });
    return results;
  }
}
