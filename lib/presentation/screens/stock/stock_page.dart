import 'package:flutter/material.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/stock',
      body: Center(child: Text('Stock Page')),
    );
  }
}
