import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Luke Lezon'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Imagem principal no topo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/header.png', fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),

            // Bloco com texto ao lado da imagem
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto inicial ao lado da imagem
                      Expanded(
                        child: Text(
                          'Luke Lezon is a pastor and author who is based in Orlando, Florida. Luke has a passion for preaching and living a bold and courageous life for the message of Jesus.',
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Imagem à direita
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Continuação do texto abaixo da imagem
                  const Text(
                    'Luke is the Lead Pastor of Lifebridge Church in Orlando, Florida.\n\n'
                    'Luke founded Quay, the young adult movement in Orlando, Florida which has reached thousands of young adults in Central Florida. Luke is a trusted voice, communicating all over the world at churches, conferences, and universities, known for being a creative, dynamic preacher of the Gospel of Jesus Christ.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
