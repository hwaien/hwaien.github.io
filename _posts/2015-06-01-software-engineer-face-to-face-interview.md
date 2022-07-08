---
layout:     post
title:      Software Engineer Face-to-Face Interview
summary:    One of the most decisive factors in the success/failure of a team, is the process of selecting suitable team members.
---

One of the most decisive factors in the success/failure of a team, is the process of selecting suitable team members.

When I interview a candidate face-to-face for a software engineer position, I focus on evaluating these things:

 1. [Consistent Mental Model](#consistent)
 2. [Passion](#passion)
 3. [Fluency with Programming Basics](#fluency)
 4. [Honesty](#honesty)
 5. [Communication](#communication)
 6. [Leadership](#leadership)

These are my personal preferences. They may not work for you.

![Interview]({{ site.url }}/assets/interview.jpg)

## <a name="consistent" />Consistent Mental Model

Mark Guzdial [mentioned in his book _Making Software_](http://files.software-carpentry.org/training-course/2012/08/guzdial.pdf) that

> Linguists generally agree that humans are 'wired' for language. Our brains have evolved to pick up language quickly and efficiently. We are wired specifically for natural language. Programming is the manipulation of an artificial language invented for a particular, relatively unnatural purpose—telling a nonhuman agent (a computer) exactly what to do. Maybe programming is not a natural activity for us, and only a few humans are able to do the complex mental gymnastics to succeed at this unnatural act.

Anecdotally, I notice that some software engineers have great difficulty performing such unnatural mental gymnastics. I have worked with software architects with 20+ years of experience, with no problem producing complex diagrams during design meetings, but would have great trouble producing working code. The software they create would consist of [baklava](http://en.wikipedia.org/wiki/Baklava) patterns (piling layers on top of layers to get code to work), mega monolithic methods (or [Megamoth](http://en.wikipedia.org/wiki/Mothra) for short), [Jenga](http://en.wikipedia.org/wiki/Jenga) code (altering a single block would cause the whole thing to collapse), and [Hydra](http://en.wikipedia.org/wiki/Lernaean_Hydra) bugs (fixing one introduces two new bugs).

In my own experience, I have yet to find an effective method to teach the right skills to people with difficulty grasping consistent programming mental models. Once they are hired onto the team, they lower product quality, drain others' time to fix their bugs, and destroy morale as team frustration builds. Therefore I consider it top priority to identify and reject this type of candidates during interviews.

The best way to screen is to have candidates write programs on a real computer. An alternative is to have candidates write programs on a whiteboard. Look for warning signs such as incoherent logic, inconsistent language syntax, overloaded meanings of variables, difficulty with [off-by-one errors](https://en.wikipedia.org/wiki/Off-by-one_error), etc.

If candidates have trouble forming consistent programming mental models, it's a no-hire. It does not matter how well they do in other areas.

## <a name="passion" />Passion

Also important to me is passion. Skilled programmers can produce poor software if their passion and motivation are not aligned with the team's mission and vision. Though product quality suffers from lack of passion as much as it does from inconsistent mental model, lack of passion is not as severe a problem because it can be mitigated by incentivisation (whereas inconsistent mental model can only be fixed by employment termination). Nevertheless, it is preferable to prevent than to mitigate.

Also, a candidate who is passionate about the job accelerates much faster than an apathetic candidate. Even if the latter can contribute slightly more business value today, the former will cumulatively contribute far more in the long run. If the goal is to build a long-lasting high-functioning team, it is especially important to look for passion.

Passion can be evaluated all through the interview process: while asking about previous projects, during technical problem solving, etc. First put candidates in a comfortable zone. Then encourage them to elaborate on answers as much as possible. (Those who pretend to be passionate usually become a broken record when asked repeatedly to elaborate, while the truly passionate talk excitedly and forget they are in an interview.) I strive to avoid being a blowhard interviewer blabbing about my own opinions and not leaving candidates time to express theirs.

## <a name="fluency" />Fluency with Programming Basics

At the end of the day, software teams are a business, not a vocational school. Even if a candidate is most passionate about the job, they still need to be able to contribute meaningfully. This is where fluency with programming basics comes in.

This can be evaluated by asking candidates to work through easy programming questions. For example: write a function to sum up a list of numbers, write a function that determines whether a number is even or odd, etc. The goal is not to see whether or not candidates solve the problem, but to see _how fast_ they do it, in other words, to see how fluent they are with programming basics.

The reason why this is helpful is [explained by Joel Spolsky](http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html) with this story:

> Serge Lang, a math professor at Yale, used to give his Calculus students a fairly simple algebra problem on the first day of classes, one which almost everyone could solve, but some of them solved it as quickly as they could write while others took a while, and Professor Lang claimed that all of the students who solved the problem as quickly as they could write would get an A in the Calculus course, and all the others wouldn't. The speed with which they solved a simple algebra problem was as good a predictor of the final grade in Calculus as a whole semester of homework, tests, midterms, and a final.

The speed with which candidates solve basic problems is a good predictor of their success with complex real world problems. If they cannot whiz through the easy stuff at 100 m.p.h., it's most likely a no-hire. (Some benefit of the doubt can be given if the candidate is fresh out of school.)

## <a name="honesty" />Honesty

Honesty may not be important to every interviewer. I personally believe that honesty begets trust, and trust significantly increases a team's capacity for success. My productivity generally grinds to a crawl if I have to verify the words and second-guess the motives of my teammates everyday. And dishonesty, like inconsistent mental model, is something I have not found an effective method to deal with. Therefore I feel it is important to screen for it during interview.

If I catch a candidate lying (for example, if they offer contradicting stories to explain inconsistencies in their resume), it is a no-hire. In addition, candidates may hide, manipulate, and/or embellish information. Also, they may pretend to agree with me even though they know what I said was wrong. These are warning signs. If I observe too many warning signs, it's a no-hire.

As an exception, I am open to the possibility of hiring a dishonest technical genius. If the candidate has a track record of groundbreaking innovations, I am willing to incur the cost of trust erosion. In experience, I have yet to meet a candidate with technical skills strong enough to justify such a trade-off.

## <a name="communication" />Communication

Consider this scenario: A user requests a photo album organization software. After 6 months, the programmer with low technical skills and high communication skills delivers a low-quality album organizer with many bugs; the programmer with high technical skills and low communication skills delivers a high-quality bug-free photo editing software. The latter, despite its technical superiority, has less business value than the former.

This is an extreme example, and in practice, I do value technical skills more than communication skills. Nonetheless, the example shows the necessity to evaluate communication skills during interview. If a candidate cannot communicate, it's a no-hire. Communication can be evaluated from two perspectives:

### Listening

Do I find myself repeatedly repeating myself to the candidate? (Hopefully this has already been screened during phone interviews.)

Does the candidate ask critical questions when listening? One possible way to evaluate this is to ask (technical or situational) questions vaguely or contradictorily.

### Expressing

Does the candidate express answers, concepts, and thoughts in ways that are easy to follow? This includes verbal communication and whiteboard (writing and drawing) communication.

Can the candidate explain technical concepts in ways that can be easily understood by someone with no technical background?

## <a name="leadership"/>Leadership

Tony Dungy once said:

> The secret to success is good leadership, and good leadership is all about making the lives of your team members or workers better.

Though lack of leadership is not a deal-breaker for me, I do focus on observing leadership qualities in candidates, so that I can use them as a tiebreaker in case two candidates score equally well in technical strength, passion, honesty, and communication. Candidates with better leadership qualities will catalyze growth in teammates and bring greater success to the team.

From interactions during the interview, and from the candidates' track record, I look for indicators of

 * Willingness to assume full responsibility
 * The habit of doing more than paid for
 * Definiteness of plans and decisions
 * Cooperation; ability to resolve conflict
 * Mastery of detail
 * A keen sense of fairness
