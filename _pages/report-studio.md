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
  align-items: flex-start;
  gap: 10px;
  margin: 1.2em 0 1.8em;
}
.rs-primary-action {
  display: flex;
  flex: 1 1 380px;
  min-width: 0;
  flex-direction: column;
  align-items: flex-start;
  gap: 6px;
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
.rs-access-note {
  max-width: 520px;
  margin: 0;
  color: #607d8b;
  font-size: 0.76em;
  line-height: 1.55;
}
.rs-access-note a { font-weight: 600; }
.rs-context {
  border-left: 4px solid #1565c0;
  background: #f5f9ff;
  border-radius: 0 10px 10px 0;
  padding: 16px 20px;
  margin: 1em 0 1.8em;
}
.rs-context > :first-child { margin-top: 0; }
.rs-context > :last-child { margin-bottom: 0; }
.page__content .rs-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 30px;
  margin: 1.6em 0;
}
.page__content .rs-card {
  display: block;
  margin: 0;
}
.rs-card video {
  width: 100%;
  aspect-ratio: 16 / 10;
  display: block;
  background: #000;
  border-radius: 12px;
}
.page__content .rs-card figcaption {
  padding: 0 2px 8px;
  line-height: 1.45;
  color: inherit;
}
.rs-card-num {
  display: block;
  font-size: 0.7em;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #78909c;
  margin-bottom: 2px;
}
.rs-card-title { font-size: 0.95em; font-weight: bold; }
.rs-card-desc {
  display: block;
  font-size: 0.78em;
  color: #607d8b;
  margin-top: 3px;
}
.rs-langswitch button:focus-visible,
.rs-back a:focus-visible,
.rs-action:focus-visible,
.rs-access-note a:focus-visible,
.rs-card video:focus-visible {
  outline: 3px solid #1565c0;
  outline-offset: 3px;
}
.rs-langswitch button:focus-visible { outline-offset: -3px; }
@media (prefers-reduced-motion: no-preference) {
  .rs-langswitch button { transition: background 0.15s ease, color 0.15s ease; }
}
</style>

<h1 class="page__title rs-title"><span class="rs-zh-only">深度报告生成智能体系统「DeepX - Report Studio」</span><span class="rs-en-only" lang="en">Deep Research Report Agent</span></h1>

<div class="rs-topbar">
  <p class="rs-back"><a href="/"><span class="rs-zh-only">← 返回主页</span><span class="rs-en-only" lang="en">← Back to Home</span></a></p>
  <div class="rs-langswitch" role="group" aria-label="语言 / Language">
    <button type="button" id="rs-lang-zh" class="is-active" aria-pressed="true">中文</button><button type="button" id="rs-lang-en" aria-pressed="false">EN</button>
  </div>
</div>

<div class="rs-chips">
  <span class="rs-chip">Multi-Agent</span><span class="rs-chip">Agentic RAG</span><span class="rs-chip">HITL</span>
</div>

