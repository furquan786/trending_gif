// giphy_model.dart
import 'dart:convert';

GiphyResponse giphyResponseFromJson(String str) =>
    GiphyResponse.fromJson(json.decode(str));

String giphyResponseToJson(GiphyResponse data) => json.encode(data.toJson());

class GiphyResponse {
  GiphyResponse({
    required this.data,
    required this.meta,
    required this.pagination,
  });

  final List<GifData> data;
  final Meta meta;
  final Pagination pagination;

  factory GiphyResponse.fromJson(Map<String, dynamic> json) => GiphyResponse(
    data: List<GifData>.from(
      (json['data'] as List<dynamic>).map((x) => GifData.fromJson(x)),
    ),
    meta: Meta.fromJson(json['meta']),
    pagination: Pagination.fromJson(json['pagination']),
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'meta': meta.toJson(),
    'pagination': pagination.toJson(),
  };
}

class GifData {
  GifData({
    required this.type,
    required this.id,
    required this.url,
    required this.slug,
    required this.bitlyGifUrl,
    required this.bitlyUrl,
    required this.embedUrl,
    required this.username,
    required this.source,
    required this.title,
    required this.rating,
    required this.importDatetime,
    required this.trendingDatetime,
    required this.images,
    this.user,
    required this.analyticsResponsePayload,
    required this.analytics,
    this.altText = '',
    this.isSticker = false,
    this.contentUrl = '',
  });

  final String type;
  final String id;
  final String url;
  final String slug;
  final String bitlyGifUrl;
  final String bitlyUrl;
  final String embedUrl;
  final String username;
  final String source;
  final String title;
  final String rating;
  final String importDatetime;
  final String trendingDatetime;
  final Images images;
  final User? user;
  final String analyticsResponsePayload;
  final Analytics analytics;
  final String altText;
  final bool isSticker;
  final String contentUrl;

  factory GifData.fromJson(Map<String, dynamic> json) => GifData(
    type: json['type'] ?? '',
    id: json['id'] ?? '',
    url: json['url'] ?? '',
    slug: json['slug'] ?? '',
    bitlyGifUrl: json['bitly_gif_url'] ?? '',
    bitlyUrl: json['bitly_url'] ?? '',
    embedUrl: json['embed_url'] ?? '',
    username: json['username'] ?? '',
    source: json['source'] ?? '',
    title: json['title'] ?? '',
    rating: json['rating'] ?? '',
    importDatetime: json['import_datetime'] ?? '',
    trendingDatetime: json['trending_datetime'] ?? '',
    images: Images.fromJson(json['images'] ?? {}),
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    analyticsResponsePayload: json['analytics_response_payload'] ?? '',
    analytics: Analytics.fromJson(json['analytics'] ?? {}),
    altText: json['alt_text'] ?? '',
    isSticker: (json['is_sticker'] != null) ? json['is_sticker'] == 1 : false,
    contentUrl: json['content_url'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'id': id,
    'url': url,
    'slug': slug,
    'bitly_gif_url': bitlyGifUrl,
    'bitly_url': bitlyUrl,
    'embed_url': embedUrl,
    'username': username,
    'source': source,
    'title': title,
    'rating': rating,
    'import_datetime': importDatetime,
    'trending_datetime': trendingDatetime,
    'images': images.toJson(),
    if (user != null) 'user': user!.toJson(),
    'analytics_response_payload': analyticsResponsePayload,
    'analytics': analytics.toJson(),
    'alt_text': altText,
    'is_sticker': isSticker ? 1 : 0,
    'content_url': contentUrl,
  };
}

class Images {
  Images({
    required this.original,
    this.fixedHeight,
    this.fixedHeightDownsampled,
    this.fixedHeightSmall,
    this.fixedWidth,
    this.fixedWidthDownsampled,
    this.fixedWidthSmall,
  });

  final ImageInfo original;
  final ImageInfo? fixedHeight;
  final ImageInfo? fixedHeightDownsampled;
  final ImageInfo? fixedHeightSmall;
  final ImageInfo? fixedWidth;
  final ImageInfo? fixedWidthDownsampled;
  final ImageInfo? fixedWidthSmall;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    original: ImageInfo.fromJson(json['original'] ?? {}),
    fixedHeight: json['fixed_height'] != null
        ? ImageInfo.fromJson(json['fixed_height'])
        : null,
    fixedHeightDownsampled: json['fixed_height_downsampled'] != null
        ? ImageInfo.fromJson(json['fixed_height_downsampled'])
        : null,
    fixedHeightSmall: json['fixed_height_small'] != null
        ? ImageInfo.fromJson(json['fixed_height_small'])
        : null,
    fixedWidth: json['fixed_width'] != null
        ? ImageInfo.fromJson(json['fixed_width'])
        : null,
    fixedWidthDownsampled: json['fixed_width_downsampled'] != null
        ? ImageInfo.fromJson(json['fixed_width_downsampled'])
        : null,
    fixedWidthSmall: json['fixed_width_small'] != null
        ? ImageInfo.fromJson(json['fixed_width_small'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'original': original.toJson(),
    if (fixedHeight != null) 'fixed_height': fixedHeight!.toJson(),
    if (fixedHeightDownsampled != null)
      'fixed_height_downsampled': fixedHeightDownsampled!.toJson(),
    if (fixedHeightSmall != null)
      'fixed_height_small': fixedHeightSmall!.toJson(),
    if (fixedWidth != null) 'fixed_width': fixedWidth!.toJson(),
    if (fixedWidthDownsampled != null)
      'fixed_width_downsampled': fixedWidthDownsampled!.toJson(),
    if (fixedWidthSmall != null) 'fixed_width_small': fixedWidthSmall!.toJson(),
  };
}

class ImageInfo {
  ImageInfo({
    this.height,
    this.width,
    this.size,
    this.url,
    this.mp4,
    this.mp4Size,
    this.webp,
    this.webpSize,
    this.frames,
    this.hash,
  });

