Spillo Sharing SDK
==================

Creating a plugin to share item with Spillo is very simple. The SDK is just a single header declaring a `LLSpilloSharingService` protocol that your plugin’s principal class needs to conform to.

You can find more about Spillo by visiting the official [page](http://bananafishsoftware.com/products/spillo/).

### How to develop a plugin

Following are the steps that one need to go through in order to develop a plugin:

1. In Xcode, create a new project and select the `Bundle` template. Select `Cocoa` as the Framework to link to.
2. In your newly created bundle target, navigate to the Build Settings. In there, change the Wrapper Extension setting (under the Packaging section) from `bundle` to `spillosharing`.
3. In your project, create a new class. A subclass of `NSObject` will do.
4. Going back to the target info, add a new enty to the Info plist `NSPrincipalClass`. Specify the name of the class you’ve just created.
5. Drag the two files `LLSpilloSharingServicePlugin.h` and `LLSpilloSharingServicePlugin.m` to your project making sure that they are copied into your project.
6. In your newly created class, `#import LLSpilloSharingServicePlugin.h`.
7. Make your class conform to the `LLSpilloSharingService` protocol.
8. Implement the required method in the protocol. `identifier` needs to be a unique identifier for your plugin, the bundle identifier will do. Display name is the name of your plugin as displayed in the share menu and the display image is the 16x16 icon.
9. Implement the `createSharingOperationForItems:` method. This is the core of the plugin. You will be passed an array of `NSURL` instances (most likely containing a single item) and you will have to return an `NSOperation` that actually perform the sharing work. The returned `NSOperation` needs to conform to the `LLSpilloSharingServiceOperation` protocol which means it just needs to have a valid completion provider when going `isFinished`. See the comments in the header for more documentation.
10. If your plugin requires authentication, makes sure to return an appropriate value for the `authenticated` property so that Spillo can correcly kick in authentication for your plugin when needed.
11. Again, if you need to authenticate your plugin, you can return a view controller from the `createLoginViewControllerWithCompletion:` method. In this controller you should ask for credentials input from the user, persist them to the keychain and invoke the completion block when done authenticating. If you need to cancel simply invoke the completion block with a `NSUserCancelledError` error code from `NSCocoaErrorDomain`.
12. If you implement the login method you should also implement the `logout` one and clean up any credentials from the keychain.

#### Notes
- If your sharing operation fails because of an authentication issue, make sure that you return an error with the `LLSpilloSharingServiceErrorDomain` error domain and `LLSpilloSharingServiceAuthenticationError` error code so that Spillo can recover from it and present the login view again.
- You shouldn’t invoke the completion block in `createLoginViewControllerWithCompletion:` until the authentication process as a whole completes.
- The view controller’s view returned by `createLoginViewControllerWithCompletion:` will be added to the content view of a window itself presented as a sheet. Layout constraints will be added to the view to make sure that the window is correctly sized. You should have non-ambiguous constrained set up in your view.
- You should codesign your plugin with a Developer ID certificate.

### Where to install the plugin

Plugins need to be installed in the application sandbox (there is a `PlugIns` directory under `~/Library/Application Support` in the sandbox). Since it can be tricky to navigate down there a menu item is available in Spillo’s help menu to quickly opening the `PlugIns` directory.

After pasting the plugin in the PlugIns directory, you will have to relaunch Spillo for it to load the plugin.

### Troubleshooting

While working on the plugin, it might be helpful setting a special user default that will report errors while loading the plugin.

```
defaults write com.ddeville.spillo developerShowPluginLoadingErrors true
```

With this on, any error happening while loading your plugin will be shown as an alert.
