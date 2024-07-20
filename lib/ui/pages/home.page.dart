// ignore_for_file: unused_field

import 'dart:async';
import 'package:arnioapp/ui/pages/charge.page.dart';
import 'package:arnioapp/ui/pages/functions.dart';
import 'package:arnioapp/ui/pages/map.page.dart';
import 'package:arnioapp/widgets/custom.header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  /*final List<String> scannedQRCodes;*/

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  bool _hasFailed = false;
  bool _isBluetoothConnecting = false;
  bool _isBluetoothConnected = false;

  String qrResult = '';
  IconData? qrIcon;

  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? _connectedDevice;

  List<Color> containerColors = [
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
    const Color.fromRGBO(69, 68, 68, 1),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _handleLancerClick() {
    setState(() {
      _isLoading = true;
      _hasFailed = false;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        _hasFailed = true;
        qrResult =
            "Chargeur Arnio non détecté.\nVeuillez connecter un chargeur Arnio";
        qrIcon = Icons.warning_sharp;
      });
    });
  }

  void _handleBluetoothClick() async {
    setState(() {
      _isBluetoothConnecting = true;
      _isBluetoothConnected = false;

      // Reset container colors to grey
      for (int i = 0; i < containerColors.length; i++) {
        containerColors[i] = const Color.fromRGBO(69, 68, 68, 1);
      }
    });

    try {
      StreamSubscription? scanSubscription;
      scanSubscription = flutterBlue
          .scan(timeout: const Duration(seconds: 5))
          .listen((scanResult) {
        if (scanResult.device.name.startsWith('NBPower')) {
          scanSubscription?.cancel(); // Stop scanning
          _connectToDevice(scanResult.device);
        }
      });

      await Future.delayed(const Duration(seconds: 5));
      if (_connectedDevice == null) {
        setState(() {
          _isBluetoothConnecting = false;
          _isBluetoothConnected = false;
          qrResult =
              "Chargeur Arnio non détecté.\nVeuillez connecter un chargeur Arnio1";
          qrIcon = Icons.warning_sharp;

          /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChargePage(),
            ),
            (Route<dynamic> route) => false,
          );*/
        });
      }
    } catch (e) {
      setState(() {
        _isBluetoothConnecting = false;
        _isBluetoothConnected = false;
        qrResult = "Erreur de connexion Bluetooth.";
        qrIcon = Icons.error;
      });
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      _connectedDevice = device;
      _isBluetoothConnecting = false;
      _isBluetoothConnected = true;
      qrResult = 'Chargeur Arnio connecté';
      qrIcon = Icons.looks;

      // Change the first four container colors to green
      for (int i = 0; i < 4; i++) {
        containerColors[i] = const Color.fromRGBO(22, 255, 148, 1);
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const ChargePage(),
        ),
        (Route<dynamic> route) => false,
      );
    });

    // Découvrir les services
    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString().startsWith("FFE0")) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString().startsWith("FFE1")) {
            // Obtenir le characteristic
            startHeartbeat(characteristic);
          }
        }
      }
    }
  }

  void startHeartbeat(BluetoothCharacteristic characteristic) {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      var response = await characteristic.write([0x31, 0x08]);
      // Traiter la réponse du battement de cœur
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.png'),
              fit: BoxFit.cover,
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
                    child:
                        customAlignedContainer(_isLoading, _handleLancerClick),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 350, left: 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/Calque 4exp.png',
                            height: 270,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, left: 90),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            },
                            child: Image.asset(
                              'assets/images/triangle_11.png',
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (qrIcon != null)
                          Icon(qrIcon,
                              color: qrIcon == Icons.warning_sharp
                                  ? const Color(0xFFFF1100)
                                  : Colors.green,
                              size: 30),
                        const SizedBox(height: 15),
                        Text(qrResult),
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

  Container customAlignedContainer(bool isLoading, VoidCallback onLancerClick) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0.5),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //margin: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF000000),
                          ),
                          width: 2,
                          height: 100,
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

                        /** LANCEMENT ET DRAPEAU */
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: GestureDetector(
                            onTap: _handleLancerClick,
                            child: Container(
                              width: 120,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xA64B4B4B),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.black,
                                              backgroundColor: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'En cours ...',
                                            style: GoogleFonts.getFont(
                                              'Inria Sans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ),
                                          ),
                                        ],
                                      )
                                    : _hasFailed
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: SvgPicture.asset(
                                                  'assets/vectors/vector_44_x2.svg',
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Échec',
                                                style: GoogleFonts.getFont(
                                                  'Inria Sans',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            'LANCER',
                                            style: GoogleFonts.getFont(
                                              'Inria Sans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: const Color(0xBA000000),
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 0),
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.lock,
                                color: Colors.black,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    '22 Kw',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  for (int i = 0;
                                      i < containerColors.length;
                                      i++)
                                    Transform(
                                      transform: Matrix4.skewX(-0.3),
                                      child: Container(
                                        width: 7,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.vertical(),
                                          color: containerColors[i],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _handleBluetoothClick,
                                    child: Center(
                                      child: _isBluetoothConnecting
                                          ? const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.black,
                                              backgroundColor: Colors.grey,
                                            )
                                          : Icon(
                                              _isBluetoothConnected
                                                  ? Icons.bluetooth_connected
                                                  : Icons.bluetooth,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.qr_code_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 245,
                                child: SizedBox(
                                  width: 160,
                                  height: 280,
                                  child: Image.asset(
                                      'assets/images/generation_2289.png'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 140,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
            color: const Color(0xFF000000),
            width: 1,
            height: 80,
          ),
           Column(
            children: [
              Text(user?.phoneNumber??"",
                style: const TextStyle(
                  fontFamily: 'Inria Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              const Text(
                '15.000 FCFA',
                style: TextStyle(
                  fontFamily: 'Inria Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
        ],
      ),
      leading: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/arvnio.png'),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo_blanc_copie_2.png'),
              ),
            ),
            width: 50,
            height: 79,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: () async{
            await disconnect();
          }, icon: const Icon(Icons.logout_rounded, size: 30,)),
        )
      ],
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox(height: 115),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Ajoutez de l'argent",
                  style: TextStyle(
                    fontFamily: 'Inria Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(width: 4.5),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
