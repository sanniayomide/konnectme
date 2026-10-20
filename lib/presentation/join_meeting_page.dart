import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:konnectme/presentation/meeting_page.dart';

class JoinMeetingPage extends StatefulWidget {
  final String email;
  const JoinMeetingPage({required this.email, super.key});

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  final TextEditingController _meetingIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _connectedToAudio = true;
  bool _videoOn = true;

  @override
  void initState() {
    _emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    _meetingIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final meetingId = _meetingIdController.text;
    final email = _emailController.text;

    if (meetingId.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter meeting ID')));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeetingPage(
            meetingId: meetingId,
            email: email,
            connectToAudio: _connectedToAudio,
            videoOn: _videoOn,
          ),
        ),
      );
      _meetingIdController.clear();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Join Meeting'), actions: [ClerkSignOutPanel()]),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: _meetingIdController,
              decoration: InputDecoration(
                hintText: 'Meeting ID',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            SwitchListTile(
              title: Text('Connect to audio'),
              value: _connectedToAudio,
              onChanged: (val) => setState(() => _connectedToAudio = val),
            ),
            const Gap(16),
            SwitchListTile(
              title: Text('Turn on my video'),
              value: _videoOn,
              onChanged: (val) => setState(() => _videoOn = val),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Join Meeting'),
            ),
          ],
        ),
      ),
    ),
  );
}
