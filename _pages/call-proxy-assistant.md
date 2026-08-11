---
title: "On-Device Call Answering Assistant｜端侧智能通话代接系统"
permalink: /projects/call-proxy-assistant/
author_profile: false
---

<style>
/* callproxy 项目页私有样式（cpa- 前缀，避免与 Minimal Mistakes 主题选择器冲突） */
.cpa-topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  margin-bottom: 0.4em;
}
.cpa-back { font-size: 0.85em; margin: 0; }
.cpa-langswitch {
  display: inline-flex;
  flex-shrink: 0;
  border: 1px solid #cfd8dc;
  border-radius: 999px;
  overflow: hidden;
}
.cpa-langswitch button {
  border: 0;
  background: transparent;
  padding: 4px 14px;
  font-size: 0.78em;
  line-height: 1.6;
  color: #546e7a;
  cursor: pointer;
}
.cpa-langswitch button.is-active {
  background: #263238;
  color: #fff;
}
/* 语言可见性：默认（无 body 类，含 JS 被禁）显示中文；body.cpa-en 时显示英文 */
body.cpa-en .cpa-zh-only { display: none !important; }
body:not(.cpa-en) .cpa-en-only { display: none !important; }
/* front-matter 标题不支持语言切换：隐藏主题渲染的 h1，正文内自绘双语标题（复用 page__title 类保持样式一致） */
h1.page__title[itemprop="headline"] { display: none; }
.page__content .cpa-title { margin-top: 0; }
.cpa-metric-note {
  display: block;
  font-weight: normal;
  font-size: 0.82em;
  color: #90a4ae;
  margin-top: 2px;
}
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
.cpa-warn {
  color: #c62828;
  font-weight: 600;
  font-size: 0.85em;
}
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
.cpa-langswitch button:focus-visible,
.cpa-card video:focus-visible,
.cpa-intro video:focus-visible {
  outline: 3px solid #1565c0;
  outline-offset: 3px;
}
.cpa-langswitch button:focus-visible { outline-offset: -3px; }
@media (prefers-reduced-motion: no-preference) {
  .cpa-btn { transition: background 0.15s ease; }
  .cpa-langswitch button { transition: background 0.15s ease, color 0.15s ease; }
}
</style>

<h1 class="page__title cpa-title"><span class="cpa-zh-only">端侧智能通话代接系统「代接助手」</span><span class="cpa-en-only" lang="en">On-Device Call Answering Assistant</span></h1>

<div class="cpa-topbar">
  <p class="cpa-back"><a href="/"><span class="cpa-zh-only">← 返回主页</span><span class="cpa-en-only" lang="en">← Back to Home</span></a></p>
  <div class="cpa-langswitch" role="group" aria-label="语言 / Language">
    <button type="button" id="cpa-lang-zh" class="is-active" aria-pressed="true">中文</button><button type="button" id="cpa-lang-en" aria-pressed="false">EN</button>
  </div>
</div>

<div class="cpa-chips">
  <span class="cpa-chip"><span class="cpa-zh-only">端侧</span><span class="cpa-en-only" lang="en">On-device</span></span><span class="cpa-chip"><span class="cpa-zh-only">全离线</span><span class="cpa-en-only" lang="en">Fully offline</span></span><span class="cpa-chip">LLM</span><span class="cpa-chip">ASR</span>
</div>

<div class="cpa-zh-only" markdown="1">
全链路离线：ASR → NLU → TTS 全部本地执行，**零联网**。实测机 **OPPO K13x 5G**（天玑 6300，6 GB RAM，Android 16）。

> 一个跑在 6 GB 内存低端安卓机上的全离线通话代接 App。用「把无限动作空间压成有限选择」的设计，让 0.8B 的小模型在代接这件事上做到可靠。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
Fully offline, end to end: ASR → NLU → TTS all run on device — **zero network access**. Benchmark device: **OPPO K13x 5G** (Dimensity 6300, 6 GB RAM, Android 16).

> A fully offline call-answering app that runs on a 6 GB entry-level Android phone. Its core design — compressing an unbounded action space into a finite set of choices — is what makes a 0.8B model reliable at taking calls.
</div>

