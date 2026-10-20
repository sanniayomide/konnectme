import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:konnectme/ui/app_theme.dart';
import 'package:konnectme/data/config/env_config.dart';
import 'package:konnectme/presentation/join_meeting_page.dart';
import 'package:konnectme/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig().initializing();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ClerkAuth(
    config: ClerkAuthConfig(publishableKey: EnvConfig().clerkApiKey),
    child: MaterialApp(
      title: 'KonnectMe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: ClerkErrorListener(
        child: ClerkAuthBuilder(
          signedInBuilder: (context, authState) {
            final user = authState.user!;
            return JoinMeetingPage(email: user.email ?? user.id);
          },
          signedOutBuilder: (context, authState) => const LoginPage(),
        ),
      ),
    ),
  );
}
