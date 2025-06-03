import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

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
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Usuário abriu a notificação');
    });

    _firebaseMessaging.getToken().then((token) {
      print('Token FCM: $token');
    });
  }

  void _initializeLocalNotifications() {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);
    _localNotifications.initialize(initSettings);
  }

  void _showLocalNotification(RemoteMessage message) {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'Canal para notificações em foreground',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    _localNotifications.show(
      0,
      message.notification?.title ?? 'Sem título',
      message.notification?.body ?? 'Sem conteúdo',
      platformDetails,
    );
  }

  void _compartilharApp() async {
    final link =
        Platform.isAndroid
            ? 'https://play.google.com/store/apps/details?id=com.seuapp.android'
            : 'https://apps.apple.com/app/id0000000000';

    final mensagem = 'Confira este app incrível! Baixe agora:\n$link';

    await SharePlus.instance.share(ShareParams(text: mensagem));
  }

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
                  // if (_hasPremium)
                  Column(
                    mainAxisSize: MainAxisSize.max,

                    children: [
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              0,
                              0,
                            ),
                            items: [
                              const PopupMenuItem<String>(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share_outlined,
                                      color: Color(0xFF9A9364),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Compartilhar app',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF9A9364),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: '/meet',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.event_available_outlined,
                                      color: Color(0xFF9A9364),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Meet & Greet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF9A9364),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            color: Color(0xFFF6F1DD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: const Color(0xFFD7D2C1),
                                width: 1,
                              ),
                            ),
                          ).then((value) {
                            if (value == 'share') {
                              _compartilharApp();
                            } else if (value != null) {
                              Navigator.pushNamed(context, value);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F1DD),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD7D2C1),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.more_vert,
                            color: Color(0xFF9A9364),
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'More',
                        style: TextStyle(
                          color: Color(0xFFA39F91),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     await _purchaseService.buyPremium();
              //     final purchased = await _purchaseService.isPurchased();
              //     setState(() {
              //       _hasPremium = purchased;
              //     });
              //   },
              //   child: Text('Comprar acesso premium'),
              // ),
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
