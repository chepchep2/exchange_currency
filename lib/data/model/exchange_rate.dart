class ExchangeRate {
  final String baseCode;
  final Map<String, dynamic> rates;

  //<editor-fold desc="Data Methods">

  const ExchangeRate({
    required this.baseCode,
    required this.rates,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          runtimeType == other.runtimeType &&
          baseCode == other.baseCode &&
          rates == other.rates);

  @override
  int get hashCode => baseCode.hashCode ^ rates.hashCode;

  @override
  String toString() {
    return 'ExchangeRate{ baseCode: $baseCode, rates: $rates,}';
  }

  ExchangeRate copyWith({
    String? baseCode,
    Map<String, num>? rates,
  }) {
    return ExchangeRate(
      baseCode: baseCode ?? this.baseCode,
      rates: rates ?? this.rates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseCode': baseCode,
      'rates': rates,
    };
  }

  factory ExchangeRate.fromJson(Map<String, dynamic> map) {
    return ExchangeRate(
      baseCode: map['base_code'] as String,
      rates: map['rates'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}
