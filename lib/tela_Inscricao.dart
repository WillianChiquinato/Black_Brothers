import 'package:flutter/material.dart';

class TelaInscricao extends StatefulWidget {
  const TelaInscricao({Key? key}) : super(key: key);

  @override
  State<TelaInscricao> createState() => _TelaInscricaoState();
}

class _TelaInscricaoState extends State<TelaInscricao> {
  final TextEditingController usuarioInscricao = TextEditingController();
  final TextEditingController emailInscricao = TextEditingController();
  final TextEditingController cpfInscricao = TextEditingController();
  final TextEditingController dtnascInscricao = TextEditingController();
  final TextEditingController tellInscricao = TextEditingController();
  final TextEditingController senhaInscricao = TextEditingController();
  bool IsChecked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          title: const Text(''),
          backgroundColor: const Color.fromARGB(255, 168, 88, 9),
        ),
        body: Center(
          child: Container(
              color: const Color.fromARGB(255, 168, 88, 9),
              child: ListView(scrollDirection: Axis.vertical, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Container(
                    color: Colors.transparent,
                    height: 100,
                    width: 200,
                    child: Image.asset(
                      'Assets/Black_Brother.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira um nome de usuário válido';
                        }
                        return null;
                      },
                      controller: usuarioInscricao,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'Usuário',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira um e-mail válido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailInscricao,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'E-mail',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira um CPF válido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: cpfInscricao,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'CPF',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira uma data válida';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.datetime,
                      controller: dtnascInscricao,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'Data de nascimento',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira um telefone válido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: tellInscricao,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'Telefone',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira uma senha válida';
                        }
                        return null;
                      },
                      controller: senhaInscricao,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'Senha',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    child: Row(
                      children: [
                        Checkbox(
                            value: IsChecked,
                            onChanged: (bool? newvalue) {
                              setState(() {
                                IsChecked = newvalue ?? false;
                              });
                            }),
                        const Text(
                          'Termos e Condições',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(200, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 75, 174, 79),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(usuarioInscricao.text);
                              print(emailInscricao.text);
                              print(cpfInscricao.text);
                              print(dtnascInscricao.text);
                              print(tellInscricao.text);
                              print(senhaInscricao.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Inscrição realizada com sucesso!'),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'INSCREVER-SE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 168, 88, 9),
                            elevation: 0,
                          ),
                          onPressed: () {
                            print("cu");
                          },
                          child: const Text(
                            'VOLTAR',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ])),
        ),
      ),
    );
  }
}
