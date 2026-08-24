package com.shadowray.warp

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.shadowray.warp.vpn.TunnelBus

class MainActivity : FlutterActivity() {

    private var plugin: ShadowRayPlugin? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        TunnelBus.bindService(applicationContext)

        plugin = ShadowRayPlugin(
            activity = this,
            messenger = flutterEngine.dartExecutor.binaryMessenger,
        ).also { it.attach() }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (plugin?.onActivityResult(requestCode, resultCode) == true) return
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        if (plugin?.onRequestPermissionsResult(requestCode, grantResults) == true) return
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onDestroy() {
        plugin?.detach()
        plugin = null
        super.onDestroy()
    }
}
