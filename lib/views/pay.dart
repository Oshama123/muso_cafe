import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:musong_cafe/views/pay_confirmations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Pay extends StatefulWidget {
  final String qrUrl;
  final String orderId;

  const Pay({Key? key, required this.qrUrl, required this.orderId})
      : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  bool paymentSuccess = false;

  @override
  void initState() {
    super.initState();
    _checkPaymentStatus();
  }

  Future<void> _checkPaymentStatus() async {
    final String serverKey = 'Mid-server-b_5mDLGgT8c2xKHwatynaqTB';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode(serverKey + ':'));

    while (!paymentSuccess) {
      final response = await http.get(
        Uri.parse('https://api.midtrans.com/v2/${widget.orderId}/status'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['transaction_status'] == 'settlement') {
          setState(() {
            paymentSuccess = true;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PayConfirmations()),
          );
          break;
        }
      } else {
        throw Exception('Failed to check payment status');
      }

      // Delay before checking again
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD3AE),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(180),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 28, 22, 106),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                    padding: const EdgeInsets.fromLTRB(22.4, 10, 22.4, 9),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFC7C7C7),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0.3, 15),
                          child: const Text(
                            'Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 0.4,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                        const Text(
                          'Pembayaran dapat dilakukan dengan QRIS dibawah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.4,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: QrImageView(
                      data: widget.qrUrl,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD26825)),
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFFFFFFFF),
                    ),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(9.1, 9, 9.1, 9),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Batalkan Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: 0.4,
                              color: Color(0xFF000000),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
