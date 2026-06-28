import os
import shlex

config.load_autoconfig(False)
config.source("colors.py")
config.source("bindings.py")
config.source("proxy.py")

term = "st"

c.editor.command = shlex.split(term) + \
    ["-T", "_floating_", \
    "nvim", "{file}", "-c", "normal {line}G{column0}l"]

fileChooser = shlex.split(term) + ["-T", "_floating_", "lf", "-selection-path={}"]
c.fileselect.handler = "external"
c.fileselect.folder.command = fileChooser
c.fileselect.single_file.command = fileChooser
c.fileselect.multiple_files.command = fileChooser


c.url.default_page= "file:///dev/null"
c.url.start_pages = "file:///dev/null"
c.tabs.last_close = "startpage"

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "b": "https://www.bing.com/search?q={}",
    "g": "https://google.com/search?hl=en&q={}",
}

c.content.blocking.enabled = True
c.content.blocking.method = 'auto'

c.content.geolocation = False
c.content.webrtc_ip_handling_policy = "default-public-interface-only"

c.auto_save.session = True
c.content.autoplay = False
c.content.fullscreen.window = True # Limit fullscreen to browser window

c.keyhint.delay = 0
c.hints.auto_follow = "full-match"
c.hints.chars = "asdfjkl;"
c.hints.min_chars = 2
c.hints.uppercase = False

c.downloads.location.directory = "~/dls"
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.downloads.location.suggestion = "both"
c.downloads.position = "bottom"
c.downloads.remove_finished = 60000

c.content.user_stylesheets = ["~/.config/qutebrowser/styles/background.css"]

c.zoom.default = 130
c.zoom.levels = [
    "25%", "33%", "50%", "67%", "75%", "90%", "100%", "110%", "120%",
    "130%", "140%", "150%", "175%", "200%", "250%", "300%"
]

c.fonts.default_family = "Noto Sans"
c.fonts.default_size = "13pt"
c.fonts.hints = "normal 13pt Noto Sans"
c.fonts.statusbar = "13pt Noto Sans"
c.fonts.tabs.selected = "13pt Noto Sans"
c.fonts.tabs.unselected = "13pt Noto Sans"
c.fonts.web.size.default = 15
c.fonts.web.size.default_fixed = 15
c.fonts.web.size.minimum = 15

c.tabs.indicator.width = 0

c.statusbar.show = "always"

c.tabs.show = "multiple"
c.tabs.position = "top"
c.tabs.padding = {"bottom":0, "left":0, "right":0, "top":0}
c.tabs.title.format = "{audio}{current_title}"
c.tabs.title.format_pinned = "[P]{audio}{current_title}"
