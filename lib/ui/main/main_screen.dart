import 'package:flutter/material.dart';

class ExchangeCurrencyMainScreen extends StatefulWidget {
  const ExchangeCurrencyMainScreen({super.key});

  @override
  State<ExchangeCurrencyMainScreen> createState() => _ExchangeCurrencyMainScreenState();
}

class _ExchangeCurrencyMainScreenState extends State<ExchangeCurrencyMainScreen> {

  num selectAmount = 1000.0;
  num targetAmount = 1000.0;
  String selectCurrency = 'KRW';
  String targetCurrency = 'USD';
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
              onChanged: (source){
              selectAmount = double.parse(source);
              },),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                DropdownButton(
                  value: selectCurrency,
                  items: const [
                    DropdownMenuItem(value: 'KRW',child: Text(' KRW')),
                    DropdownMenuItem(value:'USD'
                        ,child: Text('USD')),
                ], onChanged: (value){
                selectCurrency = value!;
                },),
              ],
            ),
          ),
            TextField(keyboardType:TextInputType.number,
              decoration: const InputDecoration(
                  labelText: '대상통화금액'
              ),
              onChanged: (source){
                targetAmount = double.parse(source);
              },),
        ],
            ),
      ),
    );}}