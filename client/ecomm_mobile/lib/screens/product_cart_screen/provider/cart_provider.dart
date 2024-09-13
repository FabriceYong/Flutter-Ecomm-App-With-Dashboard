import 'dart:developer';

import 'package:ecomm_mobile/models/coupon.dart';
import 'package:ecomm_mobile/screens/login_screen/provider/user_provider.dart';
import 'package:ecomm_mobile/services/http_service.dart';
import 'package:ecomm_mobile/utility/constants.dart';
import 'package:ecomm_mobile/utility/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(this._userProvider);
  HttpService service = HttpService();
  final storage = GetStorage();
  Razorpay razorpay = Razorpay();
  final UserProvider _userProvider;
  var flutterCart = FlutterCart();
  List<CartModel> myCartItems = [];

  final GlobalKey<FormState> buyNowFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController couponController = TextEditingController();
  bool isExpanded = false;

  Coupon? couponApplied;
  double couponCodeDiscount = 0;
  String selectedPaymentOption = 'prepaid';

  //TODO: should complete updateCart

  //TODO: should complete getCartSubTotal

  //TODO: should complete getGrandTotal

  //TODO: should complete getCartItems

  //TODO: should complete clearCartItems

  //TODO: should complete checkCoupon

  //TODO: should complete getCouponDiscountAmount

  //TODO: should complete submitOrder

  //TODO: should complete addOrder

  //TODO: should complete cartItemToOrderItem

  clearCouponDiscount() {
    couponApplied = null;
    couponCodeDiscount = 0;
    couponController.text = '';
    notifyListeners();
  }

  void retrieveSavedAddress() {
    phoneController.text = storage.read(PHONE_KEY) ?? '';
    streetController.text = storage.read(STREET_KEY) ?? '';
    cityController.text = storage.read(CITY_KEY) ?? '';
    stateController.text = storage.read(STATE_KEY) ?? '';
    postalCodeController.text = storage.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = storage.read(COUNTRY_KEY) ?? '';
  }

  Future<void> stripePayment({required void Function() operation}) async {
    try {
      Map<String, dynamic> paymentData = {
        'email': _userProvider.getLoginUser()?.name,
        'name': _userProvider.getLoginUser()?.name,
        'address': {
          'line1': streetController.text,
          'city': cityController.text,
          'state': stateController.text,
          'postal_code': postalCodeController.text,
          'country': 'US'
        },
        'amount': 100, //TODO: should complete amount grand total
        'currency': 'usd',
        'description': 'Your transaction description here'
      };
      Response response = await service.addItem(
          endPoint: 'payment/stripe', itemData: paymentData);
      final data = await response.body;
      final paymentIntent = data['paymentIntent'];
      final ephemeralKey = data['ephemeralKey'];
      final customer = data['customer'];
      final publishableKey = data['publishableKey'];

      Stripe.publishableKey = publishableKey;
      BillingDetails billingDetails = BillingDetails(
        email: _userProvider.getLoginUser()?.name,
        phone: '1234567890',
        name: _userProvider.getLoginUser()?.name,
        address: Address(
          country: 'Us', city: cityController.text,
          line1: streetController.text, line2: stateController.text,
          postalCode: postalCodeController.text, state: stateController.text,
          // Other address details
        ),
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'MOBIZATE',
          paymentIntentClientSecret: paymentIntent,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customer,
          style: ThemeMode.light,
          billingDetails: billingDetails,
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   currencyCode: 'usd',
          //   testEnv: true,
          // ),
          // applePay: const PaymentSheetApplePay(merchantCountryCode: 'US')
        ),
      );
      await Stripe.instance.presentPaymentSheet().then((value) {
        log('Payment success');
        //? do the success operation
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Payment success'),
          ),
        );
        operation();
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('${error.error.localizedMessage}'),
            ),
          );
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text('Stripe Error: $error')),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> razorpayPayment({required void Function() operation}) async {
    try {
      final Response response =
          await service.addItem(endPoint: 'payment/razorpay', itemData: {});
      final data = await response.body;
      String? razorpayKey = data['key'];
      if (razorpayKey != null && razorpayKey != '') {
        var options = {
          'key': razorpayKey,
          'amount': 100, // TODO: should complete amount grand total
          'name': 'user',
          'currency': 'USD',
          'description': 'Your transaction description',
          'send_sms_hash': true,
          'prefill': {
            'email': _userProvider.getLoginUser()?.name,
            'contact': '',
          },
          'theme': {'color': '#FFE64A'},
          'image':
              'https://store.rapidflutter.com/digitalAssetUpload/rapidlogo.png',
        };
        razorpay.open(options);
        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
            (PaymentSuccessResponse response) {
          operation();
          return;
        });
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
            (PaymentFailureResponse response) {
          SnackbarHelper.showErrorSnackBar('Error: ${response.message}');
          return;
        });
      }
    } catch (e) {
      SnackbarHelper.showErrorSnackBar('Error: $e');
      return;
    }
  }

  void updateUI() {
    notifyListeners();
  }
}
