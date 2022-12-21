class Images {
  static const String splash = "assets/images/splash.png";
  static const String backgroung = "assets/images/BG.png";
  static const String minus = "assets/images/minus.png";
  static const String profile_icon = "assets/images/profile-icon.png";
  static const String bg = "assets/images/bg.png";


  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
