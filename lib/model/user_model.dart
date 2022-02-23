const String tabelaUser = 'USER';
const String colunaId = 'id';
const String colunaName = 'name';
const String colunaUsername = 'username';
const String colunaEmail = 'email';
const String colunaStreet = 'street';
const String colunaSuite = 'suite';
const String colunaCity = 'city';
const String colunaZipcode = 'zipcode';
const String colunaLat = 'lat';
const String colunaLog = 'log';
const String colunaPhone = 'phone';
const String colunaWebsite = 'website';
const String colunaNameCompany = 'namecompany';
const String colunaCathPhrese = 'cathPhrese';
const String colunaBs = 'bs';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  String? lat;
  String? log;
  String? phone;
  String? website;
  String? nameCompany;
  String? cathPhrese;
  String? bs;

  UserModel();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'lat': lat,
      'log': log,
      'phone': phone,
      'website': website,
      'nameCompany': nameCompany,
      'cathPhrese': cathPhrese,
      'bs': bs,
    };
  }

  UserModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    lat = json['lat'];
    log = json['log'];
    phone = json['phone'];
    website = json['website'];
    nameCompany = json['nameCompany'];
    cathPhrese = json['cathPhrese'];
    bs = json['bs'];
  }
}
