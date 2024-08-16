import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/image/logo.png');
    var image = Image(
      image: assetsImage,
      height: 264,
    );

    return Container(
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFFFD3AE)),
        child: Center(
          child: image,
        ),
      ),
    );
  }
}
