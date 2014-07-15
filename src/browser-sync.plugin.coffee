# Export Plugin
module.exports = (BasePlugin) ->
    # Define Plugin
    class BrowserSyncPlugin extends BasePlugin
        # Browser Sync
        name: 'browserSync'
        config:
            files: false
            open: false

        serverAfter: (opts) ->
            address = opts.serverHttp.address()
            serverHostname = address.address
            serverPort = address.port
            serverLocation = "http://" + serverHostname + ":" + serverPort + "/";
            @browserSync = require('browser-sync')
            bsConfig = @getConfig()
            bsConfig.proxy = serverLocation
            @browserSync(bsConfig)

        generateAfter: ->
            @browserSync.reload()
            @