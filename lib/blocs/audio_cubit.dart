import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _totalDuration = Duration.zero;

  AudioCubit() : super(AudioInitial()) {
    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      emit(AudioPlaying(Duration.zero, duration, false));
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (state is AudioPlaying) {
        emit(AudioPlaying(position, _totalDuration, true));
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      emit(AudioStopped(_totalDuration));
    });
  }

  Future<void> loadAudio(String path) async {
    try {
      emit(AudioLoading());
      await _audioPlayer.setSource(DeviceFileSource(path));
      Duration? duration = await _audioPlayer.getDuration();
      _totalDuration = duration ?? Duration.zero;
      emit(AudioStopped(_totalDuration));
    } catch (e) {
      emit(AudioError("Ошибка загрузки аудио: $e"));
    }
  }

  Future<void> playAudio(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(path));
      emit(AudioPlaying(Duration.zero, _totalDuration, true));
    } catch (e) {
      emit(AudioError("Ошибка воспроизведения: $e"));
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    if (state is AudioPlaying) {
      emit(AudioPaused((state as AudioPlaying).position, _totalDuration));
    }
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    if (state is AudioPaused) {
      emit(AudioPlaying((state as AudioPaused).position, _totalDuration, true));
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    emit(AudioStopped(_totalDuration));
  }

  Future<void> seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
    if (state is AudioPlaying) {
      emit(AudioPlaying(position, _totalDuration, true));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    return super.close();
  }
}
