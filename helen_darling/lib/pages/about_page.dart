import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/header.jpg'),
            Container(
              width: 350,
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                '''Helen Darling is a retired professional basketball player who made her mark in the WNBA as a skilled point guard and an inspiring leader both on and off the court. Born on August 29, 1978, in Columbus, Ohio, Helen's journey to basketball greatness began early, and her dedication to the game propelled her to become one of the most respected players of her generation.

                Darling played collegiate basketball at Penn State University, where she stood out for the Nittany Lions. At Penn State, she garnered several accolades for her performance, including being named the Big Ten Player of the Year in 2000. Her leadership and court vision helped guide her team to the NCAA Elite Eight that same year, solidifying her status as one of the premier players in women's college basketball.

                In 2000, the Cleveland Rockers selected Helen with the 17th overall pick in the first round of the WNBA Draft. Throughout her 10-year career in the league, she played for several teams, including the Rockers, Minnesota Lynx, Charlotte Sting, and San Antonio Silver Stars. Known for her defensive prowess, basketball IQ, and unselfish playmaking, Darling earned a reputation as a consistent and reliable point guard.

                Off the court, Helen demonstrated resilience and balance in her personal life. She became a mother to triplets while maintaining a professional basketball career—a feat that inspired many fans and fellow athletes alike. Her ability to excel in both motherhood and professional sports has made her a role model for women striving to achieve success in multiple arenas.

                Since retiring from the WNBA in 2010, Helen Darling has remained active in advocating for women's sports, mentoring young athletes, and championing education. She has worked as a motivational speaker and coach, using her platform to inspire the next generation of leaders.

                Helen Darling's legacy extends beyond her athletic achievements. She is celebrated as a trailblazer who showed that excellence, humility, and determination are the cornerstones of true greatness.
                ''',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9A9364),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            // outros widgets aqui
          ],
        ),
      ),
    );
  }
}
