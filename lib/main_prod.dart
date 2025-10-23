import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.production,
    baseUrl: 'https://ge-elevators.com/api/v1',
    name: 'Production',
  );
}
