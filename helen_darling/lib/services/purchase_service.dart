import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseService {
  static const String _premiumKey = 'is_premium_user';
  static const String _productId =
      'acesso_premium'; // MESMO ID nas lojas Google e Apple

  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final available = await _iap.isAvailable();
    if (!available) return;

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList, prefs);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        // Trate erros
      },
    );
  }

  Future<bool> isPurchased() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_premiumKey) ?? false;
  }

  Future<void> buyPremium() async {
    final ProductDetailsResponse response = await _iap.queryProductDetails({
      _productId,
    });
    if (response.notFoundIDs.isNotEmpty) return;

    final ProductDetails productDetails = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(
    List<PurchaseDetails> purchases,
    SharedPreferences prefs,
  ) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        if (purchase.productID == _productId) {
          prefs.setBool(_premiumKey, true);
        }
      }
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