## <span class="cpa-zh-only">亮点</span><span class="cpa-en-only" lang="en">Highlights</span>

<div class="cpa-zh-only" markdown="1">
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
</div>

<div class="cpa-en-only" lang="en" markdown="1">
1. **Boundaries first, features second.**<br>
   The assistant is the owner's entrusted note-taker, so reliability comes first — the AI never makes decisions on the owner's behalf. The open-ended call is therefore compressed into a finite action space: every spoken line comes from a closed, human-reviewed template set (the LLM is never allowed to free-generate replies), and irreversible actions such as hanging up or transferring are arbitrated by deterministic rules and a state machine. Only after fixing what the system must *not* do can a 0.8B-class model be reliable at what it *does*.

2. **Every conclusion closed the loop on a genuinely low-end phone.**<br>
   No developing on a flagship and extrapolating on paper. Memory residency, thread scheduling, thermal stability, context budget — every engineering decision was settled by measurement on the 6 GB OPPO K13x. Low-end results are this system's floor.

3. **Pinning the 0.8B model to the observer seat.**<br>
   Measurements mapped the small model's reliable domain: free-form generation is unreliable and prompt engineering cannot rescue it, but structured state observation becomes reliable through fine-tuning. So generation is delegated to templates while business rules are baked into the weights. The fine-tuned 0.8B **beats its 397B flagship sibling** at business-rule compliance.

4. **Three orthogonal latency optimizations — no extra hardware, no smaller model, no accuracy loss.**<br>
   *Compute earlier* — the system prompt is a static prefix, prefilled while the caller is still speaking (prefix KV-snapshot reuse);<br>
   *Compute less* — the LLM emits only what changed this turn (sparse deltas), sharply shortening decode length;<br>
   *Waste nothing* — GBNF grammar constraints keep every generated token inside the legal space, so invalid output cannot exist at the decoding layer.<br>
   Measured: first-token p50 **2948 → 447 ms (−85%)**, per-turn p50 **4842 → 2423 ms (−50%)**.

5. **What ships is a complete product, not a demo.**<br>
   Permission onboarding → automatic answering → clear records (summary / full recording / per-utterance transcript) → a notification trail (answered, blocked and transferred calls all enter the system notification list). The product judgment: trust in call answering comes from verifiability — only when every call leaves complete evidence do users dare hand their phone line over.
</div>

### <span class="cpa-zh-only">关键指标</span><span class="cpa-en-only" lang="en">Key Numbers</span>

> 端侧数字均实测于 OPPO K13x 5G（天玑 6300，6 GB RAM，Android 16）。
{: .cpa-zh-only}

> All on-device numbers were measured on an OPPO K13x 5G (Dimensity 6300, 6 GB RAM, Android 16).
{: .cpa-en-only lang="en"}

| 维度 | 指标 | 数值 |
|---|---|---|
| NLU | 逐字正确率<br><span class="cpa-metric-note">输出的 JSON 内容与人工标注 ground truth 逐字段逐字比对，完全对上的比例</span> | **96.31%**（597 轮 / 198 通；Q4_K_M 量化出货件端侧实测 93.80%） |
| NLU | 渲染话术一致率<br><span class="cpa-metric-note">确定性规则引擎根据 LLM 输出的 schema 渲染出的最终回复话术，与预期话术完全一致的比例</span> | **99.66%** |
| NLU | 结构合法率 / 异常兜底<br><span class="cpa-metric-note">输出 JSON 的 schema 格式正确率 —— 全部可解析且符合约定结构，保底纠错一次没用上</span> | **100% / 0 次** |
| ASR | 字错误率 CER<br><span class="cpa-metric-note">语音转文字每 100 个字错几个，越低越好；在干净语音与两种真实通话信道音质下分别实测取平均</span> | **7.49%**（AISHELL-1 干净集 5.92% · AMR-NB 窄带 9.79% · AMR-WB 宽带 6.76%，三者平均） |
| ASR | 专名字错误率 NE-CER<br><span class="cpa-metric-note">人名、地名这类专有词最容易听错，优化后错误率砍掉一半多</span> | **15.75% → 6.67%**（拼音吸附 + 热词偏置） |
| 时延 | 首 token p50<br><span class="cpa-metric-note">对方说完话到 AI 开始回话的等待时间（中位数）</span> | **2948 → 447 ms**（−85%，前缀 KV 快照复用） |
| 时延 | 单轮 p50<br><span class="cpa-metric-note">一问一答完整一轮的耗时（中位数）</span> | **4842 → 2423 ms**（−50%） |
| 资源 | 通话中内存 PSS<br><span class="cpa-metric-note">通话时 App 实际占用的手机内存</span> | **≈1.40 GB** |
| 资源 | 通话中 CPU<br><span class="cpa-metric-note">通话时占用的算力，约一又三分之一个核心</span> | **≈1.33 核**（整机 16.6%） |
| 资源 | 模型总体积<br><span class="cpa-metric-note">随 App 装进手机的全部 AI 模型加起来的大小</span> | **≈590 MB**（LLM 529 + ASR 60 + 词典 0.5） |
| 稳定性 | 满负荷热测<br><span class="cpa-metric-note">连续高强度跑 17 分钟，手机没有因过热降速</span> | **17 min 无降频**（Thermal Status 全程 NONE，CPU 峰 60.2 °C） |
{: .cpa-zh-only}

