import 'package:eurisko_flutter_test/pages/nft_details_page.dart';
import 'package:flutter/material.dart';

class NftItem extends StatelessWidget {
  final String id;
  final String title;

  const NftItem({
    required this.id,
    required this.title,
  });

  void selectNft(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(NftDetailPage.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectNft(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Name: $title'),
        ),
      ),
    );
  }
}
