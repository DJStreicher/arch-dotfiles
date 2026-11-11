-- Converted from hyprland.conf to the Hyprland 0.55+ Lua config format.
-- Cross-check the sections flagged "-- TODO" against the wiki
-- (https://wiki.hypr.land/Configuring/) or an automated converter --
-- I translated these by hand and the newer typed-table dispatcher API
-- has some sharp edges I couldn't verify against a running Hyprland.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "DP-3", mode = "3840x2160@144", position = "0x0", scale = 1, transform = 0, bitdepth = 10 })
hl.monitor({ output = "DP-1", mode = "2560x1440@239.99899", position = "3840x0", scale = 1, transform = 0, bitdepth = 10 })
hl.monitor({ output = "DP-2", mode = "1920x1080@144", position = "6400x0", scale = 1, transform = 3 })

-- TODO: verify workspace-to-monitor assignment syntax
hl.workspace_rule({ workspace = "1", monitor = "DP-3" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "rofi -show drun"
local windowmanager = "rofi -show window"
local browser = "brave --password-store=basic --disable-features=WaylandWpColorManagerV1"
local discord = "discord"
local steam = "steam"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    -- "silent" here matches the old [workspace N] behavior: it launches
    -- onto that workspace without flicking your active workspace over to
    -- show it first.
    hl.exec_cmd(terminal .. " -e tmux", { workspace = "3 silent" })
    hl.exec_cmd(browser, { workspace = "1 silent" })
    hl.exec_cmd("hyprctl setcursor macOS 24")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "macOS")
hl.env("HYPRCURSOR_THEME", "macOS")
hl.env("FREETYPE_PROPERTIES", "truetype:interpreter-version=40")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 2,
        border_size = 1,
        col = {
            active_border = { colors = { "rgba(33ccff22)", "rgba(00ff9922)" }, angle = 45 },
            inactive_border = "rgba(ffffff19)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.4, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.0, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.75, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.8, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.7, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.5, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 1.9, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.0, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 0.75, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.9, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.7, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.0, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.6, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.0, bezier = "almostLinear", style = "fade" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "", -- was `#caps:escape` in the old conf, which was commented out there too
        kb_rules = "",
        numlock_by_default = true,
        scroll_button = 274,
        scroll_button_lock = true,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))
-- NOTE: your original conf bound both "$mainMod, S, exec, $steam" AND
-- "$mainMod, S, togglespecialworkspace, magic" to the same key (SUPER+S).
-- That was already a conflict in your old file, not something this
-- conversion introduced -- only the second one would ever have fired.
-- Pick a different key for one of these.
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(steam))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- TODO: verify fullscreen dispatcher args/shape
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(windowmanager))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- TODO: verify relative workspace move syntax (was movetoworkspace, -1 / +1)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- TODO: double-check the field name -- your old conf used `no_initial_focus`,
-- but Hyprland's own example config uses `no_focus` for a very similarly
-- shaped rule. Verify against the wiki before relying on this one.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
