# react-native-palette-full

info about colors from images or url, compatible with **Android** and **iOS**

## Getting started

`$ npm install react-native-palette-full --save`

## Mostly automatic installation

`$ react-native link react-native-palette-full`

## Manual installation

### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-palette-full` and add `RNPalette.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNPalette.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Go to `Podfile` and add `"SDWebImage", "~>4.3.3"`
5. Run your project (`Cmd+R`)<

### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`

- Add `import me.jerson.mobile.palette.RNPalettePackage;` to the imports at the top of the file
- Add `new RNPalettePackage()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:

   ```groovy
   include ':react-native-palette-full'
   project(':react-native-palette-full').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-palette-full/android')
   ```

3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:

   ```groovy
     implementation project(':react-native-palette-full')
   ```

## Usage

```javascript
import Palette from "react-native-palette-full";

const outputColors = (colors)=>{
  console.log(colors);
};

Palette.getNamedSwatchesFromUrl(url).then(outputColors);
Palette.getAllSwatchesFromUrl(url).then(outputColors);
Palette.getNamedSwatches(path).then(outputColors);
Palette.getAllSwatches(path).then(outputColors);

```
