import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NftDetailPage extends StatefulWidget {
  static const routeName = '/nft-detail';

  @override
  State<NftDetailPage> createState() => _NftDetailPageState();
}

class _NftDetailPageState extends State<NftDetailPage> {
  var loaded = false;
  Map<String, dynamic> selectedNft = {};
  List<String> comments = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (nftList.isEmpty)
  }

  @override
  Widget build(BuildContext context) {
    final nftId = ModalRoute.of(context)?.settings.arguments as String;
    final _commentController = TextEditingController();
    if (!loaded) {
      http
          .get(Uri.parse('https://api.coingecko.com/api/v3/nfts/$nftId'))
          .then((value) {
        setState(() {
          loaded = true;
          selectedNft = json.decode(value.body);
        });
      });
    }

    if (!loaded)
      return Scaffold(
        appBar: AppBar(title: Text('title')),
        body: Center(child: Center(child: Text('Loading...'))),
      );

    Widget buildSectionTitle(String title, BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

    Widget buildContainer(Widget child) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 200,
          width: 300,
          child: child);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedNft['name']),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              (selectedNft['image']['small'] as String)
                  .replaceAll("small", "large"),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Price: \$${selectedNft['floor_price_in_usd_24h_percentage_change']}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              selectedNft['description'],
              textAlign: TextAlign.center,
            ),
          ),
          buildSectionTitle('Comments', context),
          buildContainer(comments.isNotEmpty
              ? Column(
                  children: comments.map((c) => Text(c)).toList(),
                )
              : Text('No Comments yet! Start Adding')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Enter Comment'),
                  controller: _commentController,
                ),
                TextButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        setState(() {
                          comments.add(_commentController.text);
                        });
                      }
                    },
                    child: const Text('Submit Comment'))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
