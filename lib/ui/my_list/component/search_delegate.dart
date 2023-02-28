import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/active_product.dart';

class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate({required this.list})
      : super(
            searchFieldDecorationTheme: InputDecorationTheme(
                hintStyle: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
                filled: true,
                fillColor: const Color(0xffF8F8F9),
                isCollapsed: true,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(10),
                isDense: true));

  final List<Product?> list;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: searchFieldDecorationTheme,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: TextStyle(color: Colors.black),
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            CupertinoIcons.xmark_circle_fill,
            color: Style.accentColor,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, List<String>.empty());
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (Product? item in list) {
      if (item!.productName!.toLowerCase().contains(query.toLowerCase().trim())) {
        matchQuery.add(item);
      }
    }
    return matchQuery.isEmpty
        ? Center(
            child: Text(
              '$query Not Found',
              style: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.textHintColor),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Assets.search,
                ),
                dense: true,
                title: Text(
                  result.productName ?? '',
                  style: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.textColor),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Assets.arrowLeft,
                ),
                onTap: () {
                  matchQuery.insert(0, matchQuery.removeAt(index));
                  close(context, matchQuery);
                },
              );
            },
            itemCount: matchQuery.length,
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];

    for (Product? item in list) {
      if (query.trim().isNotEmpty && item!.retailer!.toLowerCase().contains(query.toLowerCase().trim())) {
        matchQuery.add(item);
      }
    }

    return matchQuery.isEmpty
        ? Center(
            child: Text(
              '$query Not Found',
              style: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.textHintColor),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Assets.search,
                ),
                dense: true,
                title: RichText(
                  text: TextSpan(
                    children: highlightOccurrences(result.retailer ?? '', query),
                    style: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Assets.arrowLeft,
                ),
                onTap: () {
                  matchQuery.insert(0, matchQuery.removeAt(index));
                  close(context, matchQuery);
                },
              );
            },
            itemCount: matchQuery.length,
          );
  }
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: source)];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: const TextStyle(fontFamily: 'DM Sans', fontSize: 15, color: Style.textColor),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}
