---
title: Noe Nieto
subtitle: Software engineer
layout: landing-page
show_sidebar: false
menubar: false
hide_hero: true
language: en
---

# Say *saluton* to <span class="has-text-primary">{{ site.author.name }}</span>, {{ site.author.description}}

> {{ site.description }}

<div class="grid">
  <div class="cell">
    <p><i class="fa-solid fa-code is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' | plus: 6 }}</p>
    <p class="subtitle is-4">
      years have passed since I wrote my first program
      (<a href="https://en.wikipedia.org/wiki/Logo_(programming_language)" target="_blank">in Logo</a>)
    </p>
  </div>
  <div class="cell">
    <p><i class="fa-solid fa-code is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' }}</p>
    <p class="subtitle is-4">
      years have passed since I earned an associate degree in programming.
    </p>
  </div>
  <div class="cell">
    <p><i class="fa-brands fa-solid fa-linux is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' | plus: -2 }}</p>
    <p class="subtitle is-4">
      years have passed since I installed my first <a href="https://es.wikipedia.org/wiki/Mandriva" target="_blank">linux distro</a>
    </p>
  </div>
  <div class="cell">
    <p><i class="fa-brands fa-python is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' | plus: -3 }}</p>
    <p class="subtitle is-4">
      years have passed since I wrote my first <b>Python</b> program.
    </p>
  </div>
  <div class="cell">
    <p><i class="fa-solid fa-microchip is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' | plus: -5 }}</p>
    <p class="subtitle is-4">years years have passed since I finished <a href="https://es.wikipedia.org/wiki/Instituto_Tecnol%C3%B3gico_de_Puebla" target="_blank">Electronics Engineering</a>
    </p>
  </div>
  <div class="cell">
    <p><i class="fa-solid fa-solar-panel is-size-1"></i></p>
    <p class="title is-1 has-text-primary	">{{ site.time | date: '%y' | plus: -18 }}</p>
    <p class="subtitle is-4">years years have passed since I finished my <a href="http://institutodeingenieria.uabc.mx/" target="_blank">Master's degree in Engineering</a>
    </p>
  </div>
</div>

{% include latest-posts.html %}
