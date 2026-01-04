# Modern App Design Principles

> AI Agent를 위한 "요즘 앱" 디자인 가이드
> 이 원칙을 따르면 사용자가 "세련됐다", "요즘 앱 같다", "있어 보인다"고 느끼는 앱을 만들 수 있다.

---

## 목차

1. [핵심 원칙](#part-1-핵심-원칙) - 5대 원칙
2. [MUST 규칙](#part-2-must-규칙-필수) - 필수 (없으면 옛날 앱) + 접근성
3. [SHOULD 규칙](#part-3-should-규칙-권장) - 권장 (있으면 세련된 앱)
4. [MAY 규칙](#part-4-may-규칙-선택) - 선택 (있으면 프리미엄 앱)
5. [공통 UI 패턴](#part-5-공통-ui-패턴) - 리스트, 카드, 모달, 폼
6. [수치 레퍼런스](#part-6-수치-레퍼런스) - 간격, 타이포, 컬러, 반응형
7. [구현 체크리스트](#part-7-구현-체크리스트) - 자가 검증용
8. [안티패턴](#part-8-안티패턴-하지-말-것) - 하지 말 것
9. [빠른 참조 카드](#part-9-빠른-참조-카드) - 한눈에 보기
10. [2024-2025 트렌드](#part-10-2024-2025-트렌드-참고) - 최신 트렌드 참고

---

## 언제 이 가이드를 참조하는가

- UI 컴포넌트를 새로 만들 때
- 색상, 간격, 타이포그래피 값을 결정할 때
- 애니메이션/트랜지션을 구현할 때
- 다크모드를 구현할 때
- 디자인 리뷰/검증할 때

---

## 이 문서의 사용법

- **MUST**: 필수. 미적용 시 "옛날 앱" 느낌
- **SHOULD**: 권장. 적용 시 "세련된 앱" 느낌  
- **MAY**: 선택. 적용 시 "프리미엄 앱" 느낌
- 수치는 **기본값**으로 제시. 범위가 아닌 단일 값 우선 적용

---

## Part 1: 핵심 원칙

### 5대 원칙

| # | 원칙 | 설명 |
|---|------|------|
| 1 | **여백이 품격이다** | 빽빽한 UI = 저가 느낌. 넉넉한 여백 = 프리미엄 |
| 2 | **일관성이 신뢰다** | 색상, 간격, 모서리, 아이콘 스타일 전체 통일 |
| 3 | **피드백이 생명이다** | 모든 터치/클릭에 즉각적인 시각적 반응 필수 |
| 4 | **단순함이 세련됨이다** | 요소가 적을수록 남은 요소가 돋보인다 |
| 5 | **디테일이 프리미엄이다** | 미세한 그림자, 정교한 애니메이션, 정렬 완벽 |

---

## Part 2: MUST 규칙 (필수)

> 이것들이 없으면 "요즘 앱"이 아니다

### 2.1 컬러

```
MUST: 기본 색상 시스템 (별도 브랜드 컬러 없으면 이 값 사용)

Primary (브랜드 컬러 - 기본값: 블루)
├── primary:        #2563EB  (메인 버튼, 강조)
├── primary-hover:  #1D4ED8  (호버 상태)
├── primary-light:  #DBEAFE  (배경 강조)
└── primary-dark:   #1E40AF  (pressed 상태)

Neutral (무채색 - 라이트모드)
├── white:          #FFFFFF  (카드 배경)
├── gray-50:        #FAFAFA  (페이지 배경)
├── gray-100:       #F4F4F5  (섹션 구분 배경)
├── gray-200:       #E4E4E7  (구분선, 비활성 보더)
├── gray-300:       #D4D4D8  (비활성 요소)
├── gray-400:       #A1A1AA  (플레이스홀더)
├── gray-500:       #71717A  (보조 텍스트)
├── gray-600:       #52525B  (본문 텍스트)
├── gray-700:       #3F3F46  (강조 본문)
├── gray-800:       #27272A  (제목)
├── gray-900:       #18181B  (최강조 제목)
└── black:          #09090B  (특수 강조)

Semantic (상태 표시)
├── success:        #10B981  (완료, 성공)
├── success-light:  #D1FAE5  (성공 배경)
├── warning:        #F59E0B  (주의)
├── warning-light:  #FEF3C7  (경고 배경)
├── error:          #EF4444  (오류, 삭제)
├── error-light:    #FEE2E2  (에러 배경)
├── info:           #3B82F6  (정보)
└── info-light:     #DBEAFE  (정보 배경)

MUST: 고채도 원색 금지
- 금지: #FF0000, #00FF00, #0000FF (원색 그대로)
- 권장: 채도를 낮추거나 톤을 조정한 색상
```

### 2.2 타이포그래피

```
MUST: 기본 폰트 - Pretendard

폰트 스택 (CSS):
font-family: 'Pretendard Variable', Pretendard, -apple-system, 
             BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 
             'Segoe UI', 'Apple SD Gothic Neo', 'Noto Sans KR', 
             'Malgun Gothic', 'Apple Color Emoji', 'Segoe UI Emoji', 
             'Segoe UI Symbol', sans-serif;

설치:
- CDN: https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css
- npm: npm install pretendard

MUST: 타이포그래피 스케일 (구체적 값)

| 용도 | 크기 | Weight | Line-height | Letter-spacing |
|------|------|--------|-------------|----------------|
| Display | 36px | Bold (700) | 1.2 (43px) | -0.02em |
| H1 | 28px | Bold (700) | 1.3 (36px) | -0.01em |
| H2 | 22px | SemiBold (600) | 1.35 (30px) | -0.01em |
| H3 | 18px | SemiBold (600) | 1.4 (25px) | 0 |
| Body Large | 17px | Regular (400) | 1.6 (27px) | 0 |
| Body | 15px | Regular (400) | 1.6 (24px) | 0 |
| Body Small | 14px | Regular (400) | 1.5 (21px) | 0 |
| Caption | 12px | Medium (500) | 1.4 (17px) | 0.01em |
| Overline | 11px | SemiBold (600) | 1.4 (15px) | 0.05em |

MUST: 가독성 규칙
- 본문 최소 크기: 15px (14px은 Caption에만)
- 줄 간격: 본문 1.5-1.6, 제목 1.2-1.4
- 금지: 장식적 폰트를 본문에 사용

MUST: Dynamic Type 지원 (접근성)
- 사용자 시스템 폰트 크기 설정 존중
- iOS 사용자 25%가 텍스트 크기 조정 사용
- 테스트 필수: xSmall, Large(기본), xxxLarge, AX5(접근성)
- 중요 정보 잘림 금지 (스크롤/줄바꿈 사용)
- 텍스트 포함 이미지: 큰 사이즈에서 실패 → 피하기

레이아웃 전략:
- 작은 텍스트: 단일 컬럼 적응
- 큰 텍스트: 가로→세로 스택으로 리플로우 필요할 수 있음

SHOULD: Optical Sizing (광학 사이즈)
- 큰 타입은 작은 타입과 다른 letterform 필요
- SF Pro는 광학 사이즈 내장

| 크기 | 설정 | 자간 | 참고 |
|------|------|------|------|
| < 12pt | SF Pro Text | +0.2pt | 가독성 위해 느슨하게 |
| 12-19pt | SF Pro Text | 0 | 기본 |
| 20-34pt | SF Pro Display | -0.5pt | 우아함 위해 타이트하게 |
| 35pt+ | SF Pro Display | -1.0pt | 타이트, 가는 획 |

Variable fonts: 'opsz' 축 사용 가능 시 활용
Fallback: 수동으로 자간 조정

SHOULD: 반응형 타이포그래피
- 플랫폼별 기본 크기 차이 고려
- iOS 시스템 기본: 17pt (San Francisco)
- 웹 브라우저 기본: 16px

| 플랫폼 | Body 권장 | Body Large 권장 |
|--------|-----------|-----------------|
| 모바일 앱 | 15-16px | 17px |
| 데스크탑 웹 | 16px | 18px |
| 읽기 중심 콘텐츠 | 17-18px | 20px |

SHOULD: 수직 리듬 (Baseline Grid)
- 모든 간격을 기본 단위의 배수로 (4px 또는 8px)
- line-height로 baseline을 그리드에 정렬

예시 (8px 기본):
- Body: 16px / 24px (24 = 3 x 8)
- Caption: 12px / 16px (16 = 2 x 8)
- Heading: 24px / 32px (32 = 4 x 8)
- 문단 마진: 16px (2 x 8)

검증: 그리드 오버레이로 baseline 정렬 확인
```

### 2.3 여백과 간격

```
MUST: 8pt 그리드 시스템 사용
- 모든 간격은 8의 배수: 8, 16, 24, 32, 40, 48, 56, 64
- 최소 단위: 4px (미세 조정용)

MUST: 최소 여백 기준
- 컴포넌트 간 간격: 16px 이상
- 섹션 간 간격: 32px 이상
- 화면 좌우 패딩: 16px 이상
- 카드 내부 패딩: 16px 이상

MUST: 터치 영역 확보
- 최소 터치 영역: 44x44px
- 권장 터치 영역: 48x48px
- 터치 요소 간 간격: 8px 이상
```

### 2.4 컴포넌트 기본

```
MUST: 모서리 라운딩 적용
- 버튼: 8px 이상
- 카드: 12px 이상
- 입력 필드: 8px 이상
- 모달/바텀시트: 16px 이상 (상단)
- 완전한 원형: 9999px 또는 50%

MUST: 중첩 요소 라운딩 공식
- 공식: 내부 radius = 외부 radius - padding
- 예시: 외부 24px, 패딩 8px → 내부 16px
- 이유: 동일 radius 적용 시 시각적 불균형 발생

MUST: 버튼 기본 스펙
- 높이: 48px (기본), 40px (작은), 56px (큰)
- 좌우 패딩: 24px 이상
- 폰트: 16px, SemiBold(600)
```

### 2.5 피드백과 상태

```
MUST: 모든 인터랙티브 요소에 상태 변화
- Default → Hover → Pressed → Disabled 4단계 필수
- Pressed 상태: scale(0.97) 또는 opacity 변화
- Disabled 상태: opacity: 0.4, cursor: not-allowed

MUST: 로딩 상태 표시
- 데이터 로드 시: 스켈레톤 UI 또는 로딩 인디케이터
- 버튼 액션 시: 버튼 내 로딩 스피너
- 금지: 빈 화면 방치, 무반응 상태
```

### 2.6 접근성 (Accessibility)

```
MUST: 색상 대비 (Contrast)
- 텍스트-배경 대비: 4.5:1 이상 (WCAG AA 기준)
- 대형 텍스트 (18px+, Bold 14px+): 3:1 이상
- 검증 도구: WebAIM Contrast Checker
- 금지: 연한 회색 텍스트 on 흰 배경 (대비 부족)

MUST: 작은 텍스트 명도 규칙
- 14px 미만 텍스트: gray-600(#52525B) 이상 사용 필수
- gray-500(#71717A)은 15px 이상에서만 사용
- 이유: gray-500은 흰 배경에서 대비비 4.5:1 경계선에 위치
- Caption(12px)에는 반드시 gray-600 이상 + Medium(500) weight 조합

MUST: 색상 외 정보 전달
- 오류 상태: 색상 + 아이콘 + 텍스트 (다중 수단)
- 필수 필드: * 표시 + "필수" 텍스트 또는 레이블
- 성공/실패: 색상만 의존 금지, 아이콘/텍스트 병행
- 이유: 색맹 사용자 대응 (전체 남성 8%, 여성 0.5%)

MUST: 터치 타겟 간격
- 터치 요소 간 최소 간격: 8px (WCAG 2.2 권장)
- 밀집 버튼 배치 금지

MUST: Flutter Semantics
```dart
// 스크린 리더용 접근성 레이블
Semantics(
  label: '장바구니에 추가',
  button: true,
  child: IconButton(
    icon: Icon(Icons.add_shopping_cart),
    onPressed: () {},
  ),
)

// 이미지 대체 텍스트
Image.asset(
  'assets/product.png',
  semanticLabel: '빨간색 운동화 측면 이미지',
)

// 폼 필드 접근성
TextFormField(
  decoration: InputDecoration(
    labelText: '이메일',
    hintText: 'example@email.com',
  ),
)
```

SHOULD: 모션 감소 대응
```dart
// 사용자가 시스템에서 모션 감소 설정 시 애니메이션 최소화
final reduceMotion = MediaQuery.of(context).disableAnimations;
final duration = reduceMotion ? Duration.zero : AppDurations.normal;
```

SHOULD: 포커스 표시
- 키보드/스위치 컨트롤 사용자를 위한 명확한 포커스 링
- 포커스 색상: Primary 또는 고대비 색상
- 포커스 링 두께: 2px 이상
```

### 2.7 다크모드

```
MUST: 다크모드 지원
- 시스템 설정 연동 필수
- 수동 전환 옵션 제공

MUST: 다크모드 색상 (구체적 값)

배경 레이어
├── dark-bg:          #0A0A0B  (최하단 배경)
├── dark-surface-1:   #18181B  (카드, 컨테이너)
├── dark-surface-2:   #27272A  (상승된 요소, 모달)
├── dark-surface-3:   #3F3F46  (호버 배경)
└── dark-border:      #27272A  (구분선, 보더)

텍스트
├── dark-text-primary:   rgba(255,255,255,0.92)  (제목, 강조)
├── dark-text-secondary: rgba(255,255,255,0.72)  (본문)
├── dark-text-tertiary:  rgba(255,255,255,0.48)  (보조, 캡션)
└── dark-text-disabled:  rgba(255,255,255,0.32)  (비활성)

Primary (다크모드용)
├── dark-primary:       #3B82F6  (밝기 조정)
└── dark-primary-light: #1E3A5F  (버튼 배경)

MUST: 다크모드 카드/컨테이너 경계
- 그림자가 잘 보이지 않으므로 보더 또는 색상 차이 필수
- 카드 보더: 1px solid rgba(255,255,255,0.08)
- 호버 시 보더: 1px solid rgba(255,255,255,0.12)
- Elevation Overlay: 표면 색상 밝기 차이로 구분
- 예시: 배경 #0A0A0B → 카드 #18181B → 모달 #27272A

MUST: 금지 사항
- 순수 검정 (#000000) 배경 금지 → 최소 #0A0A0B
- 순수 흰색 (#FFFFFF) 텍스트 금지 → 최대 rgba(255,255,255,0.92)
- 다크모드에서 그림자만으로 깊이 표현 금지 → 보더 또는 색상 차이 필수
```

### 2.8 광학 보정 (Optical Compensation)

```
MUST: 시각적 중앙 정렬 (Optical Centering)
- 수학적 중앙 ≠ 시각적 중앙
- 버튼 내 텍스트: 1-2px 위로 조정 (descender로 인한 불균형 보정)
- 원 안의 재생 아이콘: 5-8% 오른쪽으로 이동 (삼각형 무게중심 보정)
- 둥근 사각형 옆 텍스트: 왼쪽 패딩 1px 추가

MUST: 픽셀 정렬
- 모든 치수는 1x 렌더링 시 정수로 귀결되어야 함
- 스트로크: 중앙 정렬 시 짝수 너비 사용 (1px, 2px)
- 0.5px 오프셋 = 흐릿한 2px 렌더링 → 금지
- 아이콘: 24x24 기본, 1x 렌더링에서 확인

검증법: 요소를 흐리게 해서 봤을 때 중앙으로 보이는가?
```

### 2.9 에러 방지 우선 (Error Prevention)

```
MUST: 에러 방지 > 에러 메시지
- 최고의 에러 처리는 에러가 발생할 수 없게 만드는 것

에러 방지 우선순위:
1. 방지: 유효하지 않은 액션 비활성화 (폼 미완성 시 버튼 비활성화)
2. 제한: 입력을 유효한 값으로 제한 (텍스트 필드 대신 날짜 피커)
3. 제안: 인라인 자동완성/교정
4. 확인: 파괴적 액션에만 "정말로?" 확인
5. 복구: 에러 메시지 + 명확한 복구 경로 (최후의 수단)

안티패턴: 입력 허용 → 제출 → 에러 표시
프로패턴: 실시간 검증 → 유효할 때까지 제출 비활성화
```

### 2.10 플랫폼 네이티브 우선

```
MUST: 플랫폼 컨벤션 존중
- 사용자가 OS에서 기대하는 것을 오버라이드하지 않기

iOS 필수:
□ 뒤로가기 = 엣지 스와이프 (버튼 아님)
□ 탭 바는 하단에 (햄버거 메뉴 X)
□ Pull-to-refresh = 네이티브 스피너
□ Android 스타일 뒤로가기 버튼 금지

Android 필수:
□ Material 하단 내비게이션 또는 Drawer
□ 시스템 뒤로가기 버튼 정상 작동
□ 주요 생성 액션에 FAB 사용

웹 필수:
□ 브라우저 뒤로/앞으로 정상 작동
□ 우클릭 하이재킹 금지
□ 표준 스크롤바 (커스텀이 가치를 더할 때만)
□ 링크는 링크처럼 보이게

크로스플랫폼: 일관성보다 각 플랫폼에 맞추기
```

### 2.11 네이티브 컴포넌트 우선

```
MUST: 가능하면 네이티브 컴포넌트 사용
- 네이티브 피커, 시트, 알럿 = 자동 접근성, 햅틱, OS 업데이트 혜택

우선순위:
1. 시스템 컴포넌트 (최우선) - 시트, 알럿, 피커
2. 플랫폼 확장 컴포넌트 - 스타일링된 네이티브
3. 커스텀 컴포넌트 (고유 요구사항 있을 때만)

예시:
- 날짜 피커: 항상 네이티브 (접근성, 현지화)
- 액션 시트: iOS에서 네이티브, 웹에서 커스텀
- 토스트/스낵바: 커스텀 가능 (iOS에 네이티브 없음)

커스텀 정당화: 왜 네이티브가 안 되는지 명시적으로 설명 필요
```

---

## Part 3: SHOULD 규칙 (권장)

> 적용하면 확실히 "세련된 앱" 느낌

### 3.1 애니메이션

```
SHOULD: 애니메이션 타이밍 기준
- 화면 전환: 300ms
- 요소 등장/퇴장: 200ms
- 호버/포커스: 150ms
- 미세 피드백: 100ms
- 시스템 애니메이션 최대 길이: 500ms (절대 제한)

SHOULD: Easing 함수 사용
- 요소 진입: ease-out (cubic-bezier(0.0, 0.0, 0.2, 1))
- 상태 변화: ease-in-out (cubic-bezier(0.4, 0.0, 0.2, 1))
- 바운스 효과: cubic-bezier(0.34, 1.56, 0.64, 1)
- 금지: linear (기계적 느낌)

SHOULD: 순차 등장 (Stagger Animation)
- 리스트/카드 등장 시: 30-50ms 간격으로 순차 등장
- 읽기 순서 기준 (좌→우, 상→하)
- 컨테이너 먼저, 내용물 나중에
- 인터랙티브 요소(CTA 버튼)는 마지막에

SHOULD: 모션 안무 (Choreography)
- 관련 요소는 함께 움직임 (그룹 단위 애니메이션)
- 비관련 요소는 독립적으로 움직임
- 진입 순서: 컨테이너 → 주요 콘텐츠 → 보조 콘텐츠 → CTA
- 퇴장 순서: 인터랙티브 → 콘텐츠 → 컨테이너 (진입의 역순)

SHOULD: 모션 인터럽트 가능성 (Interruptibility)
- 모든 터치는 즉시 애니메이션 제어권 획득
- 모멘텀은 새 제스처로 자연스럽게 전이
- 애니메이션 취소 시 가장 가까운 유효 상태로 (스냅 금지)
- 권장: 스프링 물리 기반 애니메이션 (고정 duration 대신)

SHOULD: 의미 있는 모션만 사용
- 목적 있는 애니메이션: 상태 전달, 시선 유도, 피드백
- 금지: 장식적 애니메이션, 과도한 효과

SHOULD: 모션 의도 프레임워크
- 애니메이션 전 질문: 
  1. 어떤 공간 관계를 전달하는가? → 트리거에서 확장
  2. 사용자 주의 상태는? → 진입 시 모션 리드, 퇴장 시 모션 팔로우
  3. 어떤 액션이 이것을 유발했는가? → 직접 조작은 즉시, 시스템 발생은 페이드인
- 의도를 설명할 수 없으면 해당 애니메이션 제거
```

```dart
// 순차 등장 예시 (Flutter)
class StaggeredList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: AppDurations.normal,
          // 각 아이템에 30ms씩 딜레이
          curve: Interval(
            (index * 0.03).clamp(0.0, 1.0),
            ((index * 0.03) + 0.3).clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
          child: items[index],
        );
      },
    );
  }
}
```

### 3.2 그림자와 깊이

```
SHOULD: 미묘한 그림자로 깊이감
- 카드 기본: 0 2px 8px rgba(0,0,0,0.08)
- 카드 호버: 0 4px 16px rgba(0,0,0,0.12)
- 모달/팝업: 0 8px 32px rgba(0,0,0,0.16)
- 금지: 순수 검정(#000) 그림자, 과도한 blur

SHOULD: 다크모드 그림자
- 그림자 대신 밝은 보더(1px) 또는 elevation 색상 차이 활용
- 예시: 배경 #121212, 카드 #1E1E1E (색상 차이로 구분)
```

### 3.3 아이콘

```
SHOULD: 통일된 아이콘 스타일
- 한 앱에서 하나의 아이콘 세트만 사용
- Stroke 두께 통일: 1.5px 또는 2px
- 크기 통일: 24x24px 기본, 20x20px 작은, 28x28px 큰

SHOULD: 권장 아이콘 라이브러리
- Lucide (React: lucide-react)
- Phosphor Icons
- Heroicons (Tailwind 친화적)
- 금지: 여러 라이브러리 혼용, Stock 아이콘 무분별 사용
```

### 3.4 입력 필드

```
SHOULD: 입력 필드 스펙
- 높이: 48px
- 패딩: 좌우 16px
- 보더: 1px solid (기본 #E0E0E0, 포커스 시 Primary)
- 라운딩: 8px
- 플레이스홀더: 연한 회색 (#999)

SHOULD: 포커스 상태 강조
- 보더 색상: Primary 컬러
- 추가 효과: 미세한 box-shadow (0 0 0 3px primaryColor/20%)
```

### 3.5 네비게이션

```
SHOULD: 하단 네비게이션 (모바일)
- 항목 수: 3-5개
- 높이: 56px + Safe Area
- 아이콘 + 레이블 조합
- 선택 상태: 색상 변화 + 아이콘 채움(filled)

SHOULD: 상단 헤더
- 높이: 56px
- 뒤로가기: 왼쪽 배치
- 제목: 중앙 또는 왼쪽 (일관성 유지)
- 액션: 오른쪽 배치
```

### 3.6 햅틱 피드백

```
SHOULD: 주요 인터랙션에 햅틱 적용
- 버튼 탭: Light 또는 Medium
- 토글 스위치: Light
- 성공/완료: Success 패턴
- 오류: Warning 패턴
- 금지: 과도한 사용, 백그라운드 동작에 사용

SHOULD: 햅틱 시맨틱 (iOS/Android)
- 햅틱은 의미를 가짐. 잘못된 햅틱 = 혼란

| 햅틱 타입 | 용도 |
|-----------|------|
| .success | 의미 있는 액션 완료 (저장, 전송) |
| .warning | 주의 필요, 에러 아님 (배터리 부족 알림) |
| .error | 액션 실패 또는 차단됨 |
| .selection | 상태 토글 (체크박스, 스위치) |
| .impact(.light) | UI 피드백 (버튼 탭, 스크롤 스냅) |
| .impact(.medium) | 피커 디텐트, 중요한 선택 |
| .impact(.heavy) | 물리적 메타포용 (드롭) - 거의 사용 안 함 |

금지:
- 시맨틱 혼용 (에러에 success 햅틱 금지)
- 과다 사용 (모든 탭에 햅틱 금지)
```

### 3.7 상태 전이 매트릭스

```
SHOULD: 상태 간 전환 시간 정의
- 모든 상태(rest, hover, pressed, disabled) 전환에 의도적 타이밍 필요

| 시작 → 도착 | Duration | 이유 |
|-------------|----------|------|
| Rest → Hover | 150ms | 자연스러운 반응 |
| Rest → Pressed | 50ms | 즉각적 피드백 (빠르게!) |
| Rest → Disabled | 200ms | 놀라지 않게 |
| Hover → Pressed | 50ms | 즉각적 피드백 |
| Hover → Rest | 100ms | 자연스러운 복귀 |
| Pressed → Rest | 100ms | 완료 확인 |
| Pressed → Hover | 100ms | 손가락 뗌 |
| Any → Disabled | 200ms | 부드럽게 |

핵심:
- Pressed 전환은 빠르게 (입력 즉시 인정)
- Disabled 전환은 느리게 (놀라지 않게)
- 중단된 애니메이션은 가장 가까운 유효 상태로 완료
```

### 3.8 콘텐츠 우선 원칙

```
SHOULD: 콘텐츠가 인터페이스다 (Deference to Content)
- UI는 배경으로, 콘텐츠가 주인공
- Apple의 Photos, Music, TV+가 대표적

실천 가이드:
- UI 컨트롤은 콘텐츠보다 낮은 시각적 weight
- "이 컨트롤이 필요할 때까지 숨길 수 있나?" 질문
- 테스트: 모든 UI 요소를 가려도 콘텐츠가 말하는가?
- 비활성 컨트롤 opacity: 60-70% (숨기지 않되 deferred)
- 오버레이에는 단색 배경보다 배경 블러(materials) 선호

SHOULD: 의미 있는 깊이 (Depth as Meaning)
- 그림자와 elevation은 장식이 아닌 정보
- 깊이는 "어디서 왔는가? 어디로 가는가?"에 답해야 함

시맨틱 깊이 시스템:
- Layer 0: 기본 콘텐츠 (그림자 없음)
- Layer 1: 상승된 콘텐츠 (4px blur, 5% opacity)
- Layer 2: 모달/오버레이 (16px blur, 15% opacity)
- Layer 3: 시스템 레벨 (24px blur, 25% opacity)

규칙:
- 요소는 출발한 레이어로 돌아가야 함
- 높은 레이어 = 더 일시적 (빨리 닫힘)
```

### 3.9 예측 디자인 (Anticipatory Design)

```
SHOULD: 사용자가 원하기 전에 예측
- 예: 프리로딩, 스마트 기본값, 예측 텍스트

예측 패턴:
- 기본값: 가장 가능성 높은 선택 미리 선택
- 프리페칭: 다음 예상 화면 백그라운드 로드
- 폼 프리필: 이전 입력 기억/제안
- 컨텍스트 옵션: 현재 관련 액션만 표시
- 자동 저장: "변경사항 저장?" 묻지 않기 - 그냥 저장

원칙: 사용자가 "뭘 해야 하지?" 생각하는 순간마다 실패
측정: 작업당 결정 횟수 - 적을수록 좋음

SHOULD: 흐름 지속성 (Continuation of Flow)
- 중단은 정확히 그 지점에서 복원되어야 함
- 결제 중 전화 → 복귀 → 장바구니 그대로

상태 지속성 체크리스트:
□ 스크롤 위치 복원
□ 저장 안 된 폼 데이터 백그라운딩 생존
□ 선택 항목 네비게이션 생존
□ 실행취소 히스토리 세션 생존
□ 딥링크가 전체 컨텍스트 복원

기술: 세션 스토리지 + 상태 직렬화
테스트: 작업 중 앱 강제 종료 후 재실행 - 컨텍스트 유지되는가?
```

### 3.10 입력 방식 적응

```
SHOULD: 활성 입력 방식에 최적화
- 터치, 포인터, 키보드, 음성에 따라 다르게

| 입력 | 타겟 크기 | Hover 상태 | 포커스 링 |
|------|-----------|------------|-----------|
| Touch | 44pt 최소 | 비활성화 | 숨김 |
| Pointer | 24pt 최소 | 활성화 | 키보드 시 |
| Keyboard | N/A | N/A | 항상 |
| Hybrid | 44pt 최소 | 활성화 | 활성화 |

감지 방법 (CSS):
- @media (pointer: coarse) → 터치 주력
- @media (hover: hover) → 포인터 사용 가능
- :focus-visible → 키보드 네비게이션 활성

iPad + 키보드 ≠ iPad 터치 전용
터치 있는 랩탑 ≠ 트랙패드만 있는 랩탑
```

---

## Part 4: MAY 규칙 (선택)

> 적용하면 "프리미엄 앱" 느낌

### 4.1 글래스모피즘 (Glassmorphism)

```
MAY: 글래스 효과 적용
- 배경: rgba(255, 255, 255, 0.7) (라이트모드)
- 블러: backdrop-filter: blur(12px)
- 보더: 1px solid rgba(255, 255, 255, 0.2)
- 적용 대상: 플로팅 요소, 오버레이, 네비게이션 바

주의: 
- 가독성 확보 필수 (뒤 콘텐츠가 방해되면 안 됨)
- 성능 고려 (저사양 기기에서 blur 부담)
```

### 4.2 마이크로인터랙션

```
MAY: 상세한 피드백 애니메이션
- 좋아요 버튼: 하트 팝 애니메이션
- 새로고침: Pull-to-refresh 커스텀 애니메이션
- 완료: 체크마크 드로잉 애니메이션
- 에러: 쉐이크 애니메이션

MAY: 스크롤 연동 효과
- 헤더 축소/확장
- 패럴랙스 효과 (미묘하게)
- 요소 페이드인
```

### 4.3 커스텀 폰트

```
MAY: 브랜드 전용 폰트
- 제목용 커스텀 폰트 1개 추가 가능
- 본문은 가독성 높은 산세리프 유지
- 폰트 로딩 최적화 필수 (FOUT/FOIT 방지)
```

### 4.4 3D 요소

```
MAY: 미묘한 3D 효과
- 카드 호버 시 perspective 기울기
- 아이콘/일러스트에 3D 스타일
- 주의: 과하면 촌스러움, 미묘하게 사용
```

---

## Part 5: 공통 UI 패턴

### 5.1 리스트 아이템

```
기본 구조:
┌─────────────────────────────────────────┐
│ [썸네일] [텍스트 영역      ] [액션/상태] │
│  56x56   제목 (16px Bold)     아이콘    │
│          설명 (14px Gray)     또는      │
│          메타 (12px Light)    버튼      │
└─────────────────────────────────────────┘

수치:
- 아이템 높이: 72px (기본), 88px (상세)
- 썸네일: 48x48 또는 56x56, radius 8px
- 좌우 패딩: 16px
- 요소 간 간격: 12px
- 구분선: 1px #F0F0F0 또는 여백으로 구분
```

### 5.2 카드 레이아웃

```
기본 카드:
┌─────────────────────────┐
│      이미지 영역        │ 비율: 16:9 또는 4:3
│      (썸네일)           │ radius: 상단만 12px
├─────────────────────────┤
│ 제목 (16-18px Bold)     │ 패딩: 16px
│ 설명 (14px Gray)        │
│ [버튼]        [가격]    │
└─────────────────────────┘

수치:
- 카드 radius: 12px
- 그림자: 0 2px 8px rgba(0,0,0,0.08)
- 내부 패딩: 16px
- 요소 간 간격: 8-12px
```

### 5.3 모달/바텀시트

```
바텀시트:
┌─────────────────────────┐
│      ──────            │ 핸들: 40x4px, radius 2px
├─────────────────────────┤
│   제목 (18px Bold)      │ 상단 패딩: 20px
│   설명 (14px)           │
│                         │
│   [콘텐츠 영역]         │
│                         │
│   [Primary 버튼]        │ 하단 패딩: Safe Area + 16px
└─────────────────────────┘

수치:
- 상단 radius: 16-20px
- 핸들 영역 높이: 20px
- 배경 오버레이: rgba(0,0,0,0.5)
```

### 5.4 폼 레이아웃

```
폼 구조:
┌─────────────────────────┐
│ 레이블 (14px Medium)    │ 레이블-필드 간격: 8px
│ ┌─────────────────────┐ │
│ │ 입력 필드           │ │ 높이: 48px
│ └─────────────────────┘ │
│ 헬퍼텍스트 (12px Gray)  │ 필드-헬퍼 간격: 4px
│                         │ 필드 간 간격: 16-20px
│ 레이블                  │
│ ┌─────────────────────┐ │
│ │ 입력 필드           │ │
│ └─────────────────────┘ │
│                         │
│ [Submit 버튼 - Full]    │ 버튼 상단 마진: 24px
└─────────────────────────┘
```

---

## Part 6: 수치 레퍼런스

### 6.1 간격 (Spacing)

| 토큰 | 값 | 용도 |
|------|-----|------|
| space-xs | 4px | 아이콘-텍스트 사이 |
| space-sm | 8px | 관련 요소 간 |
| space-md | 16px | 컴포넌트 간 기본 |
| space-lg | 24px | 그룹 간 |
| space-xl | 32px | 섹션 간 |
| space-2xl | 48px | 대형 섹션 간 |
| space-3xl | 64px | 페이지 레벨 |

### 6.2 타이포그래피 (Pretendard 기준)

| 토큰 | 크기 | Weight | Line-height | 용도 |
|------|------|--------|-------------|------|
| text-display | 36px | 700 | 1.2 | 히어로 제목 |
| text-h1 | 28px | 700 | 1.3 | 페이지 제목 |
| text-h2 | 22px | 600 | 1.35 | 섹션 제목 |
| text-h3 | 18px | 600 | 1.4 | 카드 제목 |
| text-body-lg | 17px | 400 | 1.6 | 강조 본문 |
| text-body | 15px | 400 | 1.6 | 기본 본문 |
| text-body-sm | 14px | 400 | 1.5 | 보조 본문 |
| text-caption | 12px | 500 | 1.4 | 캡션, 레이블 |
| text-overline | 11px | 600 | 1.4 | 오버라인 |

### 6.3 모서리 반경 (Border Radius)

| 토큰 | 값 | 용도 |
|------|-----|------|
| radius-sm | 4px | 태그, 뱃지 |
| radius-md | 8px | 버튼, 입력 필드 |
| radius-lg | 12px | 카드 |
| radius-xl | 16px | 모달, 바텀시트 |
| radius-2xl | 24px | 대형 카드, 이미지 |
| radius-full | 9999px | 원형, 필 버튼 |

### 6.4 그림자 (Elevation)

| 레벨 | 값 | 용도 |
|------|-----|------|
| shadow-sm | 0 1px 2px rgba(0,0,0,0.05) | 미세한 구분 |
| shadow-md | 0 2px 8px rgba(0,0,0,0.08) | 카드 기본 |
| shadow-lg | 0 4px 16px rgba(0,0,0,0.12) | 호버, 드롭다운 |
| shadow-xl | 0 8px 32px rgba(0,0,0,0.16) | 모달, 팝업 |

### 6.5 애니메이션

| 용도 | Duration | Easing |
|------|----------|--------|
| 미세 피드백 | 100ms | ease-out |
| 호버/포커스 | 150ms | ease-out |
| 요소 등장 | 200ms | ease-out |
| 화면 전환 | 300ms | ease-in-out |
| 복잡한 전환 | 400ms | ease-in-out |

### 6.6 반응형 Breakpoints

| 디바이스 | 너비 | 레이아웃 | 패딩 |
|----------|------|----------|------|
| Phone (S) | < 360px | 1컬럼 | 12px |
| Phone (M) | 360-428px | 1컬럼 기본 | 16px |
| Phone (L) | 428-600px | 1컬럼 | 20px |
| Tablet | 600-905px | 2컬럼 가능 | 24px |
| Tablet (L) | 905-1240px | 2-3컬럼 | 32px |
| Desktop | > 1240px | 최대 너비 제한 (1200px) | 40px |

```dart
// lib/core/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;
  
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1240;
  
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1240;
  
  static double screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 12;
    if (width < 428) return 16;
    if (width < 600) return 20;
    if (width < 905) return 24;
    if (width < 1240) return 32;
    return 40;
  }
  
  static int gridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 1;
    if (width < 905) return 2;
    return 3;
  }
}

// 사용 예시
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: Responsive.screenPadding(context),
  ),
  child: GridView.count(
    crossAxisCount: Responsive.gridColumns(context),
    children: [...],
  ),
)
```

### 6.7 SafeArea 패턴

```dart
// lib/core/widgets/safe_scaffold.dart
import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const SafeScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: SafeArea(
        bottom: bottomNavigationBar == null, // 바텀 네비 있으면 false
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar != null
          ? SafeArea(
              top: false,
              child: bottomNavigationBar!,
            )
          : null,
    );
  }
}
```

### 6.8 즉시 사용 가능한 CSS 변수

```css
:root {
  /* ===== Typography ===== */
  --font-family: 'Pretendard Variable', Pretendard, -apple-system, 
                 BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 
                 'Segoe UI', 'Apple SD Gothic Neo', 'Noto Sans KR', 
                 'Malgun Gothic', sans-serif;
  
  /* ===== Colors - Light Mode ===== */
  /* Primary */
  --color-primary: #2563EB;
  --color-primary-hover: #1D4ED8;
  --color-primary-light: #DBEAFE;
  --color-primary-dark: #1E40AF;
  
  /* Neutral (Gray Scale) */
  --color-white: #FFFFFF;
  --color-gray-50: #FAFAFA;
  --color-gray-100: #F4F4F5;
  --color-gray-200: #E4E4E7;
  --color-gray-300: #D4D4D8;
  --color-gray-400: #A1A1AA;
  --color-gray-500: #71717A;
  --color-gray-600: #52525B;
  --color-gray-700: #3F3F46;
  --color-gray-800: #27272A;
  --color-gray-900: #18181B;
  --color-black: #09090B;
  
  /* Semantic */
  --color-success: #10B981;
  --color-success-light: #D1FAE5;
  --color-warning: #F59E0B;
  --color-warning-light: #FEF3C7;
  --color-error: #EF4444;
  --color-error-light: #FEE2E2;
  --color-info: #3B82F6;
  --color-info-light: #E0F2FE;
  
  /* ===== Semantic Mappings ===== */
  --color-bg-primary: var(--color-white);
  --color-bg-secondary: var(--color-gray-50);
  --color-bg-tertiary: var(--color-gray-100);
  --color-text-primary: var(--color-gray-900);
  --color-text-secondary: var(--color-gray-600);
  --color-text-tertiary: var(--color-gray-500);
  --color-text-disabled: var(--color-gray-400);
  --color-border: var(--color-gray-200);
  --color-border-hover: var(--color-gray-300);
  --color-divider: var(--color-gray-100);
  
  /* ===== Spacing (8pt Grid) ===== */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 20px;
  --space-6: 24px;
  --space-8: 32px;
  --space-10: 40px;
  --space-12: 48px;
  --space-16: 64px;
  
  /* ===== Border Radius ===== */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --radius-xl: 16px;
  --radius-2xl: 24px;
  --radius-full: 9999px;
  
  /* ===== Shadows ===== */
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-md: 0 2px 8px rgba(0,0,0,0.08);
  --shadow-lg: 0 4px 16px rgba(0,0,0,0.12);
  --shadow-xl: 0 8px 32px rgba(0,0,0,0.16);
  
  /* ===== Animation ===== */
  --duration-fast: 100ms;
  --duration-normal: 200ms;
  --duration-slow: 300ms;
  --duration-slower: 400ms;
  --ease-out: cubic-bezier(0.0, 0.0, 0.2, 1);
  --ease-in-out: cubic-bezier(0.4, 0.0, 0.2, 1);
  --ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
}

/* ===== Dark Mode ===== */
@media (prefers-color-scheme: dark) {
  :root {
    --color-bg-primary: #0A0A0B;
    --color-bg-secondary: #18181B;
    --color-bg-tertiary: #27272A;
    --color-text-primary: rgba(255,255,255,0.92);
    --color-text-secondary: rgba(255,255,255,0.72);
    --color-text-tertiary: rgba(255,255,255,0.48);
    --color-text-disabled: rgba(255,255,255,0.32);
    --color-border: #27272A;
    --color-border-hover: #3F3F46;
    --color-divider: #27272A;
    --color-primary: #3B82F6;
    --color-primary-light: #1E3A5F;
    
    --shadow-sm: 0 1px 2px rgba(0,0,0,0.3);
    --shadow-md: 0 2px 8px rgba(0,0,0,0.4);
    --shadow-lg: 0 4px 16px rgba(0,0,0,0.5);
    --shadow-xl: 0 8px 32px rgba(0,0,0,0.6);
  }
}
```

### 6.7 Primary 컬러 대안 (브랜드별)

서비스 특성에 맞게 `--color-primary` 값 교체:

| 산업/느낌 | Primary | Hover | Light | 예시 |
|-----------|---------|-------|-------|------|
| 신뢰/금융 | #2563EB | #1D4ED8 | #DBEAFE | 토스, PayPal |
| 에너지/커머스 | #F97316 | #EA580C | #FFEDD5 | 당근, Shopify |
| 성장/친환경 | #10B981 | #059669 | #D1FAE5 | Robinhood |
| 창의/엔터 | #8B5CF6 | #7C3AED | #EDE9FE | Spotify |
| 프리미엄/럭셔리 | #18181B | #09090B | #F4F4F5 | 고급 브랜드 |
| 친근/소셜 | #0EA5E9 | #0284C7 | #E0F2FE | 소셜 앱 |

### 6.8 Tailwind CSS 설정

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      fontFamily: {
        sans: ['Pretendard Variable', 'Pretendard', '-apple-system', 
               'BlinkMacSystemFont', 'system-ui', 'Roboto', 'sans-serif'],
      },
      colors: {
        primary: {
          DEFAULT: '#2563EB',
          hover: '#1D4ED8',
          light: '#DBEAFE',
          dark: '#1E40AF',
        },
        gray: {
          50: '#FAFAFA',
          100: '#F4F4F5',
          200: '#E4E4E7',
          300: '#D4D4D8',
          400: '#A1A1AA',
          500: '#71717A',
          600: '#52525B',
          700: '#3F3F46',
          800: '#27272A',
          900: '#18181B',
          950: '#09090B',
        },
        success: { DEFAULT: '#10B981', light: '#D1FAE5' },
        warning: { DEFAULT: '#F59E0B', light: '#FEF3C7' },
        error: { DEFAULT: '#EF4444', light: '#FEE2E2' },
        info: { DEFAULT: '#3B82F6', light: '#DBEAFE' },
      },
      spacing: {
        '4.5': '18px',
        '13': '52px',
        '15': '60px',
      },
      borderRadius: {
        'xl': '12px',
        '2xl': '16px',
        '3xl': '24px',
      },
      boxShadow: {
        'card': '0 2px 8px rgba(0,0,0,0.08)',
        'card-hover': '0 4px 16px rgba(0,0,0,0.12)',
        'modal': '0 8px 32px rgba(0,0,0,0.16)',
      },
      fontSize: {
        'display': ['36px', { lineHeight: '1.2', fontWeight: '700' }],
        'h1': ['28px', { lineHeight: '1.3', fontWeight: '700' }],
        'h2': ['22px', { lineHeight: '1.35', fontWeight: '600' }],
        'h3': ['18px', { lineHeight: '1.4', fontWeight: '600' }],
        'body-lg': ['17px', { lineHeight: '1.6', fontWeight: '400' }],
        'body': ['15px', { lineHeight: '1.6', fontWeight: '400' }],
        'body-sm': ['14px', { lineHeight: '1.5', fontWeight: '400' }],
        'caption': ['12px', { lineHeight: '1.4', fontWeight: '500' }],
      },
    },
  },
}
```

### 6.9 Flutter 테마 설정 (기본)

```dart
// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryHover = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFFDBEAFE);
  static const Color primaryDark = Color(0xFF1E40AF);

  // Neutral (Gray Scale)
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF4F4F5);
  static const Color gray200 = Color(0xFFE4E4E7);
  static const Color gray300 = Color(0xFFD4D4D8);
  static const Color gray400 = Color(0xFFA1A1AA);
  static const Color gray500 = Color(0xFF71717A);
  static const Color gray600 = Color(0xFF52525B);
  static const Color gray700 = Color(0xFF3F3F46);
  static const Color gray800 = Color(0xFF27272A);
  static const Color gray900 = Color(0xFF18181B);
  static const Color black = Color(0xFF09090B);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFE0F2FE); // Distinct from primaryLight

  // Semantic Mappings - Light
  static const Color background = white;
  static const Color surface = gray50;
  static const Color surfaceElevated = white;
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textTertiary = gray500;
  static const Color textDisabled = gray400;
  static const Color border = gray200;
  static const Color divider = gray100;
}

// lib/core/theme/app_colors_dark.dart
class AppColorsDark {
  static const Color background = Color(0xFF0A0A0B);
  static const Color surface = Color(0xFF18181B);
  static const Color surfaceElevated = Color(0xFF27272A);
  static const Color textPrimary = Color(0xFFEBEBEB); // 92% white
  static const Color textSecondary = Color(0xFFB8B8B8); // 72% white
  static const Color textTertiary = Color(0xFF7A7A7A); // 48% white
  static const Color textDisabled = Color(0xFF525252); // 32% white
  static const Color border = Color(0xFF27272A);
  static const Color divider = Color(0xFF27272A);
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF1E3A5F);
}
```

```dart
// lib/core/theme/app_spacing.dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  
  // Semantic spacing
  static const double componentGap = md;      // 16
  static const double sectionGap = xl;        // 32
  static const double screenPadding = md;     // 16
  static const double cardPadding = md;       // 16
  static const double listItemGap = sm;       // 8
}
```

```dart
// lib/core/theme/app_radius.dart
class AppRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double full = 9999;
  
  // Semantic radius
  static const double button = md;      // 8
  static const double card = lg;        // 12
  static const double modal = xl;       // 16
  static const double input = md;       // 8
  static const double chip = full;      // pill shape
}
```

```dart
// lib/core/theme/app_typography.dart
import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Pretendard';
  
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.72, // 36px * -0.02em
  );
  
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.28, // 28px * -0.01em
  );
  
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: -0.22, // 22px * -0.01em
  );
  
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.12, // 12px * 0.01em
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.55, // 11px * 0.05em
  );
}
```

```dart
// lib/core/theme/app_shadows.dart
import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x29000000), // 16% opacity
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];
  
  // Semantic
  static const List<BoxShadow> card = md;
  static const List<BoxShadow> cardHover = lg;
  static const List<BoxShadow> modal = xl;
}
```

```dart
// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_colors_dark.dart';
import 'app_typography.dart';
import 'app_radius.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTypography.fontFamily,
    
    // Colors (Flutter 3.22+ compatible)
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.gray600,
      surface: AppColors.background,
      surfaceContainerLowest: AppColors.background,
      surfaceContainerLow: AppColors.gray50,
      surfaceContainer: AppColors.gray100,
      error: AppColors.error,
    ),
    
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.divider,
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    
    // Input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: AppTypography.body.copyWith(color: AppColors.gray400),
    ),
    
    // Card
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.gray400,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTypography.fontFamily,
    
    // Colors (Flutter 3.22+ compatible)
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.gray400,
      surface: AppColorsDark.background,
      surfaceContainerLowest: AppColorsDark.background,
      surfaceContainerLow: AppColorsDark.surface,
      surfaceContainer: AppColorsDark.surfaceElevated,
      error: AppColors.error,
    ),
    
    scaffoldBackgroundColor: AppColorsDark.background,
    dividerColor: AppColorsDark.divider,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.background,
      foregroundColor: AppColorsDark.textPrimary,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
      ),
    ),
    
    cardTheme: CardTheme(
      color: AppColorsDark.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsDark.surface,
      selectedItemColor: AppColorsDark.primary,
      unselectedItemColor: AppColors.gray500,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}
