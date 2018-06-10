
package me.jerson.mobile.palette;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.net.Uri;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.v7.graphics.Palette;
import android.util.Log;

import com.facebook.common.executors.CallerThreadExecutor;
import com.facebook.common.references.CloseableReference;
import com.facebook.datasource.DataSource;
import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.imagepipeline.datasource.BaseBitmapDataSubscriber;
import com.facebook.imagepipeline.image.CloseableImage;
import com.facebook.imagepipeline.request.ImageRequest;
import com.facebook.imagepipeline.request.ImageRequestBuilder;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import java.util.List;
import java.util.Locale;

public class RNPaletteModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private Handler mainHandler;

  public RNPaletteModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.mainHandler = new Handler(this.reactContext.getMainLooper());

  }

  @Override
  public String getName() {
    return "RNPalette";
  }

    private String intToRGBA(int color) {
        return String.format("#%06X", (0xFFFFFF & color));
       // return String.format(Locale.ENGLISH,"rgba(%d,%d,%d,%.2f)", Color.red(color), Color.green(color), Color.blue(color), (float) (Color.alpha(color)) / 255.0);
    }


    @Nullable
    private Palette getPalletFromBitmap(Bitmap bitmap, Promise promise) {
        if (bitmap == null) {
            promise.reject("500", "Bitmap Null");
        } else if (bitmap.isRecycled()) {
            promise.reject("500", "Bitmap Recycled");
        }
        if (bitmap != null) {
            return Palette.from(bitmap).generate();
        }
        return null;
    }

    private WritableMap convertSwatch(Palette.Swatch swatch) {

        if (swatch == null) {
            return null;
        }
        WritableMap swatchMap = Arguments.createMap();
        swatchMap.putString("color", intToRGBA(swatch.getRgb()));
        swatchMap.putInt("population", swatch.getPopulation());
        swatchMap.putString("titleTextColor", intToRGBA(swatch.getTitleTextColor()));
        swatchMap.putString("bodyTextColor", intToRGBA(swatch.getBodyTextColor()));
        swatchMap.putString("swatchInfo", swatch.toString());
        return swatchMap;
    }

    @ReactMethod
    public void getNamedSwatchesFromUrl(String url, final Promise promise) {
        try {
            Uri uri = Uri.parse(url);
            ImageRequest request = ImageRequestBuilder.newBuilderWithSource(uri)
                    .setLowestPermittedRequestLevel(ImageRequest.RequestLevel.FULL_FETCH)
                    .setProgressiveRenderingEnabled(false)
                    .build();
            final DataSource<CloseableReference<CloseableImage>> dataSource = Fresco.getImagePipeline().fetchDecodedImage(request, this.reactContext);
            dataSource.subscribe(new BaseBitmapDataSubscriber() {
                @Override
                public void onNewResultImpl(@Nullable final Bitmap bitmap) {

                    getNamedSwatchesFromBitmap(bitmap, promise);
//                    if (mainHandler == null) {
//                        return;
//                    }
//                    Runnable myRunnable = new Runnable() {
//                        @Override
//                        public void run() {
//                            getNamedSwatchesFromBitmap(bitmap, promise);
//                        }
//                    };
//
//                    mainHandler.post(myRunnable);
                    if (dataSource != null && !dataSource.isClosed()) {
                        dataSource.close();
                    }
                    Log.d(TAG, "BaseBitmapDataSubscriber onNewResultImpl");

                }

                @Override
                public void onFailureImpl(DataSource dataSource) {

                    promise.reject("500", "Bitmap Error");
//                    if (mainHandler == null) {
//                        return;
//                    }
//                    Runnable myRunnable = new Runnable() {
//                        @Override
//                        public void run() {
//                            promise.reject("500", "Bitmap Error");
//                        }
//                    };
//                    mainHandler.post(myRunnable);

                    if (dataSource != null && !dataSource.isClosed()) {
                        dataSource.close();
                    }

                    Log.d(TAG, "BaseBitmapDataSubscriber onFailureImpl");
                }
            }, CallerThreadExecutor.getInstance());
        } catch (Exception e) {
            Log.w(TAG, "loadImage", e);
        }

    }


    @ReactMethod
    public void getAllSwatchesFromUrl(String url, final Promise promise) {
        try {
            Uri uri = Uri.parse(url);
            ImageRequest request = ImageRequestBuilder.newBuilderWithSource(uri)
                    .setLowestPermittedRequestLevel(ImageRequest.RequestLevel.FULL_FETCH)
                    .setProgressiveRenderingEnabled(false)
                    .build();
            final DataSource<CloseableReference<CloseableImage>> dataSource = Fresco.getImagePipeline().fetchDecodedImage(request, this.reactContext);
            dataSource.subscribe(new BaseBitmapDataSubscriber() {
                @Override
                public void onNewResultImpl(@Nullable final Bitmap bitmap) {

                    getAllSwatchesFromBitmap(bitmap, promise);
//                    if (mainHandler == null) {
//                        return;
//                    }
//                    Runnable myRunnable = new Runnable() {
//                        @Override
//                        public void run() {
//                            getAllSwatchesFromBitmap(bitmap, promise);
//                        }
//                    };
//                    mainHandler.post(myRunnable);

                    if (dataSource != null && !dataSource.isClosed()) {
                        dataSource.close();
                    }
                    Log.d(TAG, "BaseBitmapDataSubscriber onNewResultImpl");
                }

                @Override
                public void onFailureImpl(DataSource dataSource) {

                    promise.reject("500", "Bitmap Error");
//                    if (mainHandler == null) {
//                        return;
//                    }
//                    Runnable myRunnable = new Runnable() {
//                        @Override
//                        public void run() {
//                            promise.reject("500", "Bitmap Error");
//                        }
//                    };
//                    mainHandler.post(myRunnable);

                    if (dataSource != null && !dataSource.isClosed()) {
                        dataSource.close();
                    }

                    Log.d(TAG, "BaseBitmapDataSubscriber onFailureImpl");
                }
            }, CallerThreadExecutor.getInstance());
        } catch (Exception e) {
            Log.w(TAG, "loadImage", e);
        }

    }

    @ReactMethod
    public void getNamedSwatches(String realPath, Promise promise) {
        Bitmap bitmap = BitmapFactory.decodeFile(realPath);
        getNamedSwatchesFromBitmap(bitmap, promise);

    }

    @ReactMethod
    public void getAllSwatches(String realPath, Promise promise) {
        Bitmap bitmap = BitmapFactory.decodeFile(realPath);
        getAllSwatchesFromBitmap(bitmap, promise);

    }

    private void getNamedSwatchesFromBitmap(Bitmap bitmap, Promise promise) {
        Palette palette = getPalletFromBitmap(bitmap, promise);
        if (palette != null) {
            WritableMap swatches = Arguments.createMap();

            swatches.putMap("Vibrant", convertSwatch(palette.getVibrantSwatch()));
            swatches.putMap("Vibrant Dark", convertSwatch(palette.getDarkVibrantSwatch()));
            swatches.putMap("Vibrant Light", convertSwatch(palette.getLightVibrantSwatch()));
            swatches.putMap("Muted", convertSwatch(palette.getMutedSwatch()));
            swatches.putMap("Muted Dark", convertSwatch(palette.getDarkMutedSwatch()));
            swatches.putMap("Muted Light", convertSwatch(palette.getLightMutedSwatch()));

            promise.resolve(swatches);
        }
    }

    private void getAllSwatchesFromBitmap(Bitmap bitmap, Promise promise) {

        Palette palette = getPalletFromBitmap(bitmap, promise);
        if (palette != null) {
            WritableArray aSwatches = Arguments.createArray();
            List<Palette.Swatch> swatches = palette.getSwatches();
            for (Palette.Swatch swatch : swatches) {
                aSwatches.pushMap(convertSwatch(swatch));
            }
            promise.resolve(aSwatches);
        }
    }
}