import 'package:flutter/material.dart';
import 'package:flutter_buku_kas/models/finance_model.dart';
import 'package:flutter_buku_kas/services/database_helper.dart';

class DetailCashFlowScreen extends StatefulWidget {
  const DetailCashFlowScreen({Key? key});

  @override
  _DetailCashFlowScreenState createState() => _DetailCashFlowScreenState();
}

class _DetailCashFlowScreenState extends State<DetailCashFlowScreen> {
  List<Finance>? cashFlowData;

  @override
  void initState() {
    super.initState();
    _loadCashFlowData();
  }

  Future<void> _loadCashFlowData() async {
    final financeData = await DatabaseHelper.getAllFinance();

    if (financeData != null) {
      setState(() {
        cashFlowData = financeData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Cash Flow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cashFlowData != null
          ? ListView.builder(
              itemCount: cashFlowData!.length,
              itemBuilder: (context, index) {
                final item = cashFlowData![index];
                final isIncome = item.kategori == 'Pemasukan';
                final arrowIcon =
                    isIncome ? Icons.arrow_back_ios : Icons.arrow_forward_ios;
                final arrowColor = isIncome ? Colors.green : Colors.red;
                final sign = isIncome ? '[ + ]' : '[ - ]';

                return ListTile(
                  title: Text('${sign} Rp. ${item.nominal}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.keterangan}'),
                      Text('${item.date}'),
                    ],
                  ),
                  trailing: Icon(arrowIcon, color: arrowColor),
                );
              },
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Tampilkan loading jika data masih diambil
            ),
    );
  }
}
