There's plenty of room at the top: a Quick and Dirty Language Shoot-Out for Matrix Operations
===

Inspired by [this](https://science.sciencemag.org/content/368/6495/eaam9744) paper (I'm being respectable, but yar-har versions are available), where a team managed to get a python interpreter to take 9 hours to multiply two matrices. And their point is a fair one - default python is slooooooooooooooooooow. And when you can vectorise, you should.

Thing is - most programming classes for scientists get one, and possibly only one, thing through.

-Just use numpy. The optimisation you want is already done, better than you can do it. That leaves you free to concentrate on *your* work.

So I quickly knocked up a test between my maybe-three favourite languages. Python, because taking your pseudocode and renaming it .py is awesome for prototyping. REPLs are even better. Seriously, If you don't grok python - have you tried prototyping your code in a REPL first? Mistakes *just don't happen*.
Fortran, because it's fast and... pleasingly simple, actually. Especially if you're starting a new project.
Rust, because... well more on that later. But memory safety without a GC does sound cool.

Setup
---
Initialise a 4096x4096 array with random double precision floats, then obtain the hadamard product (aka "matrix multiplication". Hadamard product is a much better name, since anyone asked to multiply two same-shape matrices x and y would do THE OBVIOUS THING and obtain `z[i][j] = x[i][j] * y[i][j]`.
Mathematicians, [communicating badly and then acting smug makes you an arse.](https://xkcd.com/169/))

Python 3.8.2 + numpy 1.18.4  
gfortran 9.3.0 compiled with no flags whatsoever  
rust 1.43.1 with nalgebra 0.18  

There are minor differences - the FORTRAN array is static whereas the Rust and python versions are dynamically allocated.
I wanted static allocation - but caring about allocation in python is not really "pythonic" (if it's even possible?). In Rust because I gave up after two hours of trying to make static arrays work. They don't, even aside from the const generics issue which makes array traits break if you exceed a length of 32 (side note: oh, boy do I hate that.). I also built the Rust solution both in debug mode and, on a whim, in release mode.

I've also, because it does matter, estimated the time it took to write and run some basic tests on the (really, not that complex) solutions.

Results
---

Tested on an i5-8250u processor with 8GB RAM.

Python3 (numpy)  1.3s  
FORTRAN  6.0s  
Rust (debug)  >60s  
Rust (release)  4.0s  

Development time
---

Python(numpy)  ~3 minutes
FORTRAN  ~1 minute (yep, actually faster than python)
Rust  > 3 hours and one forum post for help.

Conclusion
---

Well, let's see.

I was going to absolutely rip into Rust - but when compiled in release, it's pretty respectable. I'm going to look at other things where I've been interested in Rust execution times but only ever bothered to run the debug build.

Python, of course, is fastest - because the heavy lifting is in not-python. I'm not interested in disputing how slow a naive nested-for loop would be, when the interpreter has to check types for *every single operation*.

Fortran was surpisingly easy to write quickly. Both numpy and Fortran reserve the `*` operator for elementwise multiplication, instead of hadamard product - that's a bit of a gotcha. But (and I refer to my earlier comment about mathematicians) a worthwhile one.

In all cases, however, we're not trading dev time (HOURS of it, potentially!) for hours of runtime. We're trading it for seconds, and only just plural seconds.

Real conclusion
---

Look, just use numpy.
