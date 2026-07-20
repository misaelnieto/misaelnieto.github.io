---
title: "Engineering résumé"
description: "Senior software engineer, 25 years across the stack — long enough to have learnt the value of boring, stable software doing its job correctly for 15 years or more. In the agentic-AI era, my value is engineering rigor: validating and shaping software that serves users without harming them. I consult and teach on the side. 100% remote."
template: resume.html
extra:
  resume:
    branches:
      - id: main
        label: "Day job"
        started: "2006-02"
      - id: consulting
        label: "NNieto Consulting"
        started: "2001-01"
      - id: holokinesis
        label: "Holokinesis"
        started: "2010-01"
      - id: teaching
        label: "Teaching"
        started: "2025-01"
    timeline:
      - date: "2026-01"
        branch: teaching
        ongoing: true
        hash: "3c4d5e6"
        role: "Profesor interino — Lenguajes y Autómatas I"
        org: "Instituto Tecnológico de Mexicali"
        impact: "Currently teaching formal languages and automata theory."

      - date: "2025-08"
        end: "2025-12"
        branch: teaching
        hash: "2b3c4d5"
        role: "Profesor interino — Fundamentos de Ingeniería de Software & Arquitectura de Computadoras"
        org: "Instituto Tecnológico de Mexicali"
        impact: "Two courses in the August–December term: software engineering fundamentals and computer architecture."

      - date: "2025-01"
        end: "2025-06"
        branch: teaching
        hash: "1a2b3c4"
        role: "Profesor interino — Arquitectura Orientada a Servicios"
        org: "Instituto Tecnológico de Mexicali"
        impact: "Service-oriented architecture course for undergraduate systems-engineering students."

      - date: "2021-08"
        branch: main
        ongoing: true
        hash: "f2a3b4c"
        role: "Senior Software Developer in Test"
        org: "Dextra Technologies (a Deloitte business)"
        url: "https://www.linkedin.com/company/dextra-technologies"
        impact: "Currently owning SDET work and test automation for Deloitte-grade delivery."
        stack: ["Python", "Linux", "Jenkins", "Android", "Kotlin"]

      - date: "2020-07"
        end: "2020-08"
        branch: main
        hash: "e1f2a3b"
        role: "Backend engineer"
        org: "Kimetrics"
        impact: "Two-month BI-for-retail engagement: data pipelines across AWS Redshift, S3, ECS, with Knime and Docker."
        stack: ["Python", "AWS Redshift", "Docker", "Knime"]

      - date: "2018-10"
        end: "2020-02"
        branch: main
        hash: "d0e1f2a"
        role: "Web Developer (Librem One)"
        org: "Purism SPC"
        impact: "Integrated WordPress + WooCommerce with a Django middleware. Bits of LDAP, Jekyll, Zola, and GitLab CI along the way."
        stack: ["PHP", "WordPress", "Django", "Bash", "Vagrant"]

      - date: "2015-11"
        end: "2017-08"
        branch: main
        hash: "c9d0e1f"
        role: "SRAX Web Developer"
        org: "Social Reality / SRAX"
        impact: "Modernized a legacy LAMP ad-exchange: replaced manual onboarding with tested PHP, integrated new ad exchanges, and wrote the deploy tooling the C++ team actually wanted to use."
        stack: ["PHP", "CodeIgniter", "C++", "LAMP", "PHPUnit", "New Relic"]

      - date: "2013-10"
        end: "2015-11"
        branch: main
        hash: "b8c9d0e"
        role: "Developer & Sysadmin"
        org: "Valutech Outsourcing (now Clover Wireless)"
        impact: "First data-center gig: SQL Server HA, IIS, Linux hosts, Active Directory, terabyte-scale backups. Built a few internal tools in ASP.NET MVC and Python on the side."
        stack: ["SQL Server", "IIS", "Linux", "Active Directory", "AWS S3"]

      - date: "2013-01"
        branch: holokinesis
        ongoing: true
        hash: "a7b8c9d"
        role: "Active collaborator"
        org: "Academia Internacional de Psicología Holokinética"
        impact: "Started active collaboration with the Academia, alongside the publishing work."

      - date: "2011-08"
        end: "2014-03"
        branch: consulting
        hash: "f6a1b2c"
        role: "Full-stack developer (side gig)"
        org: "HomeViva"
        impact: "Helped build a LatAm construction-tech startup: migrated the stack from LAMP + jQuery to Pyramid + Angular 1.x, and ran the AWS Linux fleet on the side."
        stack: ["Python", "Pyramid", "Angular.js", "AWS"]

      - date: "2010-01"
        branch: holokinesis
        ongoing: true
        hash: "e5f6a1b"
        role: "Editorial lead"
        org: "Holokinesis Libros"
        impact: "Took on responsibility for the Holokinesis book publishing line. Still going."

      - date: "2009-01"
        end: "2011-04"
        branch: main
        hash: "d4e5f6a"
        role: "Web/Python Developer & Linux Sysadmin"
        org: "iServices de México"
        impact: "Ran their Plone-based LCMS and the Linux underneath it — scaling, integration, break-fix."
        stack: ["Plone", "Python", "ZODB", "PostgreSQL", "RelStorage"]

      - date: "2006-05"
        end: "2008-12"
        branch: main
        hash: "c3d4e5f"
        role: "Data Acquisition Engineer"
        org: "Honeywell Aerospace — MRTC"
        impact: "Owned DA hardware commissioning and became the in-house specialist for pressure, temperature, vibration, and video-over-IP. Earned the Six Sigma Green Belt along the way."
        stack: ["Linux", "Python", "PHP", "GStreamer"]

      - date: "2006-02"
        end: "2006-03"
        branch: main
        hash: "b2c3d4e"
        role: "Multiplayer programmer (contract)"
        org: "Gameloft"
        impact: "Brief but fun: shipped multiplayer server patches and device-specific adaptations for J2ME mobile titles."
        stack: ["C++", "Apache"]

      - date: "2001-01"
        branch: consulting
        ongoing: true
        hash: "a1b2c3d"
        role: "Founder, freelance developer"
        org: "NNieto Consulting Services"
        url: "https://www.noenieto.com"
        impact: "Started as a university side gig and somehow outlived every full-time job since — PHP, Plone, Django, WordPress, the occasional PIC microcontroller."
        stack: ["PHP", "Python", "Plone", "Django", "WordPress", "Linux", "AWS"]

    education:
      - date: "2018-05"
        end: "2018-08"
        title: "Google Summer of Code — DEVSIM"
        org: "Google Summer of Code"
        url: "https://summerofcode.withgoogle.com/archive/2018/projects/6310236080046080/"
        note: "Extended DEVSIM TCAD to simulate solar cells. Built on the M.Eng thesis; funded by Google."

      - date: "2016"
        end: "2018"
        title: "M.Eng. — Solar cell simulation"
        org: "UABC, Instituto de Ingeniería"
        url: "https://hdl.handle.net/20.500.12930/2337"
        note: "Thesis: design effects on crystalline-Si solar cells via Silvaco TCAD. Led directly into GSoC 2018."

      - date: "2015-05"
        title: "Certified SCRUM Master"
        org: "International SCRUM Institute"
        note: "Authorized Certification ID 79778815187513 (lifetime)."

      - date: "2000"
        end: "2005"
        title: "B.Sc. Electronics Engineering"
        org: "Instituto Tecnológico de Puebla"
        note: "Thesis: a TCP/IP video surveillance system built entirely on F/OSS — Linux, Python, Supervisord, GStreamer."

      - date: "1997"
        end: "2000"
        title: "Computer Programmer Technician (Associate)"
        org: "UPAEP Puebla"
        note: "Basic algorithms in C, Basic, and Pascal."
