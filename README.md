#HealthKit

### 什么是HealthKit
 - HealthKit提供了一个结构，应用可以使用它来分享健康和健身数据。HealthKit管理从不同来源获得的数据，并根据用户的偏好设置，自动将不同来源的所有数据合并起来。应用还可以获取每个来源的原始数据，然后执行自己的数据合并。

### HealthKit可以做什么
- HealthKit也可以直接与健康和健身设备一起工作。在iOS8.0中，系统可以自动将兼容的低功耗蓝牙心率仪的数据直接保存在HealthKit存储中。如果有M7运动协处理器，系统还可以自动导入计步数据。其他的设备和数据源必须要有配套的应用才可以获取数据并保存在HealthKit中

### HealthKit应用
- HealthKit提供了一个应用来帮助管理用户的健康数据。健康应用为用户展示HealthKit的数据。用户可以使用健康应用来查看、添加、删除或者管理其全部的健康和健身数据。用户还可以编辑每种数据类型的分享权限。
![HealathKit](http://od2d96feb.bkt.clouddn.com/HealthKit.png)

### HealthKit的常见问题
- HealthKit和健康应用在iPad和iPod上都不可用。HealthKit框架不能用于应用扩展。

- HealthKit的数据不会保存在iCloud中，也不会在多设备间同步。这些数据只会保存在用户的本地设备中。为了安全考虑，当设备没有解锁时，HealthKit存储的数据是加密的。

- 个人感觉HealthKit这个框架帮我们把一些要查询的信息封装好了，我们只需要去查询就好了，

> HealthKit对象主要分为2类：
特征和样本
特征对象代表一些基本不变的数据。包括用户的生日、血型和生理性别。你的应用不能保存特征数
据。用户必须通过健康应用来输入或者修改这些数据。
样本对象代表某个特定时间的数据.所有的样本对象都是[HKSample](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKSample_Class/index.html#//apple_ref/occ/cl/HKSample)的子类。它们都有下列属性
1.  Type。样本类型。例如，这可能包括一个睡眠分析样本、一个身高样本或者一个计步样本.
2.  Start date。样本的开始时间。
3.  End date。样本的结束时间。如果样本代表时间中的某一刻，结束时间和开始时间相同。如果样本代表一段时间内收集的数据，结束时间应该晚于开始时间

- 苹果为我们提供了一些写好的常量[HealthKit常量参考](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HealthKit_Constants/index.html#//apple_ref/doc/uid/TP40014710)  
- 获取步数分为两步1.获得权限  2.读取步数 
- 注意：所有HealthKit API的完成回调都在一个私有的后台队列中执行。所以在更新用户界面或者修改一些只能在主线程中处理的资源之前，应该把这些数据传回主线程。

### 单位的换算
- HealthKit使用 [HKUnit](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKUnit_Class/index.html#//apple_ref/occ/cl/HKUnit) 和 [HKQuantity](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKQuantity_Class/index.html#//apple_ref/occ/cl/HKQuantity) 类来支持单位。[HKUnit](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKUnit_Class/index.html#//apple_ref/occ/cl/HKUnit) 提供了单一单位的表示。它支持大部分的公制和英制单位，当然还包括基本单位和符合单位。基本单位代表单一的度量，例如米、磅或者秒。复合单位使用数学运算连接一个或多个基本单位，例如m/s或者lb/ft2。
- [HKUnit ](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKUnit_Class/index.html#//apple_ref/occ/cl/HKUnit)提供了便捷方法来创建HealthKit支持的所有基本单位。它还提供了构建复合单位需要的数学运算。最后，你还可以通过直接使用恰当的格式化的单位字符串来创建复合单位。可参考参见[HKUnit Class Reference](https://developer.apple.com/library/prerelease/ios/documentation/HealthKit/Reference/HKUnit_Class/index.html#//apple_ref/doc/uid/TP40014727)。