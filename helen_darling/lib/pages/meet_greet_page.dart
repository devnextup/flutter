import 'package:flutter/material.dart';
import 'meet_greet_detail_page.dart';

class MeetGreetPage extends StatelessWidget {
  const MeetGreetPage({super.key});

  final Color primaryDark = const Color(0xFF9A9364);
  final Color backgroundColor = const Color(0xFFF6F1DD);
  final Color cardColor = const Color(0xFFD7D2C1);

  final List<Map<String, String>> events = const [
    {
      'title': 'Encontro com fãs - São Paulo',
      'date': '15 de Junho de 2025',
      'location': 'Shopping Eldorado',
      'description': 'Sessão de autógrafos e fotos com fãs.',
    },
    {
      'title': 'Meet & Greet - Rio de Janeiro',
      'date': '22 de Junho de 2025',
      'location': 'BarraShopping',
      'description': 'Bate-papo exclusivo com convidados e brindes!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text('Meet & Greet')),
      body:
          events.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: primaryDark.withOpacity(0.6),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum evento disponível no momento.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MeetGreetDetailPage(event: event),
                        ),
                      );
                    },
                    child: Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: primaryDark.withOpacity(0.3)),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('📅 ${event['date']}'),
                            Text('📍 ${event['location']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
