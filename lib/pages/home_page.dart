import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Você pode precisar de um pacote para exibir notificações locais se quiser
// mostrar notificações visuais quando o app está em primeiro plano.
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Converte HomePage para um StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// O Estado associado ao HomePage
class _HomePageState extends State<HomePage> {
  // Opcional: Inicializar flutter_local_notifications se for usar para foreground
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // Configura as notificações push (pede permissão e obtém token)
    setupPushNotifications();
    // Configura os listeners para lidar com as mensagens recebidas
    setupMessageHandling();

    // Opcional: Inicializar flutter_local_notifications
    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //         android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Substitua pelo ícone do seu app
    //         iOS: DarwinInitializationSettings(),
    //         macOS: null,
    //         linux: null);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Função para solicitar permissão e obter o token do dispositivo
  void setupPushNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Solicita permissão do usuário
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Se a permissão foi concedida, obtém o token
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("FCM Token: $token");

      // TODO: Envie/Armazene este token (backend ou Firestore)
    } else {
      print('User declined or has not accepted permission');
    }

    // Opcional: Listener para quando o token mudar
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
      // TODO: Atualize o token no seu backend/Firestore
    });
  }

  // Função para configurar os listeners de mensagens
  void setupMessageHandling() {
    // 1. Lidar com mensagens em primeiro plano (app aberto e visível)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // TODO: O Firebase NÃO exibe notificações visuais automaticamente
        // quando o app está em primeiro plano. Se você quiser mostrar
        // uma notificação para o usuário neste caso, você precisa usar
        // um pacote como flutter_local_notifications para criar e exibir
        // uma notificação local usando os dados da RemoteMessage.
        // Exemplo (se flutter_local_notifications estiver configurado):
        // showLocalNotification(message);
      }
    });

    // 2. Lidar com o toque na notificação quando o app está em segundo plano ou encerrado
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      // TODO: Use os dados da mensagem (message.data) para navegar
      // o usuário para a tela apropriada dentro do seu app.
      // Navigator.pushNamed(context, '/sua_rota_baseada_nos_dados', arguments: message.data);
    });

    // 3. Lidar com a mensagem inicial se o app foi aberto do estado encerrado por uma notificação
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print('App opened from terminated state by a notification!');
        print('Message data: ${message.data}');
        // TODO: Use os dados da mensagem (message.data) para navegar
        // o usuário para a tela apropriada assim que o app for inicializado.
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   Navigator.pushNamed(context, '/sua_rota_baseada_nos_dados', arguments: message.data);
        // });
      }
    });

    // OBS: O handler de background (FirebaseMessaging.onBackgroundMessage)
    // é configurado no main.dart e roda independentemente do estado do seu widget.
  }

  // O método build permanece o mesmo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70), // Espaço do topo
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildNavButton(
                    context,
                    Icons.sports_basketball_outlined,
                    'About',
                    '/about',
                  ),
                  _buildNavButton(
                    context,
                    Icons.waving_hand_outlined,
                    'Contact',
                    '/contact',
                  ),
                  _buildNavButton(
                    context,
                    Icons.language_rounded,
                    'Social',
                    '/social',
                  ),
                  _buildNavButton(
                    context,
                    Icons.chat_bubble_outline,
                    'Messages',
                    '/messages',
                  ),
                  _buildNavButton(context, Icons.more_vert, 'More', '/more'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A função auxiliar _buildNavButton também se move para a classe State
  Widget _buildNavButton(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF6F1DD), // fundo do botão
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFD7D2C1),
                width: 1.5,
              ), // borda fina
            ),
            padding: const EdgeInsets.all(
              12,
            ), // deixa o botão maior e o ícone centralizado
            child: Icon(icon, color: const Color(0xFF9A9364), size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA39F91), fontSize: 14),
        ),
      ],
    );
  }
}
