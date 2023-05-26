import 'dart:convert';

import 'package:eurisko_flutter_test/widgets/nft_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NftListPage extends StatefulWidget {
  @override
  State<NftListPage> createState() => _NftListPageState();
}

class _NftListPageState extends State<NftListPage> {
  late List<Map<String, dynamic>> nftList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (nftList.isEmpty)
      http
          .get(Uri.parse('https://api.coingecko.com/api/v3/nfts/list'))
          .then((value) {
        setState(() {
          nftList =
              json.decode(value.body).cast<Map<String, dynamic>>().toList();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nfts')),
      body: nftList.isEmpty
          ? Center(child: Text('Loading...'))
          : Center(
              child: ListView.builder(
                itemCount: nftList.length,
                itemBuilder: (ctx, index) => NftItem(
                  id: nftList[index]['id'] as String,
                  title: nftList[index]['name'] as String,
                ),
              ),
            ),
    );
  }
}
