{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    mnw.url = "github:Gerg-L/mnw";
  };
  outputs =
    {
      nixpkgs,
      mnw,
      self,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        function: nixpkgs.lib.genAttrs systems (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          grammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (
            p: with p; [
              asm
              astro
              bash
              beancount
              c
              c_sharp
              caddy
              cmake
              comment
              cpp
              css
              csv
              devicetree
              diff
              dockerfile
              git_config
              git_rebase
              gitcommit
              gitignore
              go
              gomod
              gosum
              gotmpl
              html
              htmldjango
              hyprlang
              ini
              java
              javadoc
              javascript
              jjdescription
              jsdoc
              json
              just
              kconfig
              kdl
              kotlin
              lua
              markdown
              markdown_inline
              meson
              ninja
              nix
              python
              rust
              sql
              starlark
              svelte
              tmux
              toml
              tsx
              typescript
              typst
              vim
              vimdoc
              xml
              yaml
              zig
              zsh
            ]
          );
        in
        rec {
          default = mnw.lib.wrap pkgs {
            neovim = pkgs.neovim-unwrapped;

            # all files in the `lua/lazy` folder are now autoloaded, so no need
            # for an init.lua in there
            initLua = ''
              require("frahz")
              LZN = require("lz.n")
              LZN.load("lazy")
            '';

            plugins = {
              start = [
                pkgs.vimPlugins.SchemaStore-nvim
              ]
              ++ mnw.lib.npinsToPlugins pkgs ./npins/start.json;

              # Anything that you're loading lazily should be put here
              opt = [
                pkgs.vimPlugins.blink-cmp
                grammars
              ]
              ++ mnw.lib.npinsToPlugins pkgs ./npins/opt.json;

              dev.frahz = {
                pure = ./.;
                impure = "~/coding/neovim-flake";
              };
            };
            extraBinPath = [
              pkgs.fd
              pkgs.fzf
              pkgs.ripgrep
            ];
          };

          dev = default.devMode;
        }
      );
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.dev
            pkgs.npins
          ];
        };
      });
      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "update";
              runtimeInputs = [ pkgs.npins ];
              text = ''
                npins --lock-file npins/start.json update --full
                npins --lock-file npins/opt.json update --full
              '';
            }
          );
        };
      });
    };
}
