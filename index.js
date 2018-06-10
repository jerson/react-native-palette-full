
import { NativeModules } from 'react-native';

const { RNPalette } = NativeModules;

const TAG = "[Palette]";
export default class Palette {
    static getNamedSwatchesFromUrl(url) {
    __DEV__ && console.debug(TAG, "getNamedSwatchesFromUrl",url);
      return RNPalette.getNamedSwatchesFromUrl(url);
    }
  
    static getAllSwatchesFromUrl(url) {
        __DEV__ && console.debug(TAG, "getAllSwatchesFromUrl",url);
      return RNPalette.getAllSwatchesFromUrl(url);
    }
  
    static getNamedSwatches(path) {
        __DEV__ && console.debug(TAG, "getNamedSwatches",path);
      return RNPalette.getNamedSwatches(path);
    }
  
    static getAllSwatches(path) {
        __DEV__ && console.debug(TAG, "getAllSwatches",path);
      return RNPalette.getAllSwatches(path);
    }
  }
  