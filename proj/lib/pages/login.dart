import 'package:flutter/material.dart';
import 'package:proj/data/db.dart';
import 'package:proj/pages/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List _data = [];

  void createSutent() async {
    final user = await Db.createStudent(
      usernameController.text,
      usernameController.text,
      passwordController.text,
      'Ma descrption',
    );

    setState(() {
      _data = [user];
    });

    debugPrint(_data.toString());
  }

  void getStudent(String email, String password) async {
    final user = await Db.auth(email, password);
    setState(() {
      _data = user;
    });

    debugPrint(_data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fasi Network'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Authentification',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white54))
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(30),
                        topLeft: Radius.circular(200))),
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  color: Colors.indigo.withOpacity(.2),
                                  spreadRadius: 5,
                                  blurRadius: 10)
                            ]),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            return (value!.isEmpty)
                                ? "Ce champ est requis"
                                : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Email', border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  color: Colors.indigo.withOpacity(.2),
                                  spreadRadius: 5,
                                  blurRadius: 10)
                            ]),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            return (value!.isEmpty)
                                ? "Ce champ est requis"
                                : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Mot de passe',
                              border: InputBorder.none),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('Mot de passe oublié?')),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final username = usernameController.text;
                            final password = passwordController.text;

                            getStudent(username, password);

                            if (_data.isNotEmpty) {
                              setState(() {
                                _data = [];
                              });
                              passwordController.text = '';

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Center(
                                    child: Text('Identifiants incorrect!')),
                                backgroundColor: Colors.red,
                              ));
                              debugPrint("Identifiants incorrect");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15)),
                        child: const Text('Connexion'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pas de compte?"),
                          TextButton(
                              onPressed: () {},
                              child: const Text('Créez-en un'))
                        ],
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
