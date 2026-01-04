---
description: 작업 완료 후 문서화 및 커밋/푸시
allowed-tools: Bash(git:*), Read(*), Write(*), Edit(*), Glob(*)
---

## 작업 완료 처리

현재 작업을 마무리하고 문서화한 뒤 커밋/푸시합니다.

### 1. Git 상태 확인

먼저 Git 초기화 여부를 확인하세요:
- Git 상태: !`git status 2>&1 || echo "NOT_INITIALIZED"`

**Git이 초기화되지 않은 경우:**
```bash
git init
git config user.name "kibak"
git config user.email "kibak812@gmail.com"
```

### 2. 문서화 작업

이번 작업 내용을 바탕으로 다음 문서들을 적절히 업데이트하세요:

1. **CLAUDE.md**: 프로젝트 규칙, 컨벤션, 중요 지침 추가/수정
2. **method.md**: 발생한 에러와 해결 방법 기록 (있는 경우)
3. **CHANGELOG.md**: 변경 이력 추가 (날짜, 변경 내용 요약)

문서가 없으면 새로 생성하세요.

### 3. 커밋 및 푸시

모든 변경사항을 스테이징하고 의미 있는 커밋 메시지로 커밋하세요:
```bash
git add .
git commit -m "적절한 커밋 메시지"
```

원격 저장소가 설정되어 있으면 푸시하세요:
```bash
git push
```

원격 저장소가 없으면 사용자에게 알려주세요.

### 작업 순서 요약

1. Git 초기화 확인 (필요시 init + config)
2. 문서 업데이트 (CLAUDE.md, method.md, CHANGELOG.md)
3. git add, commit
4. git push (가능한 경우)
5. 완료 보고
