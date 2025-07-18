import 'package:hive/hive.dart';
import 'dart:convert';

class CacheEntry {
  final dynamic data;
  final DateTime timestamp;

  CacheEntry({required this.data, required this.timestamp});

  Map<String, dynamic> toJson() => {'data': data, 'timestamp': timestamp.toIso8601String()};

  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      CacheEntry(data: json['data'], timestamp: DateTime.parse(json['timestamp'] as String));
}

class CacheService {
  static const String _boxName = 'api_cache';
  late final Box<String> _box;
  late final Future<void> initialized;

  CacheService() {
    initialized = _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  String _buildKey(String endpoint, Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) return endpoint;
    final sortedParams = Map.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return '$endpoint?${jsonEncode(sortedParams)}';
  }

  Future<void> cacheData<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T data,
  }) async {
    await initialized;
    final key = _buildKey(endpoint, params);
    final entry = CacheEntry(data: data, timestamp: DateTime.now());
    await _box.put(key, jsonEncode(entry.toJson()));
  }

  Future<T?> getCachedData<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    Duration? maxAge,
  }) async {
    await initialized;
    final key = _buildKey(endpoint, params);
    final cachedJson = _box.get(key);

    if (cachedJson == null) return null;

    final entry = CacheEntry.fromJson(jsonDecode(cachedJson));

    if (maxAge != null) {
      final age = DateTime.now().difference(entry.timestamp);
      if (age > maxAge) return null;
    }

    return entry.data as T;
  }

  Future<void> clearCache() async {
    await initialized;
    await _box.clear();
  }

  Future<void> removeCacheEntry({required String endpoint, Map<String, dynamic>? params}) async {
    await initialized;
    final key = _buildKey(endpoint, params);
    await _box.delete(key);
  }
}
