import 'package:flutter/material.dart';
import 'table_game_drag_drop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Lista de colores vibrantes para las tarjetas
  final List<List<Color>> cardColors = const [
    [Color(0xFFFF4B4B), Color(0xFFFF9F9F)], // Rojo vibrante a rosa
    [Color(0xFF4CAF50), Color(0xFF8BC34A)], // Verde vibrante
    [Color(0xFF2196F3), Color(0xFF03A9F4)], // Azul brillante
    [Color(0xFFFF9800), Color(0xFFFFB74D)], // Naranja vibrante
    [Color(0xFF9C27B0), Color(0xFFE1BEE7)], // Púrpura vibrante
    [Color(0xFF00BCD4), Color(0xFF80DEEA)], // Cyan brillante
    [Color(0xFFFF5722), Color(0xFFFF8A65)], // Naranja profundo
    [Color(0xFF673AB7), Color(0xFF9575CD)], // Violeta profundo
    [Color(0xFF009688), Color(0xFF4DB6AC)], // Verde azulado
    [Color(0xFFE91E63), Color(0xFFF48FB1)], // Rosa vibrante
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tablas de Multiplicar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final tableNumber = index + 1;
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: cardColors[index],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cardColors[index][0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TableGameDragDrop(
                          tableNumber: tableNumber,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tabla del',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$tableNumber',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}