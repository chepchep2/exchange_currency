import 'package:exchange_currency/data/repository/rate_repository_impl.dart';
import 'package:flutter/material.dart';

class ExchangeCurrencyMainScreen extends StatefulWidget {
  const ExchangeCurrencyMainScreen({super.key});

  @override
  State<ExchangeCurrencyMainScreen> createState() =>
      _ExchangeCurrencyMainScreenState();
}

class _ExchangeCurrencyMainScreenState
    extends State<ExchangeCurrencyMainScreen> {
  final textController = TextEditingController();

  num selectAmount = 1;
  num targetAmount = 0;
  String selectCurrency = 'KRW';

  // 기준이 되는 통화
  String targetCurrency = 'USD';

  // 환율이 적용되는 통화
  final repository = RateRepositoryImpl();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> updateTargetAmount() async {
    final exchangeRate = await repository.getRateResult(selectCurrency);
    final targetRate = exchangeRate.rates?[targetCurrency];

    if (targetRate != null) {
      setState(() {
        targetAmount = selectAmount * targetRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(repository.getRateResult('USD'));
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
                selectAmount = double.parse(source);
                // 1000원
                updateTargetAmount();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  DropdownButton(
                    value: selectCurrency,
                    items: const [
                      DropdownMenuItem(value: 'KRW', child: Text(' KRW')),
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectCurrency = value!;
                      });
                      updateTargetAmount();
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
                text: targetAmount.toString(),
              ),
            ),
            DropdownButton(
              value: targetCurrency,
              items: const [
                DropdownMenuItem(value: 'KRW', child: Text(' KRW')),
                DropdownMenuItem(value: 'USD', child: Text('USD')),
              ],
              onChanged: (value) {
                setState(() {
                  targetCurrency = value!;
                });
                updateTargetAmount();
              },
            ),
          ],
        ),
      ),
    );
  }
}
// 대상 통화 금액을 업데이트합니다.
// void _updateTargetAmount() {
//   // 환율 정보를 가져옵니다.
//   double rate = _getRate(selectCurrency, targetCurrency);
//   // 대상 통화 금액을 계산합니다.
//   targetAmount = selectAmount * rate;
//   // 대상 통화 금액 입력 필드를 업데이트합니다.
//   setState(() {
//     _targetAmount = _targetAmount;
//   });
// }
//
// // 환율 정보를 가져옵니다.
// double _getRate(String select, String target) {
//   // TODO: 실제 환율 정보를 가져오는 코드를 작성합니다.
//   return 1.0;
// }
