# Neovim Config

<img width="1226" height="731" alt="image" src="https://github.com/user-attachments/assets/128b6aac-112e-4569-b865-934ac2fe6c18" />

## Install/Run

```sh
nix run github:frahz/nvim
```

## Adding new plugins

For start plugins:
```sh
npins --lock-file npins/start.json add github <user> <repo> -b <branch>
```

For lazy plugins:
```sh
npins --lock-file npins/opt.json add github <user> <repo> -b <branch>
```

## Updating plugins

```sh
npins --lock-file npins/start.json update --full
npins --lock-file npins/opt.json update --full
```

## Credits

- [Gerg-L](https://github.com/Gerg-L) - for [mnw](https://github.com/Gerg-L/mnw/)