```

```dart
// lib/core/theme/app_durations.dart
class AppDurations {
  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration slower = Duration(milliseconds: 400);
  
  // Semantic
  static const Duration feedback = fast;
  static const Duration transition = slow;
  static const Duration pageTransition = slower;
}

// lib/core/theme/app_curves.dart
import 'package:flutter/material.dart';

class AppCurves {
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounce = Cubic(0.34, 1.56, 0.64, 1); // Subtle bounce, not elasticOut
  
  // Semantic
  static const Curve enter = easeOut;
  static const Curve exit = easeInOut;
  static const Curve emphasis = bounce;
}
```

```yaml
# pubspec.yaml - 폰트 설정
flutter:
  fonts:
    - family: Pretendard
      fonts:
        - asset: assets/fonts/Pretendard-Regular.otf
          weight: 400
        - asset: assets/fonts/Pretendard-Medium.otf
          weight: 500
        - asset: assets/fonts/Pretendard-SemiBold.otf
          weight: 600
        - asset: assets/fonts/Pretendard-Bold.otf
          weight: 700
```

---

## Part 7: 구현 체크리스트

### 7.1 필수 체크 (MUST)

```
[ ] 색상 5개 이내로 제한했는가?
[ ] 본문 폰트 15px 이상인가?
[ ] 모든 간격이 8의 배수인가?
[ ] 터치 영역 44px 이상 확보했는가?
[ ] 모든 버튼에 4단계 상태(default/hover/pressed/disabled) 있는가?
[ ] 로딩 상태 표시가 있는가?
[ ] 다크모드 지원하는가?
[ ] 다크모드에서 카드에 보더 또는 색상 차이 적용했는가?
[ ] 중첩 요소 radius 공식 적용했는가?
[ ] 텍스트-배경 대비 4.5:1 이상인가? (접근성)
[ ] 14px 미만 텍스트에 gray-600 이상 사용했는가? (접근성)
[ ] 색상 외 수단으로도 정보 전달하는가? (접근성)
[ ] Semantics 위젯으로 스크린리더 지원하는가? (접근성)
[ ] Dynamic Type 지원하는가? (접근성)
[ ] 광학 보정 적용했는가? (버튼 내 텍스트 1-2px 위로)
[ ] 에러 메시지보다 에러 방지를 우선했는가?
[ ] 플랫폼 네이티브 컨벤션 존중하는가? (iOS/Android/Web)
[ ] 가능하면 네이티브 컴포넌트 사용했는가?
```

### 7.2 권장 체크 (SHOULD)

```
[ ] 애니메이션에 적절한 easing 적용했는가?
[ ] 리스트 등장 시 순차 등장(stagger) 적용했는가?
[ ] 모션이 인터럽트 가능한가?
[ ] 그림자가 미묘하고 자연스러운가?
[ ] 아이콘 스타일이 통일되어 있는가?
[ ] 입력 필드 포커스 상태가 명확한가?
[ ] 햅틱 피드백을 시맨틱에 맞게 적용했는가?
[ ] 상태 전이 시간이 정의되어 있는가?
[ ] 콘텐츠가 UI보다 돋보이는가? (Content First)
[ ] 예측 디자인 적용했는가? (기본값, 프리페칭)
[ ] 중단된 작업 복귀 시 상태 유지되는가?
[ ] 입력 방식(터치/포인터/키보드)에 따라 적응하는가?
[ ] AI 응답은 스트리밍으로 표시하는가?
[ ] 프라이버시 권한을 Just-in-time으로 요청하는가?
```

### 7.3 프리미엄 체크 (MAY)

```
[ ] 글래스모피즘 효과가 적절한가?
[ ] 마이크로인터랙션이 있는가?
[ ] 스크롤 연동 효과가 있는가?
[ ] visionOS/공간 컴퓨팅 고려했는가?
```

---

## Part 8: 안티패턴 (하지 말 것)

### 8.1 즉시 "옛날 앱" 느낌 주는 것들

| 안티패턴 | 이유 | 대안 |
|----------|------|------|
| 고채도 원색 (#FF0000) | 저가, 경고 느낌 | 톤다운된 컬러 |
| 빽빽한 레이아웃 | 저예산 시그널 | 넉넉한 여백 |
| 반응 없는 버튼 | 고장난 느낌 | 상태 변화 필수 |
| 뚝뚝 끊기는 전환 | 조악함 | 부드러운 애니메이션 |
| 불통일한 아이콘 | 급조한 느낌 | 단일 아이콘 세트 |
| 순수 검정 배경 (#000) | 눈 피로, 거부감 | #121212 이상 |
| 순수 흰색 텍스트 (#FFF) | 대비 과함 | rgba(255,255,255,0.87) |
| 직각 모서리 (radius: 0) | 2010년대 느낌 | 최소 8px radius |
| Stock 아이콘 혼용 | 성의 없음 | 통일된 아이콘 세트 |
| linear 애니메이션 | 기계적, 부자연스러움 | ease-out, ease-in-out |

### 8.2 프리미엄 착각 (과하면 역효과)

| 안티패턴 | 이유 | 적절한 사용 |
|----------|------|-------------|
| 과도한 그라데이션 | 2000년대 느낌 | 미묘하게, 제한적으로 |
| 과도한 글래스모피즘 | 가독성 저하 | 플로팅 요소에만 |
| 과도한 애니메이션 | 산만함, 피로 | 의미 있는 곳에만 |
| 과도한 3D 효과 | 촌스러움 | 미묘한 깊이감만 |
| 너무 많은 그림자 | 무거움 | 핵심 요소에만 |

---

## Part 9: 빠른 참조 카드

### 한눈에 보는 기본 설정

```
Font
├── 기본 폰트: Pretendard
├── Body: 15px / 1.6 line-height
├── 최소 본문: 14px
└── Weight: 400(본문), 600(제목), 700(강조)

