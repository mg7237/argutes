import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Purchase extends StatefulWidget {
  final String subject;
  final int cost;
  final Function purchaseComplete;
  Purchase(
      {required this.subject,
      required this.cost,
      required this.purchaseComplete});

  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  int? cost;
  bool _loading = true;
  IAPItem? _item;
  late StreamSubscription _purchaseUpdatedSubscription;
  late StreamSubscription _purchaseErrorSubscription;
  late StreamSubscription _conectionSubscription;
  String _productId = "";
  List<String> _productLists = <String>[];

  void initPlatformState() async {
    String? platformVersion = '';

    _productId = "INR" + cost.toString();
    _productLists.add(_productId);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on Exception {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    if (!mounted) return;

    setState(() {});

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      print('purchase-updated: $productItem');

      //if (await ApiHelper.verifyPurchase(productItem.transactionReceipt)) {
      FlutterInappPurchase.instance
          .finishTransactionIOS(productItem?.transactionId ?? '');
      widget.purchaseComplete(widget.subject);
      if (this.mounted) Navigator.pop(context); //}
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
      if (this.mounted) {
        setState(() {});
      }
      // AlertDialogs dialog = AlertDialogs(
      //     title: purchaseError.code,
      //     message: "Error while purchasing: ${purchaseError.message}");
      // dialog.asyncAckAlert(context);
    });

    await _getProduct();
    setState(() {
      _loading = false;
    });
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${_item.toString()}');
      if (item.productId == _productId) {
        _item = item;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cost = widget.cost;
    initPlatformState();
  }

  Future<void>? initPurchase() async {
    if (((cost ?? 0) != 0) && (_item != null)) {
      try {
        await FlutterInappPurchase.instance
            .requestPurchase("INR" + cost.toString());
      } catch (e) {
        print("Purchase exception: " + e.toString());
      }
    } else {
      print("Error in inot purchase");
    }
    print("requestPurchase: Cost");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
      ),
      body: LoadingOverlay(
        opacity: 0.5,
        color: Colors.grey[400],
        progressIndicator: CircularProgressIndicator(),
        isLoading: _loading,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Subject: ${widget.subject}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'cost: ${widget.cost}/-',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => initPurchase(),
                    child: Container(
                      width: 150,
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
