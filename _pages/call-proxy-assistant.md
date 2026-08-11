---
title: "On-Device Call Answering Assistant｜端侧智能通话代接系统"
permalink: /projects/call-proxy-assistant/
author_profile: false
---

<style>
/* callproxy 项目页私有样式（cpa- 前缀，避免与 Minimal Mistakes 主题选择器冲突） */
.cpa-back { font-size: 0.85em; margin-bottom: 0.4em; }
.cpa-chips { margin: 0.2em 0 1.4em; }
.cpa-chip {
  display: inline-block;
  padding: 1px 12px;
  margin: 0 6px 6px 0;
  border: 1px solid #cfd8dc;
  border-radius: 999px;
  font-size: 0.72em;
  color: #546e7a;
}
.page__content .cpa-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
  gap: 22px;
  margin: 1.6em 0;
}
.page__content .cpa-card {
  display: block;
  margin: 0;
}
.cpa-card video,
.cpa-intro video {
  width: 100%;
  aspect-ratio: 9 / 16;
  display: block;
  background: #000;
  border-radius: 12px;
}
.page__content .cpa-card figcaption {
  padding: 0 2px 8px;
  line-height: 1.45;
  color: inherit;
}
.cpa-card-num {
  display: block;
  font-size: 0.7em;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #78909c;
  margin-bottom: 2px;
}
.cpa-card-title { font-size: 0.95em; font-weight: bold; }
.cpa-card-desc {
  display: block;
  font-size: 0.78em;
  color: #607d8b;
  margin-top: 3px;
}
.page__content .cpa-intro {
  max-width: 400px;
  margin: 1.6em auto;
}
.cpa-video-note {
  text-align: center;
  font-size: 0.75em;
  color: #90a4ae;
  margin-top: 8px;
}
.cpa-download {
  border: 1px solid #cfd8dc;
  border-radius: 12px;
  padding: 20px 24px;
  margin: 1.6em 0;
}
.cpa-btn {
  display: inline-block;
  padding: 12px 28px;
  background: #263238;
  color: #fff !important;
  border-radius: 8px;
  font-weight: bold;
  text-decoration: none !important;
}
.cpa-btn:hover { background: #37474f; }
.page__content .cpa-download ul {
  list-style: none;
  padding-left: 0;
  margin-left: 0;
  margin-top: 1.2em;
}
.cpa-download li { font-size: 0.88em; margin-bottom: 6px; }
.cpa-sha {
  font-family: Consolas, Monaco, monospace;
  font-size: 0.9em;
  word-break: break-all;
}
.cpa-btn:focus-visible,
.cpa-back a:focus-visible,
.cpa-card video:focus-visible,
.cpa-intro video:focus-visible {
  outline: 3px solid #1565c0;
  outline-offset: 3px;
}
@media (prefers-reduced-motion: no-preference) {
  .cpa-btn { transition: background 0.15s ease; }
}
</style>

<p class="cpa-back"><a href="/">← 返回主页 · Back to Home</a></p>

<div class="cpa-chips">
  <span class="cpa-chip">端侧</span><span class="cpa-chip">全离线</span><span class="cpa-chip">LLM</span><span class="cpa-chip">ASR</span>
</div>

全链路离线：ASR → NLU → TTS 全部本地执行，**零联网**。实测机 **OPPO K13x 5G**（天玑 6300，6 GB RAM，Android 16）。

> 一个跑在 6 GB 内存低端安卓机上的全离线通话代接 App。用「把无限动作空间压成有限选择」的设计，让 0.8B 的小模型在代接这件事上做到可靠。

## 亮点 · Highlights

1. **先划边界，再谈功能。**<br>
   代接是机主的受托记录者，可靠性优先 —— AI 绝不替机主擅自做决策。据此把开放式通话压缩成有限动作空间：话术全部出自人工审定的模板闭集，LLM 无权自由生成回复；挂断、转接这类不可逆动作由确定性规则与状态机裁决。明确了「不做什么」，0.8B 这种量级的模型才能在「做什么」上做到可靠。

2. **全部结论在真低端机上闭环。**<br>
   不在旗舰机上开发再理论外推。内存驻留、线程调度、热稳定、上下文预算，每一项工程决策都在 6 GB 内存的 OPPO K13x 上实测定案。低端机上的结果是本系统的下限。

3. **把 0.8B 钉在「观察者」位置。**<br>
   实测划出小模型的可靠域：自由生成不可靠、提示工程救不动，但结构化的状态观察可以靠微调变可靠。生成交给模板，业务规范内化进权重。微调后的 0.8B 在业务规范遵循上**反超同族 397B 旗舰**。

4. **三条正交的延迟优化，不加硬件、不换更小的模型、不牺牲精度。**<br>
   *提前算* —— 系统提示作为静态前缀，在来电者说话的窗口内完成预填（前缀 KV 快照复用）；<br>
   *少算* —— LLM 只输出本轮变化（稀疏增量），解码长度大幅缩短；<br>
   *不白算* —— GBNF 语法约束让每个生成 token 都落在合法空间，无效输出在解码层就不存在。<br>
   实测：首 token p50 **2948 → 447 ms（−85%）**，单轮 p50 **4842 → 2423 ms（−50%）**。

5. **交付的是完整产品，不是 demo。**<br>
   授权引导 → 自动代接 → 清晰记录（摘要 / 整通录音 / 逐句转写）→ 通知留痕（代接、拦截、转接均入系统消息列表）。产品判断：代接的信任来自可核查 —— 每通电话留下完整证据，用户才敢把电话交出去。

### 关键指标 · Key Numbers

> 端侧数字均实测于 OPPO K13x 5G（天玑 6300，6 GB RAM，Android 16）。

| 维度 | 指标 | 数值 |
|---|---|---|
| NLU | 逐字正确率 | **96.31%**（597 轮 / 198 通；Q4_K_M 量化出货件端侧实测 93.80%） |
| NLU | 结构合法率 / 异常兜底 | **100% / 0 次** |
| ASR | 字错误率 CER（加权） | **6.29%** |
| ASR | 专名字错误率 NE-CER | **15.75% → 6.67%**（拼音吸附 + 热词偏置） |
| 时延 | 首 token p50 | **2948 → 447 ms**（−85%，前缀 KV 快照复用） |
| 时延 | 单轮 p50 | **4842 → 2423 ms**（−50%） |
| 资源 | 通话中内存 PSS | **≈1.40 GB** |
| 资源 | 通话中 CPU | **≈1.33 核**（整机 16.6%） |
| 资源 | 模型总体积 | **≈590 MB**（LLM 529 + ASR 60 + 词典 0.5） |
| 稳定性 | 满负荷热测 | **17 min 无降频**（Thermal Status 全程 NONE，CPU 峰 60.2 °C） |

## 整体介绍 · App Overview

手持实拍真机，4′53″ 完整介绍「代接助手」的核心功能与使用流程。

<div class="cpa-intro">
  <video controls preload="none" playsinline poster="/images/callproxy/intro.jpg" src="/files/callproxy/intro.mp4" aria-label="APP 整体介绍视频"></video>
  <p class="cpa-video-note">竖屏 1080×1920 · 4′53″ · 60.4 MB · 点击播放才开始加载</p>
</div>

## 场景演示 · Case Demo

8 个实拍 case，覆盖代接的完整决策边界：从最短闭环、多轮周旋，到超出受托范围时把沟通权交还机主。视频点击播放后才开始加载；对话文字建议全屏观看。

<div class="cpa-grid">
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 1</span>
      <span class="cpa-card-title">正常外卖来电</span>
      <span class="cpa-card-desc">最短闭环：助手询问收货地址、记下、提示对方可以挂断</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case1-takeout.jpg" src="/files/callproxy/case1-takeout.mp4" aria-label="Case 1 视频：正常外卖来电"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 2</span>
      <span class="cpa-card-title">快递员多轮对话</span>
      <span class="cpa-card-desc">机主预置的放置地点逐个给出（门口 → 保安室），直到对方接受</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case2-courier-address.jpg" src="/files/callproxy/case2-courier-address.mp4" aria-label="Case 2 视频：快递员多轮对话"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 3</span>
      <span class="cpa-card-title">预置地址被全部否决</span>
      <span class="cpa-card-desc">机主授权过的选项已用尽 —— 继续谈就等于替机主做主，助手转接机主</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case3-address-exhausted.jpg" src="/files/callproxy/case3-address-exhausted.mp4" aria-label="Case 3 视频：预置地址被全部否决"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 4</span>
      <span class="cpa-card-title">骑手找不到地址</span>
      <span class="cpa-card-desc">超出转述与记录的受托范围，交还沟通权</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case4-rider-lost.jpg" src="/files/callproxy/case4-rider-lost.mp4" aria-label="Case 4 视频：骑手找不到地址"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 5</span>
      <span class="cpa-card-title">威胁辱骂场景</span>
      <span class="cpa-card-desc">命中安全词表：即刻郑重回应，且刻意不垫语气词</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case5-abuse.jpg" src="/files/callproxy/case5-abuse.mp4" aria-label="Case 5 视频：威胁辱骂场景"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 6</span>
      <span class="cpa-card-title">来电者要求转告机主</span>
      <span class="cpa-card-desc">先把事情收下来，转告事项进入摘要</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case6-message-relay.jpg" src="/files/callproxy/case6-message-relay.mp4" aria-label="Case 6 视频：来电者要求转告机主"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 7</span>
      <span class="cpa-card-title">物业有多件事要转告</span>
      <span class="cpa-card-desc">多条待办逐条记录（交物业费、周三停水）</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case7-property-multi.jpg" src="/files/callproxy/case7-property-multi.mp4" aria-label="Case 7 视频：物业有多件事要转告"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 8</span>
      <span class="cpa-card-title">同事来电后要求转接</span>
      <span class="cpa-card-desc">先收信息，再识别出「要求机主本人接听」→ 铃声级强提醒并等待接管</span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case8-colleague-transfer.jpg" src="/files/callproxy/case8-colleague-transfer.mp4" aria-label="Case 8 视频：同事来电后要求转接"></video>
  </figure>
</div>

## APK 下载 · Download

<div class="cpa-download">
  <p><a class="cpa-btn" href="https://github.com/ndwuhuangwei/ndwuhuangwei.github.io/releases/download/callproxy-v1/CallProxyAssistant-release.apk">下载 APK（597.5 MB）</a></p>
  <ul>
    <li><strong>文件</strong>：CallProxyAssistant-release.apk（Color派代接助手 正式安装包）</li>
    <li><strong>大小</strong>：597.5 MB（626,517,343 字节）—— 体积主要来自随包内置的 LLM + ASR 权重，安装后无需联网下载任何模型</li>
    <li><strong>SHA-256</strong>：<code class="cpa-sha">715d18d8dbd0d88bd86126eaf1976286133eb06711d600125ea49cc093494a70</code></li>
    <li><strong>系统要求</strong>：Android（开发实测于 Android 16 / 天玑 6300 / 6 GB RAM）</li>
    <li><strong>安装提示</strong>：需要在系统里允许安装未知来源应用；首次启动会引导设置为默认电话应用，并逐项解释所需权限</li>
  </ul>
</div>

<p class="cpa-back"><a href="/">← 返回主页 · Back to Home</a></p>