Color (Light)
├── Primary: #2563EB
├── 배경: #FFFFFF
├── 본문: #18181B (gray-900)
├── 보조: #71717A (gray-500)
└── 보더: #E4E4E7 (gray-200)

Color (Dark)
├── Primary: #3B82F6
├── 배경: #0A0A0B
├── 본문: rgba(255,255,255,0.92)
├── 보조: rgba(255,255,255,0.48)
└── 보더: #27272A

Spacing (8pt Grid)
├── 요소 간: 16px
├── 섹션 간: 32px
├── 화면 패딩: 16px
└── 터치 영역: 44px (min)

Radius
├── 버튼: 8px
├── 카드: 12px
├── 모달: 16px
└── 원형: 9999px

Shadow (Light)
├── 카드: 0 2px 8px rgba(0,0,0,0.08)
├── 호버: 0 4px 16px rgba(0,0,0,0.12)
└── 모달: 0 8px 32px rgba(0,0,0,0.16)

Animation
├── 피드백: 100ms ease-out
├── 기본: 200ms ease-out
├── 전환: 300ms ease-in-out
└── Easing: cubic-bezier(0.4, 0.0, 0.2, 1)
```

---

## Part 10: 2024-2025 트렌드 참고

> 최신 트렌드 적용은 선택적이나, 인지하고 있으면 더 현대적인 앱 구현 가능

### 10.1 Apple Liquid Glass (iOS 18+, visionOS)

- **특징**: 배경과 전경의 자연스러운 블렌딩, 유리창 느낌
- **적용 시점**: 플로팅 요소, 네비게이션 바, 시트

```dart
// Flutter 구현 (MAY)
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: content,
  ),
)
```

### 10.2 Material 3 Expressive (2024)

- **특징**: 더 큰 radius, 더 굵은 타이포, 생동감 있는 컬러
- **핵심**: `ColorScheme.fromSeed()` 사용한 자동 조화

```dart
// Dynamic Color (MAY)
final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF2563EB),
  brightness: Brightness.light,
);
```

### 10.3 Bento Grid Layout

- **특징**: 비대칭 그리드, 다양한 크기 카드 혼합 (Apple 스타일)
- **적용**: 대시보드, 설정 화면, 프로필 페이지

```dart
// flutter_staggered_grid_view 패키지 활용
StaggeredGrid.count(
  crossAxisCount: 4,
  children: [
    StaggeredGridTile.count(crossAxisCellCount: 2, mainAxisCellCount: 2, child: bigCard),
    StaggeredGridTile.count(crossAxisCellCount: 2, mainAxisCellCount: 1, child: smallCard1),
    StaggeredGridTile.count(crossAxisCellCount: 2, mainAxisCellCount: 1, child: smallCard2),
  ],
)
```

### 10.4 Variable Font Animation

- **특징**: 폰트 weight를 애니메이션으로 전환
- **주의**: Pretendard Variable 사용 시 적용 가능

```dart
// Font weight 애니메이션 (MAY)
AnimatedDefaultTextStyle(
  style: TextStyle(
    fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
  ),
  duration: AppDurations.normal,
  child: Text('Tab Label'),
)
```

### 10.5 Spatial UI (Depth Hierarchy)

- **특징**: Z축 깊이를 활용한 계층 구조 강조
- **적용**: 카드 호버, 모달 진입, 포커스 상태

```dart
// 깊이감 있는 카드 (SHOULD)
AnimatedContainer(
  duration: AppDurations.normal,
  transform: Matrix4.identity()
    ..translate(0.0, isHovered ? -4.0 : 0.0, 0.0),
  decoration: BoxDecoration(
    boxShadow: isHovered ? AppShadows.lg : AppShadows.md,
  ),
  child: card,
)
```

### 10.6 visionOS & Spatial Computing (MAY)

- **특징**: 공간 UI는 시선, 거리, 환경에 따른 새로운 규칙 필요
- **시기**: Apple의 다음 10년. 일찍 이해 = 경쟁 우위

```
공간 디자인 원칙:
- 시선 타겟팅: 60pt 최소 (눈은 손가락보다 정밀도 낮음)
- 깊이: 콘텐츠는 팔 길이(1m), 크롬은 더 가까이(0.5m)
- 배경: 절대 단색 X → 항상 passthrough 또는 블러
- 윈도우: 떠다님, 벽에 고정 X (이동 시 disorienting)
- 텍스트: 더 크게 (최소 20pt 상당)
- 모션: 사용자 방향 패럴랙스 금지 (어지러움 유발)

