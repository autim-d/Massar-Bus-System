# 🗺️ Mapbox Setup Guide for Developers

To prevent security leaks, Mapbox tokens are no longer stored in the repository. Every developer needs to set up their local environment once.

## 1. Get your Tokens
1. Log in to [Mapbox Account](https://account.mapbox.com/).
2. You need two tokens:
   - **Default Public Token**: (Starts with `pk.`)
   - **Secret Access Token**: (Starts with `sk.`). *Note: Ensure it has the `DOWNLOADS:READ` scope enabled.*

## 2. Android Configuration (Secret Token)
This allows your computer to download the Mapbox SDK.

1. Open `massar_project/android/local.properties`.
2. Add the following line at the end:
   ```properties
   MAPBOX_DOWNLOAD_TOKEN=sk.YOUR_SECRET_TOKEN_HERE
   ```

## 3. Flutter Configuration (Public Token)
The app reads the public token using `--dart-define`.

### Using Command Line:
```bash
flutter run --dart-define=MAPBOX_PUBLIC_TOKEN=pk.YOUR_PUBLIC_TOKEN_HERE
```

### Using VS Code (Recommended):
Create or update `.vscode/launch.json` in the root of the project:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Massar App",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "toolArgs": [
        "--dart-define",
        "MAPBOX_PUBLIC_TOKEN=pk.YOUR_PUBLIC_TOKEN_HERE"
      ]
    }
  ]
}
```

---
⚠️ **Warning**: Never commit your `local.properties` or any file containing these real tokens. They are already included in `.gitignore`.
