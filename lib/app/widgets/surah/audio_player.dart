import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/data/models/ayah_model.dart';
import 'package:http/http.dart' as http;

class AyahAudioPlayer extends StatefulWidget {
  final AyahModel ayah;
  final int surahNumber;

  AyahAudioPlayer({required this.ayah, required this.surahNumber});

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AyahAudioPlayer> {
  late AudioPlayer _player;
  bool isPlaying = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_player.playing) {
      _player.stop();
    }
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      setState(() {
        isPlaying = true;
      });

      final Directory dir = await getApplicationDocumentsDirectory();
      final String folderPath = '${dir.path}/audio_cache/${widget.surahNumber}';
      final String filePath = '$folderPath/${widget.ayah.number}';
      final folder = Directory(folderPath);

      final String audioUrl = widget.ayah.audio['01'];

      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final File cachedFile = File(filePath);

      if (await cachedFile.exists()) {
        await _player.setFilePath(filePath);
      } else {
        await _player.setUrl(audioUrl);
        final bytes = await http.readBytes(Uri.parse(audioUrl));
        await cachedFile.writeAsBytes(bytes);
        await _player.setFilePath(filePath);
      }

      await _player.play();
    } catch (e) {
      print('Error saat memutar audio: $e');
    } finally {}
  }

  Future<void> _pauseAudio() async {
    final playerState = _player.playerState;

    if (playerState.playing) {
      await _player.pause();
      setState(() {
        isPaused = true;
      });
    } else if (playerState.processingState == ProcessingState.ready &&
        isPaused) {
      setState(() {
        isPaused = false;
      });
      await _player.play();
    }
  }

  Future<void> _stopAudio() async {
    setState(() {
      isPaused = false;
      isPlaying = false;
    });
    await _player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (isPlaying) {
              _stopAudio();
            } else {
              _playAudio();
            }
          },
          child: Icon(
            isPlaying ? Icons.stop_outlined : Icons.play_arrow_outlined,
            color: ColorConstants.shapeColor,
            size: 28,
          ),
        ),
        if (isPlaying)
          GestureDetector(
            onTap: () {
              _pauseAudio();
            },
            child: Icon(
              isPaused ? Icons.play_arrow_outlined : Icons.pause_outlined,
              color: ColorConstants.shapeColor,
              size: 28,
            ),
          ),
      ],
    );
  }
}
