import 'package:flutter/material.dart';
import 'package:flutter_buku_kas/app.dart';
import 'package:flutter_buku_kas/services/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  runApp(App());
}
