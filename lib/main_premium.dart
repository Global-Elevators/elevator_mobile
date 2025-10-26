import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.premium,
    isPaid: true,
    name: 'premium',
  );
}