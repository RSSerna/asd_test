import '../constants/api.dart';

enum Environment { develop, production, staging }

abstract class AppEnvironment {
  static late int port;
  static late String title;
  static late bool banner;
  static late Environment _environment;

  static Environment get environment => _environment;

  static void _setUpVariables(
      {required String vTitle,
      required bool vBanner,
      required String url,
      required int vPort}) {
    port = vPort;
    API.baseUrl = url;
    title = vTitle;
    banner = vBanner;
  }

  static void setupEnv(Environment env) {
    _environment = env;

    switch (env) {
      case Environment.develop:
        {
          _setUpVariables(
              vTitle: "Develop",
              vBanner: true,
              vPort: 8080,
              url: "https://api.themoviedb.org");
          break;
        }
      case Environment.staging:
        {
          _setUpVariables(
              vTitle: "Staging",
              vBanner: true,
              vPort: 8080,
              url: "https://api.themoviedb.org");
          break;
        }
      case Environment.production:
        {
          _setUpVariables(
              vTitle: "Production",
              vBanner: false,
              vPort: 8080,
              url: "https://api.themoviedb.org");
          break;
        }
    }
  }
}
