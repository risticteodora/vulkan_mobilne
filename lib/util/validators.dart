class Validators {
  static String? email(String? v){
    if(v == null || v.trim().isEmpty) {
      return 'Unesi email';
    }
    final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(v.trim());
    if(!ok) {
      return 'Email nije validan';
    }
    return null;
  }

  static String? password(String? v){
    if(v == null || v.isEmpty) {
      return 'Unesi lozinku';
    }
    if(v.length<6) {
      return 'Lozinka mora imati bar 6 karaktera';
    }
    return null;
  }

  static String? name (String? v){
    if(v == null || v.trim().isEmpty) {
      return 'Unesi ime i prezime';
    }
    if(v.trim().length <3) {
      return 'Ime je prekratko';
    }
    return null;
  }
}