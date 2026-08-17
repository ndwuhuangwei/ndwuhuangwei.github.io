---
title: "Deep Research Report Agent｜深度报告生成智能体系统"
permalink: /projects/report-studio/
author_profile: false
---

<style>
/* report-studio 项目页私有样式（rs- 前缀，避免与 Minimal Mistakes / call-proxy 选择器冲突） */
.rs-topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  margin-bottom: 0.4em;
}
.rs-back { font-size: 0.85em; margin: 0; }
.rs-langswitch {
  display: inline-flex;
  flex-shrink: 0;
  border: 1px solid #cfd8dc;
  border-radius: 999px;
  overflow: hidden;
}
.rs-langswitch button {
  border: 0;
  background: transparent;
  padding: 4px 14px;
  font-size: 0.78em;
  line-height: 1.6;
  color: #546e7a;
  cursor: pointer;
}
.rs-langswitch button.is-active {
  background: #263238;
  color: #fff;
}
body.rs-en .rs-zh-only { display: none !important; }
body:not(.rs-en) .rs-en-only { display: none !important; }
h1.page__title[itemprop="headline"] { display: none; }
.page__content .rs-title { margin-top: 0; }
.rs-chips { margin: 0.2em 0 1.4em; }
.rs-chip {
  display: inline-block;
  padding: 1px 12px;
  margin: 0 6px 6px 0;
  border: 1px solid #cfd8dc;
  border-radius: 999px;
  font-size: 0.72em;
  color: #546e7a;
}
.page__content .rs-intro {
  max-width: 880px;
  margin: 1.6em auto;
}
.rs-intro video {
  width: 100%;
  aspect-ratio: 16 / 9;
  display: block;
  background: #000;
  border-radius: 12px;
}
.rs-video-note {
  text-align: center;
  font-size: 0.75em;
  color: #90a4ae;
  margin-top: 8px;
}
.rs-pending {
  border: 1px solid #ffe0b2;
  background: #fff8e1;
  border-radius: 10px;
  padding: 14px 18px;
  margin: 1em 0 1.6em;
  font-size: 0.92em;
  line-height: 1.6;
}
.rs-overview {
  margin: 1.6em 0;
}
.rs-overview img {
  width: 100%;
  height: auto;
  display: block;
  border: 1px solid #e1e4e8;
  border-radius: 12px;
  background: #fff;
}
.rs-overview figcaption {
  font-size: 0.78em;
  color: #607d8b;
  margin-top: 8px;
  line-height: 1.5;
}
.rs-langswitch button:focus-visible,
.rs-back a:focus-visible,
.rs-intro video:focus-visible {
  outline: 3px solid #1565c0;
  outline-offset: 3px;
}
.rs-langswitch button:focus-visible { outline-offset: -3px; }
@media (prefers-reduced-motion: no-preference) {
  .rs-langswitch button { transition: background 0.15s ease, color 0.15s ease; }
}
</style>

<h1 class="page__title rs-title"><span class="rs-zh-only">深度报告生成智能体系统「Report Studio」</span><span class="rs-en-only" lang="en">Deep Research Report Agent</span></h1>

<div class="rs-topbar">
  <p class="rs-back"><a href="/"><span class="rs-zh-only">← 返回主页</span><span class="rs-en-only" lang="en">← Back to Home</span></a></p>
  <div class="rs-langswitch" role="group" aria-label="语言 / Language">
    <button type="button" id="rs-lang-zh" class="is-active" aria-pressed="true">中文</button><button type="button" id="rs-lang-en" aria-pressed="false">EN</button>
  </div>
</div>

<div class="rs-chips">
  <span class="rs-chip">Agent</span><span class="rs-chip">Workflow</span><span class="rs-chip">HITL</span><span class="rs-chip"><span class="rs-zh-only">可视化</span><span class="rs-en-only" lang="en">Visualization</span></span>
</div>

<div class="rs-zh-only" markdown="1">
面向白皮书、科研综述等长篇报告，已上线网页端产品 **DIRC·Report Studio**。

> 流程可预定义处走定制 Workflow；开放式讨论与成稿编辑处走 ReAct、Multi-Agent 与 Human-in-the-loop。用户给一个主题，系统产出带图表与可追溯引用的结构化报告。
</div>

<div class="rs-en-only" lang="en" markdown="1">
A shipped web product — **DIRC·Report Studio** — for long-form reports such as white papers and literature reviews.

> Custom workflow where the process can be predefined; ReAct, multi-agent orchestration, and human-in-the-loop where it cannot. Give it a topic; it returns a structured report with charts and traceable citations.
</div>

## <span class="rs-zh-only">亮点</span><span class="rs-en-only" lang="en">Highlights</span>

