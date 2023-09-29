import 'package:flutter/material.dart';
import 'package:flutter_buku_kas/services/database_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  bool _isPasswordCorrect = true;

  void _saveNewPassword() async {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    final isCurrentPasswordCorrect =
        await DatabaseHelper.verifyPassword(currentPassword);

    if (isCurrentPasswordCorrect) {
      await DatabaseHelper.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password berhasil diubah.'),
        ),
      );
      setState(() {
        _isPasswordCorrect = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password saat ini salah!'),
        ),
      );
      setState(() {
        _isPasswordCorrect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.3;
    double imageHeight = screenWidth * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Password Saat Ini',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Saat Ini',
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Password Baru',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 112, 204, 109),
                  ),
                ),
                onPressed: () {
                  _saveNewPassword(); // Panggil method _saveNewPassword
                },
                child: Text('Simpan'),
              ),
            ),
            if (!_isPasswordCorrect)
              Text(
                'Password saat ini salah!',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(height: 8.0),
            Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 80, 194, 201),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('<< Kembali'),
              ),
            ),
            SizedBox(height: 60.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/pas_foto.jpg',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About This App..',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Aplikasi ini dibuat oleh:',
                    ),
                    Text(
                      'Nama: Deeva Rindu W. P.',
                    ),
                    Text(
                      'NIM: 2141764143',
                    ),
                    Text(
                      'Tanggal: 25 September 2023',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
