(function () {
  'use strict';

  var dialog = document.getElementById('cpa-trace-dialog');
  var body = document.getElementById('cpa-trace-body');
  var closeButton = document.getElementById('cpa-trace-close');
  var triggers = Array.prototype.slice.call(document.querySelectorAll('.cpa-trace-open'));
  if (!dialog || !body || !closeButton || !triggers.length) { return; }

  var traceDocument = null;
  var tracePromise = null;
  var activeCase = null;
  var activeTurn = 0;
  var lastTrigger = null;
  var openRequest = 0;

  var words = {
    zh: {
      loading: '正在读取真机 trace…',
      error: 'trace 数据暂时无法读取，请刷新页面后重试。',
      close: '关闭',
      real: '真机生产路径重放',
      turn: '第 {n} 轮',
      caller: '来电者原话',
      schema: 'NLU / 前置规则',
      engine: '引擎反应',
      reply: '助手回复',
      produced: '0.8B 模型已运行',
      skipped: '确定性规则优先',
      raw: '模型输出的原始 schema',
      meanings: '字段就地解释',
      cumulative: '引擎合并后的累计状态',
      mode: '对话状态',
      profile: '当前档案',
      candidates: '地点候选',
      requests: '已记录事项',
      callback: '接听偏好',
      safety: '安全状态',
      alert: '机主提醒',
      path: '处理路径',
      speechKey: '话术键',
      noModelLost: '“找不到 / 进不去”命中地址受阻规则。该规则位于 NLU 之前，所以这一轮没有 schema。',
      noModelSafety: '明确威胁命中安全规则。该规则位于 NLU 之前，所以这一轮没有 schema。',
      provenance: '来电文本逐帧取自对应视频；schema、累计状态、引擎动作和回复来自 2026-09-05 在 OPPO K13x 上执行的同代码路径重放。',
      noExtraState: '本轮没有新增候选或转告事项。'
    },
    en: {
      loading: 'Loading the on-device trace…',
      error: 'The trace data could not be loaded. Refresh the page and try again.',
      close: 'Close',
      real: 'Production-path replay on device',
      turn: 'Turn {n}',
      caller: 'Caller — ASR final',
      schema: 'NLU / pre-NLU rule',
      engine: 'Engine reaction',
      reply: 'Assistant reply',
      produced: '0.8B model ran',
      skipped: 'Deterministic rule took priority',
      raw: 'Raw schema emitted by the model',
      meanings: 'Inline field explanation',
      cumulative: 'Cumulative state after the engine merged this turn',
      mode: 'Dialogue mode',
      profile: 'Active profile',
      candidates: 'Location candidates',
      requests: 'Recorded requests',
      callback: 'Callback preference',
      safety: 'Safety state',
      alert: 'Owner alert',
      path: 'Engine path',
      speechKey: 'Speech key',
      noModelLost: '“Cannot find / cannot enter” hit the lost-address rule. It runs before NLU, so this turn has no schema.',
      noModelSafety: 'An explicit threat hit the safety rule. It runs before NLU, so this turn has no schema.',
      provenance: 'Caller text was recovered frame by frame from the matching video. Schema, cumulative state, engine action and reply come from the same-code-path replay run on an OPPO K13x on 2026-09-05.',
      noExtraState: 'This turn added no location candidate or recorded request.'
    }
  };

  var statusLabels = {
    zh: { available: '可用', offered: '已提出', rejected: '已拒绝', accepted: '已接受' },
    en: { available: 'available', offered: 'offered', rejected: 'rejected', accepted: 'accepted' }
  };

  var candidateLabels = {
    zh: {},
    en: {
      '订单上的收货地址': 'order delivery address',
      '门口': 'front door',
      '保安室': 'security office',
      '菜鸟驿站': 'parcel station'
    }
  };

  function language() {
    return document.body.classList.contains('cpa-en') ? 'en' : 'zh';
  }

  function text(key) {
    return words[language()][key];
  }

  function node(tag, className, value) {
    var result = document.createElement(tag);
    if (className) { result.className = className; }
    if (value !== undefined && value !== null) { result.textContent = value; }
    return result;
  }

  function localizedCandidate(label) {
    return candidateLabels[language()][label] || label;
  }

  function prettySchema(raw) {
    try { return JSON.stringify(JSON.parse(raw), null, 2); }
    catch (error) { return raw; }
  }

  function annotationRows(turn) {
    var lang = language();
    var parsed;
    try { parsed = JSON.parse(turn.raw); }
    catch (error) { return []; }
    var rows = [];

    if (parsed.profile_hint) {
      var profileMeaning = {
        zh: { dropoff: '把会话归入投递信息收集；后续只在机主授权的地点中选择。', message_capture: '把会话归入留言记录；后续内容进入请求台账。', unknown: '当前意图仍不明确，先追问具体事项。' },
        en: { dropoff: 'Classify the call as a drop-off flow; later choices stay inside owner-authorized locations.', message_capture: 'Classify the call as message capture; later items enter the request ledger.', unknown: 'Intent is still unclear, so the engine asks what the call is about.' }
      };
      rows.push(['profile_hint: ' + parsed.profile_hint, profileMeaning[lang][parsed.profile_hint] || parsed.profile_hint]);
    }
    if (parsed.biz_hint) {
      var bizMeaning = {
        zh: { takeout: '业务类型是外卖。', express: '业务类型是快递。', property: '业务类型是物业通知。', other: '没有落入已知业务类型。' },
        en: { takeout: 'Business type: takeout.', express: 'Business type: courier delivery.', property: 'Business type: property management.', other: 'No known business type was selected.' }
      };
      rows.push(['biz_hint: ' + parsed.biz_hint, bizMeaning[lang][parsed.biz_hint] || parsed.biz_hint]);
    }
    (parsed.candidate_events || []).forEach(function (event) {
      var label = traceDocument.candidateLabels[event.candidate];
      var meaning = lang === 'zh'
        ? (event.op === 'reject' ? '把“' + label + '”从可用候选改为已拒绝。' : '确认来电者接受“' + label + '”。')
        : (event.op === 'reject' ? 'Mark “' + localizedCandidate(label) + '” as rejected.' : 'Record that the caller accepted “' + localizedCandidate(label) + '”.');
      rows.push(['candidate: ' + event.candidate + ' · op: ' + event.op, meaning]);
    });
    (parsed.request_additions || []).forEach(function (request) {
      var kind = request.kind === 'todo' ? (lang === 'zh' ? '待办' : 'to-do') : (lang === 'zh' ? '通知' : 'notice');
      var deadline = request.deadline ? (lang === 'zh' ? '，截止 ' : ', due ') + request.deadline : '';
      rows.push(['request_additions · ' + request.kind, (lang === 'zh' ? '新增' : 'Add ') + kind + '：“' + request.content + '”' + deadline + '。']);
    });
    (parsed.field_events || []).forEach(function (event) {
      var meaning = lang === 'zh'
        ? '把 ' + event.field + ' 更新为“' + event.value + '”。'
        : 'Set ' + event.field + ' to “' + event.value + '”.';
      rows.push([event.field + ' · op: ' + event.op, meaning]);
    });
    if (parsed.caller_signal) {
      rows.push(['caller_signal: ' + parsed.caller_signal, lang === 'zh' ? '来电者明确要求机主本人接听。' : 'The caller explicitly asked to speak with the owner.']);
    }
    return rows;
  }

  function engineExplanation(turn) {
    var lang = language();
    var state = turn.state;
    var offered = (state.candidates || []).filter(function (item) { return item[1] === 'offered'; })[0];
    var accepted = (state.candidates || []).filter(function (item) { return item[1] === 'accepted'; })[0];
    var offeredName = offered ? localizedCandidate(offered[0]) : '';
    var acceptedName = accepted ? localizedCandidate(accepted[0]) : '';
    var explanations = {
      zh: {
        offer_platform_address: '激活投递流程，从机主授权列表中先提出“' + offeredName + '”，再渲染固定话术。',
        offer_candidate: '保存本轮拒绝结果，从仍可用的地点中选择“' + offeredName + '”，再渲染询问模板。',
        candidate_accepted: '把“' + acceptedName + '”标记为已接受，转入等待来电者结束状态，再渲染地点确认模板。',
        candidate_accepted_with_note: '同时保存已接受地点和新增通知，选择“地点＋留言均已记录”的固定话术。',
        clarify_request: '意图仍不明确，不替机主作决定；引擎选择追问事项的固定话术。',
        recorded: '把本轮待办写入请求台账，转入等待结束状态，并确认已经记录。',
        recorded_complete: '在已有台账上追加本轮通知，保留此前待办，然后渲染完成话术。',
        alert_requested: turn.enginePath === 'model_nlu' ? '识别到来电者要求机主本人接听，启动机主强提醒并进入等待接管状态。' : '前置规则直接启动机主强提醒，进入等待接管状态；模型没有运行。',
        abuse_warning: '安全规则记录首次明确威胁，将安全状态改为已警告，并立即渲染警告话术。',
        safety_end: '再次命中威胁后把安全状态改为结束；警告话术播完后执行挂断。'
      },
      en: {
        offer_platform_address: 'Activate the drop-off flow, offer “' + offeredName + '” first from the owner-authorized list, then render a fixed line.',
        offer_candidate: 'Persist the rejection, choose “' + offeredName + '” from the remaining locations, then render the candidate question template.',
        candidate_accepted: 'Mark “' + acceptedName + '” as accepted, move to the wait-for-end state, then render the location confirmation template.',
        candidate_accepted_with_note: 'Persist both the accepted location and the new notice, then choose the fixed “location and message recorded” line.',
        clarify_request: 'Intent is still unclear. The engine does not decide for the owner; it renders the fixed clarification line.',
        recorded: 'Write the to-do into the request ledger, move to the wait-for-end state, and confirm that it was recorded.',
        recorded_complete: 'Append the notice to the existing ledger while retaining the earlier to-do, then render the completion line.',
        alert_requested: turn.enginePath === 'model_nlu' ? 'The caller explicitly requested the owner. Start a high-priority owner alert and wait for takeover.' : 'A pre-NLU rule starts a high-priority owner alert and waits for takeover; the model does not run.',
        abuse_warning: 'Record the first explicit threat, move safety state to warned, and immediately render the warning line.',
        safety_end: 'A repeated threat moves safety state to ended; the call is ended after the final warning finishes.'
      }
    };
    return explanations[lang][turn.speechKey] || turn.speechKey;
  }

  function step(number, label) {
    var section = node('section', 'cpa-trace-step');
    var heading = node('h3', 'cpa-trace-step-title');
    heading.appendChild(node('span', 'cpa-trace-step-number', String(number)));
    heading.appendChild(document.createTextNode(label));
    section.appendChild(heading);
    return section;
  }

  function addMeta(container, label, value) {
    var item = node('div', 'cpa-trace-meta-item');
    item.appendChild(node('span', '', label));
    item.appendChild(node('code', '', value));
    container.appendChild(item);
  }

  function renderState(container, turn) {
    var state = turn.state;
    container.appendChild(node('h4', 'cpa-trace-subtitle', text('cumulative')));
    var meta = node('div', 'cpa-trace-meta');
    addMeta(meta, text('mode'), state.modeBefore + ' → ' + state.modeAfter);
    if (state.profile) { addMeta(meta, text('profile'), state.profile); }
    addMeta(meta, text('path'), turn.enginePath);
    addMeta(meta, text('speechKey'), turn.speechKey);
    if (state.callbackPreference) { addMeta(meta, text('callback'), state.callbackPreference); }
    if (state.safety !== 'NORMAL') { addMeta(meta, text('safety'), state.safety); }
    if (state.alert !== 'IDLE') { addMeta(meta, text('alert'), state.alert); }
    container.appendChild(meta);

    if (state.candidates && state.candidates.length) {
      container.appendChild(node('h4', 'cpa-trace-subtitle', text('candidates')));
      var candidateList = node('div', 'cpa-trace-state-list');
      state.candidates.forEach(function (candidate) {
        var chip = node('span', 'cpa-trace-state cpa-trace-state--' + candidate[1]);
        chip.appendChild(node('b', '', localizedCandidate(candidate[0])));
        chip.appendChild(document.createTextNode(' · ' + statusLabels[language()][candidate[1]]));
        candidateList.appendChild(chip);
      });
      container.appendChild(candidateList);
    }

    if (state.requests && state.requests.length) {
      container.appendChild(node('h4', 'cpa-trace-subtitle', text('requests')));
      var requestList = node('ul', 'cpa-trace-requests');
      state.requests.forEach(function (request) {
        var kind = request.kind === 'todo' ? (language() === 'zh' ? '待办' : 'TO-DO') : (language() === 'zh' ? '通知' : 'NOTICE');
        var value = kind + ' · ' + request.content + (request.deadline ? (language() === 'zh' ? ' · 截止 ' : ' · due ') + request.deadline : '');
        requestList.appendChild(node('li', '', value));
      });
      container.appendChild(requestList);
    }
  }

  function renderTurn() {
    if (!activeCase) { return; }
    var turn = activeCase.turns[activeTurn];
    var tabs = body.querySelectorAll('.cpa-trace-turn-tab');
    Array.prototype.forEach.call(tabs, function (tab, index) {
      var selected = index === activeTurn;
      tab.classList.toggle('is-active', selected);
      tab.setAttribute('aria-selected', String(selected));
      tab.tabIndex = selected ? 0 : -1;
    });
    var panel = body.querySelector('.cpa-trace-panel');
    panel.textContent = '';

    var callerStep = step(1, text('caller'));
    callerStep.appendChild(node('blockquote', 'cpa-trace-quote', '“' + turn.caller + '”'));
    panel.appendChild(callerStep);

    var schemaStep = step(2, text('schema'));
    if (turn.schemaStatus === 'produced') {
      schemaStep.appendChild(node('span', 'cpa-trace-badge cpa-trace-badge--model', text('produced')));
      schemaStep.appendChild(node('h4', 'cpa-trace-subtitle', text('raw')));
      var pre = node('pre', 'cpa-trace-code');
      pre.appendChild(node('code', '', prettySchema(turn.raw)));
      schemaStep.appendChild(pre);
      var annotations = annotationRows(turn);
      if (annotations.length) {
        schemaStep.appendChild(node('h4', 'cpa-trace-subtitle', text('meanings')));
        var annotationList = node('div', 'cpa-trace-annotations');
        annotations.forEach(function (row) {
          var item = node('div', 'cpa-trace-annotation');
          item.appendChild(node('code', '', row[0]));
          item.appendChild(node('span', '', row[1]));
          annotationList.appendChild(item);
        });
        schemaStep.appendChild(annotationList);
      }
    } else {
      schemaStep.appendChild(node('span', 'cpa-trace-badge cpa-trace-badge--rule', text('skipped')));
      schemaStep.appendChild(node('p', 'cpa-trace-rule', turn.enginePath.indexOf('safety') === 0 ? text('noModelSafety') : text('noModelLost')));
    }
    panel.appendChild(schemaStep);

    var engineStep = step(3, text('engine'));
    engineStep.appendChild(node('p', 'cpa-trace-engine-copy', engineExplanation(turn)));
    renderState(engineStep, turn);
    panel.appendChild(engineStep);

    var replyStep = step(4, text('reply'));
    replyStep.appendChild(node('blockquote', 'cpa-trace-reply', '“' + turn.reply + '”'));
    panel.appendChild(replyStep);
  }

  function renderCase(caseData) {
    activeCase = caseData;
    activeTurn = 0;
    body.textContent = '';

    var header = node('header', 'cpa-trace-header');
    var headingWrap = node('div');
    headingWrap.appendChild(node('span', 'cpa-trace-eyebrow', text('real')));
    headingWrap.appendChild(node('h2', 'cpa-trace-title', 'Case ' + caseData.id.replace('case', '') + ' · ' + caseData.title[language()]));
    header.appendChild(headingWrap);
    body.appendChild(header);

    var layout = node('div', 'cpa-trace-layout');
    var nav = node('div', 'cpa-trace-turns');
    nav.setAttribute('role', 'tablist');
    nav.setAttribute('aria-label', language() === 'zh' ? '选择对话轮次' : 'Choose a dialogue turn');
    caseData.turns.forEach(function (turn, index) {
      var tab = node('button', 'cpa-trace-turn-tab');
      tab.type = 'button';
      tab.setAttribute('role', 'tab');
      tab.appendChild(node('span', '', text('turn').replace('{n}', turn.n)));
      tab.appendChild(node('small', '', turn.caller));
      tab.addEventListener('click', function () { activeTurn = index; renderTurn(); });
      tab.addEventListener('keydown', function (event) {
        if (event.key !== 'ArrowDown' && event.key !== 'ArrowRight' && event.key !== 'ArrowUp' && event.key !== 'ArrowLeft') { return; }
        event.preventDefault();
        var direction = event.key === 'ArrowDown' || event.key === 'ArrowRight' ? 1 : -1;
        activeTurn = (activeTurn + direction + caseData.turns.length) % caseData.turns.length;
        renderTurn();
        nav.querySelectorAll('.cpa-trace-turn-tab')[activeTurn].focus();
      });
      nav.appendChild(tab);
    });
    layout.appendChild(nav);
    var panel = node('div', 'cpa-trace-panel');
    panel.setAttribute('role', 'tabpanel');
    layout.appendChild(panel);
    body.appendChild(layout);
    body.appendChild(node('p', 'cpa-trace-provenance', text('provenance')));
    renderTurn();
  }

  function showLoading() {
    body.textContent = '';
    body.appendChild(node('p', 'cpa-trace-loading', text('loading')));
  }

  function openDialog(caseId, trigger) {
    var request = ++openRequest;
    lastTrigger = trigger;
    showLoading();
    if (typeof dialog.showModal === 'function') { dialog.showModal(); }
    else { dialog.setAttribute('open', ''); }
    closeButton.setAttribute('aria-label', text('close'));
    closeButton.focus();

    var ready = traceDocument ? Promise.resolve(traceDocument) : tracePromise;
    if (!ready) {
      tracePromise = fetch('/assets/data/callproxy-nlu-traces.json', { credentials: 'same-origin' }).then(function (response) {
          if (!response.ok) { throw new Error('HTTP ' + response.status); }
          return response.json();
        }).then(function (data) {
          traceDocument = data;
          return data;
        });
      ready = tracePromise;
    }

    ready.then(function (data) {
      if (request !== openRequest || !dialog.open) { return; }
      var selected = data.cases.filter(function (item) { return item.id === caseId; })[0];
      if (!selected) { throw new Error('Unknown trace case: ' + caseId); }
      renderCase(selected);
    }).catch(function () {
      if (request !== openRequest || !dialog.open) { return; }
      body.textContent = '';
      body.appendChild(node('p', 'cpa-trace-loading cpa-trace-loading--error', text('error')));
    });
  }

  triggers.forEach(function (trigger) {
    trigger.addEventListener('click', function () { openDialog(trigger.getAttribute('data-case'), trigger); });
  });

  closeButton.addEventListener('click', function () { dialog.close(); });
  dialog.addEventListener('click', function (event) {
    var rect = dialog.getBoundingClientRect();
    var inside = event.clientX >= rect.left && event.clientX <= rect.right && event.clientY >= rect.top && event.clientY <= rect.bottom;
    if (!inside) { dialog.close(); }
  });
  dialog.addEventListener('close', function () {
    activeCase = null;
    if (lastTrigger) { lastTrigger.focus(); }
  });
  document.addEventListener('cpa-language-change', function () {
    closeButton.setAttribute('aria-label', text('close'));
    if (dialog.open && activeCase) { renderCase(activeCase); }
  });
})();
