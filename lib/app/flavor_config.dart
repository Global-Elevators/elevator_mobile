enum Flavor { free, premium }

class FlavorConfig {
  final Flavor flavor;
  final bool isPaid;
  final String name;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required bool isPaid,
    required String name,
  }) {
    _instance ??= FlavorConfig._(flavor: flavor, isPaid: isPaid, name: name);
    return _instance!;
  }

  const FlavorConfig._({
    required this.flavor,
    required this.isPaid,
    required this.name,
  });

  // provide a method to get the instance
  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static bool get isAccountPaid => instance.isPaid == true;

  static bool get isAccountNotPaid => instance.isPaid == false;
}
