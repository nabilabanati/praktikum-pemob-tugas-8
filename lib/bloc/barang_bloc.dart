import 'dart:convert';
import 'package:supermarket/helpers/api.dart';
import 'package:supermarket/helpers/api_url.dart';
import 'package:supermarket/model/barang.dart';

class BarangBloc {
  static Future<List<Barang>> getBarangs() async {
    String apiUrl = ApiUrl.listBarang;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBarang = (jsonObj as Map<String, dynamic>)['data'];
    List<Barang> barangs = [];
    for (int i = 0; i < listBarang.length; i++) {
      barangs.add(Barang.fromJSON(listBarang[i]));
    }
    return barangs;
  }

  static Future addBarang({Barang? barang}) async {
    String apiUrl = ApiUrl.createBarang;

    var body = {
      "nama_barang": barang!.namaBarang,
      "harga": barang.harga.toString(),
      "jumlah": barang.jumlah.toString(),
      "tgl_masuk": barang.tglMasuk,
      "tgl_kadaluarsa": barang.tglKadaluarsa,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateBarang({required Barang barang}) async {
    String apiUrl = ApiUrl.updateBarang(int.parse(barang.id!));
    print(apiUrl);

    var body = {
      "nama_barang": barang.namaBarang,
      "harga": barang.harga.toString(),
      "jumlah": barang.jumlah.toString(),
      "tgl_masuk": barang.tglMasuk,
      "tgl_kadaluarsa": barang.tglKadaluarsa,
    };
    print("Body : $body");

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteBarang({int? id}) async {
    String apiUrl = ApiUrl.deleteBarang(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
