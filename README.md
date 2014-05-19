Spillo Sharing SDK
==================

The SDK to create a Sharing Service for Spillo.

Creating a plugin to share item with Spillo is very simple. The SDK is just a single header defining a `LLSpilloSharingService` protocol that your plugin’s principal class needs to conform to.

### Where to install the plugin

Plugins need to be installed in the application sandbox (there is a `PlugIns` directory under `~/Library/Application Support` in the sandbox). Since it can be tricky to navigate down there a menu item is available in Spillo’s help menu to quickly opening the `PlugIns` directory.

### Troubleshooting

While working on the plugin, it might be helpful setting a special user default that will report errors while loading the plugin.

```
defaults write com.ddeville.spillo developerShowPluginLoadingErrors true
```

With this on, any error happening while loading your plugin will be shown as an alert.