| Dimension | Metric | Value |
|---|---|---|
| NLU | Word-level accuracy<br><span class="cpa-metric-note">Output JSON compared with human-labeled ground truth, field by field and character by character</span> | **96.31%** (597 turns / 198 calls; 93.80% on device with the shipped Q4_K_M quantization) |
| NLU | Rendered-utterance consistency<br><span class="cpa-metric-note">Final replies rendered by the deterministic rule engine from the LLM's schema output — share that exactly matches the expected utterance</span> | **99.66%** |
| NLU | Structural validity / fallback triggers<br><span class="cpa-metric-note">Schema validity of the output JSON — all parseable and well-formed; the fallback repair never fired</span> | **100% / 0** |
| ASR | Character error rate (CER)<br><span class="cpa-metric-note">Out of every 100 characters transcribed, roughly how many are wrong — lower is better; averaged over clean speech and two real telephone-channel codecs</span> | **7.49%** (mean of AISHELL-1 clean 5.92% · AMR-NB narrowband 9.79% · AMR-WB wideband 6.76%) |
| ASR | Named-entity CER<br><span class="cpa-metric-note">Names and places are the easiest to mishear; optimizations cut the error rate by more than half</span> | **15.75% → 6.67%** (pinyin snapping + hotword biasing) |
| Latency | First-token p50<br><span class="cpa-metric-note">Median wait from the caller finishing speaking to the AI starting to answer</span> | **2948 → 447 ms** (−85%, prefix KV-snapshot reuse) |
| Latency | Per-turn p50<br><span class="cpa-metric-note">Median time for one full ask-and-answer round</span> | **4842 → 2423 ms** (−50%) |
| Resources | In-call memory, PSS<br><span class="cpa-metric-note">RAM the app actually occupies during a call</span> | **≈1.40 GB** |
| Resources | In-call CPU<br><span class="cpa-metric-note">Compute used during a call — about one and a third cores</span> | **≈1.33 cores** (16.6% of the whole device) |
| Resources | Total model footprint<br><span class="cpa-metric-note">Combined size of all AI models shipped inside the app</span> | **≈590 MB** (LLM 529 + ASR 60 + lexicon 0.5) |
| Stability | Full-load thermal test<br><span class="cpa-metric-note">17 minutes flat out with no heat-induced slowdown</span> | **17 min with zero throttling** (Thermal Status NONE throughout, CPU peak 60.2 °C) |
{: .cpa-en-only lang="en"}

## <span class="cpa-zh-only">整体介绍</span><span class="cpa-en-only" lang="en">App Overview</span>

<div class="cpa-zh-only" markdown="1">
手持实拍真机，4′53″ 完整介绍「代接助手」的核心功能与使用流程。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
A 4′53″ walkthrough of the app's core features and flows, shot handheld on a real device.
</div>

