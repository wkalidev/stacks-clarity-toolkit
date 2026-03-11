# 🤝 Contributing to Stacks Clarity Toolkit

Share your Clarity utilities with the community!

## 🚀 Quick Start

1. **Fork** the repository
2. **Clone** your fork
```bash
git clone https://github.com/YOUR_USERNAME/stacks-clarity-toolkit.git
cd stacks-clarity-toolkit
```
3. **Install** Clarinet
```bash
brew install clarinet  # macOS
# or: https://github.com/hirosystems/clarinet/releases
```
4. **Create** a branch
```bash
git checkout -b feat/my-utility
```
5. **Add** your utility in the right folder:
   - `contracts/` — Clarity `.clar` files
   - `src/` — TypeScript helpers
   - `docs/` — Documentation
6. **Test** your contract
```bash
clarinet check
clarinet test
```
7. **Commit** and open a PR
```bash
git commit -m "feat: add my-utility to toolkit-math"
git push origin feat/my-utility
```

---

## 📁 Where to Add Things

| Type | Folder | Example |
|---|---|---|
| Clarity utility | `contracts/` | `toolkit-math.clar` |
| TypeScript helper | `src/` | `helpers.ts` |
| Documentation | `docs/` | `FUNCTIONS.md` |
| Tests | `tests/` | `toolkit-math_test.ts` |

---

## 📝 Commit Convention

- `feat:` — New utility or function
- `fix:` — Bug fix
- `docs:` — Documentation
- `test:` — Tests
- `refactor:` — Refactoring

---

## 💡 What We Need

- 🔢 More math functions (fixed-point, square root, etc.)
- 🔐 Security utilities (re-entrancy guards, pause mechanism)
- 🧪 More test helpers and mock data
- 📖 More documentation and examples
- 🌐 Multi-token batch operations

---

## 🐛 Bug Reports

[Open an issue](https://github.com/wkalidev/stacks-clarity-toolkit/issues/new) with:
- Description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Clarity version / Clarinet version

---

## 📞 Questions?

- 🐦 Twitter: [@willycodexwar](https://twitter.com/willycodexwar)
- 🟪 Farcaster: [@willywarrior](https://warpcast.com/willywarrior)

---

**Thank you for making Clarity development easier! 🛠️**
