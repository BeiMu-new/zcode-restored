# 复原层说明（restored/）

本目录存放**从 ZCode 官方正式版 v3.14.3（Windows x64）中提取、复原回来的能力包**。
开源版把这些整包裁掉了，这里把它们放回来。

## glm/packages/ —— 15 个官方插件（运行时成品）

| 目录 | 插件名 | 版本 | 作用 |
|---|---|---|---|
| `zcode-cua-plugin` | computer-use | 0.6.3 | **Computer Use：操作桌面原生软件** |
| `browser-use-plugin` | browser-use | 0.5.1 | 浏览器自动化（内嵌浏览器 IAB + 受控 headless CDP） |
| `node-repl-host` | node-repl-host | 0.6.0 | node_repl JS 运行时宿主（CU / BU 共用底座） |
| `android-emulator-plugin` | android-emulator | 0.1.0 | Android 模拟器工作流 |
| `ios-simulator-plugin` | ios-simulator | 0.1.0 | iOS 模拟器工作流 |
| `pdf-plugin` | pdf | 0.1.7 | PDF 制作技能 |
| `documents-plugin` | documents | 0.1.7 | Word(DOCX) 制作技能 |
| `spreadsheets-plugin` | spreadsheets | 0.1.7 | Excel(XLSX) 制作技能 |
| `presentations-plugin` | presentations | 0.1.7 | PPT(PPTX) 制作技能 |
| `image-search-plugin` | image-search | 0.1.1 | 官方搜图 MCP（走服务端） |
| `plugin-creator-plugin` | plugin-creator | 0.1.1 | 插件开发/校验 |
| `skill-creator-plugin` | skill-creator | 0.1.0 | 技能创建 |
| `zcode-guide-plugin` | zcode-guide | 0.3.0 | ZCode 使用与自诊断指南 |
| `restore-legacy-sessions-plugin` | restore-legacy-sessions | 0.1.0 | 恢复旧版（ACP 时代）会话 |
| `bundled-skills` | （技能集） | — | 捆绑技能 |

## tools/cua-helper/ —— Computer Use 原生助手

- 包名：`@zcode/zcode-cua-helper-runtime` v0.6.3
- `build/Release/ax_native.node` —— Windows 无障碍（UIA/AX）原生模块
- `dist/windows-helper.js` —— 本地 HTTP 助手（express + sharp）
- `runtime-manifest.json` —— 含 entry / addon 的 sha256 校验

> 上游源码为私有仓 `dev.aminer.cn/codegeex/zcode-cua.git`（本包为编译成品）。

## 注意

- 这些是**运行时成品**（含 `dist/` 与 `node_modules/`），不是 TypeScript 源码。
- 各插件许可见其目录内 `LICENSE` / `package.json`；四个文档类插件为 `SEE LICENSE IN skills/*/LICENSE.txt`。