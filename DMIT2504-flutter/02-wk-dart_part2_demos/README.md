# DMIT 2504 · Week 1 — Dart Part 2 demos

Runnable companion to the lecture deck **Dart, Part 2: Functions, Lists, Objects & Null Safety**.
Every program in `bin/` is one of the 14 in-class demos, in the order they appear on the slides.

Plain Dart — no Flutter, no packages, no `pub get` required.

```bash
dart --version          # 3.0 or newer
dart run bin/01_warmup.dart
dart analyze            # should report: No issues found!
```

## Demo map

| # | File | Slides | What it demonstrates |
|---|------|--------|----------------------|
| 1 | `01_warmup.dart` | 8 | `main()`, `var`/`final`/`const`, interpolation, `/` vs `~/` |
| 2 | `02_functions_anatomy.dart` | 10–11, 16 | Return types, `void`, arrow syntax, functions as values |
| 3 | `03_parameters.dart` | 12–14 | All four parameter styles, including why you can't skip an optional positional |
| 4 | `04_grades_functions.dart` | 17 | Three functions, three styles, composed |
| 5 | `05_list_basics.dart` | 20–21 | Four ways to build a List, `remove` vs `removeAt`, `sort()` mutating |
| 6 | `06_iteration.dart` | 22–24 | `for` / `for-in` / `forEach`, `map`/`where`/`reduce`/`fold`, Iterable vs List, spread + collection-if |
| 7 | `07_roster_stats.dart` | 25 | Five questions over one List, plus a median |
| 8 | `08_nullable_basics.dart` | 29–30 | `T` vs `T?`, flow analysis, and why a **field** doesn't promote |
| 9 | `09_null_operators.dart` | 31–33 | `??`, `??=`, `?.`, `!`, `late` |
| 10 | `10_null_safety.dart` | 34, 36 | Incomplete data with no `!`; `List<int?>` vs `List<int>?` |
| 11 | `11_student_class.dart` | 40 | Fields, constructor, getter, method, `toString()` |
| 12 | `12_constructors.dart` | 41–42 | `this.x` shorthand, named constructors, all four field strategies |
| 13 | `13_roster_objects.dart` | 43–44 | `List<Student>` with `where`/`map`/`fold`/`sort` |
| 14 | `14_grade_tracker.dart` | 46 | Capstone — all four topics, zero `!` operators |

## Exercises

```bash
dart run exercises/starter.dart     # 17 checks; all failing until you write the code
dart run exercises/solutions.dart   # instructor copy — 20 passed, 0 failed
```

`starter.dart` has one stub per exercise and a self-check harness at the bottom.
Students replace each `throw UnimplementedError(...)` with real code and re-run; `FAIL`
turns into `ok` as they go. Distribute `starter.dart` only — keep `solutions.dart` back.

## Three gotchas worth knowing before you teach this

1. **`fold` inside `print()` does not compile.** `print(list.fold(0, (a, b) => a + b))`
   fails with *"the operator '+' isn't defined for the type 'Object?'"* — `print` takes
   `Object?`, and downward inference makes `T` = `Object?`. Assign it to a variable
   first. Students will hit this; it's commented in demo 6.
2. **Fields don't promote, locals do.** `if (someField != null) someField.length`
   is a compile error. Copy into a local first — demo 8's `Session.greet()` shows
   both the failure mode and the fix.
3. **Literal nullables get optimised away.** `int? x = 0; print(x ?? 10);` raises
   `dead_null_aware_expression` because the analyzer can see the value. Demos 9 and 10
   pull nullable values from helper functions so the examples stay analyzer-clean —
   worth mimicking if you add examples of your own.

## One deliberate lint warning

`dart analyze` reports exactly one `info` — a positional `bool` in demo 3's `log()`.
That is the bad example from slide 15, left in so the analyzer itself makes the
argument for named parameters. Everything else is clean; if you see a second
warning, it came from an edit.

## Deliberate compile errors

Lines that are meant to fail are commented out and marked `// ERROR:`. Uncomment one,
show the message, read it aloud, put it back. The error text is the teaching material —
especially in demos 8–10, where the whole point is that these are *compile* errors
rather than 2am production crashes.
