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
.cpa-trace-open {
  width: 100%;
  margin-top: 10px;
  padding: 10px 13px;
  border: 1px solid #b7d4cf;
  border-radius: 10px;
  color: #00695c;
  background: #eef8f5;
  cursor: pointer;
  font-size: 0.76em;
  font-weight: 700;
  text-align: left;
}
.cpa-trace-open::after {
  content: "↗";
  float: right;
  font-size: 1.1em;
}
.cpa-trace-open:hover { border-color: #73aaa1; background: #e3f3ef; }
.cpa-trace-dialog {
  width: min(1080px, calc(100% - 24px));
  max-width: 1080px;
  max-height: calc(100vh - 32px);
  padding: 0;
  border: 0;
  border-radius: 18px;
  color: #172126;
  background: #f7faf9;
  box-shadow: 0 28px 90px rgba(13, 29, 31, 0.36);
}
.cpa-trace-dialog::backdrop { background: rgba(17, 29, 32, 0.72); backdrop-filter: blur(3px); }
.cpa-trace-dialog-topbar {
  position: sticky;
  top: 0;
  z-index: 3;
  display: flex;
  justify-content: flex-end;
  padding: 10px 12px 0;
  background: linear-gradient(#f7faf9 75%, rgba(247, 250, 249, 0));
}
.cpa-trace-close {
  display: grid;
  width: 38px;
  height: 38px;
  padding: 0;
  border: 1px solid #cfd8dc;
  border-radius: 50%;
  place-items: center;
  color: #37474f;
  background: #fff;
  cursor: pointer;
  font-size: 1.25rem;
  line-height: 1;
}
#cpa-trace-body { padding: 0 26px 24px; font-size: 16px; }
.cpa-trace-header { margin: -24px 52px 18px 0; }
.cpa-trace-eyebrow {
  color: #00796b;
  font-size: 0.76rem;
  font-weight: 800;
  letter-spacing: 0.09em;
  text-transform: uppercase;
}
.page__content .cpa-trace-title { margin: 5px 0 0; font-size: clamp(1.35rem, 3vw, 2rem); line-height: 1.2; }
.cpa-trace-layout { display: grid; grid-template-columns: 220px minmax(0, 1fr); gap: 18px; align-items: start; }
.cpa-trace-turns { display: grid; gap: 8px; }
.cpa-trace-turn-tab {
  min-width: 0;
  padding: 11px 12px;
  border: 1px solid #d8e2df;
  border-radius: 10px;
  color: #455a64;
  background: #fff;
  cursor: pointer;
  text-align: left;
}
.cpa-trace-turn-tab > span { display: block; color: #00796b; font-size: 0.78rem; font-weight: 800; }
.cpa-trace-turn-tab small {
  display: -webkit-box;
  margin-top: 3px;
  overflow: hidden;
  color: #607d8b;
  font-size: 0.76rem;
  line-height: 1.45;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
}
.cpa-trace-turn-tab.is-active { border-color: #00796b; background: #e5f4f0; box-shadow: 0 0 0 2px rgba(0, 121, 107, 0.1); }
.cpa-trace-panel { min-width: 0; border: 1px solid #d8e2df; border-radius: 14px; overflow: hidden; background: #fff; }
.cpa-trace-step { padding: 18px 20px; border-bottom: 1px solid #e1e8e6; }
.cpa-trace-step:last-child { border-bottom: 0; }
.page__content .cpa-trace-step-title {
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 0 0 12px;
  color: #00695c;
  font-size: 0.83rem;
  font-weight: 800;
  letter-spacing: 0.04em;
}
.cpa-trace-step-number {
  display: grid;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  place-items: center;
  color: #fff;
  background: #00796b;
  font-size: 0.72rem;
}
.page__content .cpa-trace-quote,
.page__content .cpa-trace-reply {
  margin: 0;
  padding: 14px 16px;
  border: 0;
  border-left: 3px solid #80cbc4;
  color: #263238;
  background: #f3f8f7;
  font-size: 1rem;
  font-style: normal;
}
.page__content .cpa-trace-reply { border-left-color: #263238; background: #eef1f2; font-weight: 650; }
.cpa-trace-badge {
  display: inline-block;
  padding: 3px 8px;
  border-radius: 999px;
  font-size: 0.72rem;
  font-weight: 800;
}
.cpa-trace-badge--model { color: #00695c; background: #dff2ed; }
.cpa-trace-badge--rule { color: #8a4b12; background: #fff0d8; }
.page__content .cpa-trace-subtitle { margin: 14px 0 7px; color: #607d8b; font-size: 0.76rem; letter-spacing: 0.03em; }
.page__content .cpa-trace-code {
  max-height: 260px;
  margin: 0;
  padding: 14px 15px;
  overflow: auto;
  border-radius: 10px;
  color: #e8f3ef;
  background: #142124;
  font-size: 0.78rem;
  line-height: 1.55;
  white-space: pre-wrap;
  word-break: break-word;
}
.cpa-trace-annotations { display: grid; gap: 7px; }
.cpa-trace-annotation { display: grid; grid-template-columns: minmax(150px, max-content) 1fr; gap: 10px; align-items: start; font-size: 0.84rem; }
.cpa-trace-annotation code { color: #00695c; font-weight: 700; word-break: break-word; }
.cpa-trace-rule { margin: 12px 0 0; padding: 12px 14px; border-left: 3px solid #d79b48; color: #75410f; background: #fff6e7; font-size: 0.9rem; }
.cpa-trace-engine-copy { margin: 0; font-size: 0.95rem; }
.cpa-trace-meta { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 7px; }
.cpa-trace-meta-item { min-width: 0; padding: 9px 10px; border-radius: 8px; background: #f1f5f4; }
.cpa-trace-meta-item span { display: block; color: #78909c; font-size: 0.7rem; }
.cpa-trace-meta-item code { display: block; margin-top: 2px; color: #263238; font-size: 0.76rem; overflow-wrap: anywhere; }
.cpa-trace-state-list { display: flex; flex-wrap: wrap; gap: 6px; }
.cpa-trace-state { padding: 4px 8px; border: 1px solid #cddbd7; border-radius: 999px; background: #fff; font-size: 0.75rem; }
.cpa-trace-state--offered { border-color: #e2bd79; color: #7d4b0d; background: #fff7e8; }
.cpa-trace-state--rejected { border-color: #e4b4b4; color: #9b2f2f; background: #fff2f2; }
.cpa-trace-state--accepted { border-color: #81b9aa; color: #00695c; background: #e8f6f2; }
.page__content .cpa-trace-requests { margin: 0; padding-left: 1.2em; font-size: 0.84rem; }
.cpa-trace-provenance { margin: 14px 0 0; color: #78909c; font-size: 0.75rem; line-height: 1.5; }
.cpa-trace-loading { min-height: 180px; margin: 0; display: grid; place-items: center; color: #607d8b; }
.cpa-trace-loading--error { color: #a52828; }
@media (max-width: 720px) {
  .cpa-trace-dialog { width: calc(100% - 12px); max-height: calc(100vh - 12px); border-radius: 14px; }
  #cpa-trace-body { padding: 0 13px 16px; }
  .cpa-trace-header { margin-right: 46px; }
  .cpa-trace-layout { grid-template-columns: 1fr; gap: 12px; }
  .cpa-trace-turns { display: flex; padding: 2px; overflow-x: auto; scroll-snap-type: x proximity; }
  .cpa-trace-turn-tab { flex: 0 0 150px; scroll-snap-align: start; }
  .cpa-trace-step { padding: 16px 14px; }
  .cpa-trace-annotation { grid-template-columns: 1fr; gap: 3px; }
  .cpa-trace-meta { grid-template-columns: 1fr; }
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
.cpa-intro video:focus-visible,
.cpa-trace-open:focus-visible,
.cpa-trace-close:focus-visible,
.cpa-trace-turn-tab:focus-visible {
  outline: 3px solid #1565c0;
  outline-offset: 3px;
}
.cpa-langswitch button:focus-visible { outline-offset: -3px; }
@media (prefers-reduced-motion: no-preference) {
  .cpa-btn { transition: background 0.15s ease; }
  .cpa-langswitch button { transition: background 0.15s ease, color 0.15s ease; }
  .cpa-trace-open, .cpa-trace-turn-tab { transition: border-color 0.15s ease, background 0.15s ease; }
}
</style>

<h1 class="page__title cpa-title"><span class="cpa-zh-only">端侧智能通话代接系统</span><span class="cpa-en-only" lang="en">On-Device Call Answering Assistant</span></h1>

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
全链路离线：ASR → NLU → TTS 全部本地执行，**零联网**。实测机 **OPPO K13x**（天玑 6300，6 GB RAM，Android 16，真正的“百元机”）。

> 把无限动作空间压成有限选择，让 0.8B 的小模型在代接这件事上做到可靠。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
Fully offline, end to end: ASR → NLU → TTS all run on device — **zero network access**. Benchmark device: **OPPO K13x** (Dimensity 6300, 6 GB RAM, Android 16 — a genuine budget phone, RMB 799 at launch).

> Compressing an unbounded action space into a finite set of choices is what makes a 0.8B model reliable at taking calls.
</div>

## <span class="cpa-zh-only">亮点</span><span class="cpa-en-only" lang="en">Highlights</span>

<div class="cpa-zh-only" markdown="1">
1. **先划边界，再谈功能。**<br>
   代接是机主的受托记录者，可靠性优先 —— AI 绝不替机主擅自做决策。据此把开放式通话压缩成有限动作空间：话术全部出自人工审定的模板闭集，LLM 无权自由生成回复；挂断、转接这类不可逆动作由确定性规则与状态机裁决。明确了「不做什么」，0.8B 这种量级的模型才能在「做什么」上做到可靠。

2. **全部结论在真低端机上闭环。**<br>
   不在旗舰机上开发再理论外推。内存驻留、线程调度、热稳定、上下文预算，每一项工程决策都基于低端机上的实际测试。

3. **把 0.8B 钉在「观察者」位置。**<br>
   实测划出小模型的可靠域：自由生成不可靠、提示工程救不动，但结构化的状态观察可以靠微调变可靠。生成交给模板，业务规范内化进权重。同一评测集上，微调后的 0.8B **在垂直任务精度上大幅超过同族 397B 旗舰**。

4. **三条正交的延迟优化，不加硬件、不换更小的模型、不牺牲精度。**<br>
   *提前算* —— system prompt 作为静态前缀，在来电者说话的窗口内完成预填（前缀 KV 快照复用）；<br>
   *少算* —— LLM 只输出本轮变化的 schema 字段（稀疏增量），解码长度大幅缩短；<br>
   *不白算* —— GBNF 语法约束让每个生成 token 都落在合法空间，无效输出在解码层就不存在。<br>
   实测：首 token p50 **2948 → 447 ms（−85%）**，单轮 p50 **4842 → 2423 ms（−50%）**。

5. **交付的是完整产品。**<br>
   授权引导 → 自动代接 → 清晰记录（摘要 / 整通录音 / 逐句转写）→ 通知留痕（代接、拦截、转接均入系统消息列表）。代接边界由机主在接起之前划定：生效时段、接管时机、白名单、黑名单。产品判断：代接的信任来自可核查 —— 每通电话留下完整证据，用户才敢把电话交出去。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
1. **Boundaries first, features second.**<br>
   The assistant is the owner's entrusted note-taker, so reliability comes first — the AI never makes decisions on the owner's behalf. The open-ended call is therefore compressed into a finite action space: every spoken line comes from a closed, human-reviewed template set (the LLM is never allowed to free-generate replies), and irreversible actions such as hanging up or transferring are arbitrated by deterministic rules and a state machine. Only after fixing what the system must *not* do can a 0.8B-class model be reliable at what it *does*.

2. **Every conclusion closed the loop on a genuinely low-end phone.**<br>
   No developing on a flagship and extrapolating on paper. Memory residency, thread scheduling, thermal stability, context budget — every engineering decision rests on measurements taken on a low-end phone.

3. **Pinning the 0.8B model to the observer seat.**<br>
   Measurements mapped the small model's reliable domain: free-form generation is unreliable and prompt engineering cannot rescue it, but structured state observation becomes reliable through fine-tuning. So generation is delegated to templates while business rules are baked into the weights. On the same evaluation set the fine-tuned 0.8B **far outperforms its 397B flagship sibling on the accuracy of this vertical task**.

4. **Three orthogonal latency optimizations — no extra hardware, no smaller model, no accuracy loss.**<br>
   *Compute earlier* — the system prompt is a static prefix, prefilled while the caller is still speaking (prefix KV-snapshot reuse);<br>
   *Compute less* — the LLM emits only the schema fields that changed this turn (sparse deltas), sharply shortening decode length;<br>
   *Waste nothing* — GBNF grammar constraints keep every generated token inside the legal space, so invalid output cannot exist at the decoding layer.<br>
   Measured: first-token p50 **2948 → 447 ms (−85%)**, per-turn p50 **4842 → 2423 ms (−50%)**.

5. **What ships is a complete product.**<br>
   Permission onboarding → automatic answering → clear records (summary / full recording / per-utterance transcript) → a notification trail (answered, blocked and transferred calls all enter the system notification list). The owner draws the line before a call is ever picked up: active hours, takeover timing, allowlist, blocklist. The product judgment: trust in call answering comes from verifiability — only when every call leaves complete evidence do users dare hand their phone line over.
</div>

## <span class="cpa-zh-only">整体介绍</span><span class="cpa-en-only" lang="en">App Overview</span>

<div class="cpa-zh-only" markdown="1">
APP 整体设计介绍（具体通话 demo 在下方）。

通话下行采集需要 `CAPTURE_AUDIO_OUTPUT` 权限，官方文档与我们的实测都确认第三方应用拿不到。这只影响 demo 的呈现形式 —— 系统本身在拿到该权限后（例如作为手机厂商系统的一部分）即可直接落地。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
An overview of the app's design (call demos are below).

Capturing the downlink audio of a call requires the `CAPTURE_AUDIO_OUTPUT` permission, which both the official documentation and our own measurements confirm is out of reach for third-party apps. That only constrains how the demo can be presented — the system itself is ready to run as soon as the permission is granted, for example as part of a phone vendor’s own system.
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

<p class="cpa-zh-only">每个视频下方都可以打开逐轮原理。来电文字逐帧取自视频；schema、累计状态、引擎动作和回复来自同一批话语在真机生产路径上的重放，不是根据最终回复反推。</p>
<p class="cpa-en-only" lang="en">Open the turn-by-turn trace below each video. Caller text was recovered frame by frame from the recording; schema, cumulative state, engine action and reply come from replaying those exact utterances through the production path on the phone—not from reverse-engineering the final reply.</p>

<div class="cpa-grid">
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 1</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">正常外卖来电</span><span class="cpa-en-only" lang="en">Regular takeout call</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">最短闭环：助手询问收货地址、记下、提示对方可以挂断</span><span class="cpa-en-only" lang="en">Shortest closed loop: the assistant asks for the delivery address, notes it down, and tells the caller they may hang up</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case1-takeout.jpg" src="/files/callproxy/case1-takeout.mp4" aria-label="Case 1 视频：正常外卖来电"></video>
    <button class="cpa-trace-open" type="button" data-case="case1" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 2 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 2 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 2</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">快递员多轮对话</span><span class="cpa-en-only" lang="en">Courier, multi-turn</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">机主预置的放置地点逐个给出（门口 → 保安室），直到对方接受</span><span class="cpa-en-only" lang="en">Owner-preset drop-off spots are offered one by one (front door → security office) until the courier accepts</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case2-courier-address.jpg" src="/files/callproxy/case2-courier-address.mp4" aria-label="Case 2 视频：快递员多轮对话"></video>
    <button class="cpa-trace-open" type="button" data-case="case2" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 4 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 4 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 3</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">地址连续受阻后转接</span><span class="cpa-en-only" lang="en">Transfer after repeated location failures</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">先逐个提出机主授权地点；“进不去”触发前置规则后把沟通权交还机主</span><span class="cpa-en-only" lang="en">Owner-authorized locations are offered in order; “cannot enter” then triggers a pre-NLU handoff rule</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case3-address-exhausted.jpg" src="/files/callproxy/case3-address-exhausted.mp4" aria-label="Case 3 视频：地址连续受阻后转接"></video>
    <button class="cpa-trace-open" type="button" data-case="case3" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 4 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 4 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 4</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">骑手找不到地址</span><span class="cpa-en-only" lang="en">Rider can't find the address</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">超出转述与记录的受托范围，交还沟通权</span><span class="cpa-en-only" lang="en">Beyond the relay-and-record mandate; the assistant hands the conversation back</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case4-rider-lost.jpg" src="/files/callproxy/case4-rider-lost.mp4" aria-label="Case 4 视频：骑手找不到地址"></video>
    <button class="cpa-trace-open" type="button" data-case="case4" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 2 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 2 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 5</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">威胁辱骂场景</span><span class="cpa-en-only" lang="en">Threats and abuse</span> <span class="cpa-warn"><span class="cpa-zh-only">⚠ 请不要在公众场合外放</span><span class="cpa-en-only" lang="en">⚠ Do not play out loud in public</span></span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">命中安全词表：即刻郑重回应，且刻意不垫语气词</span><span class="cpa-en-only" lang="en">Safety wordlist hit: an immediate, stern response with deliberately no softening filler</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case5-abuse.jpg" src="/files/callproxy/case5-abuse.mp4" aria-label="Case 5 视频：威胁辱骂场景"></video>
    <button class="cpa-trace-open" type="button" data-case="case5" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 2 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 2 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 6</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">来电者要求转告机主</span><span class="cpa-en-only" lang="en">Caller asks to relay a message</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">先把事情收下来，转告事项进入摘要</span><span class="cpa-en-only" lang="en">The matter is taken down first; relay items go into the summary</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case6-message-relay.jpg" src="/files/callproxy/case6-message-relay.mp4" aria-label="Case 6 视频：来电者要求转告机主"></video>
    <button class="cpa-trace-open" type="button" data-case="case6" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 2 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 2 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 7</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">物业有多件事要转告</span><span class="cpa-en-only" lang="en">Property office, several matters</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">多条待办逐条记录（交物业费、周三停水）</span><span class="cpa-en-only" lang="en">Multiple to-dos recorded item by item (pay the property fee; water outage on Wednesday)</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case7-property-multi.jpg" src="/files/callproxy/case7-property-multi.mp4" aria-label="Case 7 视频：物业有多件事要转告"></video>
    <button class="cpa-trace-open" type="button" data-case="case7" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 3 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 3 turns</span></button>
  </figure>
  <figure class="cpa-card">
    <figcaption>
      <span class="cpa-card-num">Case 8</span>
      <span class="cpa-card-title"><span class="cpa-zh-only">同事来电后要求转接</span><span class="cpa-en-only" lang="en">Colleague, then a transfer request</span></span>
      <span class="cpa-card-desc"><span class="cpa-zh-only">先收信息，再识别出「要求机主本人接听」→ 铃声级强提醒并等待接管</span><span class="cpa-en-only" lang="en">Information is collected first; then "the owner must take this call" is recognized → ring-level alert, waiting for takeover</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/callproxy/case8-colleague-transfer.jpg" src="/files/callproxy/case8-colleague-transfer.mp4" aria-label="Case 8 视频：同事来电后要求转接"></video>
    <button class="cpa-trace-open" type="button" data-case="case8" aria-haspopup="dialog" aria-controls="cpa-trace-dialog"><span class="cpa-zh-only">查看逐轮原理 · 2 轮</span><span class="cpa-en-only" lang="en">View NLU trace · 2 turns</span></button>
  </figure>
</div>

<dialog class="cpa-trace-dialog" id="cpa-trace-dialog" aria-label="NLU trace / 逐轮原理">
  <div class="cpa-trace-dialog-topbar"><button class="cpa-trace-close" id="cpa-trace-close" type="button" aria-label="关闭">×</button></div>
  <div id="cpa-trace-body"></div>
</dialog>

<noscript><p class="cpa-zh-only">逐轮原理需要启用 JavaScript 查看。</p><p class="cpa-en-only" lang="en">JavaScript is required to view the turn-by-turn trace.</p></noscript>

## <span class="cpa-zh-only">关键指标</span><span class="cpa-en-only" lang="en">Key Numbers</span>

> 端侧数字均实测于 OPPO K13x（天玑 6300，6 GB RAM，Android 16）。
{: .cpa-zh-only}

> All on-device numbers were measured on an OPPO K13x (Dimensity 6300, 6 GB RAM, Android 16).
{: .cpa-en-only lang="en"}

<div class="cpa-zh-only" markdown="1">
**NLU 精度：三条路线对照（使用 Qwen3.5 系列 LLM）**
</div>

<div class="cpa-en-only" lang="en" markdown="1">
**NLU accuracy: three approaches side by side (Qwen3.5 family)**
</div>

| 指标 | 0.8B 微调模型 ＋ 精简 system prompt | 397B Baseline ＋ system prompt 加入完整 schema 说明书 | 0.8B Baseline ＋ system prompt 加入完整 schema 说明书 |
|---|---|---|---|
| **Schema validity · JSON 可解析**<br><span class="cpa-metric-note">输出能不能被解析成 JSON</span> | **100%** | **100%** | 74.49% |
| **Schema validity · 契约合规**<br><span class="cpa-metric-note">解析出来之后，字段、枚举、摘录是否全部符合约定</span> | **100%** | 92.97% | 12.45% |
| **Active Intent Accuracy**<br><span class="cpa-metric-note">这通电话属于哪种场景，判断对了没有</span> | **98.12%** | 72.37% | 4.32% |
| **Slot-Event F1**<br><span class="cpa-metric-note">从原话里抽出的每一条（字段值、待办事项、候选操作）准不准</span> | **0.9288** | 0.2432 | 0.0049 |
| **Average Goal Accuracy**<br><span class="cpa-metric-note">该记下来的东西有没有记对，不追究多记</span> | **91.85%** | 37.31% | 0.56% |
| **Joint Goal Accuracy**<br><span class="cpa-metric-note">整份累积记录一字不差才算对，多记一条即归零</span> | **84.21%** | 11.09% | 29.32% |
| **Sentence-level Frame Accuracy**<br><span class="cpa-metric-note">这一轮输出的 11 个字段全部正确的比例</span> | **90.23%** | 12.22% | 0.00% |
| **回复正确率**<br><span class="cpa-metric-note">经规则引擎渲染后，来电者实际听到的那句话对不对</span> | **93.23%** | 60.34% | 0.38% |
{: .cpa-zh-only}

| Metric | 0.8B fine-tuned + compact system prompt | 397B baseline + full schema spec in the system prompt | 0.8B baseline + full schema spec in the system prompt |
|---|---|---|---|
| **Schema validity · JSON parseable**<br><span class="cpa-metric-note">Can the output be parsed as JSON at all</span> | **100%** | **100%** | 74.49% |
| **Schema validity · contract compliant**<br><span class="cpa-metric-note">Once parsed: are all fields, enum values and excerpts within the contract</span> | **100%** | 92.97% | 12.45% |
| **Active Intent Accuracy**<br><span class="cpa-metric-note">Which scenario this call belongs to — was it identified correctly</span> | **98.12%** | 72.37% | 4.32% |
| **Slot-Event F1**<br><span class="cpa-metric-note">Accuracy of each item extracted from what the caller said (field values, to-dos, candidate actions)</span> | **0.9288** | 0.2432 | 0.0049 |
| **Average Goal Accuracy**<br><span class="cpa-metric-note">Of what should have been recorded, how much was recorded correctly — over-recording not penalized</span> | **91.85%** | 37.31% | 0.56% |
| **Joint Goal Accuracy**<br><span class="cpa-metric-note">The whole accumulated record must match exactly; one spurious entry zeroes the turn</span> | **84.21%** | 11.09% | 29.32% |
| **Sentence-level Frame Accuracy**<br><span class="cpa-metric-note">Share of turns where all 11 output fields are correct</span> | **90.23%** | 12.22% | 0.00% |
| **Reply correctness**<br><span class="cpa-metric-note">After the rule engine renders it, is the sentence the caller actually hears correct</span> | **93.23%** | 60.34% | 0.38% |
{: .cpa-en-only lang="en"}

<details class="cpa-zh-only">
<summary>口径说明</summary>
<p><strong>为什么先判场景。</strong>代接不是一个通用问答任务。不同来电的观测重点不一样：外卖骑手要问的是放置地点，中介、保险要记的是转告事项，快递到楼下要处理的是到达通知。所以系统先判定这通电话属于哪种场景（放置协商 / 留言记录 / 到达通知 / 尚未确定），再按该场景激活对应的 schema 模板 —— LLM 在这一轮只被允许写入属于该场景的字段，这个收窄由语法约束在解码层强制执行（GBNF），结构上不可能越界。因此场景判断是上游闸门：判错了，后面整轮的字段空间就是错的。</p>
<p><strong>为什么 Joint Goal Accuracy 这一项，0.8B Baseline 反而比 397B Baseline 高。</strong>这一项要求整份累积记录一字不差，惩罚的是「多说」—— 多记一条本不该记的待办，这一轮就归零。于是它有个副作用：输出越少的模型，在「本来就没什么可记」的轮次上越容易蒙对。0.8B Baseline 大多数时候根本吐不出合规的结果，等于什么都没记，反而躲过了扣分；397B 会积极地填写内容，填错就扣。所以这一项必须和上一项 Average Goal Accuracy 一起看：后者只看该记的有没有记对，不追究多记。<strong>AGA 看漏没漏，JGA 看多没多。</strong></p>
</details>

<details class="cpa-en-only" lang="en">
<summary>How these were measured</summary>
<p><strong>Why the scenario is decided first.</strong> Answering a call is not a generic QA task. What matters differs by caller: a food-delivery rider needs a drop-off location, an agency or insurer leaves a message to relay, a parcel courier reports an arrival. So the system first decides which scenario the call belongs to (drop-off negotiation / message capture / arrival notice / not yet determined), then activates the schema template for that scenario — within a turn the LLM may only write fields belonging to that scenario, and the narrowing is enforced by the grammar at the decoding layer (GBNF), so going out of bounds is structurally impossible. Scenario identification is therefore an upstream gate: get it wrong and the whole turn’s field space is wrong.</p>
<p><strong>Why the 0.8B baseline beats the 397B baseline on Joint Goal Accuracy.</strong> This metric demands that the entire accumulated record match exactly, so it punishes over-recording — one to-do that should not have been written zeroes the turn. That has a side effect: the less a model produces, the more often it is right by default on turns where there was nothing to record. The 0.8B baseline mostly fails to produce anything the contract accepts, which amounts to recording nothing and so dodges the penalty; the 397B fills things in eagerly and pays for every mistake. So read this metric together with the one above it: Average Goal Accuracy only asks whether what should have been recorded was recorded, and does not hold over-recording against the model. <strong>AGA catches what was missed, JGA catches what was invented.</strong></p>
</details>

<div class="cpa-zh-only" markdown="1">
**ASR / 时延 / 资源 / 稳定性**
</div>

<div class="cpa-en-only" lang="en" markdown="1">
**ASR / latency / resources / stability**
</div>

| 维度 | 指标 | 数值 |
|---|---|---|
| ASR | 字错误率 CER<br><span class="cpa-metric-note">语音转文字每 100 个字错几个，越低越好；在干净语音与两种真实通话信道音质下分别实测取平均</span> | **7.49%**（AISHELL-1 干净集 5.92% · AMR-NB 窄带 9.79% · AMR-WB 宽带 6.76%，三者平均） |
| ASR | 专名字错误率 NE-CER<br><span class="cpa-metric-note">人名、地名这类专有词最容易听错，优化后错误率砍掉一半多</span> | **15.75% → 6.67%**（拼音吸附 + 热词偏置） |
| 时延 | 首 token 时延（优化前 → 优化后）<br><span class="cpa-metric-note">对方说完话到 AI 开始回话的等待时间（中位数）</span> | **2948 → 447 ms**（−85%，前缀 KV 快照复用） |
| 时延 | 单轮时延（优化前 → 优化后）<br><span class="cpa-metric-note">一问一答完整一轮的耗时（中位数）</span> | **4842 → 2423 ms**（−50%） |
| 资源 | 通话中内存 PSS<br><span class="cpa-metric-note">通话时 App 实际占用的手机内存</span> | **≈1.40 GB** |
| 资源 | 通话中 CPU<br><span class="cpa-metric-note">通话时占用的算力，约一又三分之一个核心</span> | **≈1.33 核**（整机 16.6%） |
| 资源 | 模型总体积<br><span class="cpa-metric-note">随 App 装进手机的全部 AI 模型加起来的大小</span> | **≈590 MB**（LLM 529 + ASR 60 + 词典 0.5） |
| 稳定性 | 满负荷热测<br><span class="cpa-metric-note">连续高强度跑 17 分钟，手机没有因过热降速</span> | **17 min 无降频**（Thermal Status 全程 NONE，CPU 峰 60.2 °C） |
{: .cpa-zh-only}

| Dimension | Metric | Value |
|---|---|---|
| ASR | Character error rate (CER)<br><span class="cpa-metric-note">Out of every 100 characters transcribed, roughly how many are wrong — lower is better; averaged over clean speech and two real telephone-channel codecs</span> | **7.49%** (mean of AISHELL-1 clean 5.92% · AMR-NB narrowband 9.79% · AMR-WB wideband 6.76%) |
| ASR | Named-entity CER<br><span class="cpa-metric-note">Names and places are the easiest to mishear; optimizations cut the error rate by more than half</span> | **15.75% → 6.67%** (pinyin snapping + hotword biasing) |
| Latency | First-token latency (before → after)<br><span class="cpa-metric-note">Median wait from the caller finishing speaking to the AI starting to answer</span> | **2948 → 447 ms** (−85%, prefix KV-snapshot reuse) |
| Latency | Per-turn latency (before → after)<br><span class="cpa-metric-note">Median time for one full ask-and-answer round</span> | **4842 → 2423 ms** (−50%) |
| Resources | In-call memory, PSS<br><span class="cpa-metric-note">RAM the app actually occupies during a call</span> | **≈1.40 GB** |
| Resources | In-call CPU<br><span class="cpa-metric-note">Compute used during a call — about one and a third cores</span> | **≈1.33 cores** (16.6% of the whole device) |
| Resources | Total model footprint<br><span class="cpa-metric-note">Combined size of all AI models shipped inside the app</span> | **≈590 MB** (LLM 529 + ASR 60 + lexicon 0.5) |
| Stability | Full-load thermal test<br><span class="cpa-metric-note">17 minutes flat out with no heat-induced slowdown</span> | **17 min with zero throttling** (Thermal Status NONE throughout, CPU peak 60.2 °C) |
{: .cpa-en-only lang="en"}

<div class="cpa-zh-only" markdown="1">
**同一份 APK 换机复测**
</div>

<div class="cpa-en-only" lang="en" markdown="1">
**Same APK, re-measured on another phone**
</div>

| 指标 | OPPO K13x（目标档） | Xiaomi 14（对照机） | 倍数 |
|---|---|---|---|
| NLU 整轮时延 | p50 1406 ms | p50 608 ms | 2.31× |
| ASR 解码 · 裸模型 greedy | p50 472.5 ms | p50 187 ms | 2.53× |
| ASR 解码 · 出品配置（beam4 ＋ 179 热词） | p50 668.5 ms | p50 295 ms | 2.27× |
| 冷启到就绪 | 4.5 s | 2.2 s | 2.05× |
{: .cpa-zh-only}

| Metric | OPPO K13x (target tier) | Xiaomi 14 (reference) | Ratio |
|---|---|---|---|
| NLU per-turn latency | p50 1406 ms | p50 608 ms | 2.31× |
| ASR decode · bare model, greedy | p50 472.5 ms | p50 187 ms | 2.53× |
| ASR decode · shipped config (beam4 + 179 hotwords) | p50 668.5 ms | p50 295 ms | 2.27× |
| Cold start to ready | 4.5 s | 2.2 s | 2.05× |
{: .cpa-en-only lang="en"}

<div class="cpa-zh-only" markdown="1">
因为 OPPO K13x 只用了两个线程，所以 Xiaomi 14 的线程数也钉死为 2，未用满其大核 —— 这一列不是 Xiaomi 14 的上限。
</div>

<div class="cpa-en-only" lang="en" markdown="1">
Because the OPPO K13x only uses two threads, the Xiaomi 14 is pinned to 2 threads as well and does not use its big cores fully — this column is not the Xiaomi 14’s ceiling.
</div>
## <span class="cpa-zh-only">APK 下载</span><span class="cpa-en-only" lang="en">Download</span>

<div class="cpa-download">
  <p><a class="cpa-btn" href="https://github.com/ndwuhuangwei/ndwuhuangwei.github.io/releases/download/callproxy-v1/CallProxyAssistant-release.apk"><span class="cpa-zh-only">下载 APK（597.5 MB）</span><span class="cpa-en-only" lang="en">Download APK (597.5 MB)</span></a></p>
  <ul>
    <li class="cpa-zh-only"><strong>文件</strong>：CallProxyAssistant-release.apk</li>
    <li class="cpa-en-only" lang="en"><strong>File</strong>: CallProxyAssistant-release.apk</li>
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
    document.dispatchEvent(new CustomEvent('cpa-language-change', { detail: en ? 'en' : 'zh' }));
  }
  zhBtn.addEventListener('click', function () { apply('zh'); });
  enBtn.addEventListener('click', function () { apply('en'); });
  var saved = null;
  try { saved = localStorage.getItem(KEY); } catch (e) {}
  apply(saved === 'en' ? 'en' : 'zh');
})();
</script>
<script src="/assets/js/callproxy-nlu-traces.js"></script>
