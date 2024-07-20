import 'dart:async';
import 'package:arnioapp/ui/pages/map.page.dart';
import 'package:arnioapp/ui/pages/recu.page.dart';
import 'package:arnioapp/widgets/custom.header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargePage extends StatefulWidget {
  const ChargePage({super.key});

  @override
  State<ChargePage> createState() => _ChargePageState();
}

class _ChargePageState extends State<ChargePage>
    with SingleTickerProviderStateMixin {
  double _progressValue = 0.0;
  Timer? _timer;

  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: const Color.fromRGBO(22, 255, 148, 1),
      end: Colors.grey,
    ).animate(_controller);

    // Simulation de remplissage de la barre de chargement avec un Timer
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue +=
              0.01; // Augmentez ce chiffre pour ajuster la vitesse de remplissage
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  double _progressValue1 = 0.0;
  Timer? _timer1;
  Color _containerColor =
      const Color(0xA64B4B4B); // Couleur de départ du Container

  void startFilling() {
    _timer1 = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progressValue1 < 1.0) {
          _progressValue1 += 0.01; // Augmentation progressive de la valeur
          _containerColor =
              Color.lerp(const Color(0xA64B4B4B), Colors.red, _progressValue1)!;
        } else {
          _timer1?.cancel();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RecuPage()),
          );
        }
      });
    });
  }

  void stopFilling() {
    _timer1?.cancel();
    setState(() {
      _progressValue1 = 0.0; // Réinitialisation de la progression
      _containerColor = Colors.red; // Réinitialisation de la couleur
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.png'), // Chemin de votre image
              fit: BoxFit
                  .cover, // Ajuste l'image pour couvrir tout l'arrière-plan
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomHeader(),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customAlignedContainer(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 220, left: 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/calque_4.png',
                            color: Colors.black,
                            height: 500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 200, left: 110),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            },
                            /*onVerticalDragUpdate: (details) {
                              if (details.primaryDelta! < -10) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const MapPage()),
                                );
                              }
                            },*/
                            child: Image.asset(
                              'assets/images/triangle_11.png',
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 650),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 250.0, // Définissez ici la largeur souhaitée
                        height: 30,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: _progressValue, // Sample progress value
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _animation.value!),
                              minHeight: 10,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 218,
                    left: 40,
                    child: Row(
                      children: [
                        GestureDetector(
                          onLongPress: startFilling,
                          onLongPressUp: stopFilling,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 90, // Largeur fixe
                            height: 40, // Hauteur fixe
                            decoration: BoxDecoration(
                              color: _containerColor,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                'ARRETEZ',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF000000),
                          ),
                          width: 4,
                          height: 40,
                          child: Container(
                            margin: const EdgeInsets.only(top: 100),
                            width: 8,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/unlock.png',
                          height: 24,
                          width: 26,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '22 Kw',
                              style: GoogleFonts.getFont(
                                'Inria Sans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(22, 255, 148, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(22, 255, 148, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(22, 255, 148, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(22, 255, 148, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(22, 255, 148, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(69, 68, 68, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(69, 68, 68, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Transform(
                              transform: Matrix4.skewX(
                                  -0.3), // Ajustez la valeur pour incliner plus ou moins
                              child: Container(
                                width: 7,
                                height: 18,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(),
                                  color: Color.fromRGBO(69, 68, 68, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '7 KWH',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '10 min',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 0, 0),
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
      ),
    );
  }

  Container customAlignedContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130, left: 18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 350, // Ajuster la hauteur si nécessaire
              child: Image.asset(
                'assets/images/GENERATION 2.294.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
