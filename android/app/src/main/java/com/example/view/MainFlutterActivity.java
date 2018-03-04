package com.example.view;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainFlutterActivity extends FlutterActivity {

    private static final String CHANNEL = "samples.flutter.io/platform_view";
    private static final String METHOD_SWITCH_VIEW = "switchView";
    private static final int COUNT_REQUEST = 1;

    private MethodChannel.Result result;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        MainFlutterActivity.this.result = result;
                        int count = methodCall.arguments();
                        if (methodCall.method.equals(METHOD_SWITCH_VIEW)) {
                        } else {
                            result.notImplemented();
                        }
                    }
                }
                                                                         );
    }

}
