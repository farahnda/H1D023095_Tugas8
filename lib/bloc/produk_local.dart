import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokokita/model/produk.dart';

class ProdukLocal {
  static const String keyProduk = "list_produk";

  // GET SEMUA PRODUK
  static Future<List<Produk>> getProduk() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(keyProduk);

    if (data == null) return [];

    List list = jsonDecode(data);
    return list.map((e) => Produk.fromJson(e)).toList();
  }

  // SIMPAN PRODUK BARU
  static Future<void> addProduk(Produk produk) async {
    final prefs = await SharedPreferences.getInstance();

    List<Produk> list = await getProduk();
    list.add(produk);

    prefs.setString(
      keyProduk,
      jsonEncode(list.map((p) => p.toMap()).toList()),
    );
  }

  // UPDATE PRODUK
  static Future<void> updateProduk(Produk produk) async {
    final prefs = await SharedPreferences.getInstance();

    List<Produk> list = await getProduk();

    int index = list.indexWhere((p) => p.id == produk.id);
    if (index != -1) {
      list[index] = produk;
    }

    prefs.setString(
      keyProduk,
      jsonEncode(list.map((p) => p.toMap()).toList()),
    );
  }

  // DELETE PRODUK
  static Future<void> deleteProduk(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<Produk> list = await getProduk();
    list.removeWhere((p) => p.id == id);

    prefs.setString(
      keyProduk,
      jsonEncode(list.map((p) => p.toMap()).toList()),
    );
  }
}
