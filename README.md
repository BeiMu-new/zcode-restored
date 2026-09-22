# ZCode 开源版 · 复原功能版本

> **zcode-restored** —— 把 ZCode 官方开源版里被裁掉的内置能力，原样复原回来。

<p align="center">
  简体中文 |
  <a href="README.en.md">English</a> |
  <a href="README.upstream.md">上游原版 README</a>
</p>

---

## 这是什么

ZCode 官方放出的**开源版**是「故意阉割版」：主体代码齐全，但**官方内置插件层被整包裁掉**（在源码里换成 CDN 引用或空桩）。

本仓库把这层**从官方正式版中原样提取回来**，放在 `restored/` 下，并附带一键还原脚本。
**开源版 + 复原层 = 官方正式版的能力。**

一句话：**给想用「无删减 ZCode 开源版」的人，省一步手工搬运。**

---

## 复原了什么

| 能力 | 开源版原状 | 本仓库（复原后） |
|---|---|---|
| **Computer Use**（操作桌面软件） | 空桩 | ✅ `restored/glm/packages/zcode-cua-plugin` |
| **Computer Use 原生助手** | 空桩 | ✅ `restored/tools/cua-helper`（含 `ax_native.node`） |
| **Browser Use**（浏览器自动化） | 有源码、无运行时 | ✅ `restored/glm/packages/browser-use-plugin` |
| **node_repl 运行时宿主** | 有源码、无运行时 | ✅ `restored/glm/packages/node-repl-host` |
| **Android / iOS 模拟器** | 无 | ✅ android-emulator-plugin / ios-simulator-plugin |
| **文档族 PDF / Word / PPT / Excel** | 部分 | ✅ pdf / documents / presentations / spreadsheets |
| **搜图（Image Search）** | 仅 CDN 定义 | ✅ image-search-plugin |
| **插件/技能创建器、ZCode 指南** | 无 | ✅ plugin-creator / skill-creator / zcode-guide |
| **旧会话恢复、捆绑技能集** | 无 | ✅ restore-legacy-sessions-plugin / bundled-skills |

> 共 **15 个官方插件包**，详见 [RESTORATION.md](RESTORATION.md)。

---

## 目录结构

```
.
├── apps/  packages/  scripts/ ...   ← 上游 ZCode 开源代码（原样保留，Apache-2.0）
├── restored/                        ← ★复原层（从官方正式版提取）
│   ├── glm/packages/                ←   15 个官方插件
│   ├── tools/cua-helper/            ←   Computer Use 原生助手
│   └── MANIFEST.sha256              ←   完整性校验清单
├── apply-restoration.ps1            ← 一键还原（Windows）
├── apply-restoration.sh             ← 一键还原（Linux / macOS）
├── tests/restoration-selftest.ps1   ← 还原自测脚本
├── RESTORATION.md                   ← 复原说明（含对照表与证据）
├── RESTORATION_TEST.md              ← 还原自测结果
└── DISCLAIMER.md                    ← 免责说明
```

---

## 怎么用

### 一键还原（推荐）

```powershell
# Windows：把复原层覆盖进已安装/已构建的 ZCode
powershell -ExecutionPolicy Bypass -File .\apply-restoration.ps1 -Target "C:\path\to\ZCode\resources"
```

```bash
# Linux / macOS
./apply-restoration.sh /path/to/ZCode/resources
```

### 手动还原

- `restored/glm/packages/*` → 目标 `resources/glm/packages/`
- `restored/tools/cua-helper/` → 目标 `resources/tools/cua-helper/`

### 自测（可选）

```powershell
powershell -ExecutionPolicy Bypass -File .\tests\restoration-selftest.ps1
```

---

## 来源

- 素材来自官方正式版 **ZCode v3.14.3（Windows x64）**
- 下载直链：`https://cdn-zcode.z.ai/zcode/electron/releases/3.14.3/windows-x64/ZCode-3.14.3-win-x64.exe`
- 构建信息：`appVersion 3.14.3` / `buildCommitId ab4d5e6b` / `buildTime 2026-09-22T03:05:10Z` / Electron 41.0.3
- 上游开源仓：`zai-org/ZCode`（Apache-2.0）

---

## ⚠️ 免责说明

**本仓库纯粹是为了方便用户使用「无删减的 ZCode 开源版」而做的能力复原与搬运**，仅供学习、研究与个人使用。
非官方发布物，与 Z.ai / 北京智谱华章无关，不提供任何担保。详见 [DISCLAIMER.md](DISCLAIMER.md)。

相关权利归原作者所有。若权利人认为不妥，请联系删除。