# web2api 整体结构与实现

> 本文从源码视角总结 **web2api** 的逻辑、模块划分以及关键实现细节，供维护/二次开发使用。

## 目录
- [1. 项目简介](#1-项目简介)
- [2. 运行时流向](#2-运行时流向)
- [3. 关键模块](#3-关键模块)
  - [3.1 `backend/main.go`](#31-backendmaingo)
  - [3.2 `adapter/`](#32-adapter)
  - [3.3 `browser/`](#33-browser)
  - [3.4 `toolcall/`](#34-toolcall)
  - [3.5 `upstream/`](#35-upstream)
  - [3.6 `context_pipeline.go`](#36-contextpipeline)
  - [3.7 `services/` / `utils/`](#37-servicesutils)
- [4. 前端与部署](#4-前端与部署)
- [5. 数据与配置](#5-数据与配置)
- [6. 关键设计要点](#6-关键设计要点)
- [7. 代码流映射](#7-代码流映射)