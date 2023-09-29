import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_buku_kas/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Kas Nusantara',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Color.fromARGB(255, 247, 247, 247),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.black,
        ),
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/addIncome': (context) => AddIncomeScreen(),
        '/addOutcome': (context) => AddOutcomeScreen(),
        '/detailCashFlow': (context) => DetailCashFlowScreen(),
        '/setting': (context) => SettingScreen(),
      },
    );
  }
}
