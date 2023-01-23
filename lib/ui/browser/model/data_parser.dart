import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:savyor/ui/browser/model/data_result.dart';

class Parser {
  Document? _dom;

  Parser(String? dom) {
    if (dom != null) {
      _dom = parse(dom);
    }
  }

  DataResult? get parent => DataResult(_dom?.parent);

  String? get html => _dom?.outerHtml;

  List<Element>? get children => _dom?.children;

  DataResult getElementById(id) {
    return DataResult(_dom?.getElementById(id));
  }

  List<DataResult>? getElementsByTagName(String? tag) {
    final results = _dom?.getElementsByTagName(tag.toString());
    return _extractResults(results);
  }

  List<DataResult> getElementsByClassName(classe) {
    final results = _dom?.getElementsByClassName(classe);
    return _extractResults(results);
  }

  DataResult querySelector(selector) {
    final result = _dom?.querySelector(selector);
    return DataResult(result);
  }

  List<DataResult> querySelectorAll(selector) {
    final results = _dom?.querySelectorAll(selector);
    return _extractResults(results);
  }

  //Organize results into a list of result
  List<DataResult> _extractResults(List<Element>? data) {
    List<DataResult>? results = <DataResult>[];

    data?.forEach((item) {
      final result = DataResult(item);
      results.add(result);
    });
    return results;
  }

  //Return page tite
  String? title() {
    var document = _dom?.outerHtml;
    final regex = RegExp('<title>(.*?)<\/title>');
    final response = regex.firstMatch(document.toString());
    return response?.group(1);
  }
}
