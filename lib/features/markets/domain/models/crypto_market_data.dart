class CryptoMarketData {
  final String symbol;
  final String name;
  final double price;
  final double change24h;
  final double marketCap;
  final double volume24h;

  CryptoMarketData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change24h,
    required this.marketCap,
    required this.volume24h,
  });

  factory CryptoMarketData.fromJson(Map<String, dynamic> json, {required String currency}) {
    return CryptoMarketData(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      price: (json['quote'][currency]['price'] as num).toDouble(),
      change24h: (json['quote'][currency]['percent_change_24h'] as num).toDouble(),
      marketCap: (json['quote'][currency]['market_cap'] as num).toDouble(),
      volume24h: (json['quote'][currency]['volume_24h'] as num).toDouble(),
    );
  }
}
