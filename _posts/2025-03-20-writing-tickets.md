---
layout: post
title: "Writing Clear and Actionable Work Tracking Tickets"
excerpt: "A practical guide for submitting software feature requests and bug reports that actually get resolved"
---

I do not believe any software team can foresee every user need and create a perfect product on the first try. Iterative development is the only path to software success, and a constant feedback loop is one of its most essential building blocks.

Recognizing this, most software teams use work tracking systems to capture feedback as new feature ideas arise and bugs surface. Yet without clear guidelines, these systems can quickly become cluttered with entries that are hard to understand, difficult to prioritize, or missing critical information. Miscommunication delays development—or worse, leads to the implementation of the wrong features or fixes—leaving users frustrated.

With clear and publicly shared guidelines, teams can broaden feedback participation beyond a limited group of support or test engineers, helping transform user input into software improvements more quickly and with higher quality.

The following guidelines provide practical tips for writing **feature requests** and **bug reports**, ensuring each entry is clear and actionable.

## Feature Requests

### Title

Write a clear, concise summary of the requested change in one sentence, using the **imperative mood**. Using the imperative (“Add a search filter” rather than “A search filter is needed”) frames the request as an actionable instruction, naturally encouraging the team to spring into action.

### Description

When describing the desired change, follow these principles:

1. Present the request from the perspective of a usage scenario. Use specific language and minimal jargon so all stakeholders can understand it without consulting other documentation.
1. Keep the request implementation-neutral. Specify what the system should do, not how it should do it.
1. Indicate the impact or priority of the change.
1. Include acceptance criteria if you have specific conditions in mind.
1. Note any relevant non-functional requirements (e.g., security, reliability, scalability, usability).

## Bug Reports

### Title

Write a clear, concise summary of the bug in one sentence, using the **declarative mood**. The declarative (“The search filter returns unfiltered results”) draws attention to the problematic state itself, helping the team immediately understand what is broken and why it needs fixing.

### Description

Include the following information to make the report actionable:

1. The environment in which the problem occurred (e.g., hardware configuration, software version).
1. The steps to reproduce the problem.
1. A description of the problematic behavior.
1. The expected or desired behavior.
1. The severity or priority of the issue.
1. Any supporting material, such as log files, screenshots, or links to run folders.