  final String? height;
  final String? width;
  final String? size;
  final String? url;
  final String? mp4;
  final String? mp4Size;
  final String? webp;
  final String? webpSize;
  final String? frames;
  final String? hash;

  factory ImageInfo.fromJson(Map<String, dynamic> json) => ImageInfo(
    height: json['height']?.toString(),
    width: json['width']?.toString(),
    size: json['size']?.toString(),
    url: json['url']?.toString(),
    mp4: json['mp4']?.toString(),
    mp4Size: json['mp4_size']?.toString(),
    webp: json['webp']?.toString(),
    webpSize: json['webp_size']?.toString(),
    frames: json['frames']?.toString(),
    hash: json['hash']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    if (height != null) 'height': height,
    if (width != null) 'width': width,
    if (size != null) 'size': size,
    if (url != null) 'url': url,
    if (mp4 != null) 'mp4': mp4,
    if (mp4Size != null) 'mp4_size': mp4Size,
    if (webp != null) 'webp': webp,
    if (webpSize != null) 'webp_size': webpSize,
    if (frames != null) 'frames': frames,
    if (hash != null) 'hash': hash,
  };
}

class User {
  User({
    this.avatarUrl,
    this.bannerImage,
    this.bannerUrl,
    this.profileUrl,
    this.username,
    this.displayName,
    this.description,
    this.instagramUrl,
    this.websiteUrl,
    this.isVerified,
  });

  final String? avatarUrl;
  final String? bannerImage;
  final String? bannerUrl;
  final String? profileUrl;
  final String? username;
  final String? displayName;
  final String? description;
  final String? instagramUrl;
  final String? websiteUrl;
  final bool? isVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    avatarUrl: json['avatar_url']?.toString(),
    bannerImage: json['banner_image']?.toString(),
    bannerUrl: json['banner_url']?.toString(),
    profileUrl: json['profile_url']?.toString(),
    username: json['username']?.toString(),
    displayName: json['display_name']?.toString(),
    description: json['description']?.toString(),
    instagramUrl: json['instagram_url']?.toString(),
    websiteUrl: json['website_url']?.toString(),
    isVerified: json['is_verified'] is bool
        ? json['is_verified']
        : (json['is_verified'] == 1),
  );

  Map<String, dynamic> toJson() => {
    if (avatarUrl != null) 'avatar_url': avatarUrl,
    if (bannerImage != null) 'banner_image': bannerImage,
    if (bannerUrl != null) 'banner_url': bannerUrl,
    if (profileUrl != null) 'profile_url': profileUrl,
    if (username != null) 'username': username,
    if (displayName != null) 'display_name': displayName,
    if (description != null) 'description': description,
    if (instagramUrl != null) 'instagram_url': instagramUrl,
    if (websiteUrl != null) 'website_url': websiteUrl,
    if (isVerified != null) 'is_verified': isVerified,
  };
}

class Analytics {
  Analytics({
    required this.onload,
    required this.onclick,
    required this.onsent,
  });

  final AnalyticsEvent onload;
  final AnalyticsEvent onclick;
  final AnalyticsEvent onsent;

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    onload: AnalyticsEvent.fromJson(json['onload'] ?? {}),
    onclick: AnalyticsEvent.fromJson(json['onclick'] ?? {}),
    onsent: AnalyticsEvent.fromJson(json['onsent'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'onload': onload.toJson(),
    'onclick': onclick.toJson(),
    'onsent': onsent.toJson(),
  };
}

class AnalyticsEvent {
  AnalyticsEvent({this.url});

  final String? url;

  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) =>
      AnalyticsEvent(url: json['url']?.toString());

  Map<String, dynamic> toJson() => {if (url != null) 'url': url};
}

class Meta {
  Meta({required this.status, required this.msg, required this.responseId});

  final int status;
  final String msg;
  final String responseId;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    status: json['status'] is int
        ? json['status']
        : int.tryParse('${json['status']}') ?? 0,
    msg: json['msg'] ?? '',
    responseId: json['response_id'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'msg': msg,
    'response_id': responseId,
  };
}

class Pagination {
  Pagination({
    required this.totalCount,
    required this.count,
    required this.offset,
  });

  final int totalCount;
  final int count;
  final int offset;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalCount: json['total_count'] is int
        ? json['total_count']
        : int.tryParse('${json['total_count']}') ?? 0,
    count: json['count'] is int
        ? json['count']
        : int.tryParse('${json['count']}') ?? 0,
    offset: json['offset'] is int
        ? json['offset']
        : int.tryParse('${json['offset']}') ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'total_count': totalCount,
    'count': count,
    'offset': offset,
  };
}
