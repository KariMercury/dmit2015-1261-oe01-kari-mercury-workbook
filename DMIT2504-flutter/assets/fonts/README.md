# Fonts for Step 3

Download from https://fonts.google.com (click **Get font → Download all**), unzip,
and copy these files into this folder:

```
assets/fonts/Merriweather-Regular.ttf
assets/fonts/Merriweather-Italic.ttf
assets/fonts/Merriweather-Bold.ttf
assets/fonts/Pacifico-Regular.ttf
```

Then uncomment the `fonts:` block in `pubspec.yaml`, run `flutter pub get`,
and do a **full restart** (not hot reload) — new assets are only picked up on restart.

> Merriweather may ship as a variable font (`Merriweather[opsz,wdth,wght].ttf`).
> Either rename that single file to `Merriweather-Regular.ttf` and list only it,
> or grab the `static/` folder inside the zip which has the individual weights.
