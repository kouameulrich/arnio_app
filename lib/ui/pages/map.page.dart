import 'dart:async';
import 'package:arnioapp/ui/pages/home.page.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationData? _currentLocation;
  static late CameraPosition _initialCameraPosition;
  final List<Marker> _markers = [];
  final List<LatLng> _latlng = [
    const LatLng(5.30966, -4.01266),
    const LatLng(5.3397027, -4.0956554),
    const LatLng(5.339331424660638, -4.100910735227834),
    const LatLng(5.338018898934557, -4.100618031229435),
    const LatLng(5.298311202176426, -4.007854259929566),
    // Ajoutez plus de positions ici
  ];

  final TextEditingController _searchController = TextEditingController();
  final List<String> _locations = [
    'DEUX PLATEAU AGHEIN',
    'Autre lieu 1',
    'Autre lieu 2',
    'Autre lieu 3',
    'Autre lieu 4',
  ];
  List<String> _filteredLocations = [];
  bool _showFilteredList = false;

  @override
  void initState() {
    super.initState();
    loadData();
    _searchController.addListener(() {
      setState(() {
        _filteredLocations = _locations
            .where((location) => location
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  loadData() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size:
              Size(60, 60)), // Vous pouvez ajuster la taille selon vos besoins
      'assets/images/rectangle_5_copie_416.png', // Assurez-vous que l'image existe dans votre dossier assets
    );

    for (var i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(_latlng[i].toString()),
          icon: customIcon,
          position: _latlng[i],
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(),
                      border: Border.all(color: Colors.white),
                      color: const Color(0xA64B4B4B),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DEUX PLATEAU AGHEIN',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Text(
                                'ARNIO CHARGEUR',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '22KW',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 201, 11, 11),
                                    ),
                                  ),
                                  Text(
                                    ' Puissance',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Connecteur GBT AC',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '100 F',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 201, 11, 11),
                                    ),
                                  ),
                                  Text(
                                    '/ Min',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Statut :',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                  Text(
                                    'Libre',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color:
                                          const Color.fromRGBO(22, 255, 148, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/images/logo_blanc_copie_3.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 300,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(),
                      border: Border.all(color: Colors.white),
                      color: const Color(0xA64B4B4B),
                    ),
                    child: Text(
                      'ALLEZ VERS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  )
                ],
              ),
              _latlng[i],
            );
          },
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _showFilteredList = false;
          });
        },
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(5.3476492, -4.0890146), zoom: 15),
              markers: Set<Marker>.of(_markers),
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 190, // Ajustez la hauteur ici selon vos besoins
              width: 300, // Ajustez la largeur ici selon vos besoins
              offset: 10,
            ),
            const Positioned(
              top: 16.0,
              right: 16.0,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/arvnio.png'), // Remplacez par votre image
                radius: 40.0, // Ajustez la taille selon vos besoins
              ),
            ),
            Positioned(
              top: 26.0,
              left: 26.0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  if (_showFilteredList)
                    Container(
                      color: const Color.fromRGBO(77, 77, 77, 0.8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredLocations.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _filteredLocations[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _showFilteredList = false;
                                _searchController.text =
                                    _filteredLocations[index];
                              });
                              // Ajoutez une action ici si nécessaire
                            },
                          );
                        },
                      ),
                    ),
                  TextFormField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color.fromRGBO(77, 77, 77, 0.81),
                      prefixIcon: Image.asset(
                        'assets/images/Frame.png', // Remplacez par le chemin de votre image
                        width: 40,
                        height: 40,
                      ),
                      suffixIcon: Image.asset(
                        'assets/images/setting.png', // Remplacez par le chemin de votre image
                        width: 40,
                        height: 40,
                      ),
                    ),
                    cursorColor: Colors.white,
                    onTap: () {
                      setState(() {
                        _showFilteredList = true;
                      });
                    },
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
