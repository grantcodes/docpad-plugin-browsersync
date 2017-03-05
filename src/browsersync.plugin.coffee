# Export Plugin
module.exports = (BasePlugin) ->
    # Define Plugin
    class BrowserSyncPlugin extends BasePlugin
        # Browser Sync
        name: 'browsersync'
        config:
            files: false
            open: false

        serverAfter: (opts) ->
            address = opts.serverHttp.address()
            serverHostname = address.address
            serverHostname = 'localhost' if serverHostname == '::' || '0.0.0.0'
            serverPort = address.port
            serverLocation = 'http://' + serverHostname + ':' + serverPort + '/';
            @browserSync = require('browser-sync')
            bsConfig = @getConfig()
            bsConfig.proxy = serverLocation
            @browserSync(bsConfig)

        generateAfter: ->
            if @browserSync?
                @browserSync.reload()
            @
