import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/API/models/modelo_pessoa.dart';
import 'package:projetosflutter/API/models/modelo_telefone.dart';
import '../API/models/modelo_usuario.dart';
import 'package:projetosflutter/Telas/tela_planos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../API/controller.dart';
import '../Components/ToastMessage.dart';
import '../Util/FormatItens.dart';

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

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  @override
  void initState() {
    super.initState();

    cpfInscricao.addListener(() {
      final textCPF = cpfInscricao.text;
      final formatted = FormatUtil.formatCpfInput(textCPF);

      if (formatted != textCPF) {
        cpfInscricao.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });

    dtnascInscricao.addListener(() {
      final textDataNasc = dtnascInscricao.text;
      final formatted = FormatUtil.formatDateInput(textDataNasc);

      if (formatted != textDataNasc) {
        dtnascInscricao.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });

    tellInscricao.addListener(() {
      final textTell = tellInscricao.text;
      final formatted = FormatUtil.formatTellInput(textTell);

      if (formatted != textTell) {
        tellInscricao.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  // função para abrir a URL do termos e condicoes
  Future<void> _launchURL() async {
    const String urlString = 'https://www.google.com.br/'; // link URL (a definir)
    final Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showToast(context, 'Não foi possível acessar os Termos e Condições.', type: ToastType.error);
      throw 'Não foi possível acessar $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'BlackBrothers'),
      child: Form(
          key: _formKey,
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                backgroundColor: grey,
              ),
              body: Center(
                  child: Container(
                      color: grey,
                      child:
                          ListView(scrollDirection: Axis.vertical, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 25),
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'Assets/logo-bb.png',
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
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Usuário',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'E-mail',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um CPF válido';
                                }

                                // lógica para permitir o ponto e hífen
                                final cleanValue = value.replaceAll(RegExp(r'\D'), '');

                                if (!RegExp(r'^\d{11}$').hasMatch(cleanValue)) {
                                  return 'CPF precisa conter 11 números';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.number,
                              controller: cpfInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'CPF',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
                              controller: dtnascInscricao,
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
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Data de nascimento',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
                                if (value == null || value.isEmpty) {
                                  return 'Insira um telefone válido';
                                } else if (!RegExp(r'^\(\d{2}\)\d{4,5}-\d{4}$')
                                    .hasMatch(value)) {
                                  return 'O telefone deve conter exatamente (DDD)XXXXX-XXXX';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              controller: tellInscricao,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Telefone (DDD)',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Senha',
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.black45,
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
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
                                    side:
                                        const BorderSide(color: Colors.white70),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Termos e ',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Condições',
                                            style: TextStyle(
                                              color: Colors.blue[200],
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = _launchURL,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
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
                                                  BorderRadius.circular(15)),
                                          minimumSize: const Size(500, 60),
                                          backgroundColor: Colors.green,
                                          disabledBackgroundColor: orange,
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

                                                  showToast(context, "Dados Enviados!", type: ToastType.success);
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            TelaPlanos(
                                                          dtNascUser:
                                                              dtnascInscricao
                                                                  .text
                                                                  .trim(),
                                                          cpfUser: cpfInscricao
                                                              .text
                                                              .trim(),
                                                          nomeUser:
                                                              usuarioInscricao
                                                                  .text
                                                                  .trim(),
                                                          senhaUser:
                                                              senhaInscricao
                                                                  .text
                                                                  .trim(),
                                                          tellUser:
                                                              tellInscricao.text
                                                                  .trim(),
                                                          emailUser:
                                                              emailInscricao
                                                                  .text
                                                                  .trim(),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                }
                                              }
                                            : null,
                                        child: const Text(
                                          'INSCREVER-SE',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
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
