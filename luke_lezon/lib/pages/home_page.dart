import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Você pode precisar de um pacote para exibir notificações locais se quiser
// mostrar notificações visuais quando o app está em primeiro plano.
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions();
    _initializeFirebaseMessaging();
    _initializeLocalNotifications();
  }

  void _requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permissões de notificação concedidas');
    } else {
      print('Permissões de notificação negadas');
    }
  }

  void _initializeFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Recebeu mensagem no foreground: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Usuário abriu a notificação');
      // Você pode navegar para uma página específica aqui, se quiser.
    });

    _firebaseMessaging.getToken().then((token) {
      print('Token FCM: $token');
    });
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    _localNotifications.initialize(initSettings);
  }

  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'Descrição do canal',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    _localNotifications.show(
      0,
      message.notification?.title ?? 'Sem título',
      message.notification?.body ?? 'Sem conteúdo',
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    // MANTÉM o mesmo conteúdo do seu `build()` atual (Stack, Column, etc.)
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/Luke_background.png', fit: BoxFit.cover),
          ),

          // Conteúdo sobreposto
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Ícones do topo
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Idioma clicado');
                        },
                        child: const Icon(
                          Icons.share,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),

                      // Botão com menu personalizado
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          size: 28,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        onSelected: (value) {
                          print('Selecionado: $value');
                          Navigator.pushNamed(context, value);
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: '/podcast',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.mic_outlined,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Podcast',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 280),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/Living_the_Gospel_Mission.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/about_luke.png',
                        onTap: () {
                          Navigator.pushNamed(context, '/about');
                        },
                      ),
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/books_button.png',
                        onTap: () {
                          Navigator.pushNamed(context, '/books');
                        },
                      ),
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/messages_button.png',
                        onTap: () {
                          Navigator.pushNamed(context, '/messages');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final VoidCallback onTap;

  const _ImageButton({
    required this.label,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
