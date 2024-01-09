import 'package:exchange_currency/data/data_source/rate_api.dart';
import 'package:exchange_currency/data/model/exchange_rate.dart';
import 'package:exchange_currency/data/repository/rate_repository.dart';

class RateRepositoryImpl implements RateRepository {
  final _api = RateApi();

  @override
  Future<ExchangeRate> getRateResult(String baseCode) async {
    final dto = await _api.getRate(baseCode);
    // print(baseCode);

    // return const ExchangeRate(baseCode: 'USD', rates: {"USD": 1});
    return ExchangeRate.fromJson(dto);
  }
  
}