진입점: hands-down 우선 설계 (시선 + 핀치)
```

### 10.7 AI 시대 UI 패턴 (SHOULD)

- **특징**: AI 상호작용에는 새로운 패턴 필요 - 신뢰도, 출처, 스트리밍
- **시기**: 모든 현대 앱에 AI 요소 포함될 것

```
AI 상호작용 패턴:
- 스트리밍 응답: 생성되는 대로 토큰 표시 (빠르게 느껴짐)
- 신뢰도 표시: 불확실한 답변에 시각적 처리
- 출처 표시: AI가 정보를 어디서 가져왔는지 인용
- 중단: 사용자가 생성 중간에 멈출 수 있음
- 재시도: 재프롬프트 없이 쉬운 재생성
- 편집: AI 출력을 시작점으로 편집 가능

안티패턴:
- 전체 응답 대기 후 표시 (느리게 느껴짐)
- AI 출력을 확정된 사실로 제시
- AI 추론 과정 볼 수 없음
- "AI가 생각 중..." 스피너만 표시
```

```dart
// 스트리밍 AI 응답 예시 (Flutter)
StreamBuilder<String>(
  stream: aiResponseStream,
  builder: (context, snapshot) {
    return AnimatedDefaultTextStyle(
      duration: Duration(milliseconds: 50),
      style: AppTypography.body,
      child: Text(
        snapshot.data ?? '',
        // 커서 깜빡임으로 "입력 중" 표시
      ),
    );
  },
)
```

### 10.8 프라이버시 UX (SHOULD)

- **특징**: 프라이버시 선택은 정보에 입각해야 함, 마지못해 하는 것 X
- **시기**: Apple 브랜드 = 프라이버시. 데이터 사용을 설명하는 디자인이 신뢰 구축

```
프라이버시 UX 패턴:
- Just-in-time 권한: 기능 필요할 때 요청, 앱 시작 시 X
- 가치 제안 설명: 요청 전 이점 설명 
  ("위치를 활성화하면 주변 매장을 보여드릴 수 있어요")
