import 'package:flutter/material.dart';

void main() {
  runApp(const MiHojaDeVidaApp());
}

class MiHojaDeVidaApp extends StatefulWidget {
  const MiHojaDeVidaApp({super.key});

  @override
  State<MiHojaDeVidaApp> createState() => _MiHojaDeVidaAppState();
}

class _MiHojaDeVidaAppState extends State<MiHojaDeVidaApp> {
  bool _isDarkTheme = false;
  String _filtroActivo = 'Todas';

  final List<Map<String, String>> _habilidades = const [
    {'nombre': 'Java / ASP.NET MVC', 'tipo': 'Backend'},
    {'nombre': 'Flutter / Dart', 'tipo': 'Móvil'},
    {'nombre': 'HTML5 / CSS3 / JavaScript', 'tipo': 'Frontend'},
    {'nombre': 'MySQL / SQL Server', 'tipo': 'Base de Datos'},
    {'nombre': 'Python / OpenCV', 'tipo': 'Backend'},
  ];

  @override
  Widget build(BuildContext context) {
    final habilidadesFiltradas = _filtroActivo == 'Todas'
        ? _habilidades
        : _habilidades.where((h) => h['tipo'] == _filtroActivo).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cv_flutter_wrapper',
      theme: ThemeData(
        brightness: _isDarkTheme ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: _isDarkTheme ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CV - hoja de vida'),
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
              tooltip: 'Cambiar Tema Nativo',
              onPressed: () {
                setState(() {
                  _isDarkTheme = !_isDarkTheme;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Recargar Vista',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contenedor Web Recargado')),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              _buildCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Text('BV', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Benjamin Valencia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Ingeniería en Ciencias de la Computación', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Text('Tulcán, Ecuador | UPEC', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // PERFIL
              _buildSection('Perfil Profesional', 
                'Enfocado en desarrollar páginas web, móviles y sistemas embebidos. Integración de servicios web, gestión de bases de datos y arquitectura de redes.'
              ),

              // PROYECTOS
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Proyectos Destacados', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                    Divider(),
                    Text('• Juego de Piano', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Sistema para aprender a tocar piano de forma interactiva.', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    Text('• 100 Ecuatorianos Dijeron', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Aplicación interactiva de juego trivia con sincronización de pantallas.', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),

              // HABILIDADES CON JS INTERACTIVO SIMULADO
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Habilidades Técnicas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                    const Divider(),
                    Wrap(
                      spacing: 6,
                      children: ['Todas', 'Backend', 'Móvil', 'Frontend']
                          .map((cat) => ChoiceChip(
                                label: Text(cat, style: const TextStyle(fontSize: 12)),
                                selected: _filtroActivo == cat,
                                onSelected: (selected) {
                                  if (selected) setState(() => _filtroActivo = cat);
                                },
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: habilidadesFiltradas
                          .map((h) => Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(h['nombre']!, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              // CONTACTO
              _buildSection('Contacto', 'Correo: elias.valencia@upec.edu.ec\nInstitución: Universidad Politécnica Estatal del Carchi'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          const Divider(),
          Text(content, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}