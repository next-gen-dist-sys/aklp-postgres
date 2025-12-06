#!/bin/bash
set -e

# PostgreSQL 초기화 스크립트
# docker compose up 시 PostgreSQL 데이터 디렉토리가 비어있을 때만 실행됩니다.
# 각 마이크로서비스용 데이터베이스를 안전하게 생성합니다.

create_database_if_not_exists() {
    local db_name=$1

    # 데이터베이스가 이미 존재하는지 확인
    if psql -U "$POSTGRES_USER" -lqt | cut -d \| -f 1 | grep -qw "$db_name"; then
        echo "⏭️  Database '$db_name' already exists, skipping..."
    else
        psql -U "$POSTGRES_USER" -c "CREATE DATABASE $db_name;"
        psql -U "$POSTGRES_USER" -c "GRANT ALL PRIVILEGES ON DATABASE $db_name TO $POSTGRES_USER;"
        echo "✅ Database '$db_name' created"
    fi
}

echo "🚀 Starting database initialization..."

# Note Service 데이터베이스
create_database_if_not_exists "aklp_note"

# Task Service 데이터베이스
create_database_if_not_exists "aklp_task"

# Agent Service 데이터베이스
create_database_if_not_exists "aklp_agent"

# File Service 데이터베이스
create_database_if_not_exists "aklp_file"

echo ""
echo "📊 Current databases:"
psql -U "$POSTGRES_USER" -c "\l"

echo ""
echo "✅ Database initialization completed successfully!"