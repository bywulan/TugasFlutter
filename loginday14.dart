import 'package:bywulan/day_13/bottomnav13.dart';
import 'package:bywulan/extension/navigator.dart';
import 'package:bywulan/tugasday18/dbhelper14.dart';
import 'package:bywulan/tugasday18/usermodel14.dart';
import 'package:flutter/material.dart';

class Logindaytugas12 extends StatefulWidget {
  const Logindaytugas12({super.key});

  @override
  State<Logindaytugas12> createState() => _Logindaytugas12State();
}

class _Logindaytugas12State extends State<Logindaytugas12> {
  final TextEditingController namaC = TextEditingController();

  final TextEditingController emailC = TextEditingController();

  final TextEditingController nomorHpC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

  final TextEditingController asalKotaC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DBHelper dbHelper = DBHelper();

  bool isEditing = false;

  int? editingUserId;

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF0024), Color(0xFF00224D)],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Text(
                    isEditing ? 'EDIT DATA' : 'MERHABA!',
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    isEditing
                        ? 'Ubah data peserta'
                        : 'Selamat Datang di Turkish Academy',

                    textAlign: TextAlign.center,

                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),

                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: namaC,
                    hintText: 'Nama',
                    icon: Icons.person_outline,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: emailC,
                    hintText: 'Email',
                    icon: Icons.email_outlined,

                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email tidak boleh kosong';
                      }

                      if (!value.contains('@')) {
                        return 'Email tidak valid';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: nomorHpC,
                    hintText: 'Nomor HP',
                    icon: Icons.phone_outlined,

                    keyboardType: TextInputType.phone,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nomor HP tidak boleh kosong';
                      }

                      if (value.trim().length < 10) {
                        return 'Nomor HP tidak valid';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  TextFormField(
                    controller: passwordC,

                    obscureText: obscurePassword,

                    style: const TextStyle(color: Colors.black),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }

                      if (value.length < 8) {
                        return 'Password minimal 8 karakter';
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,

                          color: Colors.black,
                        ),

                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),

                      hintText: 'Password',

                      hintStyle: const TextStyle(color: Colors.black),

                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),

                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: asalKotaC,
                    hintText: 'Asal Kota',
                    icon: Icons.location_city_outlined,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Asal Kota tidak boleh kosong';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: saveData,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        foregroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),

                        elevation: 0,
                      ),

                      child: Text(
                        isEditing ? 'Update' : 'Register',

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  if (isEditing)
                    Column(
                      children: [
                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: cancelEdit,

                          child: const Text(
                            'Batal Edit',

                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: OutlinedButton(
                      onPressed: loginUser,

                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      child: const Text(
                        'Login',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    'Data Peserta',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  FutureBuilder<List<UserModelSQL>>(
                    future: dbHelper.getUsers(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(20),

                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',

                          style: const TextStyle(color: Colors.white),
                        );
                      }

                      final users = snapshot.data ?? [];

                      if (users.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(20),

                          child: Text(
                            'Belum ada data peserta',

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,

                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: users.length,

                        itemBuilder: (context, index) {
                          final user = users[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),

                            color: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(16),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          user.nama,

                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text('Email: ${user.email}'),

                                        Text('Nomor HP: ${user.nomorHp}'),

                                        Text('Asal Kota: ${user.asalKota}'),
                                      ],
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      editUser(user);
                                    },

                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      confirmDelete(user);
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,

    required String? Function(String?) validator,

    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      style: const TextStyle(color: Colors.black),

      validator: validator,

      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),

        hintText: hintText,

        hintStyle: const TextStyle(color: Colors.black),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (isEditing) {
      final updatedUser = UserModelSQL(
        id: editingUserId,

        nama: namaC.text.trim(),

        email: emailC.text.trim(),

        nomorHp: nomorHpC.text.trim(),

        password: passwordC.text,

        asalKota: asalKotaC.text.trim(),
      );

      final result = await dbHelper.updateUser(updatedUser);

      if (!mounted) return;

      if (result > 0) {
        setState(() {
          isEditing = false;
          editingUserId = null;
        });

        clearForm();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diupdate!')),
        );

        setState(() {});
      }

      return;
    }

    final user = UserModelSQL(
      nama: namaC.text.trim(),

      email: emailC.text.trim(),

      nomorHp: nomorHpC.text.trim(),

      password: passwordC.text,

      asalKota: asalKotaC.text.trim(),
    );

    final success = await dbHelper.registerUser(user);

    if (!mounted) return;

    if (success) {
      clearForm();

      setState(() {});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email sudah terdaftar!')));
    }
  }

  Future<void> loginUser() async {
    final user = emailC.text.trim();

    final pass = passwordC.text;

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi!')),
      );

      return;
    }

    final pengguna = await DBHelper().loginUser(user, pass);

    if (!mounted) return;

    if (pengguna != null) {
      context.pushAndRemoveAll(const Bottomnav11());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! Email atau Password salah.'),
        ),
      );
    }
  }

  void editUser(UserModelSQL user) {
    setState(() {
      isEditing = true;

      editingUserId = user.id;

      namaC.text = user.nama;

      emailC.text = user.email;

      nomorHpC.text = user.nomorHp;

      passwordC.text = user.password;

      asalKotaC.text = user.asalKota;
    });

    Scrollable.ensureVisible(
      _formKey.currentContext!,
      duration: const Duration(milliseconds: 300),
    );
  }

  void cancelEdit() {
    setState(() {
      isEditing = false;

      editingUserId = null;

      clearForm();
    });
  }

  void clearForm() {
    namaC.clear();
    emailC.clear();
    nomorHpC.clear();
    passwordC.clear();
    asalKotaC.clear();
  }

  Future<void> confirmDelete(UserModelSQL user) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),

          content: Text('Apakah Anda yakin ingin menghapus data ${user.nama}?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text('Tidak'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text(
                'Ya, Hapus',

                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await deleteUser(user.id!);
    }
  }

  Future<void> deleteUser(int id) async {
    final result = await dbHelper.deleteUser(id);

    if (!mounted) return;

    if (result > 0) {
      if (editingUserId == id) {
        isEditing = false;
        editingUserId = null;
        clearForm();
      }

      setState(() {});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus!')));
    }
  }

  @override
  void dispose() {
    namaC.dispose();
    emailC.dispose();
    nomorHpC.dispose();
    passwordC.dispose();
    asalKotaC.dispose();

    super.dispose();
  }
}
