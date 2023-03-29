# 📱 올바른코드 플러터 보일러플레이트

반복된 작업 및 반드시 필요한 필수 파일들이 포함된 보일러플레이트 패키지입니다.

## 💡 포함된 패키지
**해당**
### 빌드 패키지

- badges: ^3.0.2 # 뱃지 컴포넌트를 위한 패키지
- cached_network_image: ^3.2.3 # 네트워크에서 가져온 이미지를 캐싱할 수 있는 패키지, 이미지 로드 동안 보여줄 스켈레톤 등의 임시 컴포넌트를 함께 지정할 수 있다.
- debounce_throttle: ^2.0.0 # 전통적인 Debounce, Throttle 을 구현하기 위한 패키지
- dio: ^4.0.6 # HTTP Communicating 라이브러리, Web 환경에서의 Axios, Ajax 와 상응한다.
- easy_debounce: ^2.0.3 # Debounce and Throttle 을 보다 간편하게 구현할 수 있는 패키지 (경우에 따라 상단 debounce_throttle 패키지를 통해 구현하거나, 해당 패키지를 통해 구현하면 된다.)
- equatable: ^2.0.5 # 객체 사이의 등가성을 간편하게 확인할 수 있는 패키지
- form_builder_validators: ^8.5.0 # flutter_form_builder 와 함께 사용되며, TextField 등의 값을 간편히 검증할 수 있는 패키지 (값 범위, 정규식, 필수 여부 등)
- flutter_riverpod: ^2.2.0 # 상태 관리 패키지 (전통적인 BloC, Provider 등을 대체한다.)
- flutter_form_builder: ^7.8.0 # 기존 플러터에서 제공하는 FormBuilder 를 대체하는 패키지 (패키지 내의 TextField, Slider 등은 onChange 를 통해 상태를 구현하지 않아도 자동으로 해당 패키지에 의해 관리된다.)
- flutter_screenutil: ^5.6.1 # 프로젝트 엔트리포인트에서 지정한 기기의 Default Size 에 맞춰 크기가 다른 기기에서도 너비, 높이를 dynamic 하게 자동으로 변경하여 주는 패키지
- flutter_secure_storage: ^8.0.0 # 플러터 저장소, SharedPreferences 보다 더 보안성이 높은 패키지로 보인다.
- flutter_staggered_grid_view: ^0.6.2 # 기존 전통적인 GridView 를 대체하는 패키지, 기존에는 GridView 내의 아이템의 크기를 제어해주는 등의 추가 로직이 필요하였으나, 해당 패키지는 자동으로 크기를 맞춰 GridView 를 구성해준다.
- fluttertoast: ^8.2.1 # 플러터 토스트 패키지
- go_router: ^6.2.0 # 기존 플러터 라우팅을 대체하는 라우팅 패키지
- retrofit: '>=3.0.0 <4.0.0' # HTTP Communicating 추상화 라이브러리, 주로 Repository 구성 시 활용된다.
- logger: any  #for logging purpose
- json_annotation: ^4.8.0 # 직렬화/역직렬화를 위한 어노테이션이 포함된 패키지, 주로 From model to json, From json to model 간의 직렬화/역직렬화를 위해 사용된다.
- intl: ^0.17.0 # 다국어지원 패키지, DateFormatting 등의 기능을 지원한다.
- skeletons: ^0.0.3 # 스켈레톤 패키지, 기본으로 제공해주는 스켈레톤 컴포넌트들이 있으며, 사용자가 직접 스켈레톤의 형식을 간편히 컴포넌트의 형태로 지정하여 사용할 수 있다.
- uuid: ^3.0.7 # UUID 패키지
- carousel_slider: ^4.2.1 # 캐러셀 패키지
- wechat_assets_picker: ^8.4.0 # Wechat 이미지/영상 Picker
- shared_preferences: ^2.0.18 # Web 에서의 Cookie 에 상응하는 메모리 데이터 저장 패키지
- flutter_isolate: ^2.0.4 # Main Thread 이외에 Background 로직 동작을 위해 필요한 패키지
- permission_handler: ^10.2.0 # 앱의 허가(활동, 카메라 등) 등을 대행하는 패키지
- path_provider: ^2.0.13 # Path 등을 보다 간편하게 관리할 수 있는 패키지, JS 계열의 path 에 상응

### 개발용 패키지
- riverpod_generator: ^1.2.0 # RiverPod 을 generate 하기 위한 패키지
- retrofit_generator: '>=4.0.0 <5.0.0' # Retrofit 을 generate 하기 위한 패키지
- build_runner: '>=2.3.0 <4.0.0' # g.dart 파일 Generate 를 위한 패키지
- json_serializable: ^6.6.1 # 직렬화/역직렬화 코어 패키지

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
