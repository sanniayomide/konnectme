import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konnectme/ui/app_theme.dart';
import 'package:konnectme/ui/components.dart';

void main() {
  testWidgets('Device preference updates when toggled', (tester) async {
    var enabled = true;
    await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: Scaffold(
      body: StatefulBuilder(builder: (context, setState) => DevicePreference(
        title: 'Microphone', subtitle: enabled ? 'On' : 'Off',
        icon: Icons.mic, value: enabled,
        onChanged: (value) => setState(() => enabled = value),
      )),
    )));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(enabled, isFalse);
    expect(find.text('Off'), findsOneWidget);
  });
}