<div class="rs-zh-only" markdown="1">
1. **先划自治边界，再谈能力。**<br>
   依据各环节的任务不确定性划分 Agent 能自主做到哪一步。检索、分章写作、图表装配这类流程可预定义的环节，用定制 Workflow 做任务拆解、分阶段规划与工具调用；开放式讨论与成稿编辑则交给 ReAct 式工具循环、Multi-Agent 编排，并在关键闸门上留出 Human-in-the-loop。

2. **主路径是可执行计划，不是一次生成。**<br>
   意图澄清 → 证据装载 → 大纲规划与评审 → 分章写作与图表装配 → Markdown / PDF / DOCX。用户在意图确认与大纲评审两道闸门上可以多轮介入，后续生成跟着改，而不是生成完再从头重来。

3. **交付的是完整网页产品。**<br>
   会话可恢复、阶段进度可见、报告可下载。不是 notebook 里的 demo 脚本。
</div>

<div class="rs-en-only" lang="en" markdown="1">
1. **Draw the autonomy boundary first.**<br>
   How much the agent may decide on its own is fixed per stage, by how uncertain that stage is. Retrieval, section writing, and figure assembly follow a custom workflow — task decomposition, staged planning, tool calls. Open-ended discussion and manuscript editing use a ReAct tool loop and multi-agent orchestration, with human-in-the-loop at the gates that matter.

2. **The main path is an executable plan, not one-shot generation.**<br>
   Intake → evidence loading → outline planning and review → section writing and figure assembly → Markdown / PDF / DOCX. The user can intervene for multiple rounds at intent confirmation and outline review; later stages follow the revised plan instead of starting over.

3. **What shipped is a complete web product.**<br>
   Sessions resume, stage progress is visible, reports download. Not a notebook demo.
</div>

## <span class="rs-zh-only">演示视频</span><span class="rs-en-only" lang="en">Demo</span>

<div class="rs-zh-only" markdown="1">
现有演示约 46 秒，覆盖已上线主流程：从一句话主题，经意图澄清、专家沙龙与逻辑规划，进入报告生成。
</div>

<div class="rs-en-only" lang="en" markdown="1">
The current walkthrough is about 46 seconds and covers the shipped main pipeline: a one-line topic, through intake, expert salon and logic planning, into report generation.
</div>

<div class="rs-intro">
  <video controls preload="none" playsinline poster="/images/report-studio/intro.jpg" src="/papers/report-agent-intro.mp4" aria-label="Report Studio 演示视频 / demo video"></video>
  <p class="rs-video-note"><span class="rs-zh-only">横屏 1920×1080 · 46″ · 22.0 MB · 点击播放才开始加载</span><span class="rs-en-only" lang="en">Landscape 1920×1080 · 46″ · 22.0 MB · nothing loads until you press play</span></p>
</div>

<div class="rs-pending">
  <span class="rs-zh-only"><strong>更多新功能待展示。</strong> 本视频只覆盖主流程。此后迭代的能力——包括用户知识库、成稿编辑 Agent、沙龙流程增强等——演示将另行补充，当前页暂不展开。</span>
  <span class="rs-en-only" lang="en"><strong>More features awaiting a demo.</strong> This video covers the main pipeline only. Later capabilities — including the user knowledge base, a post-draft editing agent, and salon-flow upgrades — will be demonstrated separately; they are not shown on this page yet.</span>
</div>

## <span class="rs-zh-only">系统总览</span><span class="rs-en-only" lang="en">System Overview</span>

<div class="rs-zh-only" markdown="1">
主流程按三阶段编排，并在意图确认、大纲评审两处设人工闸门。
</div>

<div class="rs-en-only" lang="en" markdown="1">
The main pipeline is arranged in three stages, with human gates at intent confirmation and outline review.
</div>

<figure class="rs-overview">
  <img src="/images/report-studio/overview.png" alt="Report Studio Agent system overview: Data Load, Planner, Writer" loading="lazy">
  <figcaption>
    <span class="rs-zh-only">取数 → 规划 → 写作。虚线框为人工确认闸门；写作阶段按可执行 DAG 跑抽取、分章写作、引用编号、图表装配与导出。</span>
    <span class="rs-en-only" lang="en">Data load → planner → writer. Dashed boxes are human confirmation gates. The writer stage runs extraction, section writing, citation numbering, figure assembly and export over an executable DAG.</span>
  </figcaption>
</figure>

<p class="rs-back"><a href="/"><span class="rs-zh-only">← 返回主页</span><span class="rs-en-only" lang="en">← Back to Home</span></a></p>

<script>
(function () {
  var KEY = 'rs-lang';
  var zhBtn = document.getElementById('rs-lang-zh');
  var enBtn = document.getElementById('rs-lang-en');
  if (!zhBtn || !enBtn) { return; }
  function apply(lang) {
    var en = lang === 'en';
    document.body.classList.toggle('rs-en', en);
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
