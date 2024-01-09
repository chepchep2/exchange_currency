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

  List<String> currencyCodes = [
    'AED', 'AFN', 'ALL', 'AMD', 'ANG', 'AOA', 'ARS', 'AUD', 'AWG', 'AZN',
    'BAM', 'BBD', 'BDT', 'BGN', 'BHD', 'BIF', 'BMD', 'BND', 'BOB', 'BRL',
    'BSD', 'BTN', 'BWP', 'BYN', 'BZD', 'CAD', 'CDF', 'CHF', 'CLP', 'CNY',
    'COP', 'CRC', 'CUP', 'CVE', 'CZK', 'DJF', 'DKK', 'DOP', 'DZD', 'EGP',
    'ERN', 'ETB', 'EUR', 'FJD', 'FKP', 'FOK', 'GBP', 'GEL', 'GGP', 'GHS',
    'GIP', 'GMD', 'GNF', 'GTQ', 'GYD', 'HKD', 'HNL', 'HRK', 'HTG', 'HUF',
    'IDR', 'ILS', 'IMP', 'INR', 'IQD', 'IRR', 'ISK', 'JEP', 'JMD', 'JOD',
    'JPY', 'KES', 'KGS', 'KHR', 'KID', 'KMF', 'KRW', 'KWD', 'KYD', 'KZT',
    'LAK', 'LBP', 'LKR', 'LRD', 'LSL', 'LYD', 'MAD', 'MDL', 'MGA', 'MKD',
    'MMK', 'MNT', 'MOP', 'MRU', 'MUR', 'MVR', 'MWK', 'MXN', 'MYR', 'MZN',
    'NAD', 'NGN', 'NIO', 'NOK', 'NPR', 'NZD', 'OMR', 'PAB', 'PEN', 'PGK',
    'PHP', 'PKR', 'PLN', 'PYG', 'QAR', 'RON', 'RSD', 'RUB', 'RWF', 'SAR',
    'SBD', 'SCR', 'SDG', 'SEK', 'SGD', 'SHP', 'SLE', 'SOS', 'SRD', 'SSP',
    'STN', 'SYP', 'SZL', 'THB', 'TJS', 'TMT', 'TND', 'TOP', 'TRY', 'TTD',
    'TVD', 'TWD', 'TZS', 'UAH', 'UGX', 'USD', 'UYU', 'UZS', 'VES', 'VND',
    'VUV', 'WST', 'XAF', 'XCD', 'XDR', 'XOF', 'XPF', 'YER', 'ZAR', 'ZMW', 'ZWL'
  ];

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
                    // items: const [
                    //   DropdownMenuItem(value: 'KRW', child: Text('KRW')),
                    //   DropdownMenuItem(value: 'USD', child: Text('USD')),
                    // ],
                    items: currencyCodes.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
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
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  DropdownButton(
                    value: targetCurrency,
                    items: const [
                      DropdownMenuItem(value: 'KRW', child: Text('KRW')),
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
