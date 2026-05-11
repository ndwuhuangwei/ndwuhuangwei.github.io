---
permalink: /
excerpt: "About me"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

<section class="hero" markdown="0">
  <h1 class="hero__name">Huangwei Wu</h1>
  <p class="hero__role">Ph.D. Student &middot; Shanghai Jiao Tong University</p>
  <p class="hero__affiliation">AIoT Group &middot; advised by Prof. Meng Jin</p>
  <p class="hero__identity">I design acoustic and wireless systems for resource-constrained intelligent devices, with a focus on spatial communication, on-device AI, and embedded system orchestration.</p>
  <p class="hero__links">
    <a class="pill" href="mailto:wuhuangwei@sjtu.edu.cn"><i class="fas fa-fw fa-envelope" aria-hidden="true"></i> Email</a>
    <a class="pill" href="https://github.com/ndwuhuangwei" target="_blank" rel="noopener"><i class="fab fa-fw fa-github" aria-hidden="true"></i> GitHub</a>
    {% if site.author.googlescholar %}<a class="pill" href="{{ site.author.googlescholar }}" target="_blank" rel="noopener"><i class="fas fa-fw fa-graduation-cap" aria-hidden="true"></i> Google Scholar</a>{% endif %}
  </p>
</section>

## Research Interests

<div class="research-grid" markdown="0">
  <div class="research-card">
    <div class="research-card__icon"><i class="fas fa-wave-square" aria-hidden="true"></i></div>
    <h3>Acoustic &amp; Spatial Communication</h3>
    <p>Spatially selective communication, robot interaction, and acoustic sensing for resource-constrained devices.</p>
  </div>
  <div class="research-card">
    <div class="research-card__icon"><i class="fas fa-broadcast-tower" aria-hidden="true"></i></div>
    <h3>Low-power Wireless &amp; IoT</h3>
    <p>Robust communication and practical system design under tight energy and compute budgets.</p>
  </div>
  <div class="research-card">
    <div class="research-card__icon"><i class="fas fa-microchip" aria-hidden="true"></i></div>
    <h3>On-device AI</h3>
    <p>Neural models for sensing and communication under latency, memory, and energy constraints.</p>
  </div>
</div>

## Education

<div class="edu-card" markdown="0">
  <div class="edu-card__head">
    <strong>Shanghai Jiao Tong University</strong>
    <span class="edu-card__date">Sept 2022 &ndash; present</span>
  </div>
  <div class="edu-card__sub">Ph.D. Student in Information and Signal Processing</div>
  <div class="edu-card__meta">School of Electronic Information and Electrical Engineering &middot; AIoT Group, advised by Prof. Meng Jin</div>
</div>

<div class="edu-card" markdown="0">
  <div class="edu-card__head">
    <strong>Sichuan University</strong>
    <span class="edu-card__date">Sept 2018 &ndash; June 2022</span>
  </div>
  <div class="edu-card__sub">B.S. in Electronics and Information Engineering</div>
  <div class="edu-card__meta">College of Electronics and Information Engineering</div>
</div>

## Selected Publications

<p class="pub-legend"><sup>*</sup> equal contribution &middot; <sup>&dagger;</sup> corresponding author</p>

<div class="pub-card" markdown="0">
  <div class="pub-card__thumb pub-card__thumb--robot"><i class="fas fa-robot" aria-hidden="true"></i></div>
  <div class="pub-card__body">
    <div class="pub-card__badges">
      <span class="badge badge--venue">IEEE TMC 2026</span>
      <span class="badge badge--rank">CCF-A</span>
    </div>
    <h3 class="pub-card__title"><a href="https://doi.org/10.1109/TMC.2026.3665613" target="_blank" rel="noopener">Enabling &ldquo;See-and-Point&rdquo; Communication between Robots</a></h3>
    <p class="pub-card__authors"><strong>Huangwei Wu</strong><sup>*</sup>, Weiguo Wang<sup>&dagger;</sup>, Meng Jin<sup>&dagger;</sup>, Zhuxuan He, Qi Cao, Xinbing Wang, Chenghu Zhou</p>
    <div class="pub-card__tags">
      <span class="tag">Robotics</span>
      <span class="tag">Acoustic Communication</span>
      <span class="tag">Spatial Interaction</span>
    </div>
    <p class="pub-card__summary">We enable robots to establish directional communication through pointing and spatial acoustic cues, supporting intuitive interaction in multi-robot settings.</p>
    <div class="pub-card__links">
      <a href="https://doi.org/10.1109/TMC.2026.3665613" target="_blank" rel="noopener">Paper</a>
    </div>
  </div>
</div>

<div class="pub-card" markdown="0">
  <div class="pub-card__thumb pub-card__thumb--wireless"><i class="fas fa-broadcast-tower" aria-hidden="true"></i></div>
  <div class="pub-card__body">
    <div class="pub-card__badges">
      <span class="badge badge--venue">IEEE/ACM ToN 2026</span>
      <span class="badge badge--rank">CCF-A</span>
    </div>
    <h3 class="pub-card__title"><a href="https://doi.org/10.1109/TON.2025.3650658" target="_blank" rel="noopener">Neural-Enhanced Modulation for Spatial Selective Transmission on Low-End IoT Devices</a></h3>
    <p class="pub-card__authors"><strong>Huangwei Wu</strong><sup>*</sup>, Tingchao Fan<sup>*</sup>, Meng Jin<sup>&dagger;</sup>, Tao Chen, Xinbing Wang, Chenghu Zhou</p>
    <div class="pub-card__tags">
      <span class="tag">Wireless Systems</span>
      <span class="tag">IoT</span>
      <span class="tag">On-device AI</span>
    </div>
    <p class="pub-card__summary">We combine neural modulation with resource-aware wireless design to improve spatially selective transmission on low-end IoT hardware.</p>
    <div class="pub-card__links">
      <a href="https://doi.org/10.1109/TON.2025.3650658" target="_blank" rel="noopener">Paper</a>
    </div>
  </div>
</div>

<div class="pub-card" markdown="0">
  <div class="pub-card__thumb pub-card__thumb--acoustic"><i class="fas fa-volume-up" aria-hidden="true"></i></div>
  <div class="pub-card__body">
    <div class="pub-card__badges">
      <span class="badge badge--venue">ACM MobiCom 2023</span>
      <span class="badge badge--rank">CCF-A</span>
    </div>
    <h3 class="pub-card__title"><a href="https://doi.org/10.1145/3570361.3592496" target="_blank" rel="noopener">Towards Spatial Selection Transmission for Low-end IoT Devices with SpotSound</a></h3>
    <p class="pub-card__authors">Tingchao Fan<sup>*</sup>, <strong>Huangwei Wu</strong><sup>*</sup>, Meng Jin<sup>&dagger;</sup>, Tao Chen, Longfei Shangguan, Xinbing Wang, Chenghu Zhou</p>
    <div class="pub-card__tags">
      <span class="tag">Acoustic Systems</span>
      <span class="tag">Embedded Devices</span>
      <span class="tag">Spatial Transmission</span>
    </div>
    <p class="pub-card__summary">SpotSound explores spatially selective acoustic/wireless transmission for constrained IoT devices, emphasizing practical deployment and system trade-offs.</p>
    <div class="pub-card__links">
      <a href="https://doi.org/10.1145/3570361.3592496" target="_blank" rel="noopener">Paper</a>
    </div>
  </div>
</div>

<aside class="quote-callout" markdown="0">
  <em>The art of systems research is crafting graceful trade-offs among competing objectives.</em>
</aside>
