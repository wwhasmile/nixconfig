{ inputs, config, lib, pkgs, osConfig, ... }:

let
  cfg = config.homeSettings.mango;
in {
  imports = [ inputs.mangowm.hmModules.mango ];

  options = {
    homeSettings.mango = {
      enable = lib.mkEnableOption "Enable MangoWM config";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      foot
      rofi
      brightnessctl
      playerctl
      swaynotificationcenter
      swaybg
      (writeShellApplication {
        name = "mango-screenshot";
        runtimeInputs = [ grim slurp wl-clipboard-rs satty wayfreeze ];
        text = ''
          mkdir -p "$HOME/Pictures/Screenshots"
          filepath="$HOME/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"

          case "''${1:-fullscreen}" in
            region)
              g=$(slurp -d); [ -z "$g" ] && exit 1
              grim -g "$g" "$filepath" ;;
            window)
              g=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
              [ -z "$g" ] && exit 1
              grim -g "$g" "$filepath" ;;
            freeze)
              p=$(mktemp -u).fifo; mkfifo "$p"
              wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" & wp=$!
              read -r < "$p"; grim "$filepath"
              kill "$wp" 2>/dev/null; rm -f "$p" ;;
            freeze-region)
              p=$(mktemp -u).fifo; mkfifo "$p"
              wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" & wp=$!
              read -r < "$p"; g=$(slurp -d)
              if [ -z "$g" ]; then kill "$wp" 2>/dev/null; rm -f "$p"; exit 1; fi
              grim -g "$g" "$filepath"
              kill "$wp" 2>/dev/null; rm -f "$p" ;;
            annotate)
              grim "$filepath"; satty --filename "$filepath" --output-filename "$filepath" --actions-on-enter save-to-file --early-exit ;;
            *) grim "$filepath" ;;
          esac
        '';
      })
    ];

    wayland.windowManager.mango = {
      enable = true;
      settings = {
        # Autostart
        exec-once = [
          "swaybg -i ${config.stylix.image}"
        ];

      	# Keyboard
	      xkb.rules = {
	        layout = osConfig.services.xserver.xkb.layout;
	        options = osConfig.services.xserver.xkb.options;
	      };
        bind = [
	        # Due to the lack of hot reloading, I leave it here.
          "Super+Shift,r,reload_config"

          # Application shortcuts
          "Super,Return,spawn,${config.homeSettings.terminal}"
          "Super,e,spawn,rofi -show drun"
          "Super,b,spawn,librewolf"

          # Application management
          "Super,q,killclient"

          # Window mode management
          "Super,f,togglefullscreen"
          "Super,space,togglefloating"

          # Window focus
          "Super,Left,focusdir,left"
          "Super,Down,focusdir,down"
          "Super,Up,focusdir,up"
          "Super,Right,focusdir,right"
          "Super,h,focusdir,left"
          "Super,j,focusdir,down"
          "Super,k,focusdir,up"
          "Super,l,focusdir,right"

          # Window movement
          "Super+Shift,Left,exchange_client,left"
          "Super+Shift,Down,exchange_client,down"
          "Super+Shift,Up,exchange_client,up"
          "Super+Shift,Right,exchange_client,right"
          "Super+Shift,h,exchange_client,left"
          "Super+Shift,j,exchange_client,down"
          "Super+Shift,k,exchange_client,up"
          "Super+Shift,l,exchange_client,right"

          # Window resizing
          "Super+Alt,Left,resizewin,-10,+0"
          "Super+Alt,Down,resizewin,+0,-10"
          "Super+Alt,Up,resizewin,+0,+10"
          "Super+Alt,Right,resizewin,+10,+0"
          "Super+Alt,h,resizewin,-10,+0"
          "Super+Alt,j,resizewin,+0,+10"
          "Super+Alt,k,resizewin,+0,-10"
          "Super+Alt,l,resizewin,+10,+0"

          # Floating window movement
          "Super+Ctrl,Left,movewin,-10,+0"
          "Super+Ctrl,Down,movewin,+0,+10"
          "Super+Ctrl,Up,movewin,+0,-10"
          "Super+Ctrl,Right,movewin,+10,+0"
          "Super+Ctrl,h,movewin,-10,+0"
          "Super+Ctrl,j,movewin,+0,+10"
          "Super+Ctrl,k,movewin,+0,-10"
          "Super+Ctrl,l,movewin,+10,+0"
      
          # Workspace view switching
          "Super,1,view,1,0"
          "Super,2,view,2,0"
          "Super,3,view,3,0"
          "Super,4,view,4,0"
          "Super,5,view,5,0"
          "Super,6,view,6,0"
          "Super,7,view,7,0"
          "Super,8,view,8,0"
          "Super,9,view,9,0"
          "Alt,Tab,toggleoverview"

          # Window workspace moving
          "Super+Shift,1,tag,1,0"
          "Super+Shift,2,tag,2,0"
          "Super+Shift,3,tag,3,0"
          "Super+Shift,4,tag,4,0"
          "Super+Shift,5,tag,5,0"
          "Super+Shift,6,tag,6,0"
          "Super+Shift,7,tag,7,0"
          "Super+Shift,8,tag,8,0"
          "Super+Shift,9,tag,9,0"

          # Screenshot 
          "None,Print,spawn,mango-screenshot fullscreen"
          "Shift,Print,spawn,mango-screenshot region"
          "Ctrl+Shift,Print,spawn,mango-screenshot window"
          "Super+Ctrl,Print,spawn,mango-screenshot freeze"
          "Shift+Ctrl,Print,spawn,mango-screenshot freeze-region"
          "Super,Print,spawn,mango-screenshot annotate"

          # Brightness
          "None,XF86MonBrightnessUp,spawn,brightnessctl s 5%+"
          "None,XF86MonBrightnessDown,spawn,brightnessctl s 5%-"
          "Shift,XF86MonBrightnessUp,spawn,brightnessctl s 100%"
          "Shift,XF86MonBrightnessDown,spawn,brightnessctl s 1%"

          # Volume
          "None,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK 5%+"
          "None,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK 5%-"
          "None,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK toggle"
          "Shift,XF86AudioMute,spawn,wpctl mute @DEFAULT_SOURCE toggle"

          # Playback
          "None,XF86AudioNext,spawn,playerctl next"
          "None,XF86AudioPrev,spawn,playerctl previous"
          "None,XF86AudioPlay,spawn,playerctl play-pause"
        ];

        # Touchpad
        trackpad_natural_scrolling = 1;
        gesturebind = [
          "None,left,3,focusdir,left"
          "None,down,3,focusdir,down"
          "None,up,3,focusdir,up"
          "None,right,3,focusdir,right"

          "None,left,4,focusdir,viewtoleft_have_client"
          "None,down,4,toggleoverview"
          "None,up,4,toggleoverview"
          "None,right,4,focusdir,viewtoright_have_client"
        ];

        # Tags work like workspaces in my config.
        tagrule = [
          "id:1,layout_name:scroller"
          "id:2,layout_name:scroller"
          "id:3,layout_name:scroller"
          "id:4,layout_name:scroller"
          "id:5,layout_name:scroller"
          "id:6,layout_name:scroller"
          "id:7,layout_name:scroller"
          "id:8,layout_name:scroller"
          "id:9,layout_name:scroller"
        ];

        # Border settings
        borderpx = 4;
        gappih = 6;
        gappiv = 6;
        gappoh = 12;
        gappov = 10;

        # Animations are very minimal and fast, to be snappy
        animations = 1;
        animation = {
          type = {
            open = "zoom";
            close = "zoom";
          };
          fade_in = 1;
          fade_out = 1;

          duration = {
            move = 100;
            open = 70;
            tag = 60;
            close = 60;
            focus = 20;
          };

          curve = {
            open = "0.0,0.0,0.58,1.0";
            move = "0.0,0.0,1.0,1.0";
            tag = "0.0,0.0,1.0,1.0";
            close = "0.0,0.0,0.58,1.0";
            focus = "0.0,0.0,1.0,1.0";
            opafadein = "0.0,0.0,1.0,1.0";
            opafadeout = "0.0,0.0,1.0,1.0";
          };
        };

        fadein_begin_opacity = 0.7;
        fadeout_begin_opacity = 0.8;
          zoom = {
          initial_ratio = 0.88;
          end_ratio = 0.95;
        };

        # Misc
        sloppyfocus = 0;

        # Color scheme
        rootcolor = "0x${config.lib.stylix.colors.base00}";
        bordercolor = "0x${config.lib.stylix.colors.base03}";
        focuscolor = "0x${config.lib.stylix.colors.base0D}";
        urgentcolor = "0x${config.lib.stylix.colors.base08}";
      };
    };

    services.swaync.enable = true;
  };
}
