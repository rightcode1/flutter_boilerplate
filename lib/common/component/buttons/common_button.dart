import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 가장 기본이 되는 버튼 컴포넌트, 형태에 맞게 재구성하여 사용한다.
class CommonButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 시 콜백
  final VoidCallback onPressed;

  /// 버튼 활성화 여부
  final bool isActive;

  /// 버튼 색상
  final Color? buttonColor;

  /// 폰트 사이즈
  final double? fontSize;

  /// 폰트 굵기
  final FontWeight? fontWeight;

  const CommonButton({
    required this.text,
    required this.onPressed,
    this.isActive = true,
    this.buttonColor = PRIMARY_COLOR,
    this.fontSize,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? buttonColor : AUTH_BUTTON_BG_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
      ),
      child: Text(text, style: TextStyle(
        fontSize: fontSize ?? 13.0.sp,
        fontWeight: fontWeight,
      ),),
    );
  }
}
