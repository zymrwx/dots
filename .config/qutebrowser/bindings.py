# unbind
config.unbind('<Ctrl-v>')
config.unbind('b')
config.unbind('B')
config.unbind('m')
config.unbind('M')

# command mode
config.bind('<Ctrl-n>', 'completion-item-focus --history next', mode='command')
config.bind('<Ctrl-p>', 'completion-item-focus --history prev', mode='command')

# normal mode
config.bind('m', 'tab-mute')

config.bind('I', 'config-cycle colors.webpage.darkmode.enabled false true ;; config-cycle content.user_stylesheets ["styles/darkmode.css"] []')

config.bind('<Ctrl-e>', 'edit-url')

config.bind('<Ctrl-j>', 'tab-move +')
config.bind('<Ctrl-k>', 'tab-move -')

config.bind('<Ctrl-u>', 'scroll page-up')
config.bind('<Ctrl-d>', 'scroll page-down')

config.bind(';s', 'hint images download')
config.bind(';p', 'hint links spawn qutebrowser --target private-window {hint-url}')

config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('zz', 'zoom')

config.bind('zt', 'config-cycle tabs.show multiple never')
config.bind('zv', 'config-cycle tabs.position left top')
config.bind('zb', 'config-cycle statusbar.show always never')

config.bind('zP', 'config-source noproxy.py ;; message-info "config-source noproxy.py"')
config.bind('zp', 'config-source proxy.py ;; message-info "config-source proxy.py"')

config.bind('xh', 'spawn --userscript open-html')
config.bind('xt', 'spawn --userscript open-text')
config.bind('xq', 'spawn --userscript qrcode')
config.bind('xs', 'spawn --userscript sdcv')
