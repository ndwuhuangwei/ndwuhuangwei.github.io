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
.rs-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin: 1.2em 0 1.8em;
}
.rs-action {
  display: inline-block;
  padding: 8px 16px;
  border: 1px solid #263238;
  border-radius: 8px;
  font-size: 0.88em;
  font-weight: 600;
  text-decoration: none;
}
.rs-action-primary {
  color: #fff !important;
  background: #263238;
}
.rs-context {
  border-left: 4px solid #1565c0;
  background: #f5f9ff;
  border-radius: 0 10px 10px 0;
  padding: 16px 20px;
  margin: 1em 0 1.8em;
}
.rs-context > :first-child,
.rs-pending > :first-child { margin-top: 0; }
.rs-context > :last-child,
.rs-pending > :last-child { margin-bottom: 0; }
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
.rs-langswitch button:focus-visible,
.rs-back a:focus-visible,
.rs-action:focus-visible,
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
  <span class="rs-chip">Multi-Agent</span><span class="rs-chip">Agentic RAG</span><span class="rs-chip">LangGraph</span><span class="rs-chip">HITL</span><span class="rs-chip">DeepSeek</span>
</div>

<div class="rs-zh-only" markdown="1">
**Report Studio** 是 [DeepX 平台](https://deepx.acemap.cn/)面向科研综述、白皮书等长篇学术报告的智能体功能，目前正在服务真实学术合作内测。

> 系统从研究主题出发，完成需求澄清、专家研讨、证据检索、逻辑规划、并行写作、图表与引用装配，并支持在关键节点由领域专家介入和修改。
</div>

<div class="rs-en-only" lang="en" markdown="1">
**Report Studio** is the review-writing agent inside the [DeepX platform](https://deepx.acemap.cn/), built for literature reviews, white papers, and other long-form academic reports. It is currently being used in a real journal collaboration and internal pilot.

> Starting from a research topic, it handles requirement clarification, expert deliberation, evidence retrieval, logic planning, parallel writing, figures, and citations, while keeping domain experts in control at critical gates.
</div>

<div class="rs-actions">
  <a class="rs-action rs-action-primary" href="https://deepx.acemap.cn/report-studio/" target="_blank" rel="noopener noreferrer"><span class="rs-zh-only">打开 Report Studio ↗</span><span class="rs-en-only" lang="en">Open Report Studio ↗</span></a>
  <a class="rs-action" href="https://deepx.acemap.cn/" target="_blank" rel="noopener noreferrer"><span class="rs-zh-only">访问 DeepX 平台 ↗</span><span class="rs-en-only" lang="en">Visit DeepX Platform ↗</span></a>
</div>

## <span class="rs-zh-only">研发背景与合作内测</span><span class="rs-en-only" lang="en">R&amp;D Background &amp; Journal Pilot</span>

<div class="rs-context rs-zh-only" markdown="1">
《地球科学地平线》是面向人工智能时代新创办的地球与行星科学领域期刊，目标是识别未来方向、引领学科发展；创办前期将以邀请领域专家撰写综述论文为主。

Report Studio 目前正与《地球科学地平线》开展综述智能体合作内测。双方依托真实文献数据库与 DeepSeek 系列模型，检验智能体能否真正帮助学科专家把综述写出来、写得好，并融入真实的研究写作流程。期刊方不仅愿意发表 AI 辅助完成的综述，也愿意推广这类工具，并欢迎作者将人机协同写作过程整理成文章。
</div>

<div class="rs-context rs-en-only" lang="en" markdown="1">
**地球科学地平线** is a newly founded journal for Earth and planetary sciences in the AI era. It aims to identify future directions and help lead disciplinary development, beginning primarily with invited review articles from domain experts.

Report Studio is now in a collaborative pilot with the journal. Backed by a real literature database and DeepSeek models, the pilot asks a practical question: can an agent genuinely help domain experts produce high-quality reviews and fit into a real research-writing workflow? The journal is open not only to publishing AI-assisted reviews, but also to promoting such tools and articles that document the human–AI writing process.
</div>

## <span class="rs-zh-only">技术亮点</span><span class="rs-en-only" lang="en">Technical Highlights</span>

<div class="rs-zh-only" markdown="1">
1. **Agent 编排与 Human-in-the-loop。**<br>
   主链路由自研 DAG Workflow 驱动，包含拓扑校验、内容寻址 JSON Checkpoint 与断点恢复；开放环节使用 Multi-Agent 学术沙龙、ReAct 和原生 Function Calling，成稿后由 LangGraph 报告编辑 Agent 接管。需求问询、专家名单确认、逻辑拓扑编辑与计划审阅均保留 HITL 闸门。

2. **真实文献库上的 Agentic RAG。**<br>
   AceMap 学术文献库与用户知识库可独立或混合使用；通过 PyMuPDF、python-docx 等解析 PDF、DOCX、Markdown、TXT，并进行结构感知的上下文化分块。检索链采用 BM25 + BGE-M3 稠密向量、RRF 融合和 BGE Cross-Encoder 重排，并支持模型驱动的多轮定向检索、Tavily 联网搜索及显式降级。

3. **证据约束的规划、写作与引用。**<br>
   Planner 将研究需求转换为可执行、可编辑的报告拓扑；结构化抽取为每条论断保留来源 ID、来源类型与混合语料出处。Writer 按证据分章写作，引用按正文首次出现排序并保留 DOI，同时用 Matplotlib、NetworkX、Squarify 生成数据驱动图表，降低“有结论、无出处”的风险。

4. **面向长任务的生成工程。**<br>
   DeepSeek 系列模型通过 OpenAI-compatible API 按阶段路由快/深思模型，并设模型降级、上下文预算与分层压缩。论文抽取采用自适应并发，独立章节并行写作；分阶段缓存、局部 Checkpoint 和恢复机制避免单点失败导致整份报告重跑。

5. **从生成到修改、交付的产品闭环。**<br>
   SQLite 持久化账户、会话与任务状态，用户知识库支持跨会话复用；可编辑预览和 LangGraph 编辑 Agent 通过 diff、修订号与写锁保护并发修改。产品提供中英双语界面、明暗主题，以及 Markdown / DOCX 导出，而不是停留在 notebook demo。
</div>

<div class="rs-en-only" lang="en" markdown="1">
1. **Agent orchestration with human control.**<br>
   A custom DAG workflow drives the main path with topology validation, content-addressed JSON checkpoints, and recovery. Open-ended stages use a multi-agent academic salon, ReAct, and native function calling; a LangGraph report agent handles post-draft edits. HITL gates cover intake, expert-roster confirmation, editable logic topology, and plan review.

2. **Agentic RAG over real literature.**<br>
   AceMap scholarly data and a user-owned corpus can be used separately or together. PyMuPDF and python-docx parse PDF, DOCX, Markdown, and TXT into structure-aware contextual chunks. Retrieval combines BM25, BGE-M3 dense embeddings, Reciprocal Rank Fusion (RRF), and a BGE Cross-Encoder reranker, with model-directed multi-round retrieval, Tavily web search, and explicit degradation.

3. **Evidence-grounded planning, writing, and citations.**<br>
   The planner converts research intent into an executable, editable report topology. Structured extraction preserves source IDs, source types, and mixed-corpus provenance for claims. The writer works section by section from evidence, numbers citations by first appearance, retains DOI metadata, and builds data-driven figures with Matplotlib, NetworkX, and Squarify.

4. **Engineering for long-running generation.**<br>
   DeepSeek models are routed by stage through an OpenAI-compatible API with fast/reasoning modes, model fallback, context budgets, and layered compaction. Adaptive extraction concurrency, parallel section writing, staged caches, and partial checkpoints prevent a single failure from restarting the entire report.

5. **A product loop from generation to revision and delivery.**<br>
   SQLite persists accounts, sessions, and task state, while user corpora can be reused across sessions. Editable preview and the LangGraph editing agent protect concurrent changes with diffs, revision IDs, and write locks. The product includes Chinese/English UI, light/dark themes, and Markdown / DOCX export—not a notebook-only demo.
</div>

## <span class="rs-zh-only">演示视频</span><span class="rs-en-only" lang="en">Demo</span>

<div class="rs-zh-only" markdown="1">
现有视频是一段 **45.5 秒的早期流程片段**，只覆盖从创建任务，经需求澄清、专家沙龙与逻辑规划，到进入报告生成的前半段；它不是当前系统的完整能力清单。
</div>

<div class="rs-en-only" lang="en" markdown="1">
This is a **45.5-second early workflow excerpt**. It covers only the first half of the journey—from task creation through intake, expert salon, and logic planning to the start of report generation. It is not a complete inventory of the current system.
</div>

<div class="rs-intro">
  <video controls preload="none" playsinline poster="/images/report-studio/intro.jpg" src="/papers/report-agent-intro.mp4" aria-label="Report Studio 演示视频 / demo video"></video>
  <p class="rs-video-note"><span class="rs-zh-only">横屏 1920×1080 · 45.5″ · 22.0 MB · 点击播放才开始加载</span><span class="rs-en-only" lang="en">Landscape 1920×1080 · 45.5″ · 22.0 MB · nothing loads until you press play</span></p>
</div>

<div class="rs-pending rs-zh-only" markdown="1">
**更多新功能待展示——视频尚未展示：**

- 用户知识库、混合 RAG 与模型驱动的多轮检索；
- 专家名单确认、智能跳过已回答问题，以及可编辑、可讨论的逻辑拓扑；
- 完整章节并行生成、证据引用、数据图表与参考文献装配；
- 报告完成后的 LangGraph 编辑 Agent；
- Markdown / DOCX 导出与跨会话知识库复用。

以上属于当前开发/合作内测能力，后续将补充分段演示。
</div>

<div class="rs-pending rs-en-only" lang="en" markdown="1">
**More features await dedicated demos—this video does not yet show:**

- the user knowledge base, hybrid RAG, and model-directed multi-round retrieval;
- expert-roster confirmation, intelligent question skipping, and editable/discussable logic topology;
- full parallel section generation, evidence citations, data figures, and reference assembly;
- the post-draft LangGraph editing agent;
- Markdown / DOCX export and cross-session corpus reuse.

These are current development/collaborative-pilot capabilities. Focused walkthroughs will be added later.
</div>

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
