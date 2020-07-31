# ysumeng_example

Demonstrates how to use the ysumeng plugin.

## Getting Started

集成友盟的库，主要这个地方有不少坑，work around 几天.
集成的时候主要几个问题：
1. umeng的日志正常打印，后台没数据
2. plugin 插件库没进去，找不到方法
3. pageStart pageEnd 无顺序调用，异常

### 集成成功的标志，控制台看到如下日志

```json
D/MobclickAgent(27356): 
constructMessage:{"sessions":[{"id":"5BBAA1802FC7A2EFF3621F373F747348","start_time":"1596157583166","end_time":"1596158165664","duration":582498,"pages":[{"page_name":"com.yuesi.lottery_flutter.MainActivity","duration":82481,"type":1,"ts":1596157583166},{"page_name":"com.yuesi.lottery_flutter.MainActivity","duration":83922,"type":1,"ts":1596157795889},{"page_name":"com.yuesi.lottery_flutter.MainActivity","duration":281378,"type":1,"ts":1596157884286}],"traffic":{"download_traffic":36363423,"upload_traffic":12751143},"$page_num":3}],"sdk_version":"8.1.4","device_id":"e54b74fe0d2fa226","device_model":"Android SDK built for x86","version":1,"appkey":"xxx","channel":"official"}
```
能看到sessions信息了，代表通信问题不大了

---

### 安卓集成方法：
1. 集成ysumeng 库
2. 在应用的application class，做一些初始化操作，如下：

    ```java
    public class MainApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        android.util.Log.i("UMLog", "Application class.");
        android.util.Log.i("UMLog", "UMConfigure.init@MainApplication");
        com.yuesi.umeng.ysumeng.YsumengPlugin.setContext(this);//此处需要设置，否则插件找不到context.
        UMConfigure.init(this, "XXX", "official", UMConfigure.DEVICE_TYPE_PHONE, null);
        UMConfigure.setLogEnabled(true);
        MobclickAgent.setDebugMode(true);
        UMConfigure.setProcessEvent(true);
        }
    }
    ```

3. 在manifest.xml 增加必要的权限 和 meta-data
```java
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
  <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
  <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
  <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

  .... 

   <meta-data
    android:name="UMENG_APPKEY"
    android:value="5f213302d309322154731be0"/>
    <meta-data
    android:name="UMENG_CHANNEL"
    android:value="official"/>

```

 4. flutter app中引用
```dart
Future<void> initUmeng() async {
    String platformVersion = await Ysumeng.platformVersion;
}
```
    库里面提供了官方sdk的一些方法，Ysumeng.initCommon 等，初始化已经在原生的地方完成了，这个地方可有可无了.
5. 对页面onPageStart onPageEnd的调用

    * 先创建一个mixin类来进行监听
    ```dart
    
    import 'package:flutter/cupertino.dart';
    import 'package:lottery/util/log_utils.dart';
    import 'package:ysumeng/ysumeng.dart';

    mixin BasePage<T extends StatefulWidget> on State<T> {
    @override
    void initState() {
        super.initState();
        Log.d("page start:" + this.context.widget.runtimeType.toString());
        Ysumeng.onPageStart(this.context.widget.runtimeType.toString());
    }

    @override
    void dispose() {
        super.dispose();
        Log.d("page end:" + this.context.widget.runtimeType.toString());
        Ysumeng.onPageEnd(this.context.widget.runtimeType.toString());
    }
    }
    ```
```dart
    * 然后在每个StatefulWidget 页面中进行集成即可
    ```dart 
    class MorePage extends StatefulWidget {
    @override
    _MorePageState createState() => _MorePageState();
    }
    class _MorePageState extends State<MorePage> with BasePage<MorePage> {
        ...
    }

```
### 几个参考：

1. https://flutter.dev/docs/development/packages-and-plugins/developing-packages
2. https://www.jianshu.com/p/f1ed21dc2e30