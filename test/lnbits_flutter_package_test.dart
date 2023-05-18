import 'package:flutter_test/flutter_test.dart';
import 'package:lnbits/lnbits.dart';

void main() {
  const url = 'https://your-lnbits-instance.com';
  const adminKey = 'your-admin-key';
  const invoiceKey = 'your-invoice-key';

  test('Get wallet details', () async {
    final api = LNBitsAPI(url: url, adminKey: adminKey, invoiceKey: invoiceKey);
    final walletDetails = await api.getWalletDetails();
    expect(walletDetails.isNotEmpty, true);
  });

  test('Creates invoice', () async {
    final api = LNBitsAPI(url: url, adminKey: adminKey, invoiceKey: invoiceKey);
    final invoice = await api.createInvoice(amount: 1000);
    expect(invoice.isNotEmpty, true);
  });

  test('Pays invoice', () async {
    final api = LNBitsAPI(url: url, adminKey: adminKey, invoiceKey: invoiceKey);
    final invoice = await api.createInvoice(amount: 100, memo: 'Test');
    final paymentHash = await api.payInvoice(bolt11: invoice);
    expect(paymentHash.isNotEmpty, true);
  });

  test('Checks invoice', () async {
    final api = LNBitsAPI(url: url, adminKey: adminKey, invoiceKey: invoiceKey);
    final invoice = await api.createInvoice(amount: 100, memo: 'Test');
    final paymentHash = await api.payInvoice(bolt11: invoice);
    final isPaid = await api.checkInvoice(paymentHash: paymentHash);
    expect(isPaid, true);
  });

  test('Decodes invoice', () async {
    final api = LNBitsAPI(url: url, adminKey: adminKey, invoiceKey: invoiceKey);
    final invoice = await api.createInvoice(amount: 100, memo: 'Test');
    final decodedInvoice = await api.decodeInvoice(invoice: invoice);
    expect(decodedInvoice.isNotEmpty, true);
  });
}
