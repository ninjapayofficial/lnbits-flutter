library lnbits;

import 'dart:convert';
import 'package:http/http.dart' as http;

class LNBitsAPI {
  final String url;
  final String adminKey;
  final String invoiceKey;
  // late final http.Client client;

  LNBitsAPI({
    required this.url,
    required this.adminKey,
    required this.invoiceKey,
    // required this.client,
  });
// Get wallet details
  Future<Map<String, dynamic>> getWalletDetails() async {
    final response = await http.get(
      Uri.parse('$url/api/v1/wallet'),
      headers: {
        'X-Api-Key': invoiceKey,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get wallet details');
    }
  }

// Creating an invoice
  Future<String> createInvoice({
    required int amount,
    String? memo,
    int? expiry,
    String? unit,
    String? webhook,
    bool? internal,
  }) async {
    var body = {
      'out': false,
      'amount': amount,
    };

    if (memo != null) body['memo'] = memo;
    if (expiry != null) body['expiry'] = expiry;
    if (unit != null) body['unit'] = unit;
    if (webhook != null) body['webhook'] = webhook;
    if (internal != null) body['internal'] = internal;

    final response = await http.post(
      Uri.parse('$url/api/v1/payments'),
      headers: {
        'X-Api-Key': invoiceKey,
        'Content-type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['payment_request'];
    } else {
      throw Exception('Failed to create invoice');
    }
  }

// Paying an invoice
  Future<String> payInvoice({required String bolt11}) async {
    final response = await http.post(
      Uri.parse('$url/api/v1/payments'),
      headers: {
        'X-Api-Key': adminKey,
        'Content-type': 'application/json',
      },
      body: jsonEncode({'out': true, 'bolt11': bolt11}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['payment_hash'];
    } else {
      throw Exception('Failed to pay invoice');
    }
  }

// Checking an invoice
  Future<bool> checkInvoice({required String paymentHash}) async {
    final response = await http.get(
      Uri.parse('$url/api/v1/payments/$paymentHash'),
      headers: {
        'X-Api-Key': invoiceKey,
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['paid'];
    } else {
      throw Exception('Failed to check invoice');
    }
  }

// Decode an invoice
  Future<Map<String, dynamic>> decodeInvoice({required String invoice}) async {
    final response = await http.post(
      Uri.parse('$url/api/v1/payments/decode'),
      headers: {
        'X-Api-Key': invoiceKey,
        'Content-type': 'application/json',
      },
      body: jsonEncode({'data': invoice}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to decode invoice');
    }
  }
}
