import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:konnectme/ui/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(toolbarHeight: 88, title: const BrandMark()),
    body: SafeArea(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Icon(Icons.waving_hand_rounded, size: 40),
          const SizedBox(height: 20),
          Text('Welcome to your space.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          const Text('Sign in to start your next conversation.', textAlign: TextAlign.center),
          const SizedBox(height: 28),
          const ClerkAuthentication(),
        ])),
      )),
    )),
  );
}
