// books_page.dart
import 'package:flutter/material.dart';
import 'webview_page.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebViewPage(
      title: 'Books',
      url:
          'https://www.amazon.com/stores/Luke-Lezon/author/B07TV95H29?language=es&isDramIntegra[…]portalEnabled=true&ccs_id=87a85b1e-cc28-4fac-b323-2e34fa567468',
    );
  }
}
