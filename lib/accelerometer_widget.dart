import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerWidget extends StatefulWidget {
  const AccelerometerWidget({super.key});

  @override
  State<AccelerometerWidget> createState() => _AccelerometerWidgetState();
}

class _AccelerometerWidgetState extends State<AccelerometerWidget> {
  AccelerometerEvent? _event;
  bool _shakeDetected = false;

  StreamSubscription<AccelerometerEvent>? _subscription;

  static const double _shakeThreshold = 15.0;

  @override
  void initState() {
    super.initState();

    _subscription = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    ).listen((event) {
      final magnitude = math.sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );

      setState(() {
        _event = event;
        _shakeDetected = magnitude > _shakeThreshold;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = _event;

    return Card(
      color: _shakeDetected ? Colors.red.shade50 : Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acelerómetro',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (event != null) ...[
              Text('X: ${event.x.toStringAsFixed(2)} m/s²'),
              Text('Y: ${event.y.toStringAsFixed(2)} m/s²'),
              Text('Z: ${event.z.toStringAsFixed(2)} m/s²'),
              const SizedBox(height: 8),
              if (_shakeDetected)
                const Text(
                  '¡Agitación detectada!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                const Text('Dispositivo estable'),
            ] else
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}