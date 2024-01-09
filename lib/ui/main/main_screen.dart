import 'package:exchange_currency/data/repository/rate_repository_impl.dart';
import 'package:exchange_currency/ui/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ExchangeCurrencyMainScreen extends StatefulWidget {
  const ExchangeCurrencyMainScreen({super.key});

  @override
  State<ExchangeCurrencyMainScreen> createState() =>
      _ExchangeCurrencyMainScreenState();
}

class _ExchangeCurrencyMainScreenState
    extends State<ExchangeCurrencyMainScreen> {
  final textController = TextEditingController();

  // num selectAmount = 1;
  // num targetAmount = 0;
  // String selectCurrency = 'KRW';
  //
  // // 기준이 되는 통화
  // String targetCurrency = 'USD';
  //
  // // 환율이 적용되는 통화
  // final repository = RateRepositoryImpl();
  //


  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Future<void> updateTargetAmount() async {
  //   final exchangeRate = await repository.getRateResult(selectCurrency);
  //   final targetRate = exchangeRate.rates?[targetCurrency];
  //
  //   if (targetRate != null) {
  //     setState(() {
  //       targetAmount = selectAmount * targetRate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('환율 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '기준통화금액',
              ),
              onChanged: (source) {
                viewModel.selectAmount = double.parse(source);
                // 1000원
                viewModel.updateTargetAmount();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  DropdownButton(
                    value: viewModel.selectCurrency,
                    items: viewModel.currenyCodes
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        viewModel.selectCurrency = value!;
                      });
                      viewModel.updateTargetAmount();
                    },
                  ),
                ],
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '대상통화금액'),
              readOnly: true,
              controller: TextEditingController(
                text: viewModel.targetAmount.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  DropdownButton(
                    value: viewModel.targetCurrency,
                    items: viewModel.currenyCodes.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
                    onChanged: (value) {
                      setState(() {
                        viewModel.targetCurrency = value!;
                      });
                      viewModel.updateTargetAmount();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
