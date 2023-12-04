import 'package:flutter/material.dart';
import 'package:pharmate/screens/signup_page.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage> {
  bool _isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ExcludeSemantics(child:SizedBox(height: 100),), 
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Accedi",
                  semanticsLabel: "Pagina di accesso",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const ExcludeSemantics(child: SizedBox(height: 50),),
              Semantics(label: "Inserisci ",
              textField: false,
              child: TextField(
                onTap: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                  controller: emailController,
                  decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                labelText: 'Email',
              )),
              ),
              const ExcludeSemantics(child:SizedBox(height: 16),), 
              Semantics(label: "Inserisci",
              child:TextField(
                onTap: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    labelText: 'Password',
                  )),
              ),
              const SizedBox(height: 20),
              Visibility(visible:_isVisible, child: const Text('Email o Password errata',style: TextStyle(color: Color(0xff023D74),fontWeight: FontWeight.bold),),),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff023D74),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    bool result = true;
                    if (result == true){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));}
                    else {
                      setState(() {
                        _isVisible = true;
                      });
                    }
                    // TODO: login
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Entra"),
                ),
              ),
              const SizedBox(height: 80),
              const ExcludeSemantics(child: 
                Text(
                "Primo accesso?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCAE6FF),
                  foregroundColor: const Color(0xFF023D74),
                ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpPage())),
                child: const Text("Registrati"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //TODO:Authentication method
  Future<bool> _login() async{
    return true; 
  }
}
