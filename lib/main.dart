import 'package:arnioapp/ui/pages/home.page.dart';
import 'package:arnioapp/ui/pages/login.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arnio App',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: _auth.authStateChanges(), builder: (context, snapshot) {
        return snapshot.data == null ? const LoginPage() : const HomePage();
      }),
    );
  }
}

// import 'package:connexion_firebase_app/firebase_options.dart';
/*import 'package:arnioapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Connexion OTP Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController otpCode = TextEditingController();
  bool showLoading = false;
  bool isOtpInput = false;
  bool isConnected = false;
  String verificationId = '';
  @override
  void initState() {
    super.initState();
  }

  _connexion() async{
    setState(() {
      showLoading = true;
    });
    print('${phone.text}');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+225${phone.text}',
      verificationCompleted:(PhoneAuthCredential credential) {},
      verificationFailed:(FirebaseAuthException e) {
        setState(() {
          showLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e'), backgroundColor: Colors.red,)
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          showLoading = false;
          isOtpInput = true;
        });

        verificationId = verificationId;

      },
      codeAutoRetrievalTimeout:(String verificationId) {},
    );
  }

  _verifOtp() async{
    setState(() {
      showLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode.text
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      showLoading = false;
      isOtpInput = false;
      isConnected=true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:isConnected ? const  Text('Connected'): Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              isOtpInput==true?SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: otpCode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OTP Number',
                  ),
                ),
              ):const SizedBox(height: 0,),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: MaterialButton(
                    onPressed: isOtpInput==false? _connexion : _verifOtp,
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: showLoading?const CircularProgressIndicator(color: Colors.white,): const Text('Connexion', style: TextStyle(color:Colors.white,),)
                ),
              )
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
