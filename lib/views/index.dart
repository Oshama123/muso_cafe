import 'package:flutter/material.dart';
import 'package:musong_cafe/menu/menu.dart';
import 'package:musong_cafe/views/confirmations.dart';
import 'package:musong_cafe/views/insert_name.dart';
import 'package:musong_cafe/views/menu_details.dart';
import 'package:musong_cafe/database/database_helper.dart';

class Index extends StatefulWidget {
  final String name;

  const Index({Key? key, required this.name}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<Map<String, dynamic>> _names = [];
  List<Map<String, dynamic>> _menuItems = [];
  List<int> _quantities = List.generate(menuItems.length, (index) => 0);

  bool get _isAnyItemSelected {
    return _quantities.any((quantity) => quantity > 0);
  }

  @override
  void initState() {
    super.initState();
    _loadNames();
    _loadMenuItems();
  }

  void _loadNames() async {
    print('Loading names from database');
    try {
      List<Map<String, dynamic>> names =
          await DatabaseHelper.instance.queryAll();
      print('Names loaded: $names');
      setState(() {
        _names = names;
      });
    } catch (e) {
      print('Error loading names: $e');
    }
  }

  void _loadMenuItems() {
    setState(() {
      _menuItems = menuItems.map((item) {
        return {
          'image_url': item.imageAsset,
          'name': item.name,
          'price': item.price,
        };
      }).toList();
      _quantities = List<int>.filled(_menuItems.length, 0);
    });
  }

  void _updateQuantity(int index, int quantity) {
    setState(() {
      _quantities[index] = quantity;
      menuItems[index].quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  // App bar section
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: SizedBox(
                      height: 340,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/bg3.png'),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 400,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(21.9, 19.5, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                      child: TextButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Kembali',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            child: Container(
                              margin: EdgeInsets.only(top: 70),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40000000),
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 20, 14, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            12, 0, 12, 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 90,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/image/logo.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom:
                                                          BorderSide(width: 1)),
                                                ),
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 14),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 0, 9),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 5),
                                                      child: const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Halo ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            letterSpacing: 0.4,
                                                            color: Color(
                                                                0xFF000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        '${widget.name}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 30,
                                                          letterSpacing: 0.4,
                                                          color:
                                                              Color(0xFF000000),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9),
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10.2, 9),
                                        child: const Text(
                                          'Silahkan lihat dan pesan menu kami',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            letterSpacing: 0.4,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            1, 0, 1, 0),
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 9),
                                        child: const Text(
                                          'Datang ketika kamu dipanggil ya ^^',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            letterSpacing: 0.4,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 7,
                            ),
                            itemCount: menuItems.length,
                            itemBuilder: (context, index) {
                              final item = menuItems[index];
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 123,
                                        width: 130,
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuDetails(
                                                      item: menuItems[
                                                          index], // Pass the MenuItem object
                                                      heroTag: 'item_$index',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: 'item_$index',
                                                child: Image.asset(
                                                  menuItems[index].imageAsset,
                                                  height: 123,
                                                  width: 123,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: _quantities[index] == 0
                                                  ? FloatingActionButton(
                                                      mini: true,
                                                      onPressed: () {
                                                        setState(() {
                                                          _quantities[index]++;
                                                        });
                                                      },
                                                      child: Icon(Icons.add),
                                                    )
                                                  : Container(
                                                      color: Colors.white54,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.remove),
                                                            onPressed: () {
                                                              setState(() {
                                                                _quantities[
                                                                    index]--;
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            _quantities[index]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.add),
                                                            onPressed: () {
                                                              setState(() {
                                                                _quantities[
                                                                    index]++;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        item.name, // Use name from menuItems
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Harga: ${item.price}', // Use price from menuItems
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isAnyItemSelected
          ? Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: FloatingActionButton.extended(
                onPressed: () {
                  List<MenuItem> selectedItems = [];
                  for (int i = 0; i < menuItems.length; i++) {
                    if (_quantities[i] > 0) {
                      MenuItem selectedItem = MenuItem(
                        imageAsset: menuItems[i].imageAsset,
                        name: menuItems[i].name,
                        price: menuItems[i].price,
                        description: menuItems[i].description,
                        quantity: _quantities[i], // Pass the quantity here
                      );
                      selectedItems.add(selectedItem);
                    }
                  }
                  if (selectedItems.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirmations(
                          selectedItems: selectedItems,
                        ),
                      ),
                    );
                  }
                },
                backgroundColor: Color(0xFFFFD3AE),
                label: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
