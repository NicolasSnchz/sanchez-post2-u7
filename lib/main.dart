import 'package:flutter/material.dart';

import 'accelerometer_widget.dart';
import 'map_view.dart';

void main() {
  runApp(const GeoSenseApp());
}

class GeoSenseApp extends StatelessWidget {
  const GeoSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const GeoSenseHomePage(),
    );
  }
}

class GeoSenseHomePage extends StatelessWidget {
  const GeoSenseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoSense'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: MapView(),
              ),
              SizedBox(height: 16),
              AccelerometerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}