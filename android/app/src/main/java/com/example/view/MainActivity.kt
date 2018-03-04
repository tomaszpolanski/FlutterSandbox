package com.example.view

import android.content.Intent
import android.os.Bundle
import android.support.design.widget.FloatingActionButton
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.TextView
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterView
import io.reactivex.BackpressureStrategy
import io.reactivex.Flowable
import io.reactivex.android.schedulers.AndroidSchedulers

import java.util.ArrayList
import java.util.concurrent.TimeUnit

class MainActivity : AppCompatActivity() {
    private var flutterView: FlutterView? = null
    private var counter: Int = 0
    private lateinit var messageChannel: BasicMessageChannel<String>
    private var eventsPerSecond = 1

    private fun getArgsFromIntent(intent: Intent): Array<String>? {
        // Before adding more entries to this list, consider that arbitrary
        // Android applications can generate intents with extra data and that
        // there are many security-sensitive args in the binary.
        val args = ArrayList<String>()
        if (intent.getBooleanExtra("trace-startup", false)) {
            args.add("--trace-startup")
        }
        if (intent.getBooleanExtra("start-paused", false)) {
            args.add("--start-paused")
        }
        if (intent.getBooleanExtra("enable-dart-profiling", false)) {
            args.add("--enable-dart-profiling")
        }
        if (!args.isEmpty()) {
            return args.toTypedArray()
        }
        return null
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val args = getArgsFromIntent(intent)
        FlutterMain.ensureInitializationComplete(applicationContext, args)
        setContentView(R.layout.flutter_view_layout)
        val supportActionBar = supportActionBar
        supportActionBar?.hide()


//        Observable.interval(50, TimeUnit.MILLISECONDS)
//                .subscribe  {  sendAndroidIncrement()}

        flutterView = findViewById(R.id.flutter_view)
        flutterView!!.runFromBundle(FlutterMain.findAppBundlePath(applicationContext), null)

        val eventCount: TextView = findViewById(R.id.event_count)

        val shared =
                flutterEventStream.share()


        shared.observeOn(AndroidSchedulers.mainThread())
                .subscribe({ onFlutterIncrement()})
               {
                   Log.e("Flutter Error", "Error", it)
               }

        shared.window(1, TimeUnit.SECONDS)
                .flatMapSingle { it.count() }
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe { eventCount.text = "Events per second: $it" }


        val fab = findViewById<FloatingActionButton>(R.id.button)
        fab.setOnClickListener { sendAndroidIncrement() }
        fab.setOnLongClickListener {
            startActivity(Intent(applicationContext, MainFlutterActivity::class.java))
            true
        }
    }


    private val flutterEventStream get() = Flowable.create<Unit>({
        messageChannel = BasicMessageChannel(flutterView, CHANNEL, StringCodec.INSTANCE)
        messageChannel.setMessageHandler { _, reply ->
            it.onNext(Unit)
            reply.reply(EMPTY_MESSAGE)
        }
        it.setCancellable {
            messageChannel.setMessageHandler(null)
        }
    }, BackpressureStrategy.ERROR)

    private fun sendAndroidIncrement() {
        messageChannel.send("$eventsPerSecond")
        eventsPerSecond *= 2
    }

    private fun onFlutterIncrement() {
        counter++
        val textView = findViewById<TextView>(R.id.button_tap)
        val value = "Flutter button tapped " + counter + if (counter == 1) " time" else " times"
        textView.text = value
    }

    override fun onDestroy() {
        if (flutterView != null) {
            flutterView!!.destroy()
        }
        super.onDestroy()
    }

    override fun onPause() {
        super.onPause()
        flutterView!!.onPause()
    }

    override fun onPostResume() {
        super.onPostResume()
        flutterView!!.onPostResume()
    }

    companion object {
        private val CHANNEL = "increment"
        private val EMPTY_MESSAGE = ""
        private val PING = "ping"
    }
}
