import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contact block from https://foxnext.net/runtime-config.json
class ContactFeed {
  const ContactFeed({
    required this.websiteDisplay,
    required this.websiteLink,
    required this.emailDisplay,
    required this.emailLink,
    required this.githubDisplay,
    required this.githubLink,
    required this.channelLink,
    required this.supportLink,
    required this.botLink,
    required this.groupLink,
  });

  final String websiteDisplay;
  final String websiteLink;
  final String emailDisplay;
  final String emailLink;
  final String githubDisplay;
  final String githubLink;
  final String channelLink;
  final String supportLink;
  final String botLink;
  final String groupLink;

  bool get isValid =>
      websiteLink.isNotEmpty ||
      emailLink.isNotEmpty ||
      githubLink.isNotEmpty ||
      channelLink.isNotEmpty;

  factory ContactFeed.fromJson(Map<String, dynamic> json) {
    return ContactFeed(
      websiteDisplay: (json['website_display'] as String?)?.trim() ?? '',
      websiteLink: (json['website_link'] as String?)?.trim() ?? '',
      emailDisplay: (json['email_display'] as String?)?.trim() ?? '',
      emailLink: (json['email_link'] as String?)?.trim() ?? '',
      githubDisplay: (json['github_display'] as String?)?.trim() ?? '',
      githubLink: (json['github_link'] as String?)?.trim() ?? '',
      channelLink: (json['channel_link'] as String?)?.trim() ?? '',
      supportLink: (json['support_link'] as String?)?.trim() ?? '',
      botLink: (json['bot_link'] as String?)?.trim() ?? '',
      groupLink: (json['group_link'] as String?)?.trim() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'website_display': websiteDisplay,
        'website_link': websiteLink,
        'email_display': emailDisplay,
        'email_link': emailLink,
        'github_display': githubDisplay,
        'github_link': githubLink,
        'channel_link': channelLink,
        'support_link': supportLink,
        'bot_link': botLink,
        'group_link': groupLink,
      };
}

class ContactFeedService extends ChangeNotifier {
  ContactFeedService._();

  static final ContactFeedService instance = ContactFeedService._();

  static const runtimeConfigUrl = 'https://foxnext.net/runtime-config.json';
  static const _cacheKey = 'cb_runtime_contact_json';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  ContactFeed? _feed;
  bool _live = false;

  ContactFeed? get feed => _feed;
  bool get live => _live;

  String pick(String? remote, String fallback) {
    final value = remote?.trim() ?? '';
    return value.isEmpty ? fallback : value;
  }

  Future<void> loadOnStartup() async {
    await _loadCache();
    await refresh();
  }

  Future<void> refresh() async {
    try {
      final response = await _dio.get<String>(runtimeConfigUrl);
      final body = response.data;
      if (body == null || body.isEmpty) {
        return;
      }
      final root = jsonDecode(body) as Map<String, dynamic>;
      final block = root['contact'];
      if (block is! Map<String, dynamic>) {
        return;
      }
      final parsed = ContactFeed.fromJson(block);
      if (!parsed.isValid) {
        return;
      }
      _feed = parsed;
      _live = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(parsed.toJson()));
      notifyListeners();
    } catch (_) {
      _live = false;
      notifyListeners();
    }
  }

  Future<void> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey);
    if (raw == null || raw.isEmpty) {
      return;
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final parsed = ContactFeed.fromJson(json);
      if (parsed.isValid) {
        _feed = parsed;
        _live = false;
        notifyListeners();
      }
    } catch (_) {}
  }
}
