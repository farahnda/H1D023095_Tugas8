Nama: Farah Tsani Maulida 

NIM: H1D023095 

Shift D -> Shift F 


# Screenshot aplikasi
<img src="https://github.com/user-attachments/assets/d9d5b17b-4a41-47c6-975a-b2a99656278e" width="300">
<img src="https://github.com/user-attachments/assets/ae579dbe-ed24-4890-84d8-9d666d358af3" width="300">
<img src="https://github.com/user-attachments/assets/637a6aa5-e854-425f-8ecd-845e98478935" width="300">
<img src="https://github.com/user-attachments/assets/4e1d73c9-8541-4931-9e08-d39a2da260d3" width="300">
<img src="https://github.com/user-attachments/assets/99b8ca9c-b7f7-4830-8b65-f310c64c514a" width="300">
<img src="https://github.com/user-attachments/assets/f108b0f2-5b79-48ea-8210-a4e291719fc1" width="300">

# Penjelasan kode untuk tiap halaman pada Readme
## login_page.dart
### import library
```
import 'package:flutter/material.dart';
import 'package:tokokita/bloc/auth_local.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/ui/produk_page.dart';
```
- material.dart → UI dasar Flutter (Scaffold, TextField, Button, dll).
- auth_local.dart → tempat fungsi login lokal (cek email & password di SQLite).
- registrasi_page.dart → halaman menuju pendaftaran.
- produk_page.dart → halaman utama setelah login berhasil.

### Class LoginPage (StatefulWidget)
```
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}
```
Memakai StatefulWidget karena halaman login butuh perubahan state: loading indicator & validasi form.

### State Class
```
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
```
- _formKey → dipakai untuk validasi Form.
- _isLoading → menampilkan loading (CircularProgressIndicator) saat login diproses.
- _emailTextboxController & _passwordTextboxController → mengambil nilai dari TextField email dan password.

### Build Method
```
@override
Widget build(BuildContext context) {
  return Scaffold(
```
Scaffold → struktur utama halaman (appBar + body).

### Body (Form Login)
```
body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Form(
      key: _formKey,
```
- SingleChildScrollView → agar halaman bisa discroll (penting saat keyboard muncul).
- Padding → beri jarak konten.
- Form → membungkus input supaya bisa divalidasi.

### Input + Button Login
```
child: Column(
  children: [
    _emailTextField(),
    _passwordTextField(),
```
Memanggil widget pembentuk input email & password.

### Button Login
```
ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
```
- validasi input
- Jika valid → ubah _isLoading = true supaya tombol berubah jadi loading.

### Proses Login
```
bool sukses = await AuthLocal.login(
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
);
```
- Memanggil fungsi login lokal.
- Fungsi ini cek username & password di SQLite.

### Jika login berhasil → pindah ke ProdukPage
```
if (sukses) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const ProdukPage()),
  );
}
```
- pushReplacement → halaman login dihapus dari history.
- User tidak bisa kembali ke login pakai tombol back.

### Jika login gagal
```
} catch (e) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Login gagal")));
}
```
Menampilkan SnackBar jika error (misal user tidak ditemukan).

### Setelah proses selesai
```
setState(() => _isLoading = false);
```

## register_page.dart
### IMPORT
```
import 'package:flutter/material.dart';
import 'package:tokokita/bloc/auth_local.dart';
```
- material.dart → untuk UI Flutter.
- auth_local.dart → berisi fungsi registrasi lokal (SQLite).

### Class RegistrasiPage
```
class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});
  
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}
```
Menggunakan StatefulWidget karena: butuh validasi, punya loading indicator, input berubah sesuai user.

### State Class
```
final _formKey = GlobalKey<FormState>();
bool _isLoading = false;

final _namaTextboxController = TextEditingController();
final _emailTextboxController = TextEditingController();
final _passwordTextboxController = TextEditingController();
```
- _formKey → untuk validasi form.
- _isLoading → tombol register berubah jadi spinner.
- Controllers → mengambil value dari TextFormField.

### Build UI
```
return Scaffold(
  appBar: AppBar(title: const Text("Registrasi")),
  body: SingleChildScrollView(
    child: Padding(
```
- Structure halaman disusun dengan Scaffold.
- SingleChildScrollView supaya UI bisa discroll.
- Padding agar form tidak nempel ke sisi layar.

### Form Registrasi
```
Form(
  key: _formKey,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _namaTextField(),
      _emailTextField(),
      _passwordTextField(),
      _passwordKonfirmasiTextField(),
```
Kolom berisi semua input form.

### Button Registrasi
```
ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
```
- Validasi semua TextFormField.
- Jika valid → tampilkan loading.

### Proses Registrasi
```
bool sukses = await AuthLocal.register(
  nama: _namaTextboxController.text,
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
);
```
- Memanggil fungsi registrasi ke SQLite.
- Disimpan sebagai user baru.

### Jika berhasil
```
if (sukses) {
  Navigator.pop(context);
}
```
- Kembali ke LoginPage.
- Karena registrasi selesai → user login dari awal.

