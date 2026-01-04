# HWP Viewer - Development Notes

## Project Overview
HWP/HWPX 파일 뷰어 iOS 앱 (Flutter 기반)
광고 없이 깔끔하게 한글 문서를 열람할 수 있는 앱

## Tech Stack
- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **Database**: SQLite (sqflite)
- **Document Rendering**: WebView (flutter_inappwebview)
- **Archive Handling**: archive (for HWPX zip extraction)
- **XML Parsing**: xml

---

## Issues & Solutions

### 1. FileType 네이밍 충돌
**문제**: `file_picker` 패키지의 `FileType` enum과 앱 내부의 `FileType` enum 이름 충돌

**해결**: 
```dart
import 'package:file_picker/file_picker.dart' as picker;
// 사용 시
picker.FileType.custom
```

### 2. AppThemeMode vs ThemeMode 타입 불일치
**문제**: 커스텀 `AppThemeMode` enum을 MaterialApp의 `themeMode`에 직접 할당 불가

**해결**:
```dart
// ref.watch로 상태 변경 감지
ref.watch(themeProvider);
// ref.read로 변환된 ThemeMode 가져오기  
final themeMode = ref.read(themeProvider.notifier).themeMode;
```

### 3. withOpacity deprecated
**문제**: Flutter 최신 버전에서 `Color.withOpacity()` deprecated

**해결**:
```dart
// Before
AppColors.primary.withOpacity(0.2)

// After
AppColors.primary.withValues(alpha: 0.2)
```

### 4. iOS 빌드 (Windows 환경)
**문제**: Windows에서 `flutter build ios` 실행 불가

**해결**: iOS 빌드는 Mac에서만 가능. Windows에서는 다음만 가능:
- `flutter analyze` - 코드 분석
- `flutter pub get` - 의존성 설치
- 코드 작성 및 테스트 (non-iOS)

### 5. HWPX XML 파싱 시 한글 깨짐
**문제**: `String.fromCharCodes()`로 ZIP 파일 내 XML 읽을 때 UTF-8 인코딩 깨짐

**해결**:
```dart
// Before (한글 깨짐)
final xmlContent = String.fromCharCodes(contentFile.content);

// After (정상)
import 'dart:convert';
final xmlContent = utf8.decode(contentFile.content, allowMalformed: true);
```

### 6. 검색 기능 XSS 취약점 (2026-01-04 수정)
**문제**: `viewer_screen.dart`에서 검색어를 JavaScript에 직접 삽입하여 XSS 공격 가능

**해결**:
```dart
// JavaScript 문자열 이스케이프 함수 추가
String _escapeForJavaScript(String input) {
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll("'", "\\'")
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\r', '\\r');
}

// RegExp 특수문자 이스케이프 함수 추가
String _escapeRegExp(String input) {
  return input.replaceAllMapped(
    RegExp(r'[.*+?^${}()|[\]\\]'),
    (match) => '\\${match.group(0)}',
  );
}

// 사용 시
final escapedQuery = _escapeForJavaScript(_escapeRegExp(query));
```

### 7. WebView 보안 설정 (2026-01-04 수정)
**문제**: `allowFileAccess`, `allowContentAccess` 활성화로 로컬 파일 접근 가능

**해결**:
```dart
InAppWebViewSettings(
  // 보안: 로컬 파일 접근 차단
  allowFileAccess: false,
  allowContentAccess: false,
  allowUniversalAccessFromFileURLs: false,
  allowFileAccessFromFileURLs: false,
)
```

추가로 HTML에 Content Security Policy 헤더 추가:
```html
<meta http-equiv="Content-Security-Policy"
      content="default-src 'none'; style-src 'unsafe-inline'; img-src data: blob:; script-src 'unsafe-inline';">
```

### 8. ThemeProvider 인덱스 범위 오류 (2026-01-04 수정)
**문제**: SharedPreferences에 저장된 인덱스가 enum 범위를 벗어나면 RangeError 발생

**해결**:
```dart
final themeIndex = prefs.getInt(_themeKey) ?? 0;
// 범위 검증 추가
if (themeIndex >= 0 && themeIndex < AppThemeMode.values.length) {
  state = AppThemeMode.values[themeIndex];
} else {
  state = AppThemeMode.system;
}
```

### 9. DatabaseHelper close() 레이스 컨디션 (2026-01-04 수정)
**문제**: `close()` 호출 후 다른 스레드가 `database` getter 호출 시 닫힌 DB 접근 가능

**해결**:
```dart
Future<void> close() async {
  // null을 먼저 설정하여 재초기화 방지
  final db = _database;
  if (db != null) {
    _database = null;
    await db.close();
  }
}
```

