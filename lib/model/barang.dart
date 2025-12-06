class Barang {
  String? id;
  String? namaBarang;
  int? harga;
  int? jumlah;
  String? tglMasuk;
  String? tglKadaluarsa;

  Barang({
    this.id,
    this.namaBarang,
    this.harga,
    this.jumlah,
    this.tglMasuk,
    this.tglKadaluarsa,
  });

  factory Barang.fromJSON(Map<String, dynamic> obj) {
    print('Parsing Barang from: $obj');
    try {
      return Barang(
        id: obj['id']?.toString() ?? '',
        namaBarang: obj['nama_barang']?.toString() ?? '',
        harga: obj['harga'] is int ? obj['harga'] : int.tryParse(obj['harga']?.toString() ?? '0') ?? 0,
        jumlah: obj['jumlah'] is int ? obj['jumlah'] : int.tryParse(obj['jumlah']?.toString() ?? '0') ?? 0,
        tglMasuk: obj['tgl_masuk']?.toString() ?? '',
        tglKadaluarsa: obj['tgl_kadaluarsa']?.toString() ?? '',
      );
    } catch (e) {
      print('Error parsing Barang: $e');
      rethrow;
    }
  }
}
