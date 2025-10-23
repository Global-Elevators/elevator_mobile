import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.production,
    isPaid: true,
    name: 'Production',
  );
}