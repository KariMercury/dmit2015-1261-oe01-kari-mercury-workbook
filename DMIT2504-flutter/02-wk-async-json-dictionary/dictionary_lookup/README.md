# dictionary_lookup — DMIT 2504 Futures & JSON exercise (solution)

Console app that prompts for a word, calls `https://api.dictionaryapi.dev/api/v2/entries/en/<word>`,
and prints the first definition in a two-column table. Loops until `quit`.

## Run
```bash
dart pub get
dart run bin/main.dart          # run in the TERMINAL, not the VS Code Debug Console (stdin)
dart test                       # 9 offline tests via MockClient + test/fixture_vernacular.json
```

## Structure
| File | Responsibility |
|---|---|
| `lib/word_definition.dart` | Model class. `factory fromJson(dynamic)` walks `[0].meanings[0].definitions[0]`, throws `FormatException` on bad shape. `toJson()` for the round trip. |
| `lib/dictionary_service.dart` | `Future<WordDefinition> lookup(String)`. Builds the URL, `await`s `http.get`, handles all failures and rethrows them as `DictionaryException`. |
| `bin/main.dart` | Prompt loop, `try / on DictionaryException / catch`, table formatting. |
| `test/dictionary_test.dart` | 200, 404, 522, garbage-body and shape tests — no network needed. |

## Failure types handled (assignment requirement)
1. **Status != 200** — 404 surfaces the API's own `message`; anything else reports the code. Network/timeout errors are caught around the `await`.
2. **Bad body on 200** — `jsonDecode` or `fromJson` throws `FormatException` → converted to `DictionaryException`.
3. **Bugs in our own code** — bare `catch` in `main` prints and keeps the loop alive.

## Note
dictionaryapi.dev is a free community service and occasionally returns Cloudflare 522s. If that happens in class, it is a live demo of failure type 1; use `dart test` to exercise parsing offline.
