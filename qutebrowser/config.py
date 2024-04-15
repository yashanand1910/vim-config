config.load_autoconfig(False)

c.url.searchengines = {
        'DEFAULT':  'https://google.com/search?hl=en&q={}'
}
c.url.default_page = 'https://google.com'
c.url.start_pages = ['https://google.com']
c.zoom.default = 100

# c.fonts.default_size = '12pt'
# c.fonts.hints = '12pt'

# Keybinds
c.bindings.default['normal']['H'] = 'tab-prev'
c.bindings.default['normal']['L'] = 'tab-next'
c.bindings.default['normal']['<Ctrl-o>'] = 'back'
c.bindings.default['normal']['<Ctrl-i>'] = 'forward'
c.bindings.key_mappings['<Ctrl-c>'] = '<Escape>'