- 최소 수집: 최소 범위 요청 (사진 접근 → 선택된 사진만 먼저)
- 투명성: 어떤 데이터가 있는지 표시, 쉬운 삭제
- 기본 꺼짐: Opt-in, 절대 opt-out 아님

Apple 기대: 프라이버시 영양 라벨이 정직하고 완전해야 함
핵심: 신뢰 = 리텐션
```

### 10.9 지각적 균일 컬러 (SHOULD)

- **특징**: 인간은 색상 변화를 불균일하게 인식. HSL 동일 단계 ≠ 인식 동일 단계
- **시기**: gray-300 → gray-400은 크게 보이고, gray-600 → gray-700은 작게 보일 수 있음

```
지각적으로 균일한 팔레트:
- OKLCH 또는 CAM16 색상 공간으로 팔레트 생성
- 테스트: 흑백으로 출력 - 단계가 시각적으로 균일한가?
- 회피: HSL은 빠른 프로토타이핑에만

OKLCH 밝기 단계 (균일 인식용):
| 토큰 | Lightness |
|------|-----------|
| gray-100 | 95% |
| gray-200 | 88% |
| gray-300 | 78% |
| gray-400 | 65% |
| gray-500 | 50% |
| gray-600 | 38% |
| gray-700 | 28% |
| gray-800 | 18% |
| gray-900 | 10% |
```

### 10.10 시맨틱 컬러 아키텍처

```
SHOULD: 색상을 용도로 명명 (외관 X)
- "blue-500"은 다크모드에서 깨짐
- "interactive-primary"는 어디서나 동작

