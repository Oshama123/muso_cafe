import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:musong_cafe/menu/menu.dart';
// import 'package:musong_cafe/views/pay.dart';
import 'package:musong_cafe/views/pay_confirmations.dart';

class Confirmations extends StatelessWidget {
  final List<MenuItem> selectedItems;

  const Confirmations({Key? key, required this.selectedItems})
      : super(key: key);

  int calculateTotalPrice(List<MenuItem> items) {
    int total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  Future<String> createTransaction(
      String orderId, List<MenuItem> items, int totalPrice) async {
    final String serverKey = 'Mid-server-b_5mDLGgT8c2xKHwatynaqTB';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$serverKey:'));

    var url = Uri.parse("https://api.midtrans.com/v2/charge");

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Basic ${base64Encode(utf8.encode('$serverKey:'))}",
    };

    var body = {
      "transaction_details": {
        "order_id": orderId,
        "gross_amount": totalPrice,
      },
      "customer_details": {
        "first_name": "User",
        "last_name": "Test",
        "email": "user@test.com",
        "phone": "081234567890",
      },
      "item_details": items
          .map((item) => {
                "price": item.price,
                "quantity": item.quantity,
                "name": item.name,
              })
          .toList(),
      "payment_type": "qris",
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['actions'][0]
          ['url']; // Mengambil QR URL dari response
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> itemsToShow =
        selectedItems.where((item) => item.quantity > 0).toList();

    int totalPrice =
        itemsToShow.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/bg1.jpg'),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 240,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(21.9, 19.5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Konfirmasi Pesanan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemsToShow.length,
                itemBuilder: (context, index) {
                  final item = itemsToShow[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      subtitle: Text('Rp ${item.price} x ${item.quantity}'),
                      trailing: Text(
                        'Rp ${item.price * item.quantity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp $totalPrice',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Batalkan Pesanan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // String orderId =
                        //     "order-id-${DateTime.now().millisecondsSinceEpoch}";
                        // String qrUrl = await createTransaction(
                        //     orderId, itemsToShow, totalPrice);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         Pay(qrUrl: qrUrl, orderId: orderId),
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayConfirmations(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD26825),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Bayar Pesanan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
