import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/API/models/modelo_pessoa.dart';
import 'package:projetosflutter/Telas/tela_planos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../API/controller.dart';
import '../API/models/modelo_usuario.dart';

class TelaInscricao extends StatefulWidget {
  const TelaInscricao({Key? key}) : super(key: key);

  @override
  State<TelaInscricao> createState() => _TelaInscricaoState();
}

class _TelaInscricaoState extends State<TelaInscricao> {
  late GenericController<PessoaClass> _pessoaController;
  late List<PessoaClass> pessoa = [];

  late GenericController<UsuarioClass> _usuarioController;
  late List<UsuarioClass> usuario = [];

  final TextEditingController usuarioInscricao = TextEditingController();
  final TextEditingController emailInscricao = TextEditingController();
  final TextEditingController cpfInscricao = TextEditingController();
  final TextEditingController dtnascInscricao = TextEditingController();
  final TextEditingController tellInscricao = TextEditingController();
  final TextEditingController senhaInscricao = TextEditingController();
  bool IsChecked = false;

  @override
  void initState() {
    super.initState();
    _pessoaController = GenericController(
      endpoint: 'Pessoa',
      fromJson: (json) => PessoaClass.fromJson(json),
    );

    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );

    cpfInscricao.addListener(() {
      final textCPF = cpfInscricao.text;
      String cleanText = textCPF.replaceAll(RegExp(r'\D'), '');

      if (cleanText.length > 0) {
        if (cleanText.length > 11) {
          // Limita o tamanho máximo a 12 caracteres com o formato completo
          cleanText = cleanText.substring(0, 11);
        }
      }

      if (cleanText != textCPF) {
        cpfInscricao.value = TextEditingValue(
          text: cleanText,
          selection: TextSelection.collapsed(offset: cleanText.length),
        );
      }
    });

    dtnascInscricao.addListener(() {
      final textDataNasc = dtnascInscricao.text;

      String cleanText = textDataNasc.replaceAll(RegExp(r'\D'), '');

      if (cleanText.length > 0) {
        if (cleanText.length > 2) {
          cleanText = '${cleanText.substring(0, 2)}/${cleanText.substring(2)}';
        }
        if (cleanText.length > 5) {
          cleanText = '${cleanText.substring(0, 5)}/${cleanText.substring(5)}';
        }
        if (cleanText.length > 10) {
          // Limita o tamanho máximo a 10 caracteres com o formato completo
          cleanText = cleanText.substring(0, 10);
        }
      }

      if (cleanText != textDataNasc) {
        dtnascInscricao.value = TextEditingValue(
          text: cleanText,
          selection: TextSelection.collapsed(offset: cleanText.length),
        );
      }
    });

    tellInscricao.addListener(() {
      final textTell = tellInscricao.text;

      String cleanText = textTell.replaceAll(RegExp(r'\D'), '');

      if (cleanText.length > 0) {
        cleanText = '(' + cleanText;
        if (cleanText.length > 3) {
          cleanText = '${cleanText.substring(0, 3)})${cleanText.substring(3)}';
        }
        if (cleanText.length > 9) {
          cleanText = '${cleanText.substring(0, 9)}-${cleanText.substring(9)}';
        }
        if (cleanText.length > 14) {
          // Limita o tamanho máximo a 14 caracteres com o formato completo
          cleanText = cleanText.substring(0, 14);
        }
      }

      if (cleanText != textTell) {
        tellInscricao.value = TextEditingValue(
          text: cleanText,
          selection: TextSelection.collapsed(offset: cleanText.length),
        );
      }
    });
  }

  //Criar usuário.
  Future<void> _criarPessoa() async {
    String? dataFormatada;

    try {
      // Converte de dd/MM/yyyy para yyyy-MM-dd
      DateTime data =
          DateFormat('dd/MM/yyyy').parse(dtnascInscricao.text.trim());
      dataFormatada = DateFormat('yyyy-MM-dd').format(data);
    } catch (e) {
      print('Erro ao formatar a data: $e');
      return;
    }

    Map<String, dynamic> data = {
      'CPF': cpfInscricao.text.trim(),
      'Nome': usuarioInscricao.text.trim(),
      'Email': emailInscricao.text.trim(),
      'DtNasc': dataFormatada,
      'FK_Academia_ID': '12345678000100'
    };

    print('Dados enviados: $data');

    var resultado = await _pessoaController.create(data);
    if (resultado != null) {
      setState(() {
        pessoa = [resultado];
      });

      final pessoaId = resultado.CPF!;
      await _criarUsuario(pessoaId);

      print('Pessoa criada com sucesso!!');
    } else {
      print('Usuario com esse CPF cadastrado');
    }
  }

  //Apos o cadastro ja pega o login tambem.
  Future<void> _criarUsuario(String pessoaId) async {
    Map<String, dynamic> usuarioData = {
      'Login': usuarioInscricao.text.trim(),
      'Senha': senhaInscricao.text.trim(),
      'FK_Pessoa_ID': pessoaId,
    };

    var resultado = await _usuarioController.create(usuarioData);
    if (resultado != null) {
      print('Usuário criado com sucesso!');
      // Vá para a tela de planos e passe o ID do usuário
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaPlanos(usuarioId: resultado.id!),
        ),
      );
    } else {
      print('Erro ao criar usuário');
    }
  }

  //Update Pessoa.
  Future<void> _updatePessoa() async {
    Map<String, dynamic> novosDados = {
      'CPF': '232253463',
    };

    var resultado = await _pessoaController.update('0', novosDados);

    if (resultado != null) {
      setState(() {
        pessoa = [resultado];
      });
      print("Pessoa atualizada");
    } else {
      print("Erro ao atualizar pessoa");
    }
  }

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
                backgroundColor: const Color.fromARGB(255, 210, 125, 43),
              ),
              body: Center(
                  child: Container(
                      color: const Color.fromARGB(255, 210, 125, 43),
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
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                                  return 'CPF precisa conter 11 numeros';
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
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
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
                              style:
                                  const TextStyle(fontFamily: 'PadraoLoginBB'),
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

                                                  final cpfInput =
                                                      cpfInscricao.text.trim();

                                                  if (cpfInput.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Preencha todos os dados'),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ),
                                                    );
                                                    return;
                                                  } else {
                                                    await _criarPessoa();
                                                  }
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
