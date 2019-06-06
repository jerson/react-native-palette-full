import { NativeModules } from 'react-native';

const { RNPalette } = NativeModules;

export enum ISwatchType {
  vibrant = 'Vibrant',
  vibrantDark = 'Vibrant Dark',
  vibrantLight = 'Vibrant Light',
  muted = 'Video',
  mutedDark = 'Muted Dark',
  mutedLight = 'Muted Light',
}

export interface ISwatch {
  color: string;
}

export interface IPalette {
  [key: string]: ISwatch;
}

const TAG = '[Palette]';
export default class Palette {
  static getNamedSwatchesFromUrl(url: string): IPalette {
    __DEV__ && console.debug(TAG, 'getNamedSwatchesFromUrl', url);
    return RNPalette.getNamedSwatchesFromUrl(url);
  }

  static getAllSwatchesFromUrl(url: string): ISwatch[] {
    __DEV__ && console.debug(TAG, 'getAllSwatchesFromUrl', url);
    return RNPalette.getAllSwatchesFromUrl(url);
  }

  static getNamedSwatches(path: string): IPalette {
    __DEV__ && console.debug(TAG, 'getNamedSwatches', path);
    return RNPalette.getNamedSwatches(path);
  }

  static getAllSwatches(path: string): ISwatch[] {
    __DEV__ && console.debug(TAG, 'getAllSwatches', path);
    return RNPalette.getAllSwatches(path);
  }
}