---

## Now

Senior Software Developer at **Deloitte**, since August 2021. Running **NNieto Consulting** on the side — going strong since 2001. Teaching at the **Instituto Tecnológico de Mexicali** since January 2025. Actively helping **Holokinesis Libros** and **Academia Internacional de Psicología Holokinética** promote the study of [Unitary Perception](https://percepcionunitaria.org/en) around the world.

## My tool belt

I love technology, but I have preferences (who doesn't?). Lately, I've been amazed how many problems can be solved with **[Linux](https://www.kernel.org/) + [Python](https://www.python.org/) + [SQLite](https://www.sqlite.org/)** — the small, sharp stack that handles most things without ceremony. But I'm hopelessly curious, so the toolkit keeps growing.

- **Programming languages**: [Python](https://www.python.org/), [Rust](https://www.rust-lang.org/), [TypeScript](https://www.typescriptlang.org/), [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)/[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)/[HTML](https://developer.mozilla.org/en-US/docs/Web/HTML), [Kotlin](https://kotlinlang.org/), [Dart](https://dart.dev/), [PHP](https://www.php.net/), [C](https://en.cppreference.com/w/c), [.NET](https://dotnet.microsoft.com/), [SQL](https://en.wikipedia.org/wiki/SQL).
- **Backends**: [Django](https://www.djangoproject.com/), [FastAPI](https://fastapi.tiangolo.com/), [Node.js](https://nodejs.org/)/[Bun](https://bun.sh/), [Spring Boot](https://spring.io/projects/spring-boot), [Rocket](https://rocket.rs/) (Rust).
- **Frontends**: [Next.js](https://nextjs.org/) (and the usual HTML/CSS/JS), [KnockoutJS](https://knockoutjs.com/), [HTMX](https://htmx.org/), [AlpineJS](https://alpinejs.dev/), [BootstrapCSS](https://getbootstrap.com/), [TailwindCSS](https://tailwindcss.com/), [BulmaCSS](https://bulma.io/).
- **Mobile**: [Android](https://www.android.com/), [Java](https://www.java.com/), [Kotlin](https://kotlinlang.org/), [Dart](https://dart.dev/), [Flutter](https://flutter.dev/).
- **Databases**: [PostgreSQL](https://www.postgresql.org/), [MySQL](https://www.mysql.com/), [MongoDB](https://www.mongodb.com/), [Firebase](https://firebase.google.com/), [SQL Server](https://www.microsoft.com/en-us/sql-server).
- **Infrastructure**: [Linux](https://www.kernel.org/), [AWS](https://aws.amazon.com/), [Docker](https://www.docker.com/), CI/CD, [Jenkins](https://www.jenkins.io/), [Apache](https://httpd.apache.org/), [Nginx](https://nginx.org/), [Kong](https://konghq.com/), [Varnish](https://varnish-cache.org/), [Squid](http://www.squid-cache.org/), [HAProxy](https://www.haproxy.org/), [Supervisor](http://supervisord.org/), [RabbitMQ](https://www.rabbitmq.com/), [Redis](https://redis.io/), [Celery](https://docs.celeryq.dev/).
- **Test automation**: [pytest](https://docs.pytest.org/), [Cucumber](https://cucumber.io/), [Testcontainers](https://testcontainers.com/), BDD, [Selenium](https://www.selenium.dev/), [JUnit](https://junit.org/junit5/), [PHPUnit](https://phpunit.de/), [Playwright](https://playwright.dev/), [chrome-devtools](https://developer.chrome.com/docs/devtools/), [firefox-devtools](https://firefox-source-docs.mozilla.org/devtools-user/), [AndroidViewClient](https://github.com/dtmilano/AndroidViewClient), [Postman](https://www.postman.com/), [JMeter](https://jmeter.apache.org/).
- **Methodologies**: [Agile](https://agilemanifesto.org/)/[SCRUM](https://scrumguides.org/), [ISTQB](https://www.istqb.org/) (WIP).

## Work style

- **100% remote, permanently.** Sorry, I'm not relocating. Baja California is my operations base.
- **Day job first.** Deloitte gets my full-time attention. Consulting, teaching, and Holokinesis happen in my own time.
- **Async-friendly.** For me, working async means I deeply value everybody's time and space. I love sitting down in my office to write things down and document decisions — and I'm the first to admit that *a quick call can save hours* of typing and guessing. Long calls are super useful for discussing plans, explaining complex topics, and reaching consensus. Back-to-back meetings are 98% wasteful. On-site visits can be incredibly productive when well-coordinated, terribly wasteful when they're not.
- **Engineering culture required.** Being a grown-up doesn't automatically come with age. Code reviews, tests, and CI/CD are excellent tools, but their complexity can distract from the business objective. As engineers, we love to think our decisions are unbiased — they aren't, though that isn't intrinsically good or bad. Across my career I've watched a lot of projects fail, and the root causes are rarely scientific, engineering, or economic; they're biased decisions by people who wouldn't accept they had a bad idea. My ideal environment: one where professionals are free to suggest improvements and changes, supportive enough to identify bad ideas quickly, and full of people who can admit when they're wrong and want to learn.
- **User-value first.** Software exists to serve the people who use it — and to minimize harm to them. That's a P0 I won't trade away. I won't work on projects that build or enable weapons, sell illegal drugs (such as alcohol), promote unethical services, or do harm to society, families, animals, or the environment.

If you're still here, thank you — it means you're still interested.

The timeline below tracks four parallel tracks of my career. Each "commit" is a role or milestone, tagged with the branch it belongs to.
