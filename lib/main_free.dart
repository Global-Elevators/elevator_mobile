import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';

void main() async {
  mainCommon(
    flavor: Flavor.free,
    isPaid: false,
    name: 'free',
  );
}