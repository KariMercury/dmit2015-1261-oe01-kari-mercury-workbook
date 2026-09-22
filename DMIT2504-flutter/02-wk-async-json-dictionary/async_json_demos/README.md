# async_json_demos — concept demos for Week 2 Day 1

Each file maps to a slide. Run any of them with `dart run bin/<file>.dart`.

| Demo | Slide | Shows |
|---|---|---|
| `demo_01_future_then.dart` | 9 | `Future.delayed` consumed with `.then`; output order |
| `demo_02_async_await.dart` | 10 | Same Future with `async` / `await`; the "Instance of Future" bug |
| `demo_03_future_wait.dart` | 11 | Sequential awaits (~4 s) vs `Future.wait` (~2 s) |
| `demo_04_async_errors.dart` | 12 | Custom exception, `try / on / catch / finally` around an `await` |
| `demo_05_convert.dart` | 18 | `jsonEncode`, `jsonDecode`, pretty printing |
| `demo_06_dynamic_trap.dart` | 19 | Three bugs that compile with `dynamic` |
| `demo_07_nested.dart` | 22 | One class per JSON object; cast → map → toList |
| `demo_08_null_safety.dart` | 23 | Required / optional / defaulted fields in `fromJson` |
