import 'package:flutter/material.dart';
import 'package:tokokita/bloc/auth_local.dart';
import 'package:tokokita/bloc/produk_local.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/login_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Farah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProdukForm()),
              );
              setState(() {});  // REFRESH SETELAH BALIK DARI FORM
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await AuthLocal.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: ProdukLocal.getProduk(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Produk> list = snapshot.data!;

          if (list.isEmpty) {
            return const Center(child: Text("Belum ada produk"));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ItemProduk(produk: list[index]);
            },
          );
        },
      ),
    );
  }
}


// class _ProdukPageState extends State<ProdukPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('List Produk Farah'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               child: const Icon(Icons.add, size: 26.0),
//               onTap: () async {
//                 Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => ProdukForm()));
//               },
//             ))
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               title: const Text('Logout'),
//               trailing: const Icon(Icons.logout),
//               onTap: () async {
//                 await AuthLocal.logout();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (_) => const LoginPage()),
//                   (route) => false,
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//       body: ListView(
//         children: [
//           ItemProduk(
//             produk: Produk(
//               id: "1",
//               kodeProduk: 'A001',
//               namaProduk: 'Kamera',
//               hargaProduk: 5000000,
//             ),
//           ),
//           ItemProduk(
//             produk: Produk(
//               id: "2",
//               kodeProduk: 'A002',
//               namaProduk: 'Kulkas',
//               hargaProduk: 2500000,
//             ),
//           ),
//           ItemProduk(
//             produk: Produk(
//               id: "3",
//               kodeProduk: 'A003',
//               namaProduk: 'Mesin Cuci',
//               hargaProduk: 2000000,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ItemProduk extends StatelessWidget {
  final Produk produk;
  
  const ItemProduk({super.key, required this.produk});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              produk: produk,
            )));
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text(produk.hargaProduk.toString()),
        ),
      ),
    );
  }
}