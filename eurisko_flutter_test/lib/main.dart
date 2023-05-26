import 'package:eurisko_flutter_test/pages/nft_details_page.dart';
import 'package:eurisko_flutter_test/pages/nft_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData(
    canvasColor: Color.fromRGBO(255, 254, 229, 1),
    colorScheme: ThemeData().colorScheme.copyWith(
        primary: Colors.blue,
        secondary: Colors.amber,
        error: Color(0xFFF44336)),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        "/": (ctx) => NftListPage(),
        NftDetailPage.routeName: (ctx) => NftDetailPage(),
      },
    );
  }
}
