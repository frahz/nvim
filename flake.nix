{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      packages = forAllSystems (pkgs: rec {
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
            start = mnw.lib.npinsToPlugins pkgs ./npins/start.json;

            # Anything that you're loading lazily should be put here
            opt = [
              pkgs.vimPlugins.blink-cmp
              pkgs.vimPlugins.nvim-treesitter.withAllGrammars
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
            pkgs.git
            pkgs.ripgrep
            pkgs.tree-sitter

            pkgs.nil
            pkgs.tinymist
            pkgs.marksman

            # Formatters
            pkgs.typstyle
            pkgs.nixfmt
          ];
        };

        dev = default.devMode;
      });
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