2계층 컬러 시스템:
Layer 1 - Primitives (원시값):
  $blue-500: oklch(60% 0.15 250);

Layer 2 - Semantics (용도):
  $color-interactive-primary: $blue-500; /* 라이트모드 */
  $color-interactive-primary-dark: $blue-400; /* 다크모드 */

사용: 컴포넌트에서는 시맨틱 토큰만. Primitive 직접 사용 금지.
이점: 테마 변경 시 Layer 2 → Layer 1 매핑만 수정.
```

---

## 변경 이력

| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| 1.0 | 2025-01 | 최초 작성 - 2024-2025 글로벌 트렌드 기반 |
| 1.1 | 2025-01 | 접근성, 반응형, 2024-2025 트렌드 섹션 추가. Flutter 코드 수정 (letterSpacing, ColorScheme API) |
| 1.2 | 2026-01 | Apple HIG 수준 강화: 광학 보정, 에러 방지, 플랫폼 네이티브 규칙 MUST 추가. 접근성: 작은 텍스트 명도 규칙, 다크모드 카드 보더 필수. 애니메이션: 순차 등장, 모션 인터럽트, 안무 가이드. 타이포: Dynamic Type, 광학 사이징, 반응형 스케일. 새 SHOULD: 상태 전이 매트릭스, 콘텐츠 우선, 예측 디자인, 흐름 지속성, 입력 방식 적응, 햅틱 시맨틱. 새 트렌드: visionOS/공간 컴퓨팅, AI 시대 UI, 프라이버시 UX, 지각적 균일 컬러, 시맨틱 컬러 아키텍처. 체크리스트 확장. |

---

*이 가이드는 2024-2025년 글로벌 앱 디자인 트렌드와 Apple HIG, Material Design 3, 주요 성공 앱들의 분석을 기반으로 작성되었습니다. v1.2부터 Apple 최고 수준 UI/UX 디자이너 관점의 디테일(광학 보정, 모션 철학, 시맨틱 디자인)이 추가되었습니다.*
