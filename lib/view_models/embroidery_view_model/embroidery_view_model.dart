import 'package:flutter_riverpod/flutter_riverpod.dart';

final addTextBoolProvider = StateProvider.autoDispose<bool>((ref) => false);
final textPositionProvider = StateProvider.autoDispose<String>((ref) => 'Left Chest');
final textColorProvider = StateProvider.autoDispose<String>((ref) => 'Black');
final textFontProvider = StateProvider.autoDispose<String>((ref) => 'Block');
final textName1Provider = StateProvider.autoDispose<String>((ref) => '');
final textName2Provider = StateProvider.autoDispose<String>((ref) => '');
