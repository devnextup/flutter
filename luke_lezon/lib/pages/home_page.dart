import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
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
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Idioma clicado');
                        },
                        child: const Icon(
                          Icons.language,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Compartilhar clicado');
                        },
                        child: const Icon(
                          Icons.share,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Espaço maior entre ícones e imagem principal
                const SizedBox(height: 280),

                // Imagem principal
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

                // Espaço menor entre imagem e botões
                const SizedBox(height: 20),

                // Três botões com imagem e texto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/about_luke.png',
                        onTap: () {
                          print('About Luke');
                        },
                      ),
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/books_button.png',
                        onTap: () {
                          print('Books');
                        },
                      ),
                      _ImageButton(
                        label: "",
                        imageAsset: 'assets/messages_button.png',
                        onTap: () {
                          print('Messages');
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
