import 'package:arnioapp/ui/pages/confirm.page.dart';
import 'package:arnioapp/ui/pages/functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool loading = false;
  String phoneNumber = '';
  void sendOtpCode() {
    loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(phoneNumber, onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ConfirmPage(
                    verificationId: verificationId,
                phoneNumber: phoneNumber,
                  )),
        );
      }, onAutoVerify: (v) async {
        await auth.signInWithCredential(v);
      }, onFailed: (e) {
        print("Le code est érroné");
      }, autoRetrieval: (v) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3F5460), // Début du dégradé
                Color(0xFF131B1E), // Fin du dégradé
              ],
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/logo_blanc_copie_3.png'),
                      ),
                    ),
                    width: 300,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ), // Espacement entre le logo et le container blanc
              Container(
                width: 500,
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ENTRER VOS COORDONNÉES',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Roboto Condensed',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 260,
                        decoration: BoxDecoration(
                          color: const Color(0x30808080),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0x66000000)),
                        ),
                        child: Center(
                          child: IntlPhoneField(
                            initialCountryCode: "CI",
                            onChanged: (value) {
                              phoneNumber = value.completeNumber;
                              print(value.completeNumber);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                              hintText: "Numéro de téléphone",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.transparent, // This makes the button's background transparent
                        shadowColor: Colors.transparent, // This removes the button's shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: loading ? null : sendOtpCode,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1, 0),
                            end: Alignment(1, 0),
                            colors: <Color>[
                              Color(0xFF405663),
                              Color(0xFF202A31)
                            ],
                            stops: <double>[0, 1],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 145,
                          padding: const EdgeInsets.fromLTRB(0, 11, 2.3, 13),
                          child: loading
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                              : Text(
                            'Valider',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Roboto Condensed',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Ajoutez ici le contenu supplémentaire du container blanc
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
