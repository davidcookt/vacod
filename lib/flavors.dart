enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static Flavor? flavor;
  static String get title {
    switch (flavor) {
      case Flavor.dev:
        return "Dev";

      case Flavor.staging:
        return "Staging";

      case Flavor.production:
        return "Production";

      default:
        return "Dev";
    }
  }
}
