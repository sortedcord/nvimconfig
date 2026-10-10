# Agent Guidelines

This repository manages the Neovim configuration for this system (`~/.config/nvim`).

## Instructions for AI Agents

1. **Commit and Push on Configuration Changes**
   - Whenever you make changes to the Neovim configuration (options, plugins, keymaps, or dependencies), always create a descriptive git commit and push it to the remote tracking branch (`origin/master`).
   - Use conventional commit messages (e.g., `feat: ...`, `fix: ...`, `refactor: ...`).

2. **Validate Before Committing**
   - Always run a headless sanity check before committing to ensure there are no Lua syntax or runtime errors:
     ```bash
     nvim --headless "+qa"
     ```

3. **Keep Keymaps Centralized**
   - All user keybindings belong in `lua/config/keymaps.lua`.
   - Do not scatter keymaps across individual plugin files in `lua/plugins/`. Plugin files should only contain plugin options and setup logic.

4. **Protect Secrets and Local Configs**
   - Never commit sensitive tokens, API keys, or machine-specific overrides.
   - Any local-only configurations should go into `lua/config/local.lua` or `.env` (which are ignored by `.gitignore`).
