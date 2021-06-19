import 'dart:io';

void main() {
  var converter = VideoConversionFacade();
  var mp4Video = converter.convertVideo('testvideo.ogg', 'mp4');
  var oggVideo = converter.convertVideo('testvideo1.mp4', 'ogg');
}

class VideoFile {
  String name;
  String codecType;

  VideoFile(this.name, this.codecType) {
    codecType = name.substring(name.indexOf('.') + 1);
  }
}

abstract class Codec {}

class MPEG4CompressionCodec implements Codec {
  String type = 'mp4';
}

class OggCompressionCodec implements Codec {
  String type = 'ogg';
}

class CodecFactory {
  static Codec extract(VideoFile file) {
    if (file.codecType.contains('mp4')) {
      print('CodecFactory: extracting mpeg audio...');
      return MPEG4CompressionCodec();
    } else {
      print('CodecFactory: extracting ogg audio...');
      return OggCompressionCodec();
    }
  }
}

class BitrateReader {
  static VideoFile read(VideoFile file, Codec codec) {
    print('BitrateReader: reading file...');
    return file;
  }

  static VideoFile convert(VideoFile buffer, Codec codec) {
    print('BitrateReader: writing file...');
    return buffer;
  }
}

class AudioMixer {
  File fix(VideoFile result) {
    print('AudioMixer: fixing audio...');
    return File('tmp');
  }
}

class VideoConversionFacade {
  File convertVideo(String filename, String format) {
    print('\nVideoConversionFacade: conversion started.');
    var file = VideoFile(filename, format);
    var sourceCodec = CodecFactory.extract(file);
    var destinationCodec = format.contains('mpg4')
        ? MPEG4CompressionCodec()
        : OggCompressionCodec();
    var buffer = BitrateReader.read(file, sourceCodec);
    var intermediateResult = BitrateReader.convert(buffer, destinationCodec);
    var result = (AudioMixer()).fix(intermediateResult);
    print('VideoConversionFacade: conversion completed.');
    return result;
  }
}
