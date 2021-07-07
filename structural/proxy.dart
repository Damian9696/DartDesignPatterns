import 'dart:io';
import 'dart:math';

void main() {
  var naiveDownloader = YouTubeDownloader(ThirdPartyYouTubeClass());
  var smartDownloader =
      YouTubeDownloader(YouTubeCacheProxy(ThirdPartyYouTubeClass()));

  var naive = test(naiveDownloader);
  var smart = test(smartDownloader);
  print('Time saved by caching proxy: ${naive - smart} ms');
}

int test(YouTubeDownloader downloader) {
  var startTime = DateTime.now().millisecondsSinceEpoch;

  // User behavior in our app:
  downloader.renderPopularVideos();
  downloader.renderVideoPage('922c05ab-01cc-41d6-9b88-e03c350b194f');
  downloader.renderPopularVideos();
  downloader.renderVideoPage('624db385-6053-4e6e-8ba6-981534a78667');

  // Users might visit the same page quite often.
  downloader.renderVideoPage('922c05ab-01cc-41d6-9b88-e03c350b194f');
  downloader.renderVideoPage('48cce1d5-5f9c-47d2-aec2-6d343b54f7e6');

  var estimatedTime = DateTime.now().millisecondsSinceEpoch - startTime;
  print('Time elapsed $estimatedTime ms\n');
  return estimatedTime;
}

abstract class ThirdPartYoutubeLib {
  Map<String, Video> popularVideos();

  Video getVideo(String videoId);
}

class ThirdPartyYouTubeClass implements ThirdPartYoutubeLib {
  @override
  Video getVideo(String videoId) {
    connectToServer('http://www.youtube.com/$videoId');
    return getSomeVideo(videoId);
  }

  @override
  Map<String, Video> popularVideos() {
    connectToServer('http://www.youtube.com/');
    return getRandomVideos();
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void simulateNetworkLatency() {
    var randomLatency = random(5, 10);
    for (var i = 0; i < randomLatency; i++) {
      try {
        sleep(Duration(microseconds: 100));
      } catch (e) {
        print(e);
      }
    }
  }

  void connectToServer(String server) {
    print('Connecting to server $server ...');
    simulateNetworkLatency();
    print('Connected\n');
  }

  Map<String, Video> getRandomVideos() {
    print('Downloading populars...');
    simulateNetworkLatency();
    var popularVideos = <String, Video>{
      'First_video': Video(
          '922c05ab-01cc-41d6-9b88-e03c350b194f', 'First_video.avi', 'Random'),
      'Second_video': Video(
          '624db385-6053-4e6e-8ba6-981534a78667', 'Second_video.mp4', 'Random'),
      'Third_video': Video(
          '48cce1d5-5f9c-47d2-aec2-6d343b54f7e6', 'Third_video.mov', 'Random'),
      'Fourth_video': Video(
          '35f1c0ca-8302-42f8-96a1-69d54f8ad98f', 'Fourth_video.mp4', 'Random'),
    };
    print('Done!\n');
    return popularVideos;
  }

  Video getSomeVideo(String videoId) {
    print('Downloading video...');
    simulateNetworkLatency();
    var video = Video(videoId, 'Some video title', 'Random');
    print('Done!\n');
    return video;
  }
}

class Video {
  final String id;
  final String title;
  final String data;

  Video(this.id, this.title, this.data);
}

class YouTubeCacheProxy implements ThirdPartYoutubeLib {
  final ThirdPartYoutubeLib youtubeService;
  var cachePopular = <String, Video>{};
  var cacheAll = <String, Video>{};

  YouTubeCacheProxy(this.youtubeService);

  @override
  Video getVideo(String videoId) {
    var video = cacheAll[videoId];
    if (video == null) {
      video = youtubeService.getVideo(videoId);
      cacheAll.putIfAbsent(videoId, () => video!);
    } else {
      print('Retrieved video $videoId from cache');
    }
    return video;
  }

  @override
  Map<String, Video> popularVideos() {
    if (cachePopular.isEmpty) {
      cachePopular = youtubeService.popularVideos();
    } else {
      print('Retrieved list from cache.');
    }
    return cachePopular;
  }

  void reset() {
    cacheAll.clear();
    cachePopular.clear();
  }
}

class YouTubeDownloader {
  final ThirdPartYoutubeLib api;

  YouTubeDownloader(this.api);

  void renderVideoPage(String videoId) {
    var video = api.getVideo(videoId);
    print('\n~~~~~~~~~~~~~~~~~~~~~~~~');
    print('Video page(imagine fancy HTML');
    print('id:${video.id}');
    print('title:${video.title}');
    print('data:${video.data}');
    print('~~~~~~~~~~~~~~~~~~~~~~~~\n');
  }

  void renderPopularVideos() {
    print('\n~~~~~~~~~~~~~~~~~~~~~~~~');
    var list = api.popularVideos();
    print('Most popular videos on YouTube(imagine fany HTML)');
    list.forEach((key, value) {
      print('id: ${value.id} / title: ${value.title}');
    });
    print('~~~~~~~~~~~~~~~~~~~~~~~~\n');
  }
}
