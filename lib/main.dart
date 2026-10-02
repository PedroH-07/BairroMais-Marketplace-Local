import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'core/theme.dart';

void main() async {
  // Garante que o Flutter está pronto antes de inicializar pacotes externos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa a conexão com o Supabase
  await Supabase.initialize(
    url: 'https://umpzclsztdfeaptmbxkb.supabase.co', // COLOQUE A SUA URL AQUI
    publishableKey: 'sb_publishable_NuiCWcZ11jny2EmbeWO-EA_gKwp3LKp', // COLOQUE A SUA CHAVE AQUI
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BairroMais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primaryGreen,
        scaffoldBackgroundColor: AppTheme.backgroundLight,
        fontFamily: 'Poppins', 
      ),
      home: const HomeScreen(),
    );
  }
}