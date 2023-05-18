import "package:lnbits/lnbits.dart";

import 'package:lnbits/lnbits.dart';

void main() async {
  final api = LNBitsAPI(
    url: 'https://legend.lnbits.com',
    adminKey: 'c6bda6e5c9374d21a5cdee58572f08en1',
    invoiceKey: 'b86dacdf0d8b449193230ff47093d5and',
  );

  // Get wallet details
  final walletDetails = await api.getWalletDetails();
  print('Wallet ID: ${walletDetails['id']}');
  print('Wallet Name: ${walletDetails['name']}');
  print('Wallet Balance: ${walletDetails['balance']}');

  // Create an invoice
  final invoice = await api.createInvoice(amount: 1000, memo: 'Test');
  print('Invoice: $invoice');

  // Pay an invoice
  final paymentHash = await api.payInvoice(bolt11: 'invoice');
  print('Payment Hash: $paymentHash');

  // Check if an invoice is paid
  final isPaid = await api.checkInvoice(paymentHash: 'payment_hash');
  print('Is Paid: $isPaid');

  // Decode an invoice
  final decodedInvoice = await api.decodeInvoice(invoice: 'invoice');
  print('Decoded Invoice: $decodedInvoice');
}
