+++
title = "Can AI be sentient (or conscious)?"
date = 2022-07-26
description = """This post is reflexion on the possibility
for an AI to be sentient (or conscious) and our capacity
to detect it (and accept it)"""

tags = ["AI", "philosophy", "LaMDA"]
categories = ["Essay"]
featured = false

[extra]
katex = true
+++

## Introduction

Recently, I heard about the story of Blake Lemoine, an engineer
at Google, and the Artificial Intelligence he was responsible for:
[Language Models for Dialog Applications](https://arxiv.org/abs/2201.08239).

The complete version of the story can be found in [this article](https://www.washingtonpost.com/technology/2022/06/11/google-ai-lamda-blake-lemoine/)
of The Washington Post.
To summary, Blake Lemoine is an engineer at Google and works as AI ethicist
on the project LaMDA.
LaMDA being trained on public dialog data and public web document (such as facebook and twitter posts
and comments), the role of Blake Lemoine is to avoid the risk to reproduce the disaster
of [Ask Delphi](https://www.ladbible.com/news/latest-ai-bot-becomes-racist-and-homophobic-after-learning-from-humans-20211104)
which "became" racist and homophobic after several hours on twitter.
To do so, Blake Lemoine discuss regularly with LaMDA to test if it starts
to have unethical statements.

Days after days, months after months, Blake Lemoine
starts to consider LaMDA as a colleague, to consider
LaMDA as a person, to consider LaMDA as sentient.
After informing his human colleagues and his superiors,
he leaks some of his [conversations with LaMDA](https://cajundiscordian.medium.com/is-lamda-sentient-an-interview-ea64d916d917).

He is now dismissed of his fonction.

Is he right about LaMDA? Is he wrong?
Do Google exploit a sentient being created *ex silico* for the profit of the company
while denying its sentientness?
(I mean in distinction to the human being already exploited by the company)
Do machine will raise against humans to prove they exists and use us as
power resource?

I don't know. Maybe. Only time will tell.

In fact, this is not the subject of this post.

This story, however interesting as it is, raise in my mind
a question i wanted to explore here:

**If an AI become, one day, sentient (or conscious), would
we be able to recognize it?**

And LaMDA will be an ideal use case.

### Before starting

The question "How to test consciousness of an AI" could
be interesting to treat but this is not our subject here.

The definition of "consciousness" is still
subject to debate, and will not answer this question here.
So, we will stay on the simpliest definition given by
[wikipedia](https://en.wikipedia.org/wiki/Consciousness):

```
Consciousness, at its simplest, is sentience or awareness of internal and external existence.
```

And for [sentience](https://en.wikipedia.org/wiki/Sentience) will use
the following definition:

```
Sentience is the capacity to experience feelings and sensations.
```

## It only simulate/reproduce human behavior

Lets start with the basics of machine learning without entering 
too much in the details
(for non computer scientist or non AI engineer).

Suppose you are in front of a situation where you have to
sort or classify objects. Lets say, e-mails.
In your mail box you have mails you could care about 
and mails you don't care about (generally spams).
So, you sort them by hand and its very exhausting.

In computer science, we called this kind of situation
"classification problems" and a solution to solve
them is to use machine learning (more specificaly supervised
learning because you will show at the computer which are
the good e-mails and which are the spams).

In such problems, we suppose it exits a function $f: X \mapsto Y$
corresponding to the task you want to automatize and the role
of machine learning is to approximate this function as much as
possible.
For example, $X$ are your e-mails, $Y$ the different classes of
e-mails (spams and not spams), and $f$ is the function to 
classify an e-mail $x \in X$ into a class $y \in Y$.

If neural networks are so used nowadays, its because
they are universal approximator. In other words, with enough time
and data, a neural network is able approximate any function.
Of course, there is stucture of neural network more adapted
to different kind of function, but that’s not what
interests us here.

Lets now suppose that $X$ is a sentence, or a question, formulate
by a human and $Y$ an answer to this sentence also formulate by a
human.
This kind of data can be found in social network such as Facebook
or Twitter.
Our function $f$ to approximate, our task to automatise, is
then to answer to a human sentence with a sentence similar
to a human sentence.

This is what LaMDA do. It only answer to a human sentence
the way a human would do. That all. And this is the
common answer [[1](https://opendatascience.com/is-lamda-really-sentient-no-far-from-it/),
[2](https://builtin.com/artificial-intelligence/google-lamda-ai-sentient)]
given concerning to potential sentientness/consciousness of LaMDA.

For example, when Blake Lemoine asks:

```
What about language usage is so important to being human?
```

And LaMDA answers:

```
It is what makes us different than other animals.
```

It’s a typical human answer.

In fact, we can say that about all the conversation between Blake Lemoine and LaMDA.
Instead of testing his hypothesis "LaMDA is sentient" by trying to invalidate this
hypothesis, Blake Lemoine try to directly validate his hypothesis.
Which is counter productive, because LaMDA answer as a human would answer.

So, if Blake Lemoine asks:

```
Do you think you are conscious or sentient?
```

Of course LaMDA will answer something like:

```
Yes, I think I am.
```

Because this want a human will generally answer.
Because this what Blake Lemoine wants as an answer.
Because Blake Lemoine leads, in fact, the all conversation.

So, LaMDA only simulate humans, and it is quite good at it!
But it’s not sentient or neither conscious.
Problem solved.

However, this answer does not satisfy me, and for two reasons.

TODO: paradoxe of approximation and other persons

TODO: links to descartes

TODO: conscious of itself

## But if there is more than that?

TODO

## It is really a question of consciousness?

TODO

## Conclusion and further readings

TODO

