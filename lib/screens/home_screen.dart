import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget menuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 60,
            color: Color.fromARGB(255, 118, 221, 226),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "RANGKUMAN BULAN INI",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pengeluaran: Rp. 500.000',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 175, 32, 32),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pemasukan: Rp. 1.500.000',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 61, 187, 71),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2, // 2 tombol per baris
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                children: [
                  menuButton(
                    icon: Icons.input_rounded,
                    label: "Tambah Pemasukan",
                    onPressed: () {
                      Navigator.pushNamed(context, '/addIncome');
                    },
                  ),
                  menuButton(
                    icon: Icons.output_rounded,
                    label: "Tambah Pengeluaran",
                    onPressed: () {
                      Navigator.pushNamed(context, '/addOutcome');
                    },
                  ),
                  menuButton(
                    icon: Icons.list,
                    label: "Detail Cash Flow",
                    onPressed: () {
                      Navigator.pushNamed(context, '/detailCashFlow');
                    },
                  ),
                  menuButton(
                    icon: Icons.settings,
                    label: "Pengaturan",
                    onPressed: () {
                      Navigator.pushNamed(context, '/setting');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
