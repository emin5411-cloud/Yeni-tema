import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const OpelLauncherApp());
}

class OpelLauncherApp extends StatelessWidget {
  const OpelLauncherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astra H OS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFB300),
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String _timeString = "";
  String _dateString = "";
  int _currentSpeed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentSpeed = (_currentSpeed + 5) % 140;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    if (mounted) {
      setState(() {
        _timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
        _dateString = "${now.day}.${now.month}.${now.year} - Astra H Edition";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF15161A), Color(0xFF0F1013)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.directions_car, color: Color(0xFFFFB300), size: 28),
                      const SizedBox(width: 8),
                      Text(
                        _dateString,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    _timeString,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1C23),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFFB300).withOpacity(0.3), width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_currentSpeed',
                              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'monospace'),
                            ),
                            const Text(
                              'KM/H',
                              style: TextStyle(fontSize: 18, color: Color(0xFFFFB300), fontWeight: FontWeight.bold, letterSpacing: 2),
                            ),
                            const SizedBox(height: 10),
                            const Icon(Icons.speed, color: Colors.white38, size: 24),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E212B),
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage('https://unsplash.com'),
                            fit: BoxFit.cover,
                            opacity: 0.4,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(color: Colors.black70, borderRadius: BorderRadius.circular(8)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.navigation, color: Colors.green, size: 16),
                                    SizedBox(width: 4),
                                    Text('Harita Hazir', style: TextStyle(fontSize: 12, color: Colors.white)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.apple, color: Colors.white, size: 54),
                              SizedBox(height: 8),
                              Text(
                                'CARPLAY',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildShortcutButton(Icons.radio, "RADYO", Colors.blue, () {}),
                  _buildShortcutButton(Icons.music_note, "MUZIK", Colors.orange, () {}),
                  _buildShortcutButton(Icons.ondemand_video, "YOUTUBE", Colors.red, () {}),
                  _buildShortcutButton(Icons.settings, "AYARLAR", Colors.blueGrey, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1E212A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white10, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
