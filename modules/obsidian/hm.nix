{
  mkTarget,
  lib,
  ...
}:
mkTarget {
  name = "obsidian";
  humanName = "Obsidian";

  extraOptions.vaultNames = lib.mkOption {
    description = "The obsidian vault names to apply styling on.";
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  configElements = [
    (
      { cfg, fonts }:
      {
        programs.obsidian = {
          defaultSettings.appearance = {
            "interfaceFontFamily" = fonts.sansSerif.name;
            "monospaceFontFamily" = fonts.monospace.name;
            "baseFontSize" = fonts.sizes.applications;
          };
          vaults = lib.genAttrs cfg.vaultNames (_: {
            settings.appearance = {
              "interfaceFontFamily" = fonts.sansSerif.name;
              "monospaceFontFamily" = fonts.monospace.name;
              "baseFontSize" = fonts.sizes.applications;
            };
          });
        };
      }
    )
    (
      {
        cfg,
        colors,
        polarity,
      }:
      {
        programs.obsidian.defaultSettings.cssSnippets = with colors.withHashtag; [
          {
            name = "Stylix Config";
            text = ''
              .theme-${polarity} {
                  /* Base Colors */

                  --background-primary: ${base00};
                  --background-secondary: ${base01};
                  --background-modifier-border: ${base0D};

                  --text-normal: ${base05};
                  --text-muted: ${base03};
                  --text-faint: ${base03};
                  --text-on-accent: ${base02};
                  --text-success: ${base0C};
                  --text-warning: ${base0A};
                  --text-error: ${base09};
                  --text-accent: ${base04};

                  --color-accent: ${base0D};
                  --color-accent-1: ${base0D};
              }
            '';
          }
        ];
        programs.obsidian.vaults = lib.genAttrs cfg.vaultNames (_: {
          settings.cssSnippets = with colors.withHashtag; [
            {
              name = "Stylix Config";
              text = ''
                .theme-${polarity} {
                    /* Base Colors */

                  --background-primary: ${base00};
                  --background-secondary: ${base01};
                  --background-modifier-border: ${base0D};

                  --text-normal: ${base05};
                  --text-muted: ${base03};
                  --text-faint: ${base03};
                  --text-on-accent: ${base02};
                  --text-success: ${base0C};
                  --text-warning: ${base0A};
                  --text-error: ${base09};
                  --text-accent: ${base04};

                  --color-accent: ${base0D};
                  --color-accent-1: ${base0D};
                }
              '';
            }
          ];
        });
      }
    )
  ];
}
