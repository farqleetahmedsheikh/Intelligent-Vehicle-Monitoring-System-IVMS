import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:track_vision/Auth/user/mobile_camerastate.dart';

class CameraScanPage extends ConsumerStatefulWidget {
  const CameraScanPage({super.key});

  @override
  ConsumerState<CameraScanPage> createState() => _CameraScanPageState();
}

class _CameraScanPageState extends ConsumerState<CameraScanPage> {
  bool _handled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        onDetect: (capture) async {
          if (_handled) return;

          final barcodes = capture.barcodes;
          if (barcodes.isEmpty) return;

          final value = barcodes.first.rawValue;
          if (value == null) return;

          _handled = true;

          await ref.read(mobileCamerastateProvider.notifier).saveScan(value);
          if (!mounted) return;
          Navigator.of(context).pop(value);
        },
      ),
    );
  }
}