<div class="rs-zh-only" markdown="1">
**DeepX - Report Studio** 是 DIRC（上海交通大学数据智能研究所）的 [DeepX 平台](https://deepx.acemap.info/)面向科研综述、白皮书等长篇学术报告的智能体功能，目前正在服务真实学术合作内测。

> 系统从研究主题出发，完成需求澄清、专家研讨、证据检索、逻辑规划、并行写作、图表与引用装配，并支持在关键节点由领域专家介入和修改。
</div>

<div class="rs-en-only" lang="en" markdown="1">
**DeepX - Report Studio** is the review-writing agent inside the [DeepX platform](https://deepx.acemap.info/), built by DIRC (the Data Intelligence Research Center at Shanghai Jiao Tong University) for literature reviews, white papers, and other long-form academic reports. It is currently being used in a real journal collaboration and internal pilot.

> Starting from a research topic, it handles requirement clarification, expert deliberation, evidence retrieval, logic planning, parallel writing, figures, and citations, while keeping domain experts in control at critical gates.
</div>

<div class="rs-actions">
  <div class="rs-primary-action">
    <a class="rs-action rs-action-primary" href="https://deepx.acemap.info/report-studio/" target="_blank" rel="noopener noreferrer"><span class="rs-zh-only">打开 Report Studio ↗</span><span class="rs-en-only" lang="en">Open Report Studio ↗</span></a>
    <p class="rs-access-note"><span class="rs-zh-only">内测阶段实行邀请制，只有被邀请的专家才能使用；如想试用，请<a href="mailto:wuhuangwei@sjtu.edu.cn?subject=Report%20Studio%20Trial%20Request">联系 Huangwei</a>（wuhuangwei@sjtu.edu.cn）。</span><span class="rs-en-only" lang="en">The pilot is invitation-only and currently limited to invited experts. To request access, <a href="mailto:wuhuangwei@sjtu.edu.cn?subject=Report%20Studio%20Trial%20Request">email Huangwei</a> (wuhuangwei@sjtu.edu.cn).</span></p>
  </div>
  <a class="rs-action" href="https://deepx.acemap.info/" target="_blank" rel="noopener noreferrer"><span class="rs-zh-only">访问 DeepX 平台 ↗</span><span class="rs-en-only" lang="en">Visit DeepX Platform ↗</span></a>
</div>

## <span class="rs-zh-only">研发背景与合作内测</span><span class="rs-en-only" lang="en">R&amp;D Background &amp; Journal Pilot</span>

<div class="rs-context rs-zh-only" markdown="1">
《地球科学地平线》是面向人工智能时代新创办的地球与行星科学领域期刊，目标是识别未来方向、引领学科发展；创办前期将以邀请领域专家撰写综述论文为主。

DIRC 目前正与《地球科学地平线》开展综述智能体合作内测。双方依托真实文献数据库，检验智能体能否真正帮助学科专家把综述写出来、写得好，并融入真实的研究写作流程。期刊方不仅愿意发表 AI 辅助完成的综述，也愿意推广这类工具，并欢迎作者将人机协同写作过程整理成文章。
</div>

<div class="rs-context rs-en-only" lang="en" markdown="1">
**地球科学地平线** is a newly founded journal for Earth and planetary sciences in the AI era. It aims to identify future directions and help lead disciplinary development, beginning primarily with invited review articles from domain experts.

DIRC is now in a collaborative pilot with the journal. Backed by a real literature database, the pilot asks a practical question: can an agent genuinely help domain experts produce high-quality reviews and fit into a real research-writing workflow? The journal is open not only to publishing AI-assisted reviews, but also to promoting such tools and articles that document the human–AI writing process.
</div>

## <span class="rs-zh-only">技术亮点</span><span class="rs-en-only" lang="en">Technical Highlights</span>

<div class="rs-zh-only" markdown="1">
1. **Agent 编排与 Human-in-the-loop。**<br>
   主链路由自研 DAG Workflow 驱动；针对交叉学科报告进行了特别优化，通过 Multi-Agent 编排推出学术沙龙功能，由一批各自专注于某一学科视角的 Agent 组成集群，尽可能拓宽报告视野、丰富框架；成稿后由基于 LangGraph 架构开发的报告编辑 Agent 接管，用户提出修改意见，Agent 会进行 ReAct 式工具调用循环，对报告中的指定部分进行修改。需求问询、专家名单确认、逻辑拓扑编辑与计划审阅均保留 Human-in-the-loop (HITL) 闸门。

2. **真实文献库上的 Agentic RAG。**<br>
   AceMap 学术文献库（[www.acemap.info](https://www.acemap.info/)）与用户知识库可独立或混合使用；支持上传 PDF 格式的文献或用户资料，并进行结构感知的上下文化分块。检索链采用 BM25 + BGE-M3 稠密向量、RRF 融合和 BGE Cross-Encoder 重排，并支持模型驱动的多轮定向检索和 Tavily 联网搜索。

3. **证据约束的规划、写作与引用。**<br>
   一个 Planner 将研究需求转换为可执行、可编辑的报告拓扑；Agent 解析论文时做结构化抽取，为每条 Claim 保留来源 ID、来源类型与语料出处。Writer 按证据分章写作，引用按正文首次出现排序并保留 DOI，同时基于 Matplotlib、NetworkX、Squarify 构建 Agent 可调用的数据图表生成工具，降低“有结论、无出处”的幻觉风险。

4. **面向长任务的生成工程。**<br>
   设有完善的模型降级策略、上下文管理与分层压缩机制。论文抽取采用自适应并发（根据网络状况实时调整向 model provider 请求的并发调用数），独立章节并行写作；采用分阶段缓存、局部 Checkpoint 和恢复机制避免单点失败导致整份报告重跑。

5. **从生成到修改、交付的产品闭环。**<br>
   SQLite 持久化账户、会话与任务状态，同一个账号的用户知识库支持跨会话复用；用户可直接编辑报告预览，与此同时，编辑助手 Agent 可通过 diff、修订号与写锁保护并发修改。产品提供中英双语界面、明暗主题，以及 DOCX 导出。
</div>

<div class="rs-en-only" lang="en" markdown="1">
1. **Agent orchestration with human control.**<br>
   A custom DAG workflow drives the main path, with a specific optimization for interdisciplinary reports: multi-agent orchestration powers an academic salon in which a cluster of agents, each focused on one disciplinary perspective, widens the report's scope and enriches its framework. Once the draft is complete, a report-editing agent built on LangGraph takes over — the user asks for a change and the agent runs a ReAct-style tool-calling loop to revise the specified part of the report. Human-in-the-loop (HITL) gates cover intake, expert-roster confirmation, editable logic topology, and plan review.

2. **Agentic RAG over real literature.**<br>
   The AceMap scholarly database ([www.acemap.info](https://www.acemap.info/)) and a user-owned corpus can be used separately or together. Literature and user documents are uploaded as PDFs and split into structure-aware contextual chunks. Retrieval combines BM25, BGE-M3 dense embeddings, Reciprocal Rank Fusion (RRF), and a BGE Cross-Encoder reranker, with model-directed multi-round retrieval and Tavily web search.

3. **Evidence-grounded planning, writing, and citations.**<br>
   A planner converts research intent into an executable, editable report topology. When the agent parses a paper it performs structured extraction, preserving the source ID, source type, and corpus provenance behind every claim. The writer works section by section from evidence, numbers citations by first appearance, retains DOI metadata, and builds agent-callable chart-generation tools with Matplotlib, NetworkX, and Squarify to place data-driven figures in the report — lowering the risk of a hallucinated conclusion with no source behind it.

4. **Engineering for long-running generation.**<br>
   Model fallback, context management, and layered compaction are all in place. Paper extraction runs with adaptive concurrency — the number of parallel calls to the model provider is tuned in real time to network conditions — and independent sections are written in parallel; staged caches, partial checkpoints, and recovery keep a single failure from restarting the entire report.

5. **A product loop from generation to revision and delivery.**<br>
   SQLite persists accounts, sessions, and task state, and a user corpus can be reused across sessions within the same account. Users can edit the report preview directly, while an editing-assistant agent protects concurrent changes with diffs, revision IDs, and write locks. The product includes a Chinese/English UI, light/dark themes, and DOCX export.
</div>

## <span class="rs-zh-only">演示视频</span><span class="rs-en-only" lang="en">Demo</span>

<div class="rs-zh-only" markdown="1">
四段实录，按用户使用时的 pipeline 先后顺序排列：先备料（文献知识库），再澄清需求、开专家沙龙，然后审阅大纲并生成正文，最后是成稿后的交互式 Agent 修订。中文字幕已烧录在画面里。
</div>

<div class="rs-en-only" lang="en" markdown="1">
Four screen recordings, ordered by the pipeline a user actually walks through: preparing source material in the literature knowledge base, clarifying the request and convening the expert salon, reviewing the outline and generating the draft, and finally revising the finished draft interactively with the agent. Chinese subtitles are burned into the picture.
</div>

<div class="rs-grid">
  <figure class="rs-card">
    <figcaption>
      <span class="rs-card-num">Demo 1 · 1′18″ · 4.3 MB</span>
      <span class="rs-card-title"><span class="rs-zh-only">文献知识库</span><span class="rs-en-only" lang="en">Literature knowledge base</span></span>
      <span class="rs-card-desc"><span class="rs-zh-only">打开自定义数据库 → 上传导入 PDF 文献 → 重复上传检测 → 解析结果对照预览 → 账号知识库跨会话复用</span><span class="rs-en-only" lang="en">Open a custom database → upload and import PDFs → duplicate detection → side-by-side parsing preview → corpus reuse across sessions</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/report-studio/v4-library.jpg" src="/files/report-studio/v4-library.mp4" aria-label="Demo 1 视频：文献知识库 / Demo 1 video: literature knowledge base"></video>
  </figure>
  <figure class="rs-card">
    <figcaption>
      <span class="rs-card-num">Demo 2 · 2′30″ · 11.2 MB</span>
      <span class="rs-card-title"><span class="rs-zh-only">需求澄清与专家沙龙</span><span class="rs-en-only" lang="en">Clarification and expert salon</span></span>
      <span class="rs-card-desc"><span class="rs-zh-only">一句话研究请求 → 需求澄清与总结卡编辑 → 专家面板 → 专家提问与发言 → 思维基元与思维链</span><span class="rs-en-only" lang="en">A one-sentence research request → requirement clarification and summary-card editing → the expert panel → experts questioning and speaking → thought primitives and chains</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/report-studio/v2-salon.jpg" src="/files/report-studio/v2-salon.mp4" aria-label="Demo 2 视频：需求澄清与专家沙龙 / Demo 2 video: clarification and expert salon"></video>
  </figure>
  <figure class="rs-card">
    <figcaption>
      <span class="rs-card-num">Demo 3 · 2′00″ · 27.6 MB</span>
      <span class="rs-card-title"><span class="rs-zh-only">大纲审阅与正文写作</span><span class="rs-en-only" lang="en">Outline review and drafting</span></span>
      <span class="rs-card-desc"><span class="rs-zh-only">逻辑拓扑思维导图审阅（拖拽、标注逻辑类型、对话改大纲并给出 diff 卡）→ 写作引擎进度 → 图表落位 → DOCX 导出</span><span class="rs-en-only" lang="en">Reviewing the logic-topology mind map (drag, label logic types, revise the outline by chat with diff cards) → writing-engine progress → figure placement → DOCX export</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/report-studio/v3-revise.jpg" src="/files/report-studio/v3-revise.mp4" aria-label="Demo 3 视频：大纲审阅与正文写作 / Demo 3 video: outline review and drafting"></video>
  </figure>
  <figure class="rs-card">
    <figcaption>
      <span class="rs-card-num">Demo 4 · 1′34″ · 10.4 MB</span>
      <span class="rs-card-title"><span class="rs-zh-only">成稿后的编辑 Agent</span><span class="rs-en-only" lang="en">Post-draft editing agent</span></span>
      <span class="rs-card-desc"><span class="rs-zh-only">用自然语言提出修改 → 工具调用轨迹 → 行内 diff 与撤销 → 上下文占用与 compact</span><span class="rs-en-only" lang="en">Ask for changes in natural language → tool-call trace → inline diffs and undo → context usage and compaction</span></span>
    </figcaption>
    <video controls preload="none" playsinline poster="/images/report-studio/v1-agent.jpg" src="/files/report-studio/v1-agent.mp4" aria-label="Demo 4 视频：成稿后的编辑 Agent / Demo 4 video: post-draft editing agent"></video>
  </figure>
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
