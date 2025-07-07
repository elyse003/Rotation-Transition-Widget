import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpongeBobRotationDemo(),
    );
  }
}

class SpongeBobRotationDemo extends StatefulWidget {
  @override
  _SpongeBobRotationDemoState createState() => _SpongeBobRotationDemoState();
}

class _SpongeBobRotationDemoState extends State<SpongeBobRotationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  bool isRotating = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(); // Start rotating by default
  }

  void toggleRotation() {
    setState(() {
      if (isRotating) {
        _controller.stop();
      } else {
        _controller.repeat();
      }
      isRotating = !isRotating;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('SpongeBob Rotation')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _rotation,
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/spongebob.webp',
                errorBuilder: (context, error, stackTrace) =>
                    Text('Image failed to load'),
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: toggleRotation,
            child: Text(isRotating ? 'Stop Rotation' : 'Start Rotation'),
          ),
        ],
      ),
    );
  }
}
