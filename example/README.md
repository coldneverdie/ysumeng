# ysumeng_example

Demonstrates how to use the ysumeng plugin.

## Getting Started

集成友盟的库，主要这个地方有不少坑，work around 几天.
集成的时候主要几个问题：
1. umeng的日志正常打印，后台没数据
2. plugin 插件库没进去，找不到方法
3. pageStart pageEnd 无顺序调用，异常

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


### 几个参考：

1. https://flutter.dev/docs/development/packages-and-plugins/developing-packages
2. https://www.jianshu.com/p/f1ed21dc2e30