# RJ's public dotfiles

## Current Status

- I'm continuously working on optimizing plugin startup times to make Neovim faster and more responsive.
- Still figuring out the best way to ensure plugins load in the correct order to avoid any issues.
- One known problem is that sometimes some plugins load before `neodev`, which causes errors such as `vim` being tagged as an undefined global.
- Fixing this loading order issue is a top priority to maintain stability and smooth operation.
