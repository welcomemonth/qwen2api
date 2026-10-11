#!/bin/bash
set -euo pipefail

# ===================== 配置区 =====================
# 阿里云镜像仓库地址
REGISTRY="crpi-npw0av7ozhtwtzou.cn-hangzhou.personal.cr.aliyuncs.com"
NAMESPACE="goalpher"
REPO="web2api"
IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${REPO}"

# 本地构建时的临时镜像名
LOCAL_IMAGE="web2api"

# 标签（你要求用 latest）
TAG="latest"

# Dockerfile 所在目录（默认当前目录）
BUILD_CONTEXT="."
DOCKERFILE="Dockerfile"
# ==================================================

FULL_IMAGE="${IMAGE_NAME}:${TAG}"

echo "========================================"
echo " 开始构建并推送镜像"
echo " 目标镜像: ${FULL_IMAGE}"
echo "========================================"

# 1. 构建镜像
echo ">>> 正在构建镜像..."
docker build \
  -t "${LOCAL_IMAGE}:${TAG}" \
  -f "${DOCKERFILE}" \
  "${BUILD_CONTEXT}"

# 2. 打标签（指向阿里云仓库）
echo ">>> 正在打标签..."
docker tag "${LOCAL_IMAGE}:${TAG}" "${FULL_IMAGE}"

# 3. 推送到阿里云
echo ">>> 正在推送到阿里云镜像仓库..."
docker push "${FULL_IMAGE}"

# 4. 删除本地镜像（可选，但按你要求删除）
echo ">>> 正在清理本地镜像..."
docker rmi "${FULL_IMAGE}" || true
docker rmi "${LOCAL_IMAGE}:${TAG}" || true

# 可选：清理悬空镜像（dangling images）
docker image prune -f || true

echo "========================================"
echo " 完成！"
echo " 镜像已成功推送: ${FULL_IMAGE}"
echo "========================================"