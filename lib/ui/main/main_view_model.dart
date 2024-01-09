import 'package:exchange_currency/data/repository/rate_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:exchange_currency/ui/util/currency_codes.dart';

class MainViewModel extends ChangeNotifier {
  num selectAmount = 1;
  num targetAmount = 0;
  String selectCurrency = 'KRW';

  // 기준이 되는 통화
  String targetCurrency = 'USD';

  // 환율이 적용되는 통화
  final repository = RateRepositoryImpl();

  final currenyCodes = currencyCodes;

  Future<void> updateTargetAmount() async {
    final exchangeRate = await repository.getRateResult(selectCurrency);
    final targetRate = exchangeRate.rates[targetCurrency];

    if (targetRate != null) {

        targetAmount = selectAmount * targetRate;
      notifyListeners();
    }
  }
}