<div class="cpa-intro">
  <video controls preload="none" playsinline poster="/images/callproxy/intro.jpg" src="/files/callproxy/intro.mp4" aria-label="APP 整体介绍视频 / App overview video"></video>
  <p class="cpa-video-note"><span class="cpa-zh-only">竖屏 1080×1920 · 4′53″ · 60.4 MB · 点击播放才开始加载</span><span class="cpa-en-only" lang="en">Portrait 1080×1920 · 4′53″ · 60.4 MB · nothing loads until you press play</span></p>
</div>

## <span class="cpa-zh-only">场景演示</span><span class="cpa-en-only" lang="en">Case Demos</span>

<div class="cpa-zh-only" markdown="1">
8 个实拍 case，覆盖代接的完整决策边界：从最短闭环、多轮周旋，到超出受托范围时把沟通权交还机主。视频点击播放后才开始加载；对话文字建议全屏观看。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
Eight real-device recordings covering the full decision boundary: from the shortest closed loop and multi-turn negotiation to handing the conversation back once a request exceeds the assistant's mandate. Videos load only when played; fullscreen is recommended for reading the on-screen dialogue.
</div>

<div class="cpa-grid">
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 1</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">正常外卖来电</span><span class="cpa-en-only" lang="en">Regular takeout call</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">最短闭环：助手询问收货地址、记下、提示对方可以挂断</span><span class="cpa-en-only" lang="en">Shortest closed loop: the assistant asks for the delivery address, notes it down, and tells the caller they may hang up</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case1-takeout.jpg" src="/files/callproxy/case1-takeout.mp4" aria-label="Case 1 视频：正常外卖来电"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 2</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">快递员多轮对话</span><span class="cpa-en-only" lang="en">Courier, multi-turn</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">机主预置的放置地点逐个给出（门口 → 保安室），直到对方接受</span><span class="cpa-en-only" lang="en">Owner-preset drop-off spots are offered one by one (front door → security office) until the courier accepts</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case2-courier-address.jpg" src="/files/callproxy/case2-courier-address.mp4" aria-label="Case 2 视频：快递员多轮对话"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 3</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">预置地址被全部否决</span><span class="cpa-en-only" lang="en">All preset spots rejected</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">机主授权过的选项已用尽 —— 继续谈就等于替机主做主，助手转接机主</span><span class="cpa-en-only" lang="en">The owner-authorized options are exhausted — negotiating further would mean deciding for the owner, so the assistant transfers the call</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case3-address-exhausted.jpg" src="/files/callproxy/case3-address-exhausted.mp4" aria-label="Case 3 视频：预置地址被全部否决"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 4</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">骑手找不到地址</span><span class="cpa-en-only" lang="en">Rider can't find the address</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">超出转述与记录的受托范围，交还沟通权</span><span class="cpa-en-only" lang="en">Beyond the relay-and-record mandate; the assistant hands the conversation back</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case4-rider-lost.jpg" src="/files/callproxy/case4-rider-lost.mp4" aria-label="Case 4 视频：骑手找不到地址"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 5</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">威胁辱骂场景</span><span class="cpa-en-only" lang="en">Threats and abuse</span> <span class="cpa-warn"><span class="cpa-zh-only">⚠ 请不要在公众场合外放</span><span class="cpa-en-only" lang="en">⚠ Do not play out loud in public</span></span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">命中安全词表：即刻郑重回应，且刻意不垫语气词</span><span class="cpa-en-only" lang="en">Safety wordlist hit: an immediate, stern response with deliberately no softening filler</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case5-abuse.jpg" src="/files/callproxy/case5-abuse.mp4" aria-label="Case 5 视频：威胁辱骂场景"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 6</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">来电者要求转告机主</span><span class="cpa-en-only" lang="en">Caller asks to relay a message</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">先把事情收下来，转告事项进入摘要</span><span class="cpa-en-only" lang="en">The matter is taken down first; relay items go into the summary</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case6-message-relay.jpg" src="/files/callproxy/case6-message-relay.mp4" aria-label="Case 6 视频：来电者要求转告机主"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 7</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">物业有多件事要转告</span><span class="cpa-en-only" lang="en">Property office, several matters</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">多条待办逐条记录（交物业费、周三停水）</span><span class="cpa-en-only" lang="en">Multiple to-dos recorded item by item (pay the property fee; water outage on Wednesday)</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case7-property-multi.jpg" src="/files/callproxy/case7-property-multi.mp4" aria-label="Case 7 视频：物业有多件事要转告"></video>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 8</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">同事来电后要求转接</span><span class="cpa-en-only" lang="en">Colleague, then a transfer request</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">先收信息，再识别出「要求机主本人接听」→ 铃声级强提醒并等待接管</span><span class="cpa-en-only" lang="en">Information is collected first; then "the owner must take this call" is recognized → ring-level alert, waiting for takeover</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case8-colleague-transfer.jpg" src="/files/callproxy/case8-colleague-transfer.mp4" aria-label="Case 8 视频：同事来电后要求转接"></video>
  </figure>
