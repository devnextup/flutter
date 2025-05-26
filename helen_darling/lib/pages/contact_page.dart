import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ContactPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              child: const Text(
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                Sed ut nisl pellentesque turpis imperdiet venenatis. Aliquam eget dui quis 
                diam eleifend pretium sit amet ac nisl. In mollis nec justo mollis fringilla. 
                Vestibulum suscipit molestie lacinia. Vivamus egestas rhoncus orci, a facilisis
                dolor sollicitudin sed. Vestibulum ullamcorper ex nisl, et gravida ipsum
                aliquet ac. Etiam ultricies arcu pharetra leo gravida dignissim id id odio. 
                Nulla tristique quam at tellus varius, at varius leo viverra.''',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9A9364),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
