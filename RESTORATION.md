# ZCode 开源版 · 复原功能版本

> 本仓库 = **ZCode 官方开源代码**（上游 `zai-org/ZCode`，Apache-2.0）+ **从官方正式版中提取、复原回来的「内置插件与 Computer Use 能力」**。

---

## 这是什么？

ZCode 官方放出的开源版是**「故意阉割版」**——主体代码齐全，但**官方内置插件层被整包裁掉**（换成 CDN 引用或空桩）。本仓库把这层**从官方正式版里原样取回来**，放在 `restored/` 下，并附带一键还原脚本。

一句话：**开源版 + 复原的功能 = 官方正式版的能力。**

---

## 复原了什么（对照表）

| 能力 | 开源版 | 本仓库（复原后） |
|---|---|---|
| **Computer Use（操作桌面软件）** | 空桩 | ✅ `restored/glm/packages/zcode-cua-plugin`（21.35 MB） |
| **CU 原生助手**（无障碍/截图/本地 HTTP） | 空桩 | ✅ `restored/tools/cua-helper`（含 `ax_native.node`） |
| **Browser Use（浏览器自动化）** | 有源码、无运行时 | ✅ `restored/glm/packages/browser-use-plugin`（19.74 MB） |
| **node_repl 运行时宿主**（CU/BU 底座） | 有源码、无运行时 | ✅ `restored/glm/packages/node-repl-host`（24.40 MB） |
| **Android 模拟器** | 无 | ✅ `restored/glm/packages/android-emulator-plugin` |
| **iOS 模拟器** | 无 | ✅ `restored/glm/packages/ios-simulator-plugin` |
| **文档族：PDF / Word / PPT / Excel** | 部分 | ✅ pdf / documents / presentations / spreadsheets 四个插件 |
| **搜图（Image Search）** | 仅 CDN 定义 | ✅ `restored/glm/packages/image-search-plugin` |
| **插件/技能创建器、ZCode 指南** | 无 | ✅ plugin-creator / skill-creator / zcode-guide |
| **旧会话恢复** | 无 | ✅ restore-legacy-sessions-plugin |
| **捆绑技能集** | 无 | ✅ bundled-skills |

> 合计 **15 个官方插件包，约 70 MB**（作者 Z.ai）。

---

## 目录结构

```
.
├── apps/ packages/ scripts/ ...   ← 上游 ZCode 开源代码（原样保留）
├── restored/                      ← ★复原层（从官方正式版提取）
│   ├── glm/packages/              ←   15 个官方插件（运行时成品：dist + node_modules）
│   └── tools/cua-helper/          ←   Computer Use 原生助手
├── apply-restoration.ps1          ← 一键还原脚本（Windows）
├── apply-restoration.sh           ← 一键还原脚本（Linux/macOS）
└── RESTORATION.md                 ← 本文件
```

---

## 怎么用

### 方式一：把复原层覆盖进已安装/已构建的 ZCode

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File .\apply-restoration.ps1 -Target "C:\path\to\ZCode\resources"
```

```bash
# Linux / macOS
./apply-restoration.sh /path/to/ZCode/resources
```

脚本会把 `restored/glm/packages/*` 与 `restored/tools/cua-helper/*` 复制到目标 `resources/` 对应位置，覆盖空桩。

### 方式二：手动复制

把 `restored/glm/packages/` 下的 15 个目录 → 目标 `resources/glm/packages/`；
把 `restored/tools/cua-helper/` → 目标 `resources/tools/cua-helper/`。

---

## 来源与证据

- 复原素材来自官方正式版 **ZCode v3.14.3（Windows x64）**
  下载直链：`https://cdn-zcode.z.ai/zcode/electron/releases/3.14.3/windows-x64/ZCode-3.14.3-win-x64.exe`
- 构建信息：`appVersion 3.14.3` / `buildCommitId ab4d5e6b` / `buildTime 2026-09-22T03:05:10Z` / Electron 41.0.3
- 解包链：`.exe` → `$PLUGINSDIR\app-64.7z` → `resources\app.asar` + `resources\glm\packages\*` + `resources\tools\cua-helper\*`
- 详细逆向过程见上游仓库同目录的《ZCode 正式版逆向报告》。

---

## 许可与声明（重要）

- **上游 ZCode 开源代码**：Apache-2.0（见根目录 `LICENSE`）。
- **复原的官方插件**：多为 MIT；但 **documents / pdf / presentations / spreadsheets 四个插件的许可为
  `SEE LICENSE IN skills/<name>/LICENSE.txt`**，移植/再分发前请**逐字阅读该 LICENSE**，自行判断合规性。
- 本仓库为**学习与研究用途**的复原实践，非官方发布物。相关权利归 Z.ai（北京智谱华章）所有。