class UserSettings {
  final bool account;
  final bool newAnime;
  final bool newLogin;
  final bool recommendation;
  final bool survey;
  final bool twoFactor;
  final bool adultFilter;
  final bool thirdPartyCookies;

  UserSettings({
    required this.account,
    required this.newAnime,
    required this.newLogin,
    required this.recommendation,
    required this.survey,
    required this.twoFactor,
    required this.adultFilter,
    required this.thirdPartyCookies,
  });

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      account: map['AccountisEnabled'] ?? false,
      newAnime: map['NewAnimeisEnabled'] ?? false,
      newLogin: map['NewLoginisEnabled'] ?? false,
      recommendation: map['ReccomendationisEnabled'] ?? false,
      survey: map['SurveyisEnabled'] ?? false,
      twoFactor: map['TwoFactorAuthisEnabled'] ?? false,
      adultFilter: map['adultContentFilterisEnabled'] ?? false,
      thirdPartyCookies: map['thirdPartyCookiesisEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountisEnabled': account,
      'NewAnimeisEnabled': newAnime,
      'NewLoginisEnabled': newLogin,
      'ReccomendationisEnabled': recommendation,
      'SurveyisEnabled': survey,
      'TwoFactorAuthisEnabled': twoFactor,
      'adultContentFilterisEnabled': adultFilter,
      'thirdPartyCookiesisEnabled': thirdPartyCookies,
    };
  }
}