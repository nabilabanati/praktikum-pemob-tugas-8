class ApiUrl {
  static const String baseUrl = 'http://localhost:8080/';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBarang = baseUrl + '/barang';
  static const String createBarang = baseUrl + '/barang';

  static String updateBarang(int id) {
    return baseUrl + '/barang/' + id.toString();
  }

  static String showBarang(int id) {
    return baseUrl + '/barang/' + id.toString();
  }

  static String deleteBarang(int id) {
    return baseUrl + '/barang/' + id.toString();
  }
}
