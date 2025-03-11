import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chatter/blocs/audio_cubit.dart';
import 'package:chatter/blocs/audio_state.dart';
import 'package:chatter/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioBubble extends StatelessWidget {
  final String audioPath;

  const AudioBubble({super.key, required this.audioPath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        Duration duration = Duration.zero;
        Duration position = Duration.zero;
        bool isPlaying = false;
        bool isLoading = state is AudioLoading;
        bool isPause = state is AudioPaused;

        if (state is AudioPlaying) {
          position = state.position;
          duration = state.duration;
          isPlaying = state.isPlaying;
        } else if (state is AudioPaused) {
          position = state.position;
          duration = state.duration;
        } else if (state is AudioStopped) {
          duration = state.duration;
        }

        return Theme(
          data: Theme.of(context).copyWith(
            sliderTheme: SliderThemeData(
              activeTrackColor: green,
              thumbColor: green,
            ),
          ),
          child: BubbleNormalAudio(
            color: Color(0xFFE8E8EE),
            duration: duration.inSeconds.toDouble(),
            position: position.inSeconds.toDouble(),
            isPlaying: isPlaying,
            isLoading: isLoading,
            isPause: isPause,
            onSeekChanged: (value) {
              context
                  .read<AudioCubit>()
                  .seekAudio(Duration(seconds: value.toInt()));
            },
            onPlayPauseButtonClick: () {
              if (isPlaying) {
                context.read<AudioCubit>().pauseAudio();
              } else if (isPause) {
                context.read<AudioCubit>().resumeAudio();
              } else {
                context.read<AudioCubit>().playAudio(audioPath);
              }
            },
            sent: true,
          ),
        );
      },
    );
  }
}
