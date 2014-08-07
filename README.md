Don't Get Buried by Your Unit Tests
===================================

Introduction
------------

Tests can be slow, expensive, and fragile. They can make you feel buried alive... (show Khaaaan! video)

They don't need to be this way.

Delete some tests!!!

Unit tests should test in isolation. Integration tests exercise an entry point and asserts the appropriate change(s) happen inside the system.

Tests should be: Thorough, Stable, Fast, and Few

Outline
-------

Problem: App feels like complicated spaghetti. Code is too complex.

Solution: Focus on messages (public interface / methods).

Objects should be isolated. We should minimize the knowledge an object has about its collaborators (dependencies).

### Types of messages (methods):

#### Origin

* received from others (incoming)
* sent to others (outgoing)
* sent to self (private methods)

#### Types

* Command–query separation--Bertrand Meyer (designer of Eiffel programming language)
* query (return something / change nothing--no public side effects)
* command (return nothing / change something)
 * sometimes these do both, but be CAREFUL
 * good example is popping an item off a queue
 * tell, don't ask

### Rules (credit Sandi Metz, show chart):

#### Test incoming query messages

* assert result (what they send back / return)
* test the interface, NOT the implementation

#### Test incoming command message
   * assert direct public side effects
   * DRY tests--receiver (object / class) of incoming message has sole responsibility for asserting public side effects

#### DO NOT test messages sent to self
   * anti-pattern, tests for public interface ensure private methods do their job
   * test interface, not implementation
   * break rule if it saves time during dev if you must
   * put TODO around tests that says IF THIS FAILS, DELETE IT

#### DO NOT test outgoing query messages
   * anti-pattern
   * tests of collaborator (dependency) already tests these methods
   * if message has no visible side effects, sender should not test it (that is an integration test)

#### Test outgoing command messages
* expect to send
* command message causes direct public side effects
* it MUST be sent
* don't test implementation--it depends on a distant side effect
* that would make it an integration test
* use mocks to verify message was sent
* break the rule if side effects are stable and cheap (close by)
* what if collaborator (dependency) stops implementing expected method?
 * PAIN--API drift
 * honor the contract--stay in sync with API
 * see FAQ for solution (verifying doubles)'

### Summary (credit Sandi Metz)

* be a minimalist
* use good judgement
* test everything once
* test the interface, not the implementation
* trust collaborators (dependencies)
* keep it simple

FAQ
---

What purpose do mocks serve if my real implementation changes?

Aren't mocks fragile? Test suite could be green when app is broken.

* Honor the contract - stay in sync with the API
* Use tools that ensure mocks don't drift from the API:
 * RSpec [verifying doubles](https://www.relishapp.com/rspec/rspec-mocks/v/3-0/docs/verifying-doubles)
 * [rspec-fire](https://github.com/xaviershay/rspec-fire) obsoleted by Rspec verifying doubles
 * [MiniTest](https://github.com/seattlerb/minitest) requires that stubbed methods exist
 * [MiniTest::FireMock](https://github.com/cfcosta/minitest-firemock)

Sources
-------

https://en.wikipedia.org/wiki/Command%E2%80%93query_separation

http://pragprog.com/articles/tell-dont-ask

https://speakerdeck.com/skmetz/magic-tricks-of-testing-railsconf

http://www.confreaks.com/videos/2452-railsconf2013-the-magic-tricks-of-testing

https://speakerdeck.com/railsberry/zero-confidence-by-katrina-owen

http://confreaks.com/videos/3760-railsberry2013-467-tests-0-failures-0-confidence

https://www.youtube.com/watch?v=e7X01_j_oDA#t=2m06s