</div>

## <span class="cpa-zh-only">APK 下载</span><span class="cpa-en-only" lang="en">Download</span>

<div class="cpa-download">
  <p><a class="cpa-btn" href="https://github.com/ndwuhuangwei/ndwuhuangwei.github.io/releases/download/callproxy-v1/CallProxyAssistant-release.apk"><span class="cpa-zh-only">下载 APK（597.5 MB）</span><span class="cpa-en-only" lang="en">Download APK (597.5 MB)</span></a></p>
  <ul>
    <li class="cpa-zh-only"><strong>文件</strong>：CallProxyAssistant-release.apk（Color派代接助手 正式安装包）</li>
    <li class="cpa-en-only" lang="en"><strong>File</strong>: CallProxyAssistant-release.apk (the Color派代接助手 release build)</li>
    <li class="cpa-zh-only"><strong>大小</strong>：597.5 MB（626,517,343 字节）—— 体积主要来自随包内置的 LLM + ASR 权重，安装后无需联网下载任何模型</li>
    <li class="cpa-en-only" lang="en"><strong>Size</strong>: 597.5 MB (626,517,343 bytes) — mostly the bundled LLM + ASR weights; nothing else to download after install</li>
    <li><strong>SHA-256</strong><span class="cpa-zh-only">：</span><span class="cpa-en-only" lang="en">: </span><code class="cpa-sha">715d18d8dbd0d88bd86126eaf1976286133eb06711d600125ea49cc093494a70</code></li>
    <li class="cpa-zh-only"><strong>系统要求</strong>：Android（开发实测于 Android 16 / 天玑 6300 / 6 GB RAM）</li>
    <li class="cpa-en-only" lang="en"><strong>Requires</strong>: Android (developed and tested on Android 16 / Dimensity 6300 / 6 GB RAM)</li>
    <li class="cpa-zh-only"><strong>安装提示</strong>：需要在系统里允许安装未知来源应用；首次启动会引导设置为默认电话应用，并逐项解释所需权限</li>
    <li class="cpa-en-only" lang="en"><strong>Install notes</strong>: allow installation from unknown sources; on first launch the app walks you through setting it as the default phone app, explaining each permission it asks for</li>
  </ul>
</div>

<p class="cpa-back"><a href="/"><span class="cpa-zh-only">← 返回主页</span><span class="cpa-en-only" lang="en">← Back to Home</span></a></p>

<script>
(function () {
  var KEY = 'cpa-lang';
  var zhBtn = document.getElementById('cpa-lang-zh');
  var enBtn = document.getElementById('cpa-lang-en');
  if (!zhBtn || !enBtn) { return; }
  function apply(lang) {
    var en = lang === 'en';
    document.body.classList.toggle('cpa-en', en);
    zhBtn.classList.toggle('is-active', !en);
    enBtn.classList.toggle('is-active', en);
    zhBtn.setAttribute('aria-pressed', String(!en));
    enBtn.setAttribute('aria-pressed', String(en));
    try { localStorage.setItem(KEY, en ? 'en' : 'zh'); } catch (e) {}
  }
  zhBtn.addEventListener('click', function () { apply('zh'); });
  enBtn.addEventListener('click', function () { apply('en'); });
  var saved = null;
  try { saved = localStorage.getItem(KEY); } catch (e) {}
  apply(saved === 'en' ? 'en' : 'zh');
})();
</script>
