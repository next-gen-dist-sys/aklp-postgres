# AKLP PostgreSQL

AKLP (AI-powered Kubernetes Learning Platform)의 PostgreSQL 데이터베이스 서비스입니다.

## 📋 개요

PostgreSQL 17 기반의 커스텀 이미지로, AKLP의 모든 마이크로서비스가 사용하는 공용 데이터베이스를 제공합니다.

## 🗄 데이터베이스 구조

이 서비스는 다음 데이터베이스들을 자동으로 생성합니다:

- **aklp_note**: Note 서비스용 데이터베이스
- **aklp_task**: Task 서비스용 데이터베이스
- **aklp_agent**: Agent 서비스용 데이터베이스

## 🚀 사용 방법

### Docker Compose로 실행 (권장)

```bash
# aklp-infra 레포지토리에서
cd /path/to/aklp-infra
docker compose up postgres
```

### 단독 실행

```bash
# 이미지 빌드
docker build -t aklp-postgres .

# 컨테이너 실행
docker run -d \
  --name aklp-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=postgres \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  aklp-postgres
```

## 📂 파일 구조

```
aklp-postgres/
├── Dockerfile          # PostgreSQL 17 커스텀 이미지
├── init-db.sh          # 데이터베이스 초기화 스크립트
└── README.md
```

## 🔧 초기화 스크립트

`init-db.sh`는 PostgreSQL 컨테이너 최초 실행 시 자동으로 실행됩니다:

- 중복 생성 방지 (이미 존재하는 DB는 스킵)
- 각 데이터베이스에 권한 부여
- 생성된 데이터베이스 목록 출력

## 🔌 연결 정보

### 로컬 개발 환경

```
Host: localhost
Port: 5432
User: postgres
Password: postgres
```

### Docker Compose 환경 (서비스 간 통신)

```
Host: postgres  # 서비스 이름
Port: 5432
User: postgres
Password: postgres
```

## 💾 데이터 영속성

Docker volume (`postgres_data`)을 사용하여 데이터를 영속적으로 저장합니다.

### 데이터 초기화

```bash
# 볼륨 포함 완전 삭제
docker compose down -v

# 다시 시작 (DB 재초기화)
docker compose up postgres
```

## 🛠 기술 스택

- **Base Image**: PostgreSQL 17 Alpine
- **Init System**: docker-entrypoint-initdb.d
- **Shell Script**: Bash

## 📄 라이선스

MIT License