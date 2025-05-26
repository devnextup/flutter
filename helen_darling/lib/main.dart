import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // <--- Importar FCM
import 'firebase_options.dart';

import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/social_page.dart';
import 'pages/messages_page.dart';
import 'pages/more_page.dart';

// <--- Handler de mensagens em segundo plano/encerradas (FUNÇÃO TOP-LEVEL)
// Esta função DEVE ser uma função top-level e não pode estar dentro de uma classe.
@pragma(
  'vm:entry-point',
) // Essencial para que o Flutter execute esta função em segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ao lidar com mensagens em segundo plano, você pode precisar inicializar o Firebase
  // novamente, pois o handler pode rodar em um contexto isolado.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');

  // TODO: Aqui você pode processar a mensagem de dados ou notification
  // enquanto o app está em segundo plano.
  // Exemplos:
  // - Atualizar dados no banco de dados local
  // - Agendar uma notificação local (se a notificação não foi exibida automaticamente)
  // - Executar alguma lógica de negócio
  // NÃO execute operações de UI complexas aqui, pois não há contexto de UI garantido.
}
// <--- Fim do Handler de mensagens em segundo plano/encerradas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // <--- Registrar o background handler AQUI, após a inicialização do Firebase
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // <--- Fim do registro

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F1DD), // Cor de fundo global
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F1DD), // Cor de fundo da AppBar
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/about': (_) => const AboutPage(),
        '/contact': (_) => const ContactPage(),
        '/social': (_) => const SocialPage(),
        '/messages': (_) => const MessagesPage(),
        '/more': (_) => const MorePage(),
      },
    );
  }
}
