import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';

void main() async {
  mainCommon(
    flavor: Flavor.development,
    baseUrl: 'https://elevatormaintenance-app-pgdai7-e43646-92-242-187-173.traefik.me/api/v1',
    name: 'Dev',
  );
}
