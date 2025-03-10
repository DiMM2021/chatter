import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object?> get props => [];
}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioPlaying extends AudioState {
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  const AudioPlaying(this.position, this.duration, this.isPlaying);

  @override
  List<Object?> get props => [position, duration, isPlaying];
}

class AudioPaused extends AudioState {
  final Duration position;
  final Duration duration;

  const AudioPaused(this.position, this.duration);

  @override
  List<Object?> get props => [position, duration];
}

class AudioStopped extends AudioState {
  final Duration duration;

  const AudioStopped(this.duration);

  @override
  List<Object?> get props => [duration];
}

class AudioError extends AudioState {
  final String message;

  const AudioError(this.message);

  @override
  List<Object?> get props => [message];
}
