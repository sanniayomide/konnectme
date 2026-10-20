import 'package:flutter/material.dart';
import 'package:konnectme/data/config/env_config.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MeetingPage extends StatelessWidget {
  final String meetingId;
  final String email;
  final bool connectToAudio;
  final bool videoOn;

  const MeetingPage({
    super.key,
    required this.meetingId,
    required this.email,
    required this.connectToAudio,
    required this.videoOn,
  });

  @override
  Widget build(BuildContext context) => ZegoUIKitPrebuiltCall(
    appID: EnvConfig().zegoAppId,
    appSign: EnvConfig().zegoAppSign,
    callID: meetingId,
    userID: email,
    userName: email,
    config: ZegoUIKitPrebuiltCallConfig()
      ..turnOnCameraWhenJoining = videoOn
      ..turnOnMicrophoneWhenJoining = connectToAudio
      ..topMenuBar.isVisible = true
      ..topMenuBar.buttons = [
        ZegoCallMenuBarButtonName.minimizingButton,
        ZegoCallMenuBarButtonName.showMemberListButton,
        ZegoCallMenuBarButtonName.soundEffectButton,
      ],
  );
}
