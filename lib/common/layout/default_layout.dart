import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// 기본 레이아웃을 지정한다.
class DefaultLayout extends ConsumerWidget {
  final Widget child;

  final Color? backgroundColor;

  /// default: false 앱바 보여줄지에 대한 여부
  final bool showAppBar;

  /// 뒤로가기 버튼을 보여줄지에 대한 여부, showClose 와 함께 쓸 경우 예외를 발생시킨다.
  /// default: false
  final bool showBack;

  /// X 표시를 보여줄지에 대한 여부, showBack 과 함께 쓸 경우 예외를 발생시킨다.
  /// default: false
  final bool showClose;

  /// X 표시를 클릭 시 추가적인 로직 동작
  ///
  /// 정의하지 않을 시, context.pop() 으로 동작한다.
  final VoidCallback? onClosePressed;

  /// 앱바 제목
  final String title;

  /// 앱바 위젯 타이틀
  final Widget? widgetTitle;

  /// Bottom navigation bar
  final Widget? bottomNavigationBar;

  /// 패딩을 위한 EdgeInsets
  final EdgeInsetsGeometry? padding;

  final List<Widget> actions;

  // 앱바 하단 경계선을 그릴지에 대한 여부
  final bool showBottomDivider;

  /// back 버튼에서 추가 기능을 원할 때 사용
  final VoidCallback? onBackPressed;

  // 캐시 탭 - 최애돌 하트 전환 부분에서 앱바에 gradiant 주려고 추가
  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottomWidget;

  final double actionsRightPadding;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.showAppBar = false,
    this.showBack = false,
    this.showClose = false,
    this.onClosePressed,
    this.title = '',
    this.widgetTitle,
    this.bottomNavigationBar,
    this.padding,
    this.actions = const [],
    this.showBottomDivider = false,
    this.onBackPressed,
    this.bottomWidget,
    this.flexibleSpace,
    this.actionsRightPadding = 16,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // show AppBar 가 false 이나, showBack, showClose 가 true 일 경우 예외를 발생시킨다.
    if (!showAppBar && (showBack || showClose || title.isNotEmpty || actions.isNotEmpty || widgetTitle != null)) {
      throw Exception(
          'showAppBar 가 활성화되지 않은 상태에서 showBack, title 또는 showClose, actions 프로퍼티를 사용할 수 없습니다.\n\nshowAppBar 프로퍼티를 true 로 변경한 후, 해당 프로퍼티들을 사용해주세요.');
    }

    // showBack, showClose 가 동시에 True 일 경우, 예외를 발생시킨다.
    if (showBack && showClose) {
      throw Exception('showBack 과 showClose 속성은 함께 사용될 수 없습니다.');
    }

    // title, imageTitle 가 동시에 사용 될 경우, 예외를 발생시킨다.
    if (title.isNotEmpty && widgetTitle != null) {
      throw Exception('title 과 widgetTitle 속성은 함께 사용될 수 없습니다.');
    }

    // showBottomDivider, bottomWidget 가 동시에 사용 될 경우, 예외를 발생시킨다.
    if (showBottomDivider && bottomWidget != null) {
      throw Exception('showBottomDivider 과 bottomWidget 속성은 함께 사용될 수 없습니다.');
    }

    return GestureDetector(
      // 키보드 활성화 시, 다른 스크린을 클릭할 때 자동으로 키보드가 내려가도록 전역 설정
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: showAppBar ? _renderAppBar(context) : null,
        backgroundColor: backgroundColor ?? Colors.white,
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: padding == null
                ? EdgeInsets.symmetric(
              vertical: 17.8.h,
              horizontal: 25.5.w,
            )
                : padding!,
            child: child,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        // extendBody: true,
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  /// 렌더를 위한 앱바를 반환한다.
  AppBar _renderAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: flexibleSpace,
      // 앱바 우측 X 버튼 활성화 여부, false 일 경우, 지정한 actions 가 출력된다. showClose 가 true 인 상태에서 다른 actions 를 정의할 수 없다.
      actions: showClose
          ? [
        IconButton(
          onPressed: () {
            if (onClosePressed != null) {
              onClosePressed!();
            } else {
              context.pop();
            }
          },
          icon: Image.asset('asset/icons/common/close_icon.png', height: 22.0.h,),
        ),
        SizedBox(
          width: 16.0.w,
        ) // 액션 버튼의 오른쪽에 16 pixel 만큼의 여백을 둔다.
      ]
          : [
        ...actions,
        SizedBox(
          width: actionsRightPadding.w,
        ) // 액션
      ],
      backgroundColor: Colors.white,
      // 앱바 타이틀 가운데 적용 여부
      centerTitle: true,
      // 앱바 Shadow 해제
      elevation: 0.0,
      // App Bar 의 뒤로가기 버튼 출력 여부
      automaticallyImplyLeading: showBack ? true : false,
      leading: showBack
          ? Transform.translate(
        offset: Offset(4.0.w, 0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: onBackPressed ??
                  () {
                // 스택에 남아있는 페이지가 없을 경우, 에외를 발생시킨다.
                if (!context.canPop()) {
                  throw Exception('뒤로갈 수 있는 페이지가 존재하지 않습니다. 코드를 다시 확인해주세요.');
                }
                context.pop();
              },
        ),
      )
          : null,
      // title 이 위젯일 경우, 위젯을 그대로 렌더링하고, 아닐 경우 text 로 구성된 title 을 렌더링한다. widgetTitle, title 은 동시에 사용될 수 없다.
      title: widgetTitle ?? Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 15.0.sp,
        ),
      ),
      titleSpacing: 24.0,
      // 앱바 하단 Divider 적용
      bottom: bottomWidget != null
          ? bottomWidget!
          : showBottomDivider
          ? PreferredSize(
        preferredSize: Size.fromHeight(8.0.h),
        child: Divider(
          color: BORDER_COLOR,
          thickness: 1.0,
          height: 0.0.h,
        ),
      )
          : null,
    );
  }
}
