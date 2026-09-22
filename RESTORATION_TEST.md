# 还原自测报告（RESTORATION_TEST）

> 目的：证明 `apply-restoration.ps1` 能把 `restored/` 复原层**完整、逐字节一致**地还原进目标目录。
> 脚本：`tests/restoration-selftest.ps1`

---

## 测试方法

1. **模拟"被阉割"状态**：新建临时目标目录，在其中放置一个**空桩**占位文件
   `glm/packages/zcode-cua-plugin/index.js`，内容为
   `// Computer Use is not available in this build.`（即开源版里 Computer Use 的桩）。
2. **执行还原**：调用 `apply-restoration.ps1 -Target <临时目录>`。
3. **逐文件校验**：读取 `restored/MANIFEST.sha256`（共 **1029** 个文件），
   对每个文件比对**存在性**与 **sha256**。
4. 统计 `ok / missing / mismatch`，全对则 `PASS`。

---

## 测试结果

```
== Restoration self-test ==
[stub] wrote stripped placeholder: glm/packages/zcode-cua-plugin/index.js
[run ] apply-restoration.ps1 -Target <temp>
[1/3] Copying plugins -> <temp>\glm\packages\
[2/3] Copying cua-helper -> <temp>\tools\cua-helper\
[3/3] Done.
  - android-emulator-plugin
  - browser-use-plugin
  - bundled-skills
  - documents-plugin
  - image-search-plugin
  - ios-simulator-plugin
  - node-repl-host
  - pdf-plugin
  - plugin-creator-plugin
  - presentations-plugin
  - restore-legacy-sessions-plugin
  - skill-creator-plugin
  - spreadsheets-plugin
  - zcode-cua-plugin
  - zcode-guide-plugin

== Result ==
total   : 1029
ok      : 1029
missing : 0
mismatch: 0
SELFTEST: PASS
```

| 指标 | 数值 |
|---|---|
| 校验文件总数 | **1029** |
| 通过（sha256 一致） | **1029** |
| 缺失 | 0 |
| 内容不符 | 0 |
| **结论** | ✅ **PASS** |

---

## 结论

- 复原脚本可**完整还原** 15 个官方插件与 Computer Use 原生助手，**逐字节与源一致**。
- 空桩会被**正确覆盖**（`Copy-Item -Force`）。
- 覆盖范围：`glm/packages/**`（15 个插件） + `tools/cua-helper/**`，共 1029 个文件。

## 说明（范围与边界）

- 本自测验证的是**还原过程与文件完整性**，属于"搬得对不对"。
- **运行时实测**（把复原层装进已构建的 ZCode 后，Computer Use 能否真正驱动桌面软件）
  需要**带图形界面的桌面环境 + 已登录的 ZCode**，请在实际使用机器上按 `README` 的用法执行。
- 复原素材的**逐文件 sha256 清单**见 `restored/MANIFEST.sha256`，可随时独立复验。