import 'package:flutter/material.dart';
import 'dart:math';

class TableGameDragDrop extends StatefulWidget {
  final int tableNumber;

  const TableGameDragDrop({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

  @override
  _TableGameDragDropState createState() => _TableGameDragDropState();
}

class _TableGameDragDropState extends State<TableGameDragDrop> {
  final Random _random = Random();
  late int _randomNumber;
  bool isDropped = false;
  late List<int> _options;
  
  @override
  void initState() {
    super.initState();
    _generateNewNumber();
  }
  
  void _generateNewNumber() {
    setState(() {
      _randomNumber = _random.nextInt(10) + 1;
      isDropped = false;
      _generateOptions();
    });
  }

  void _generateOptions() {
    int correctAnswer = widget.tableNumber * _randomNumber;
    Set<int> wrongAnswers = {};
    
    while (wrongAnswers.length < 2) {
      int wrongAnswer = _random.nextInt(widget.tableNumber * 10) + 1;
      if (wrongAnswer != correctAnswer) {
        wrongAnswers.add(wrongAnswer);
      }
    }
    
    _options = [correctAnswer, ...wrongAnswers.toList()];
    _options.shuffle();
  }

  void _handleCorrectAnswer() async {
    setState(() {
      isDropped = true;
    });
    
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      _generateNewNumber();
    }
  }

  Widget _buildDraggable(int number) {
    return Draggable<int>(
      data: number,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFB347),  // Naranja suave
              Color(0xFFFFCC33),  // Amarillo cálido
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
      feedback: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFB347).withOpacity(0.9),
              Color(0xFFFFCC33).withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla del ${widget.tableNumber} - Arrastra y Suelta'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5E6CA),  // Beige cálido
              Color(0xFFFFE5D9),  // Rosa muy suave
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            // Primera fila con la multiplicación y el área de soltar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.tableNumber} × $_randomNumber = ',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: isDropped ? Colors.green.shade700 : Colors.black87,
                      shadows: [
                        Shadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  DragTarget<int>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDropped
                                ? [Colors.green.shade300, Colors.green.shade100]
                                : [Colors.grey.shade200, Colors.white70],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isDropped ? Colors.green : Colors.grey.shade400,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            isDropped ? '¡Correcto!' : 'Suelta aquí',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDropped ? Colors.green.shade700 : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (data) => !isDropped,
                    onAccept: (data) {
                      if (data == widget.tableNumber * _randomNumber) {
                        _handleCorrectAnswer();
                      } else {
                        setState(() {
                          isDropped = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // Segunda fila con las opciones arrastrables
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _options.map((number) => _buildDraggable(number)).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateNewNumber,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}