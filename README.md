# LNBits Flutter Package

[![pub package](https://img.shields.io/badge/lnbits-api-blueviolet)](https://pub.dev/packages/lnbits)
[![pub package](https://img.shields.io/badge/lnbits-docs-blueviolet)](https://legend.lnbits.com/docs)

A Flutter package for interacting with the LNBits API. This package provides convenient methods to create, pay, check, and decode invoices, as well as getting wallet details.

## Getting Started

In your `pubspec.yaml` file add:

```yaml
dependencies:
  lnbits: 1.0.0
```

Then run `flutter pub get`.

## Usage

First, import the package:

```dart
import 'package:lnbits/lnbits.dart';
```

Create an instance of `LNBitsAPI`:

```dart
final api = LNBitsAPI(
  url: 'https://your-lnbits-instance.com',
  adminKey: 'your-admin-key',
  invoiceKey: 'your-invoice-key',
);
```

Now, you can use the various methods provided:

```dart
// Get Wallet Details
final walletDetails = await api.getWalletDetails();

// Create an Invoice
// Required parameters:
// - amount: The amount of the invoice (in satoshis)
// Optional parameters:
// - memo: A memo to attach to the invoice
// - webhook: A webhook url to get response once paid
// - expiry: Enter the expiry of the invoice in seconds
final invoice = await api.createInvoice(amount: 1000, memo: 'Test');

// Pay an Invoice
// Required parameters:
// - bolt11: The invoice string in BOLT11 format
final paymentHash = await api.payInvoice(bolt11: 'invoice');

// Check an Invoice
// Required parameters:
// - paymentHash: The payment hash of the invoice to check
final isPaid = await api.checkInvoice(paymentHash: 'payment_hash');

// Decode an Invoice
// Required parameters:
// - invoice: The invoice string in BOLT11 format
final decodedInvoice = await api.decodeInvoice(invoice: 'invoice');
```

## Issues and Feedback

For any issues with the package or to provide feedback, please [open an issue on GitHub](https://github.com/ninjapayofficial/lnbits-flutter/issues).

## License

This project is licensed under the [MIT License](https://opensource.org/license/mit/).

## Future Developments

- Plugins
