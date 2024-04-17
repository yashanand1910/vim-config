config.load_autoconfig()

c.auto_save.session = True
c.session.lazy_restore = True

c.url.searchengines = {
        'DEFAULT':  'https://google.com/search?hl=en&q={}'
}
c.url.default_page = 'https://google.com'
c.url.start_pages = ['https://google.com']
c.zoom.default = 100

c.downloads.location.directory = "~/downloads"
c.input.insert_mode.auto_load = True

c.fonts.default_family = "JetBrainsMono"
# c.fonts.default_size = '12pt'
# c.fonts.hints = '12pt'

# Unbindings

# config.unbind('<Ctrl-D>', mode='normal')
# config.unbind('<Ctrl-U>', mode='normal')

# Keybinds

c.bindings.default['normal']['H'] = 'tab-prev'
c.bindings.default['normal']['L'] = 'tab-next'
c.bindings.default['normal']['<Ctrl-o>'] = 'back'
c.bindings.default['normal']['<Ctrl-i>'] = 'forward'
c.bindings.default['normal']['<Ctrl-e>'] = 'scroll down'
c.bindings.default['normal']['<Ctrl-y>'] = 'scroll up'
c.bindings.default['normal']['1'] = 'tab-focus 1'
c.bindings.default['normal']['2'] = 'tab-focus 2'
c.bindings.default['normal']['3'] = 'tab-focus 3'
c.bindings.default['normal']['4'] = 'tab-focus 4'
c.bindings.default['normal']['5'] = 'tab-focus 5'
c.bindings.default['normal']['6'] = 'tab-focus 6'
c.bindings.default['normal']['7'] = 'tab-focus 7'
c.bindings.default['normal']['8'] = 'tab-focus 8'
c.bindings.default['normal']['9'] = 'tab-focus 9'

c.bindings.default['command']['<Ctrl-N>'] = 'completion-item-focus next'
c.bindings.default['command']['<Ctrl-P>'] = 'completion-item-focus prev'

c.bindings.default['command']['<Ctrl-C>'] = 'mode-leave'
c.bindings.default['caret']['<Ctrl-C>'] = 'mode-leave'
c.bindings.default['insert']['<Ctrl-C>'] = 'mode-leave'

c.bindings.key_mappings['<Ctrl-M>'] = '<Return>'

