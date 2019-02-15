# KTSandbox
iOS sandbox debug tool

KTSandbox是一个方便开发者调试沙盒内容的工具。  

## 如何使用  

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()        
        //在makeKeyAndVisible()后调用一行代码即可
        KTSandbox.share.enable()
        return true
    }
```  

在任意界面从右边缘往左滑，就可以看到下图的沙盒内文件：
![](https://github.com/Fidetro/KTSandbox/tree/master/src/1.jpeg)  

需要发送文件至电脑，或保存到相册时，点击左上角选择，然后多选需要发送的文件，从左边缘往右滑，就可以看到下图：
![](https://github.com/Fidetro/KTSandbox/tree/master/src/2.jpeg) 

## CocoaPod
```ruby
platform :ios, '8.0'
target 'YouApp' do
use_frameworks!
pod 'KTSandbox'
end
```
