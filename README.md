# MetaVersion Manager (MVM)

A portable, deterministic, corporate‑friendly version‑management system for polyglot developers.

MetaVersion Manager (MVM) is designed for engineers working in **locked‑down Windows environments** where installers, PATH edits, registry writes, and elevation are restricted or outright impossible. MVM provides a clean, reproducible way to manage multiple versions of PowerShell, .NET, Node.js, Python, and other runtimes — all without touching system state.

This project is part of the **PolyVerse Pioneers** organization, dedicated to building tools that empower developers working across many languages, platforms, and constraints.

---

## 🚀 Why MVM Exists

Corporate Windows environments often impose:

- No admin rights  
- No installers  
- No PATH modifications  
- No registry writes  
- No access to system‑level package managers  
- Frequent machine resets or reimages  

MVM solves this by giving you a **portable, hermetic, self‑contained environment** that:

- Lives entirely under a user‑controlled directory (e.g., `C:\myenv`)
- Loads cleanly through a PowerShell profile
- Uses shims to route commands to the active version
- Never modifies system configuration
- Can be zipped, copied, or rebuilt instantly

If you’ve ever lost your dev environment to a corporate reimage, this tool is for you.

---

## ✨ Features

- **Portable version managers** for:
  - PowerShell modules
  - Node.js
  - .NET SDK
  - Python
- **Zero‑installer workflow** — everything is file‑based
- **Deterministic environment loading** via PowerShell profile
- **Shims** for stable entrypoints (`node`, `python`, `dotnet`, etc.)
- **Hermetic runtime roots** stored under a single directory
- **Rebuild‑in‑seconds bootstrap script**
- **VS Code‑friendly structure** for clarity and portability

---

## 📁 Project Structure

```
mvm/
├── modules/ (PowerShell Core)
│   ├── pwsh-nvm/          # Node.js version manager 
│   ├── pwsh-dotnet/       # .NET SDK version manager
│   ├── pwsh-python/       # Python version manager
│   └── Ensure-Env/        # Environment bootstrap + safety checks
│
├── profile/
│   └── Microsoft.PowerShell_profile.ps1   # Deterministic environment loader
│
├── bootstrap/
│   ├── install.ps1        # Creates portable environment root
│   └── create-portable-env.ps1
│
├── shims/
│   ├── dotnet             # Shim launcher for active .NET version
│   ├── node               # Shim launcher for active Node.js version
│   └── python             # Shim launcher for active Python version
│
│── docs/
│   ├── quickstart.md
│   └── architecture.md
└── README.md
```

Each module is self‑contained and can be improved independently.

---

## 🧠 How It Works

1. **Bootstrap**  
   Run the installer to create your portable environment root and copy in the modules, shims, and profile.

2. **Profile Load**  
   PowerShell imports `Ensure-Env` and the version‑manager modules on startup.

3. **Version Selection**  
   Use `mvm use node 20`, `mvm use dotnet 8`, etc.  
   The selected version is written to a `.current` file.

4. **Shims**  
   Calls to `node`, `python`, `dotnet`, etc. are routed through shims that read the active version and launch the correct binary.

5. **Reproducibility**  
   Your entire environment can be zipped, copied, or restored instantly.

---

## 🛠 Requirements

- Windows 10/11  
- PowerShell 7+  
- No admin rights required  
- No system modifications performed  

---

## 🧪 Status

MVM is under active development.  
The initial public release focuses on:

- Portable environment creation  
- Node.js, Python, and .NET version switching  
- Clean PowerShell integration  
- Stable shim behavior  

Future enhancements will include:

- Additional language runtimes  
- Plugin system  
- Integrity validation  
- Cross‑platform support  

---

## 🤝 Contributing

Contributions are welcome — especially from developers working in constrained environments who understand the pain points firsthand.

If you’d like to help:

- Open an issue  
- Submit a PR  
- Share your environment constraints or use cases  

---

## 🪐 Part of PolyVerse Pioneers

This project is the public flagship of the **PolyVerse Pioneers** organization — a home for tools that support polyglot developers working across diverse ecosystems.

A second project, the **Privileged Integrity Platform**, is in private development and will integrate with MVM in the future.

---

## 📜 License

MIT License. See `LICENSE` for details.

---

## 🌟 Acknowledgments

Thanks to everyone building tools that make development possible in restrictive environments.  
You’re the real pioneers.
