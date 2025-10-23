enum Flavor { development, staging, production }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  final String name;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
    required String name,
  }) {
    _instance ??= FlavorConfig._(flavor: flavor, baseUrl: baseUrl, name: name);
    return _instance!;
  }

  const FlavorConfig._({
    required this.flavor,
    required this.baseUrl,
    required this.name,
  });

  // provide a method to get the instance
  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static bool get isDevelopment => instance.flavor == Flavor.development;

  static bool get isStaging => instance.flavor == Flavor.staging;

  static bool get isProduction => instance.flavor == Flavor.production;
}
