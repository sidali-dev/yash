import 'package:yash/app/model/checkout_metadata.dart';

class CheckoutResponse {
  final bool livemode;
  final String id;
  final String entity;
  final int amount;
  final String currency;
  final int fees;
  final int feesOnMerchant;
  final int feesOnCustomer;
  final String? passFeesToCustomer;
  final String chargilyPayFeesAllocation;
  final String status;
  final String fulfillmentStatus;
  final String? depositTransactionId;
  final String locale;
  final String? description;
  final CheckoutMetadata metadata;
  final String successUrl;
  final String? failureUrl;
  final String? webhookEndpoint;
  final String paymentMethod;
  final String? invoiceId;
  final String? customerId;
  final String? paymentLinkId;
  final int createdAt;
  final int updatedAt;
  final String? shippingAddress;
  final int collectShippingAddress;
  final String? discount;
  final int amountWithoutDiscount;
  final int earningsConsumed;
  final int paidCheckoutsConsumed;
  final String checkoutUrl;

  CheckoutResponse({
    required this.livemode,
    required this.id,
    required this.entity,
    required this.amount,
    required this.currency,
    required this.fees,
    required this.feesOnMerchant,
    required this.feesOnCustomer,
    this.passFeesToCustomer,
    required this.chargilyPayFeesAllocation,
    required this.status,
    required this.fulfillmentStatus,
    this.depositTransactionId,
    required this.locale,
    this.description,
    required this.metadata,
    required this.successUrl,
    this.failureUrl,
    this.webhookEndpoint,
    required this.paymentMethod,
    this.invoiceId,
    this.customerId,
    this.paymentLinkId,
    required this.createdAt,
    required this.updatedAt,
    this.shippingAddress,
    required this.collectShippingAddress,
    this.discount,
    required this.amountWithoutDiscount,
    required this.earningsConsumed,
    required this.paidCheckoutsConsumed,
    required this.checkoutUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'livemode': livemode,
      'id': id,
      'entity': entity,
      'amount': amount,
      'currency': currency,
      'fees': fees,
      'fees_on_merchant': feesOnMerchant,
      'fees_on_customer': feesOnCustomer,
      'pass_fees_to_customer': passFeesToCustomer,
      'chargily_pay_fees_allocation': chargilyPayFeesAllocation,
      'status': status,
      'fulfillment_status': fulfillmentStatus,
      'deposit_transaction_id': depositTransactionId,
      'locale': locale,
      'description': description,
      'metadata': metadata.toJson(),
      'success_url': successUrl,
      'failure_url': failureUrl,
      'webhook_endpoint': webhookEndpoint,
      'payment_method': paymentMethod,
      'invoice_id': invoiceId,
      'customer_id': customerId,
      'payment_link_id': paymentLinkId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'shipping_address': shippingAddress,
      'collect_shipping_address': collectShippingAddress,
      'discount': discount,
      'amount_without_discount': amountWithoutDiscount,
      'earnings_consumed': earningsConsumed,
      'paid_checkouts_consumed': paidCheckoutsConsumed,
      'checkout_url': checkoutUrl,
    };
  }

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    // normalize checkout_url to https
    final rawUrl = json['checkout_url'] as String;
    final secureUrl = rawUrl.startsWith("http://")
        ? rawUrl.replaceFirst("http://", "https://")
        : rawUrl;

    return CheckoutResponse(
      livemode: json['livemode'] as bool,
      id: json['id'] as String,
      entity: json['entity'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      fees: json['fees'] as int,
      feesOnMerchant: json['fees_on_merchant'] as int,
      feesOnCustomer: json['fees_on_customer'] as int,
      passFeesToCustomer: json['pass_fees_to_customer'],
      chargilyPayFeesAllocation: json['chargily_pay_fees_allocation'] as String,
      status: json['status'] as String,
      fulfillmentStatus: json['fulfillment_status'] as String,
      depositTransactionId: json['deposit_transaction_id'],
      locale: json['locale'] as String,
      description: json['description'],
      metadata: CheckoutMetadata.fromJson(json['metadata']),
      successUrl: json['success_url'] as String,
      failureUrl: json['failure_url'],
      webhookEndpoint: json['webhook_endpoint'],
      paymentMethod: json['payment_method'] as String,
      invoiceId: json['invoice_id'],
      customerId: json['customer_id'],
      paymentLinkId: json['payment_link_id'],
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
      shippingAddress: json['shipping_address'],
      collectShippingAddress: json['collect_shipping_address'] as int,
      discount: json['discount'],
      amountWithoutDiscount: json['amount_without_discount'] as int,
      earningsConsumed: json['earnings_consumed'] as int,
      paidCheckoutsConsumed: json['paid_checkouts_consumed'] as int,
      checkoutUrl: secureUrl,
    );
  }
}
