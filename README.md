# RGPRS J&K

Offline-first organisation, grievance and membership app.

## Run on Windows

The project path contains a space (`ALL SHIH`). Flutter's Windows native-assets
hooks currently fail when invoked from a project path containing spaces. Use
the project launcher instead:

```powershell
.\tool\run_windows.ps1
```

For a specific Flutter command, pass its arguments after the script:

```powershell
.\tool\run_windows.ps1 build apk --debug
```

The launcher creates `C:\rgprs_jk_run` as a junction to this project and runs
Flutter from that space-free path. The junction is reused on subsequent runs.

In VS Code, select **RGPRS J&K (Windows path-safe)** from the Run and Debug
configuration list, then press **F5**. Do not use the default Flutter launch
configuration while this project remains under a path containing spaces.
