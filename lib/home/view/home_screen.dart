
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ppl_app/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static get routeName => 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // 초기 데이터를 가져온다.
    getInitialData();
  }

  /// 화면을 최초로 그릴 시, 초기 데이터가 필요한 경우 사용한다. 필요에 따라 제거한다.
  Future<void> getInitialData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      showAppBar: true,
      title: '홈 스크린',
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        )
      ],
      child: const Center(
        child: Text('홈 스크린'),
      )
    );
  }
}
