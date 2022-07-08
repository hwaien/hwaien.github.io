---
layout: post
title: Technology Selection
---

Think twice before adopting new technologies. Always keep your larger business goals in mind.

---

If you work with passionate software professionals who care about their craft, it is inevitable to come across discussions about emerging technologies:

"Microsoft just announced a killer technology called _Silverlight_. Let's rewrite our legacy Flash code to stay ahead of competition!" "Our homegrown AJAX framework is difficult to scale. We should reimplement using this new framework called _Backbone.js_!" "Have you heard of _AngularJS_? It is so much better. We need to migrate our current jQuery source code as soon as possible!" "Facebook's new _React_ library is a game changer. If we redesign our application using isomorphic React, we can double our productivity!"

I do believe in learning new technologies. On low-stake projects or personal projects, I always make it a point to try out technologies I've never used before.

I also believe in waiting for a few releases of a new technology before adopting it on business-critical projects.

Adopting technologies early requires **higher upfront development costs**. Early adopters must spend effort not only on building their own product, but also on testing the technology they are adopting. And if issues are not addressed by the creator of the technology, early adopters must spend further effort on building workaround solutions.

Early adoption also leads to **higher maintenance costs**. A technology typically has the greatest changes/improvements in the second generation release, after its creator learns from early adopters' feedback. To upgrade to more mature versions of the technology, early adopters must spend effort on refactoring and resolving compatibility issues.

## Craigslist

Craigslist is a classic example of selecting and staying with mature technologies.

Through the years, server-side technologies have seen innovations in PHP, Python, ASP.NET, Go, Node, etc., while on the client side, JavaScript has been revolutionized by Ajax, jQuery, Backbone.js, Ember.js, AngularJS, React, etc. Meanwhile, Craigslist continues to be a [Perl site](http://www.craigslist.org/about/thanks) and continues to keep JavaScript to a minimum. As its founder [stated in a 2008 interview](http://broadcast.oreilly.com/2008/12/craig-newmark-interview-a-brie.html):

<blockquote>
  <p>[We are under] very little pressure in innovation in the conventional sense. … What people want is something simple, fast, effective. People don't care about the fancy stuff.</p>
  <footer><cite title="Craig Newmark">Craig Newmark</cite></footer>
</blockquote>

This minimalistic view on technology selection helps Craigslist stay as one of the most popular sites on the Internet for over a decade. In Auguest 2015, Craigslist's Alexa rank is 57.

## Etsy

The benefit of [choosing "boring" technologies](http://mcfunley.com/choose-boring-technology) like Craigslist is explained by Etsy's Dan McKinley:

<blockquote>
  <p>Mindful choice of technology gives engineering minds real freedom: the freedom to <strong>contemplate bigger questions</strong>. Technology for its own sake is snake oil.</p>
  <footer><cite title="Dan McKinley">Dan McKinley</cite></footer>
</blockquote>

To McKinley, this mindful choice is not only about

- **Selecting mature technologies** with well-understood capabilities and failure modes, but also about
- **[Selecting few technologies](http://www.techrepublic.com/article/developers-are-calling-it-quits-on-polyglot-programming/)** to focus engineers on technological mastery.

McKinley inherited this [conservative philosophy on technology](http://techcrunch.com/2015/04/27/etsy-cto-on-its-conservatively-crafty-tech-philosophy/) from Kellan Elliott-McCrea, who believes that it is more valuable to [optimize globally, not locally](http://laughingmeme.org/2015/08/31/five-years-building-a-culture-and-handing-it-off/):

<blockquote>
  <p>If it slows down shipping, it probably isn’t worth it. Maturity is knowing when to make the trade off and when not to.</p>
  <footer><cite title="Kellan Elliott-McCrea">Kellan Elliott-McCrea</cite></footer>
</blockquote>

Etsy has profited from this philosophy. Its 2014 total merchandise sales were $1.93B. In 2015, it [enjoyed a highly successful IPO](http://techcrunch.com/2015/04/16/etsy-stock-surges-86-percent-at-close-of-first-day-of-trading-to-30-per-share/).

Next time you are tempted to adopt an emerging technology, think twice. Always keep your larger business goals in mind.

![Technology Selection]({{ site.url }}/assets/technologies.jpg)
