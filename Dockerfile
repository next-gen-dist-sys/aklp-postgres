# PostgreSQL 17 with custom initialization script
FROM postgres:17-alpine

# 데이터베이스 초기화 스크립트 복사 (실행 권한 부여)
COPY --chmod=755 init-db.sh /docker-entrypoint-initdb.d/init-db.sh

# PostgreSQL 기본 포트
EXPOSE 5432

# 기본 entrypoint는 베이스 이미지의 것을 사용