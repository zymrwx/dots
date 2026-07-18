config.load_autoconfig(False)
config.source("bindings.py")
config.source("colors.py")
config.source("proxy.py")

c.fonts.default_family = "Source Code pro"
c.fonts.default_size = "14pt"
c.fonts.hints = "16pt"
c.fonts.web.size.minimum = 14
c.content.user_stylesheets = ["styles/darkmode.css"]
c.zoom.default = 150
c.zoom.levels = ([
    '25',  '33',  '50',  '67',  '75',  '80',  '90', '100', '110',
   '125', '133', '140', '150', '175', '200', '250', '300', '400'
])

c.url.default_page= "file:///dev/null"
c.url.start_pages = "file:///dev/null"
c.tabs.last_close = "startpage"

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "b": "https://www.bing.com/search?q={}",
    "g": "https://google.com/search?hl=en&q={}",
}

c.content.geolocation = False
c.content.webrtc_ip_handling_policy = "default-public-interface-only"

c.auto_save.session = True
c.content.autoplay = False
c.content.fullscreen.window = True

c.downloads.location.directory = "~/dls"
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.downloads.location.suggestion = "both"
c.downloads.position = "bottom"

c.hints.auto_follow = "full-match"
c.hints.border = '1px solid #aaaaaa'
c.hints.radius = 0
c.hints.chars = "asdfjkl;"
c.hints.min_chars = 2
c.hints.uppercase = False
c.keyhint.delay = 0
c.prompt.radius = 0
c.completion.height = '25%'


import os
import shlex
c.editor.command = shlex.split("st") + ["-T", "_floating_", "nvim", "{file}", "-c", "normal {line}G{column0}l"]
fileChooser = shlex.split("st") + ["-T", "_floating_", "lf", "-selection-path={}"]
c.fileselect.handler = "external"
c.fileselect.folder.command = fileChooser
c.fileselect.single_file.command = fileChooser
c.fileselect.multiple_files.command = fileChooser
