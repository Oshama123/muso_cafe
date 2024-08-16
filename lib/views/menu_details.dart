import 'package:flutter/material.dart';
import 'package:musong_cafe/menu/menu.dart';

class MenuDetails extends StatelessWidget {
  final MenuItem item;
  final String heroTag;

  const MenuDetails({Key? key, required this.item, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Menu'),
      ),
      body: Column(
        children: [
          Hero(
            tag: heroTag,
            child: Image.asset(
              item.imageAsset,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Rp ${item.price}',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  item.description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
