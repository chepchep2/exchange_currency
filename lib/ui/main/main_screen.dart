import 'package:flutter/material.dart';

class ExchangeCurrencyMainScreen extends StatefulWidget {
  const ExchangeCurrencyMainScreen({super.key});

  @override
  State<ExchangeCurrencyMainScreen> createState() => _ExchangeCurrencyMainScreenState();
}

class _ExchangeCurrencyMainScreenState extends State<ExchangeCurrencyMainScreen> {

  final dropDown = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('환율 계산기'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(keyboardType:TextInputType.number,
              decoration: const InputDecoration(
                labelText: '기준통화금액'
              ),
              onTap: (){},),
          DropdownButton(items: const [
              DropdownMenuItem(child: Text('')),
              DropdownMenuItem(child: Text('')),
              DropdownMenuItem(child: Text('')),
          ], onChanged: (value){},),
        ],
            ),
      ),
    );}}