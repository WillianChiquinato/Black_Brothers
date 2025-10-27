import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';

import '../API/controller.dart';
import '../API/models/modelo_tipoPlano.dart';

class MenuComunidade extends StatefulWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuComunidade({super.key, this.user, this.plan});

  @override
  State<MenuComunidade> createState() => _MenuComunidadeState();
}

class _MenuComunidadeState extends State<MenuComunidade> {
  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);
 //cor para o coracao
  final Color redHeart = const Color(0xFFFF0000);

  late GenericController<UsuarioClass> _usuarioController;
  late UsuarioClass? usuario;
  late TipoPlanoClass? plano;

  final List<Map<String, dynamic>> postsComunidade = [
    {
      "usuario": "GustavoPablo_fit",
      "horario": "2h atrás",
      "fotoPerfil": "Assets/UserIcon.png",
      "fotoPost": "Assets/legday.png",
      "legenda": "Treino de pernas concluído! Foco total nos ganhos. 🚀 #fitness #legday",
      "curtidas": 156,
    },
    {
      "usuario": "Luciana_Personal",
      "horario": "5h atrás",
      "fotoPerfil": "Assets/UserIcon.png",
      "fotoPost": "Assets/shake.png",
      "legenda": "Receita de shake proteico pós-treino: rápido e delicioso! 🥛💪",
      "curtidas": 305,
    },
  ];

  @override
  void initState() {
    usuario = widget.user;
    plano = widget.plan;
    super.initState();
    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );
  }

  final List<Map<String, String>> historicoFalso = [
    {
      "data": "20/04/2025",
      "progresso": "Progresso de 10% no treino de pernas",
      "tempo": "Treino de 1h 15min",
    },
    {
      "data": "18/04/2025",
      "progresso": "Treino de costas e bíceps completo",
      "tempo": "Treino de 55min",
    },
    {
      "data": "15/04/2025",
      "progresso": "Início do plano alimentar com nutricionista",
      "tempo": "Dieta atualizada",
    },
  ];

  void _showNewPostSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.90,
          child: _NovaPublicacaoSheet(
            orange: orange,
            grey: grey,
            onPublish: (descricao, imagem) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Post Publicado: $descricao (Imagem: $imagem)")),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: grey,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('Assets/UserIcon.png'),
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
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${usuario?.login}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: orange,
            labelColor: orange,
            unselectedLabelColor: Colors.white,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'COMPARTILHAR'),
              Tab(text: 'HISTÓRICO'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCompartilharTab(),
            _buildHistoricoTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showNewPostSheet,
          backgroundColor: orange,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
  Widget _buildPostCard(Map<String, dynamic> post) {
    return _PostItem(
      post: post,
      grey: grey,
      redHeart: redHeart,
      orange: orange,
    );
  }

  Widget _buildCompartilharTab() {
    return Container(
      color: lightOrange,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: postsComunidade.length,
        itemBuilder: (context, index) {
          return _buildPostCard(postsComunidade[index]);
        },
      ),
    );
  }

  Widget _buildHistoricoTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: historicoFalso.length,
        itemBuilder: (context, index) {
          final item = historicoFalso[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: lightOrange,
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.history, color: orange),
              title: Text(
                item["progresso"]!,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${item["data"]} • ${item["tempo"]}",
                style: GoogleFonts.poppins(fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PostItem extends StatefulWidget {
  final Map<String, dynamic> post;
  final Color grey;
  final Color redHeart;
  final Color orange;

  const _PostItem({
    required this.post,
    required this.grey,
    required this.redHeart,
    required this.orange,
  });

  @override
  State<_PostItem> createState() => __PostItemState();
}

class __PostItemState extends State<_PostItem> {
  bool isLiked = false;
  bool isSaved = false;

  bool showCommentField = false;
  final TextEditingController _commentController = TextEditingController();

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      // contagem de curtidas
      if (isLiked) {
        widget.post['curtidas'] = widget.post['curtidas'] + 1;
      } else {
        widget.post['curtidas'] = widget.post['curtidas'] - 1;
      }
    });
  }

  void _toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  void _toggleCommentField() {
    setState(() {
      showCommentField = !showCommentField;
    });
  }

  void _sendComment() {
    if (_commentController.text.isNotEmpty) {
      // lógica para enviar para a api e banco de dados

      // mostrar que o comentário foi enviado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Comentário enviado: ${_commentController.text}")),
      );

      _commentController.clear();
      // fecha o campo após enviar
      setState(() {
        showCommentField = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do Post
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.post['fotoPerfil']),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post['usuario'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      widget.post['horario'],
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Foto do Post
          Image.asset(
            widget.post['fotoPost'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    "Imagem do Post não Encontrada",
                    style: GoogleFonts.poppins(color: widget.grey.withOpacity(0.6)),
                  ),
                ),
              );
            },
          ),

          // Botões de Interação
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                // ALTERAÇÃO: Botão de Curtir (Ícone preenchido/vazio e cor)
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? widget.redHeart : widget.grey,
                  ),
                  onPressed: _toggleLike,
                ),
                // ALTERAÇÃO: Botão de Comentário (Abre/fecha o campo)
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: _toggleCommentField,
                  color: widget.grey,
                ),
                const Spacer(),
                // ALTERAÇÃO: Botão de Salvar (Ícone preenchido/vazio)
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? widget.orange : widget.grey, // Salvo usa a cor laranja
                  ),
                  onPressed: _toggleSave,
                ),
              ],
            ),
          ),

          // Contagem de Curtidas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "${widget.post['curtidas']} curtidas",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),

          // Legenda do Post
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 14, color: widget.grey),
                children: [
                  TextSpan(
                    text: widget.post['usuario'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: widget.grey),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: widget.post['legenda'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.normal, color: widget.grey),
                  ),
                ],
              ),
            ),
          ),

          // INCLUSÃO: Campo de Comentário Condicional
          if (showCommentField)
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 4),
              child: Row(
                children: [
                  // Campo para digitar
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Adicione um comentário...",
                        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: widget.grey.withOpacity(0.5), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: widget.orange, width: 1),
                        ),
                      ),
                      onSubmitted: (_) => _sendComment(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Botão de Envio
                  IconButton(
                    icon: Icon(Icons.send, color: widget.orange),
                    onPressed: _sendComment,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// CLASSE NÃO MODIFICADA: _NovaPublicacaoSheet (Mantida para fins de compilação)
class _NovaPublicacaoSheet extends StatefulWidget {
  final Color orange;
  final Color grey;
  final Function(String descricao, String imagem) onPublish;

  const _NovaPublicacaoSheet({
    required this.orange,
    required this.grey,
    required this.onPublish,
  });

  @override
  State<_NovaPublicacaoSheet> createState() => __NovaPublicacaoSheetState();
}

class __NovaPublicacaoSheetState extends State<_NovaPublicacaoSheet> {
  final TextEditingController _descricaoController = TextEditingController();
  String? _imagemPath; // simula o caminho da imagem selecionada

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }

  void _selectImage() {
    // apenas simula a selecao para demonstracao.
    setState(() {
      _imagemPath = "Assets/imagem_temporaria.png"; // placeholder
    });
  }

  void _publicar() {
    if (_descricaoController.text.isNotEmpty || _imagemPath != null) {
      widget.onPublish(_descricaoController.text, _imagemPath ?? "Nenhuma");
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adicione uma descrição ou imagem para publicar.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Criar Nova Publicação",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _descricaoController,
                maxLines: 4,
                style: GoogleFonts.poppins(fontSize: 16, color: widget.grey),
                decoration: InputDecoration(
                  hintText: "O que você tem a dizer sobre seu treino ou dica fitness?",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: widget.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: widget.orange, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              if (_imagemPath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey[200],
                      height: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: widget.grey.withOpacity(0.5)),
                            Text("Imagem selecionada (Placeholder)", style: GoogleFonts.poppins(color: widget.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              OutlinedButton.icon(
                onPressed: _selectImage,
                icon: Icon(Icons.photo_library_outlined, color: widget.orange),
                label: Text(
                  _imagemPath == null ? "Anexar Imagem" : "Trocar Imagem",
                  style: GoogleFonts.poppins(color: widget.orange, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: BorderSide(color: widget.orange, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

              const Spacer(),

              ElevatedButton(
                onPressed: _publicar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: Text(
                  "PUBLICAR",
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}