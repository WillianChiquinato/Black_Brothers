import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/modelo_user.dart';
import 'package:projetosflutter/API/Json/api_services.dart';

class MenuInicialHome extends StatefulWidget {
  const MenuInicialHome({super.key});

  @override
  State<MenuInicialHome> createState() => _MenuInicialHomeState();
}

class _MenuInicialHomeState extends State<MenuInicialHome> {
  UserClass _user = UserClass();

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  @override
  void initState() {
    super.initState();
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
              icon: const Icon(Icons.menu),
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
                  backgroundImage: AssetImage("Assets/iam.jpg"),
                  radius: 25,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _user.plano ?? 'Plano não definido',
                      style: GoogleFonts.poppins(
                        color: orange,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _user.nome ?? 'Nome não informado',
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
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Text("MEU TREINO", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PROGRESSO\n25%", style: GoogleFonts.poppins()),
                Text("Data Treino:\n30/03 - 30/09", style: GoogleFonts.poppins()),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.fitness_center_rounded, color: Colors.white),
                label: Text(
                  "VER MEU TREINO",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text("INFORMAÇÕES", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
                      const Icon(Icons.calendar_today_outlined),
                      Text("3", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text("Dias de treino", style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.timer_outlined),
                      Text("8H 36M", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text("Horas treinadas", style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text("VÍDEOS", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: [
                {
                  'thumbnail': 'Assets/thumb-peito.png',
                  'title': 'Treino de Peito Avançado',
                },
                {
                  'thumbnail': 'Assets/nutricionista.png',
                  'title': 'Dicas de Alimentação Pós-Treino',
                },
                {
                  'thumbnail': 'Assets/alongamentos.png',
                  'title': 'Alongamentos Essenciais',
                },
              ].map((video) {
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
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            video['thumbnail']!,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            video['title']!,
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
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    builder: (context) => Padding(
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
                              color: grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Envie dúvidas, feedbacks ou reclamações. Selecione a categoria abaixo:',
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ...[
                            'INFRAESTRUTURA',
                            'EQUIPAMENTO',
                            'PROFESSORES',
                            'ATENDIMENTO',
                            'FAQ',
                          ].map(
                                (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ExpansionTile(
                                title: Text(
                                  item,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: orange,
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      maxLines: 4,
                                      style: GoogleFonts.poppins(fontSize: 14),
                                      decoration: InputDecoration(
                                        hintText: 'Escreva sua mensagem...',
                                        hintStyle: GoogleFonts.poppins(fontSize: 14),
                                        filled: true,
                                        fillColor: lightOrange,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: ElevatedButton.icon(
                                      onPressed: () => Navigator.pop(context),
                                      label: Text(
                                        'Enviar',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.message, color: Colors.white),
                label: Text(
                  "FALE CONOSCO",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
