config.load_autoconfig(False)

c.auto_save.session = True
c.session.lazy_restore = True

c.url.searchengines = {
        'DEFAULT':  'https://google.com/search?hl=en&q={}'
}
c.url.default_page = 'https://google.com'
c.url.start_pages = ['https://google.com']
c.zoom.default = 100

c.downloads.location.directory = "~/downloads"

# c.fonts.default_size = '12pt'
# c.fonts.hints = '12pt'

# Keybinds
c.bindings.default['normal']['H'] = 'tab-prev'
c.bindings.default['normal']['L'] = 'tab-next'
c.bindings.default['normal']['<Ctrl-o>'] = 'back'
c.bindings.default['normal']['<Ctrl-i>'] = 'forward'
c.bindings.default['normal']['<Ctrl-e>'] = 'scroll down'
c.bindings.default['normal']['<Ctrl-y>'] = 'scroll up'
c.bindings.default['command']['<Ctrl-N>'] = 'completion-item-focus next'
c.bindings.default['command']['<Ctrl-P>'] = 'completion-item-focus prev'
c.bindings.default['command']['<Ctrl-C>'] = 'mode-leave'
c.bindings.key_mappings['<Ctrl-M>'] = '<Return>'