### Jika gagal
```
} catch (e) {
  ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text("Registrasi gagal")));
}
```

### Setelah selesai proses
```
setState(() => _isLoading = false);
```

## produk_page.dart
### Import Library & File
```
import 'package:flutter/material.dart';
import 'package:tokokita/bloc/auth_local.dart';
import 'package:tokokita/bloc/produk_local.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/login_page.dart';
```
- Mengambil package Flutter untuk UI.
- Mengambil helper AuthLocal untuk logout.
- Mengambil ProdukLocal untuk mengelola produk di penyimpanan lokal.
- Mengambil model Produk.
- Import halaman lain: detail produk, form produk, dan login.

### Deklarasi Halaman ProdukPage
```
class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}
```
- ProdukPage adalah halaman utama daftar produk.
- Menggunakan StatefulWidget karena halaman berubah (misal setelah tambah produk).

### State Class
```
class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
```
Semua UI halaman dibuat di dalam build() metode.

### AppBar
```
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
        setState(() {});  // REFRESH setelah kembali dari form
      },
    ),
  ],
),
```
- Judul halaman: List Produk Farah.
- Tombol + untuk menambah produk.
- Setelah kembali dari halaman ProdukForm, setState() dipanggil agar daftar produk otomatis refresh.

### Drawer (Menu Samping)
```
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
```
- Drawer hanya berisi satu menu: Logout.
- Ketika logout:
  - Hapus status login via AuthLocal.logout().
  - Kembali ke halaman Login dengan pushReplacement() agar halaman produk tidak bisa di-back lagi.

### Body Menggunakan FutureBuilder
```
body: FutureBuilder(
  future: ProdukLocal.getProduk(),
  builder: (context, snapshot) {
```
- Mengambil data produk dari penyimpanan lokal (SharedPreferences).
- FutureBuilder memastikan UI menunggu data.

### Saat belum ada data = loading
```
if (!snapshot.hasData) {
  return const Center(child: CircularProgressIndicator());
}
```

### Ambil data list produk
` List<Produk> list = snapshot.data!; `

### Jika list kosong
```
if (list.isEmpty) {
  return const Center(child: Text("Belum ada produk"));
}
```

### Jika ada produk → tampilkan ListView
```
return ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return ItemProduk(produk: list[index]);
  },
);
```
- Membuat list dinamis sesuai jumlah produk.
- Setiap item ditampilkan dengan widget ItemProduk.

### Widget ItemProduk
```
class ItemProduk extends StatelessWidget {
  final Produk produk;
  
  const ItemProduk({super.key, required this.produk});
```
Widget kecil untuk menampilkan satu produk.

### Saat item ditekan → buka ProdukDetail
```
return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdukDetail(
          produk: produk,
        )));
  },
```

### Tampilan kotak produk
```
child: Card(
  child: ListTile(
    title: Text(produk.namaProduk!),
    subtitle: Text(produk.hargaProduk.toString()),
  ),
),
```
- Menampilkan nama produk.
- Menampilkan harga produk.

## produk_detail.dart
### Import File dan Library
```
import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/bloc/produk_local.dart';
```
- Menggunakan widget UI Flutter.
- Mengimpor model Produk.
- Mengimpor halaman untuk mengedit: ProdukForm.
- Mengimpor halaman utama daftar produk: ProdukPage.
- Mengimpor helper CRUD lokal: ProdukLocal.

### Deklarasi Halaman ProdukDetail
```
class ProdukDetail extends StatefulWidget {
  Produk? produk;
```
- Halaman menerima 1 data produk yang dipilih user.
- Menggunakan StatefulWidget karena nilai produk dapat berubah (misal setelah di-edit).

### State Class
` class _ProdukDetailState extends State<ProdukDetail> { `
widget.produk menyimpan data produk yang sedang ditampilkan.

### UI Detail Produk
```
return Scaffold(
  appBar: AppBar(
    title: const Text('Detail Produk Farah'),
  ),
  body: Center(
    child: Column(
      children: [
        Text("Kode : ${widget.produk!.kodeProduk}", ...),
        Text("Nama : ${widget.produk!.namaProduk}", ...),
        Text("Harga : Rp. ${widget.produk!.hargaProduk}", ...),
        _tombolHapusEdit()
      ],
    ),
  ),
);
```
- Menampilkan beberapa Text berisi: Kode Produk, Nama Produk, Harga Produk.
- Fungsi _tombolHapusEdit() menampilkan tombol edit dan delete.

### Widget Tombol Edit & Delete
```
Widget _tombolHapusEdit() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      OutlinedButton(
        child: const Text("EDIT"),
        onPressed: () async { ... },
      ),
      OutlinedButton(
        child: const Text("DELETE"),
        onPressed: () => confirmHapus(),
      ),
    ],
  );
}
```
Tombol terbagi dua:

#### Tombol EDIT
```
final updatedProduk = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProdukForm(produk: widget.produk!),
  ),
);

if (updatedProduk != null) {
  setState(() {
    widget.produk = updatedProduk;
  });
}
```
- User membuka halaman ProdukForm, sambil mengirim produk lama.
- Setelah selesai edit dan kembali (pop), form mengirim data produk baru.
- Jika produk baru diterima → UI di-refresh dengan setState.

#### Tombol DELETE
` onPressed: () => confirmHapus(), `
Menjalankan dialog konfirmasi.

### Dialog Konfirmasi Hapus
```
void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          ProdukLocal.deleteProduk(widget.produk!.id!).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const ProdukPage()),
            );
          });
        },
      ),
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );

  showDialog(context: context, builder: (context) => alertDialog);
}
```
Alur:
- Tampilkan alert "Yakin ingin hapus?"
- Jika user memilih Ya:
  - Hapus data dari penyimpanan lokal via ProdukLocal.deleteProduk(id).
  - Kembali ke halaman daftar produk dengan pushReplacement.
- Jika user memilih Batal: Tutup dialog saja.

### WarningDialog (Dialog umum)
```
class WarningDialog extends StatelessWidget {
  final String description;

  const WarningDialog({super.key, required this.description});
```
- Dialog general untuk menampilkan pesan warning satu tombol “OK”.
- Bisa dipakai untuk validasi form atau notifikasi lain.

## produk_form.dart
### Import File dan Library
```
import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/bloc/produk_local.dart';
import 'package:uuid/uuid.dart';
```
- flutter/material.dart → UI Flutter.
- produk.dart → Model produk.
- produk_local.dart → Helper CRUD menggunakan penyimpanan lokal.
- uuid.dart → Untuk membuat ID unik saat menambah produk baru.

### Deklarasi StatefulWidget
```
Deklarasi StatefulWidget
```
- Form bisa menerima produk lama (jika edit), atau null (jika tambah).
- Karena isinya bisa berubah → wajib pakai StatefulWidget.

### State Class
` class _ProdukFormState extends State<ProdukForm> { `

### Inisialisasi variable penting
```
final _formKey = GlobalKey<FormState>();

String judul = "TAMBAH PRODUK";
String tombolSubmit = "SIMPAN";
```
- formKey untuk validasi form.
- judul dan tombolSubmit berubah tergantung apakah sedang tambah atau edit.

### Controller untuk tiap TextField
```
final _kodeProdukTextboxController = TextEditingController();
final _namaProdukTextboxController = TextEditingController();
final _hargaProdukTextboxController = TextEditingController();
```
Controller dipakai untuk membaca isi input user.

### initState + isUpdate()
```
@override
void initState() {
  super.initState();
  isUpdate();
}

isUpdate() {
  if (widget.produk != null) {
    setState(() {
      judul = "UBAH PRODUK";
      tombolSubmit = "UBAH";

      _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
      _namaProdukTextboxController.text = widget.produk!.namaProduk!;
      _hargaProdukTextboxController.text =
          widget.produk!.hargaProduk.toString();
    });
  }
}
```
- Jika widget.produk != null → mode Edit.
- TextField otomatis terisi data produk lama.
- Judul dan label tombol berubah.
Jika tidak → tetap mode Tambah.

### Build UI
```
return Scaffold(
  appBar: AppBar(title: Text("$judul FARAH")),
  body: ...
);
```
AppBar menampilkan judul sesuai mode.

### Form Input
#### TextField Kode Produk
```
Widget _kodeProdukTextField() {
  return TextFormField(
    decoration: const InputDecoration(labelText: "Kode Produk"),
    controller: _kodeProdukTextboxController,
    validator: (value) {
      if (value!.isEmpty) return "Kode Produk harus diisi";
      return null;
    },
  );
}
```
#### TextField Nama Produk
` Widget _namaProdukTextField() `

#### TextField Harga Produk
` Widget _hargaProdukTextField() `
Semua TextField memiliki:
- Label
- Controller
- Validasi minimal wajib isi

### Tombol Submit
```
Widget _buttonSubmit() {
  return OutlinedButton(
    child: Text(tombolSubmit),
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
```
- Validasi semua form.
- Buat objek produk baru:
```
var uuid = const Uuid();

Produk produkBaru = Produk(
  id: widget.produk?.id ?? uuid.v4(),
  kodeProduk: _kodeProdukTextboxController.text,
  namaProduk: _namaProdukTextboxController.text,
  hargaProduk: int.parse(_hargaProdukTextboxController.text),
);
```
- Cara menentukan ID:
  - Jika tambah → buat ID baru pakai UUID.
  - Jika edit → gunakan ID lama.

#### Tambah / Update Produk
```
if (widget.produk == null) {
  await ProdukLocal.addProduk(produkBaru);
} else {
  await ProdukLocal.updateProduk(produkBaru);
}
```

### Kembali ke halaman sebelumnya
` Navigator.pop(context); `
Mengembalikan data perubahan ke halaman sebelumnya (ProdukPage atau ProdukDetail).
