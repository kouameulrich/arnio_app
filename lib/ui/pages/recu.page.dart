import 'package:arnioapp/ui/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecuPage extends StatefulWidget {
  const RecuPage({super.key});

  @override
  State<RecuPage> createState() => _RecuPageState();
}

class _RecuPageState extends State<RecuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(19, 0, 0, 22),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'assets/images/Check Mark.png',
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 96,
                  height: 96,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(19, 0, 0, 62),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x26D9D9D9),
                ),
                child: Container(
                  width: 260,
                  padding: const EdgeInsets.fromLTRB(0, 9, 8.4, 10),
                  child: Text(
                    'Référence : 1234567890',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(18.2, 0, 0, 14),
              child: Text(
                '2.000 fcfa',
                style: GoogleFonts.getFont(
                  'Roboto Condensed',
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 11),
              child: Text(
                'Mercredi 10 novembre 2023',
                style: GoogleFonts.getFont(
                  'Roboto Condensed',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(3, 0, 0, 31),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: const SizedBox(
                  width: 154,
                  height: 2,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(180, 0, 0, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/Clock.png',
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        width: 24,
                        height: 23,
                      ),
                    ),
                  ),
                  Text(
                    '17h',
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 13),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                    child: const SizedBox(
                      width: 347,
                      height: 4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 29),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x26D9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                                width: 60,
                                height: 40,
                                child: Positioned(
                                  right: 0,
                                  bottom: -5.2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/logo_blanc_copie_2.png',
                                        ),
                                      ),
                                    ),
                                    child: const SizedBox(
                                      width: 59,
                                      height: 32.2,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 6, 50, 0),
                                child: Text(
                                  'Arnio chargeur \nCocody vallon',
                                  style: GoogleFonts.getFont(
                                    'Roboto Condensed',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 2.1, 91),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Puissance',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0x59000000),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'temps',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0x59000000),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Déduction',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0x59000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(1, 0, 1.6, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '22 KW/h',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '10 min',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '-2000 FCFA',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    height: 1.3,
                                    color: const Color(0xFFCA2222),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 2, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 9, 0, 8),
                          child: SizedBox(
                            width: 86,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                  child: SizedBox(
                                    width: 32,
                                    height: 31,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.save_alt_rounded)),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                  height: 31,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.upload_rounded)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Naviguer vers la nouvelle page lorsque l'utilisateur appuie sur le texte
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D99FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 185,
                              padding:
                                  const EdgeInsets.fromLTRB(19, 13, 19, 12),
                              child: Text(
                                'Retour a l’accueil ',
                                style: GoogleFonts.getFont(
                                  'Roboto Condensed',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
