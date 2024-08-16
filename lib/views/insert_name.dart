import 'package:flutter/material.dart';
import 'package:musong_cafe/database/database_helper.dart';
import 'package:musong_cafe/views/index.dart';

class InputName extends StatefulWidget {
  @override
  _InputNameState createState() => _InputNameState();
}

class _InputNameState extends State<InputName> {
  final TextEditingController _controller = TextEditingController();

  void _insertName() async {
    print('Inserting name: ${_controller.text}');
    String name = _controller.text;
    if (name.isNotEmpty) {
      Map<String, dynamic> row = {'name': name};
      await DatabaseHelper.instance.insert(row);
      _navigateToIndex(name);
    }
  }

  void _navigateToIndex(String name) {
    print('Navigating to Index page with name: $name');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Index(name: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFD3AE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'Kavoon',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Image.asset('assets/image/logo.png', height: 170),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukin Nama Kamu',
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'nama panggilan kamu aja ya',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _insertName,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Masuk',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD3AE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
