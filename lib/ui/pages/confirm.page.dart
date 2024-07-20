import 'dart:async';

import 'package:arnioapp/ui/pages/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage(
      {super.key, required this.verificationId, required this.phoneNumber});

  final String verificationId;
  final String phoneNumber;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final TextEditingController _otpController = TextEditingController();
  String smsCode = "";
  bool loading = false;
  bool resend = false;
  int count = 20;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decompte();
  }

  late Timer timer;
  void decompte() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (count < 1) {
        timer.cancel();
        count = 20;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(widget.phoneNumber, onCodeSend: (verificationId, v) {
      loading = false;
      decompte();
      setState(() {});
    }, onAutoVerify: (v) async {
      await _auth.signInWithCredential(v);
    }, onFailed: (e) {
      print("Le code est érroné");
    }, autoRetrieval: (v) {});
  }

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOtp(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print("Vérification éffectué avec succès");
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: const Color(0x30808080),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x66000000)),
    )
  );

  @override
  Widget build(BuildContext context) {
    print(widget.verificationId);
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Form(
          child: SingleChildScrollView(
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
                            image: AssetImage(
                                'assets/images/logo_blanc_copie_3.png'),
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
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SAISISSEZ LE CODE A 6 CHIFFRES ',
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
                          child: Pinput(
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                border: Border.all(color: const Color(0x30808080)),
                              ),
                            ),
                            onChanged: (value) {
                              smsCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: !resend ? null : onResendSmsCode,
                              child: Text(!resend
                                  ? "00:${count.toString().padLeft(2, "0")}"
                                  : "Renvoyer le code")),
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
                          onPressed: smsCode.length < 6 || loading
                              ? null
                              : onVerifySmsCode,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*Container(
                          height: 60,
                          width: 260,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0x66000000)),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0x30808080),
                          ),
                          child: Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _otpController,
                              keyboardType: TextInputType.phone,
                              /*validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrer un nom utilisateur';
                              }
                              return null;
                            },*/
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '+225 ',
                                    style: GoogleFonts.getFont(
                                      'Roboto Condensed',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: const Color(0x80000000),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                        ),
                          ),*/

/*GestureDetector(
                          onTap: smsCode.length < 6 || !loading? null : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment(-1, 0),
                                end: Alignment(1, 0),
                                colors: <Color>[
                                  Color(0xFF405663),
                                  Color(0xFF202A31)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            child: Container(
                              width: 145,
                              padding:
                                  const EdgeInsets.fromLTRB(0, 11, 2.3, 13),
                              child: Text(
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
                        ),*/
