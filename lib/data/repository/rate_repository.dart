import 'package:exchange_currency/data/model/exchange_rate.dart';

abstract interface class RateRepository {
  Future<ExchangeRate> getRateResult(String baseCode);
}