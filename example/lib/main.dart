import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_sdk/flutter_facebook_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deepLinkUrl = 'Unknown';
  FlutterFacebookSdk? fbSdk;
  bool isAdvertisingTrackingEnabled = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? deepLinkUrl;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      fbSdk = FlutterFacebookSdk();
      if (Platform.isIOS) {
        var res = await fbSdk!.initializeSDK(
            appId: '2363413603901188',
            displayName: 'text.example',
            clientToken: '16372fbab7af3d283aedadbd0c5eae1a');
        print('res $res');
      }
      fbSdk!.onDeepLinkReceived!.listen((event) {
        setState(() {
          _deepLinkUrl = event;
        });
      });
      deepLinkUrl = await fbSdk!.getDeepLinkUrl;
      setState(() {
        _deepLinkUrl = deepLinkUrl!;
      });
    } on PlatformException {}
    if (!mounted) return;
  }

  Future<void> logViewContent() async {
    await fbSdk!.logViewedContent(
        contentType: "Product",
        contentData: "Nestle Milkpak",
        contentId: "NST135",
        currency: "PKR",
        price: 160);
  }

  Future<void> logAddToCart() async {
    await fbSdk!.logAddToCart(
        contentType: "Product",
        contentData: "Nestle Milkpak",
        contentId: "NST135",
        currency: "PKR",
        price: 160);
  }

  Future<void> logAddToWishlist() async {
    await fbSdk!.logAddToWishlist(
        contentType: "Product",
        contentData: "Nestle Milkpak",
        contentId: "NST135",
        currency: "PKR",
        price: 160);
  }

  Future<void> logPurchase() async {
    await fbSdk!.logPurhcase(amount: 669, currency: "PKR", params: {
      'content-type': "product_group",
      'num-items': 56,
    });
  }

  Future<void> logCompleteRegistration() async {
    await fbSdk!.logCompleteRegistration(registrationMethod: "Number");
  }

  Future<void> logActivateApp() async {
    await fbSdk!.logActivateApp();
  }

  Future<void> logSearch() async {
    await fbSdk!.logSearch(
        contentType: "Product",
        contentData: "Nestle Milkpak",
        contentId: "NST135",
        searchString: "Habeeb",
        success: false);
  }

  Future<void> logInitiateCheckout() async {
    await fbSdk!.logInitiateCheckout(
      contentType: "Product",
      contentData: "Nestle Milkpak",
      contentId: "NST135",
      currency: "PKR",
      numItems: 12,
      paymentInfoAvailable: false,
      totalPrice: 560,
    );
  }

  Future<void> logEvent(
      {required String eventName,
      double? valueToSum,
      dynamic? parameters}) async {
    await fbSdk!.logEvent(
        eventName: eventName, parameters: parameters, valueToSum: valueToSum);
  }

  Future<void> setAdvertiserTracking() async {
    await fbSdk!
        .setAdvertiserTracking(isEnabled: !isAdvertisingTrackingEnabled);
    setState(() {
      isAdvertisingTrackingEnabled = !isAdvertisingTrackingEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_deepLinkUrl\n'),
              TextButton(
                  onPressed: () async => await logViewContent(),
                  child: Text("Trigger View Content")),
              TextButton(
                  onPressed: () async => await logActivateApp(),
                  child: Text("Trigger Activate App")),
              TextButton(
                  onPressed: () async => await logAddToCart(),
                  child: Text("Trigger Add to cart")),
              TextButton(
                  onPressed: () async => await logAddToWishlist(),
                  child: Text("Trigger Add to Wishlist")),
              TextButton(
                  onPressed: () async => await logCompleteRegistration(),
                  child: Text("Trigger Complete Registration")),
              TextButton(
                  onPressed: () async => await logPurchase(),
                  child: Text("Trigger Purchase")),
              TextButton(
                  onPressed: () async => await logSearch(),
                  child: Text("Trigger Search")),
              TextButton(
                  onPressed: () async => await logInitiateCheckout(),
                  child: Text("Trigger Initiate Checkout")),
              TextButton(
                  onPressed: () async => await logEvent(
                        eventName: "button_clicked",
                        parameters: {
                          'button_id': 'the_clickme_button',
                        },
                      ),
                  child: Text("Trigger Button Clicked")),
              TextButton(
                  onPressed: () async => await logEvent(
                        eventName: "fb_mobile_add_payment_info",
                        valueToSum: 55,
                        parameters: {
                          'SUCCESS': "true",
                        },
                      ),
                  child: Text("Trigger Payment Info Click")),
              Platform.isIOS
                  ? TextButton(
                      onPressed: () async => await setAdvertiserTracking(),
                      child: isAdvertisingTrackingEnabled
                          ? Text("Disable Advertiser Tracking")
                          : Text("Enable Advertiser Tracking"))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
