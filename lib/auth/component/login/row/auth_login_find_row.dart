import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 기본 형태의 아이디 찾기 및 비밀번호 찾기 텍스트 버튼 Row, 형태에 맞게 재정의하여 사용한다.
class AuthLoginFindRow extends StatelessWidget {
  const AuthLoginFindRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              '아이디 찾기',
              style: TextStyle(
                color: const Color(0xFF575757),
                fontSize: 13.0.sp,
              ),
            )),
        const Text(
          '|',
          style: TextStyle(color: HINT_TEXT_COLOR),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              '비밀번호 찾기',
              style: TextStyle(
                color: const Color(0xFF575757),
                fontSize: 13.0.sp,
              ),
            )),
      ],
    );
  }
}