### 10. HWP 바이너리 파싱 범위 오류 (2026-01-04 수정)
**문제**: `_extractTextFromBinary`에서 `i++` 후 다음 반복에서 `bytes[i+1]` 접근 시 범위 초과

**해결**:
```dart
// for 루프 대신 while 루프로 변경, i += 2로 명시적 증가
int i = 0;
final maxIndex = bytes.length - 1;
while (i < maxIndex) {
  // Hangul 발견 시
  i += 2; // 두 바이트 모두 건너뜀
  continue;
}
```

### 11. 대용량 파일 UI 블로킹 (2026-01-04 수정)
**문제**: 큰 HWP 파일 파싱 시 메인 스레드 블로킹

**해결**: 100KB 이상 파일은 `compute()`로 Isolate 처리
```dart
if (bytes.length > 100 * 1024) {
  return await compute(_parseInBackground, _ParseParams(bytes, extension));
}
```

---

## Mac에서 빌드 및 배포 절차

### 1. 앱 아이콘 생성
```bash
# assets/icons/app_icon.png 파일 준비 (1024x1024px, PNG, no alpha)
flutter pub get
dart run flutter_launcher_icons
```

### 2. iOS 빌드
```bash
# 코드 분석
flutter analyze

# iOS 빌드 (개발용)
flutter build ios --debug

# iOS 빌드 (배포용)
flutter build ios --release
```

### 3. Xcode 설정
1. `ios/Runner.xcworkspace` 열기
2. Runner > Signing & Capabilities에서:
   - Team 설정
   - Bundle Identifier 확인: `com.yourname.hwpviewer`
3. General > Deployment Info:
   - iOS 15.0+ 권장

### 4. App Store 제출
1. Xcode에서 Product > Archive
2. Window > Organizer에서 Validate App
3. Distribute App > App Store Connect

---

## 파일 구조

```
lib/
├── main.dart                 # 앱 진입점
├── app.dart                  # 메인 앱 + 탭 네비게이션
├── core/
│   ├── theme/                # 전체 테마 시스템
│   ├── constants/            # 상수
│   ├── utils/                # 유틸리티 (파일 검증 포함)
│   ├── errors/               # 커스텀 예외 클래스 (AppException 등)
│   └── database/             # SQLite 설정
├── features/
│   ├── file_browser/         # 파일 브라우저
│   ├── viewer/               # 문서 뷰어 (XSS 방어, CSP 적용)
│   ├── recents/              # 최근 파일
│   └── settings/             # 설정
└── shared/
    ├── widgets/              # 공유 위젯
    ├── providers/            # Riverpod 프로바이더 (에러 로깅 포함)
    └── services/             # 서비스 (file_handler)

test/
└── unit/                     # 단위 테스트
    ├── file_utils_test.dart
    ├── theme_provider_test.dart
    └── app_exceptions_test.dart
```

---

## HWP/HWPX 파싱 제한사항

### HWPX (잘 동작)
- ZIP 압축 해제 후 XML 파싱
- Contents/section0.xml 등에서 텍스트 추출
- HTML로 변환하여 WebView 렌더링

### HWP 5.0 (제한적 지원)
- 바이너리 포맷으로 완전한 파싱 어려움
- 현재는 텍스트 추출만 시도
- OLE 구조 분석 필요 (libhwp 참조)

### 향후 개선 방향
1. libhwp 또는 hancom-office-sdk 연동 검토
2. WASM 기반 hwp.js 포팅 검토
3. 서버 사이드 변환 API 고려

---

## 테스트 체크리스트

### 기능 테스트
- [ ] 파일 브라우저에서 HWP/HWPX 파일 선택
- [ ] iCloud Drive 접근
- [ ] 문서 뷰어 렌더링
- [ ] 검색 기능
- [ ] 공유 기능
- [ ] 최근 파일 목록
- [ ] 테마 변경 (라이트/다크/시스템)
- [ ] 외부 앱에서 파일 열기

### 호환성 테스트
- [ ] iPhone SE (작은 화면)
- [ ] iPhone 15 Pro Max (큰 화면)
- [ ] iPad
- [ ] iOS 15, 16, 17

---

## 주의사항

1. **광고 금지**: 핵심 차별점이므로 절대 광고 추가하지 않음
2. **HWP 5.0 완벽 지원 약속 금지**: 현재 파서는 제한적
3. **개인정보 수집 없음**: App Store 제출 시 명시
4. **오프라인 동작**: 네트워크 불필요

---

## Dependencies 업데이트

```bash
# 업데이트 가능한 패키지 확인
flutter pub outdated

# 주요 패키지 업데이트 (호환성 확인 후)
flutter pub upgrade
```

---

## 문의 및 피드백
설정 화면에서 이메일 문의 기능 제공
