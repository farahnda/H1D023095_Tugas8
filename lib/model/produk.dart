class Produk {
  String? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;

  Produk({
    this.id,
    this.kodeProduk,
    this.namaProduk,
    this.hargaProduk,
  });

  // Convert JSON dari local / api
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'],
      kodeProduk: obj['kode_produk'],
      namaProduk: obj['nama_produk'],
      hargaProduk: obj['harga'],
    );
  }

  // WAJIB: Convert ke Map supaya SharedPreferences bisa simpan
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "kode_produk": kodeProduk,
      "nama_produk": namaProduk,
      "harga": hargaProduk,
    };
  }
}
