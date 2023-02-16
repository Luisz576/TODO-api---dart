class Auth{
  static final RegExp _validator = RegExp(r'(l[a-z]5[0-9]7[A-Z]6[567][aAlLbB]l[0-9]5[AWSD]7[A-Z]6[a-z]=)');

  static bool validateToken(String token){
    return _validator.allMatches(token).length == 1;
  }
}