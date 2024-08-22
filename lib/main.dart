import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'HID Ring Gesture Demo';

    return const MaterialApp(
      title: title,
      home: MainPage(title: title),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> _logLines = [];
  final ScrollController _scrollController = ScrollController();

  void _addLogLine(String line) {
    setState(() {
      _logLines.add(line);
      // Scroll to the bottom of the list
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ring Button Tester'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (x) {
                // x.velocity.pixelsPerSecond.dy reports about +4000 or -4000
                // for Prev and Next buttons respectively
                if (x.velocity.pixelsPerSecond.dy > 0) {
                  _addLogLine('${DateTime.now()} - Previous');
                }
                else {
                  _addLogLine('${DateTime.now()} - Next');
                }
              },
              onTapDown: (x) {
                _addLogLine('${DateTime.now()} tap down: $x');
              },
              onTapUp: (x) {
                _addLogLine('${DateTime.now()} tap up: $x');
              },
              onDoubleTap: () {
                _addLogLine('${DateTime.now()} double tap');
              },
              onLongPress: () {
                _addLogLine('${DateTime.now()} long press');
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _logLines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_logLines[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
