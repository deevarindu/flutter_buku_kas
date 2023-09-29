import 'package:flutter/material.dart';
import 'package:flutter_buku_kas/models/finance_model.dart';
import 'package:flutter_buku_kas/services/database_helper.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _resetFields() {
    setState(() {
      selectedDate = DateTime(2000, 1, 1);
      _amountController.text = '';
      _descriptionController.text = '';
    });
  }

  void _saveData() async {
    final date = selectedDate.toLocal().toString().split(' ')[0];
    final nominal = int.tryParse(_amountController.text) ?? 0;
    final keterangan = _descriptionController.text;

    if (nominal <= 0 || keterangan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon isi semua field dengan benar.'),
        ),
      );
      return;
    }

    final finance = Finance(
        date: date,
        nominal: nominal,
        keterangan: keterangan,
        kategori: 'Pemasukan');
    final result = await DatabaseHelper.addFinance(finance);

    if (result != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pemasukan berhasil disimpan.'),
        ),
      );

      _resetFields();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Pemasukan gagal disimpan.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Pemasukan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 112, 204, 109),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tanggal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nominal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Masukkan jumlah uang',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Keterangan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Masukkan keterangan',
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 231, 185, 86),
                  ),
                ),
                onPressed: () => _resetFields(),
                child: Text('Reset'),
              ),
            ),
            SizedBox(height: 8.0), // Tambahkan spasi kecil
            Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 112, 204, 109),
                  ),
                ),
                onPressed: () => _saveData(),
                child: Text('Simpan'),
              ),
            ),
            SizedBox(height: 8.0), // Tambahkan spasi kecil
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
          ],
        ),
      ),
    );
  }
}
