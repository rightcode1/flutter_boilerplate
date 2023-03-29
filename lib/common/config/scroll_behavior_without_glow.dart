import 'package:flutter/material.dart';

/// 기본 스크롤 시 렌더링할 동작을 Overriding 한다. (AOS 환경에서 Glow 제거를 위한 목적)
class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}