import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:konnectme/presentation/meeting_page.dart';
import 'package:konnectme/ui/app_theme.dart';
import 'package:konnectme/ui/components.dart';

class JoinMeetingPage extends StatefulWidget {
  const JoinMeetingPage({required this.email, super.key});
  final String email;

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  final _formKey = GlobalKey<FormState>();
  final _meetingIdController = TextEditingController();
  bool _connectedToAudio = true;
  bool _videoOn = true;

  @override
  void dispose() {
    _meetingIdController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => MeetingPage(
      meetingId: _meetingIdController.text.trim(),
      email: widget.email,
      connectToAudio: _connectedToAudio,
      videoOn: _videoOn,
    )));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      toolbarHeight: 88,
      title: const BrandMark(),
      actions: [ClerkSignOutPanel(), const SizedBox(width: 16)],
    ),
    body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 840;
      final introduction = _Introduction(videoOn: _videoOn, audioOn: _connectedToAudio);
      final form = SurfaceCard(child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('YOUR NEXT CONVERSATION', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.teal, letterSpacing: 2)),
        const SizedBox(height: 12),
        Text('Take a seat.', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Enter your room ID and make yourself comfortable.'),
        const SizedBox(height: 28),
        TextFormField(
          controller: _meetingIdController,
          textInputAction: TextInputAction.go,
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Meeting ID', hintText: 'Enter the ID from your host', prefixIcon: Icon(Icons.tag_rounded)),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Enter a meeting ID to continue.';
            if (!RegExp(r'^[a-zA-Z0-9_-]{1,64}$').hasMatch(value.trim())) return 'Use 1–64 letters, numbers, underscores or hyphens.';
            return null;
          },
          onFieldSubmitted: (_) => _handleSubmit(),
        ),
        const SizedBox(height: 20),
        Text('JOINING AS', style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.5)),
        const SizedBox(height: 8),
        Text(widget.email, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 18), child: Divider()),
        DevicePreference(title: 'Microphone', subtitle: _connectedToAudio ? 'On when you join' : 'Join muted', icon: _connectedToAudio ? Icons.mic_rounded : Icons.mic_off_rounded, value: _connectedToAudio, onChanged: (v) => setState(() => _connectedToAudio = v)),
        DevicePreference(title: 'Camera', subtitle: _videoOn ? 'On when you join' : 'Join with camera off', icon: _videoOn ? Icons.videocam_rounded : Icons.videocam_off_rounded, value: _videoOn, onChanged: (v) => setState(() => _videoOn = v)),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: _handleSubmit, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('Join conversation')),
        const SizedBox(height: 12),
        const Text('You can change your mic and camera during the call.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ])));
      return SingleChildScrollView(padding: EdgeInsets.all(wide ? 40 : 20), child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: wide ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(child: introduction), const SizedBox(width: 56), Expanded(child: form)]) : Column(children: [introduction, const SizedBox(height: 28), form]),
      )));
    })),
  );
}

class _Introduction extends StatelessWidget {
  const _Introduction({required this.videoOn, required this.audioOn});
  final bool videoOn;
  final bool audioOn;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('LESS DISTANCE. MORE CONNECTION.', style: TextStyle(color: AppTheme.teal, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2)),
    const SizedBox(height: 18),
    Text('Good conversations
start here.', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.8, height: 1.1)),
    const SizedBox(height: 18),
    const Text('A little space for big ideas, familiar faces, and everything in between.', style: TextStyle(fontSize: 17, height: 1.6, color: Color(0xFF60716D))),
    const SizedBox(height: 28),
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF173F40), Color(0xFF006D68)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(28)),
      child: Column(children: [
        const CircleAvatar(radius: 36, backgroundColor: Color(0xFFDDEDCC), child: Icon(Icons.forum_rounded, size: 34, color: AppTheme.teal)),
        const SizedBox(height: 20),
        const Text('Your space to connect', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('Join with the settings that feel right for you.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFCCE0DA), height: 1.5)),
        const SizedBox(height: 24),
        Wrap(spacing: 12, runSpacing: 8, alignment: WrapAlignment.center, children: [
          Chip(avatar: Icon(audioOn ? Icons.mic_rounded : Icons.mic_off_rounded, size: 18), label: Text(audioOn ? 'Mic on' : 'Mic off')),
          Chip(avatar: Icon(videoOn ? Icons.videocam_rounded : Icons.videocam_off_rounded, size: 18), label: Text(videoOn ? 'Camera on' : 'Camera off')),
        ]),
      ]),
    ),
  ]);
}
