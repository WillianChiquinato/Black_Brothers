import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/Models/modelo_feedback.dart';
import 'package:projetosflutter/API/Models/modelo_tipoFeedback.dart';
import 'package:projetosflutter/API/Models/modelo_videos.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'menu_treino.dart';

import '../API/controller.dart';
import '../API/models/modelo_tipoPlano.dart';
import '../Components/ToastMessage.dart';

class MenuInicialHome extends StatefulWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuInicialHome({super.key, this.user, this.plan});

  @override
  State<MenuInicialHome> createState() => _MenuInicialHomeState();
}

class _MenuInicialHomeState extends State<MenuInicialHome> {
  late GenericController<UsuarioClass> _usuarioController;
  late GenericController<VideosClass> _videoController;
  late GenericController<FeedbackClass> _feedbackController;
  late GenericController<TipoFeedbackClass> _tipoFeedBackController;
  late UsuarioClass? usuario;
  late TipoPlanoClass? plano;
  late List<FeedbackClass> feedbacks;
  late TipoFeedbackClass? tipoFeedbacks;
  late Future<List<VideosClass>> videos;

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  final List<Map<String, dynamic>> topicos = [
    {'id': 1, 'nome': 'EQUIPAMENTO'},
    {'id': 2, 'nome': 'INFRAESTRUTURA'},
    {'id': 3, 'nome': 'PROFESSORES'},
    {'id': 4, 'nome': 'ATENDIMENTO'},
    {'id': 5, 'nome': 'FAQ'},
  ];

  late final Map<int, TextEditingController> controllers;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();

