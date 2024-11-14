import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/Telas/tela_planos.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'BlackBrothers'),
      child: Form(
          key: _formKey,
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                backgroundColor: const Color.fromARGB(255, 143, 82, 25),
              ),
              body: Center(
                  child: Container(
                      color: const Color.fromARGB(255, 143, 82, 25),
                      child:
                          ListView(scrollDirection: Axis.vertical, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 25),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um nome de usuário válido';
                                } else if (value.length < 5) {
                                  return 'Usuario precisa ter o minimo 5 caracteres';
                                }
                                return null;
                              },
                              controller: usuarioInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'USUÁRIO',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style: const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um e-mail válido';
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Insira o email completo [@, .com]';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: emailInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'E-MAIL',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style: const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um CPF válido';
                                } else if (!RegExp(r'^\d{11}$')
                                    .hasMatch(value)) {
                                  return 'CPF precisa conter 11 caracteres';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              controller: cpfInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'CPF',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style: const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira uma data válida';
                                } else if (!RegExp(r'^\d{2}/\d{2}/\d{4}$')
                                    .hasMatch(value)) {
                                  return 'A data precisa estar correta';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              controller: dtnascInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'DATA DE NASCIMENTO',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style: const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um telefone válido';
                                } else if (!RegExp(r'^\d{11}$')
                                    .hasMatch(value)) {
                                  return 'O telefone deve conter exatamente 11 dígitos';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              controller: tellInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'TELEFONE (DDD)',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style: const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira uma senha válida';
                                } else if (value.length < 8) {
                                  return 'A senha deve conter no minimo 8 caracteres';
                                }
                                return null;
                              },
                              controller: senhaInscricao,
                              obscureText: true,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: 'SENHA',
                                hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'PadraoLoginBB',
                                ),
                                fillColor: Colors.white70,
                                filled: true,
                              ),
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: IsChecked,
                                    onChanged: (bool? newvalue) {
                                      setState(() {
                                        IsChecked = newvalue ?? false;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Termos e ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Condições',
                                            style: TextStyle(
                                              color: Colors.blue[200],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final Uri url = Uri.parse(
                                                    'https://www.jusbrasil.com.br/artigos/o-que-sao-termos-de-condicoes/1569717144');
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                } else {
                                                  throw 'Não foi possível acessar o site';
                                                }
                                              }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, right: 100),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minimumSize: const Size(200, 40),
                                          backgroundColor: const Color.fromARGB(
                                              255, 75, 174, 79),
                                        ),
                                        onPressed: IsChecked
                                            ? () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  print(usuarioInscricao.text);
                                                  print(emailInscricao.text);
                                                  print(cpfInscricao.text);
                                                  print(dtnascInscricao.text);
                                                  print(tellInscricao.text);
                                                  print(senhaInscricao.text);

                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  // Feito para a tela de planos.
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TelaPlanos(
                                                                valorUser:
                                                                    usuarioInscricao
                                                                        .text,
                                                                senhaUser:
                                                                    senhaInscricao
                                                                        .text,
                                                              )));
                                                }
                                              }
                                            : null,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]))))),
    );
  }
}