    usuario = widget.user;
    plano = widget.plan;
    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );

    _videoController = GenericController<VideosClass>(
      endpoint: 'Videos',
      fromJson: (json) => VideosClass.fromJson(json),
    );

    _feedbackController = GenericController<FeedbackClass>(
      endpoint: 'Feedbacks',
      fromJson: (json) => FeedbackClass.fromJson(json),
    );

    _tipoFeedBackController = GenericController<TipoFeedbackClass>(
      endpoint: 'Tipo_Feedbacks',
      fromJson: (json) => TipoFeedbackClass.fromJson(json),
    );

    videos = carregarRandomVideos();
    controllers = {for (var t in topicos) t['id']: TextEditingController()};
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<List<VideosClass>> carregarRandomVideos() async {
    final videosRequest = await _videoController.getAll();
    if (videosRequest == null || videosRequest.isEmpty) return [];

    final random = Random();
    final List shuffled = List.from(videosRequest)..shuffle(random);
    final List randomVideos = shuffled.take(3).toList();

    return randomVideos.cast<VideosClass>();
  }

  Future<void> _criarFeedback(int TopicoID, String Mensagem) async {
    var resultadoTipoFeedback =
    await _tipoFeedBackController.getOne(TopicoID.toString());
    if (resultadoTipoFeedback != null) {
      Map<String, dynamic> data = {
        'Mensagem': Mensagem,
        'FK_TipoFeedbacks_ID': TopicoID,
      };

      var resultadoFeedback = await _feedbackController.create(data);

      if (resultadoFeedback != null) {
        setState(() {
          feedbacks = [resultadoFeedback];
        });

        print('Feedback criado com sucesso!!');
      } else {
        print('Feedback deu errado!!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('Assets/logo-bb.png', height: 40, width: 40),
            const SizedBox(width: 8),
            Text(
              "Black Brothers",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: grey),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    'Opções',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text('Nutricionista', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: Text('Consultar Dieta', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: Text('Treinos', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: Text('Eventos', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Configurações', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('Sair', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("Assets/UserIcon.png"),
                  radius: 25,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${plano?.nomePlano}',
                      style: GoogleFonts.poppins(
                        color: orange,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${usuario?.login}',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.show_chart, color: Colors.orange),
              label: Text(
                "VER MEU DESENVOLVIMENTO NA REDE “MIX-BROTHERS”",
                style: GoogleFonts.poppins(
                  color: orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: lightOrange,
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Text("MEU TREINO",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PROGRESSO\n25%", style: GoogleFonts.poppins()),
                Text("Data Treino:\n30/03 - 30/09",
                    style: GoogleFonts.poppins()),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.25,
              backgroundColor: lightOrange,
              color: orange,
              minHeight: 10,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuTreino(user: usuario, plan: plano,),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.fitness_center_rounded,
                    color: Colors.white),
                label: Text(
                  "VER MEU TREINO",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text("INFORMAÇÕES",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: lightOrange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      Text("3",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text("Quantidade de treinos",
                          style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.timer_outlined),
                      Text("8H 36M",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text("Horas treinadas",
                          style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text("VÍDEOS",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            //Lista assincrona de videos.
            FutureBuilder<List<VideosClass>>(
              future: carregarRandomVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar vídeos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum vídeo disponível'));
                }

                final videos = snapshot.data!;
                return Column(
                  children: videos.map((video) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightOrange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                video.thumbnail,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                video.titulo,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    builder: (context) {
                      return _FaleConoscoModal(
                        topicos: topicos,
                        grey: grey,
                        orange: orange,
                        lightOrange: lightOrange,
                        criarFeedback: _criarFeedback,
                        controllers: controllers,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.message, color: Colors.white),
                label: Text(
                  "FALE CONOSCO",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FaleConoscoModal extends StatefulWidget {
  final List<Map<String, dynamic>> topicos;
  final Color grey;
  final Color orange;
  final Color lightOrange;
  final Future<void> Function(int TopicoID, String Mensagem) criarFeedback;
  final Map<int, TextEditingController> controllers;

  const _FaleConoscoModal({
    required this.topicos,
    required this.grey,
    required this.orange,
    required this.lightOrange,
    required this.criarFeedback,
    required this.controllers,
  });

  @override
  State<_FaleConoscoModal> createState() => __FaleConoscoModalState();
}

class __FaleConoscoModalState extends State<_FaleConoscoModal> {
  int? _expandedIndex;
  Map<int, int> _ratings = {};

  @override
  void initState() {
    super.initState();
    _ratings = {for (var t in widget.topicos) t['id']: 0};
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FALE CONOSCO',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Envie dúvidas, feedbacks ou reclamações. Selecione a categoria abaixo:',
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...widget.topicos.asMap().entries.map(
                  (entry) {
                final index = entry.key;
                final item = entry.value;
                final currentTopicId = item['id'] as int;
                final currentRating = _ratings[currentTopicId] ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    key: ValueKey(item['id']),
                    initiallyExpanded: index == _expandedIndex,
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        _expandedIndex = isExpanded ? index : null;
                      });
                    },
                    title: Text(
                      item['nome'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: widget.orange,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: widget.controllers[item['id']],
                          maxLines: 1,
                          style: GoogleFonts.poppins(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Escreva sua mensagem...',
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            filled: true,
                            fillColor: widget.lightOrange,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                              (starIndex) {
                            return IconButton(
                              icon: Icon(
                                starIndex < currentRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: widget.orange,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _ratings[currentTopicId] = starIndex + 1;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final mensagem =
                            widget.controllers[item['id']]!.text.trim();
                            if (mensagem.isEmpty) {
                              showToast(context,
                                  "Digite algo para enviar!",
                                  type: ToastType.error);
                              return;
                            }

                            await widget.criarFeedback(item['id'], mensagem);

                            widget.controllers[item['id']]!.clear();
                            setState(() {
                              _ratings[currentTopicId] = 0;
                              _expandedIndex = null;
                            });

                            showToast(context,
                                "Feedback enviado com sucesso!",
                                type: ToastType.success);

                            Future.delayed(
                                const Duration(milliseconds: 500), () {
                              Navigator.pop(context);
                            });
                          },
                          label: Text(
                            'Enviar',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}