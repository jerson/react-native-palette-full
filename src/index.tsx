import { NativeModules } from "react-native";

const { RNPalette } = NativeModules;

export enum ISwatchType {
  vibrant = "Vibrant",
  vibrantDark = "Vibrant Dark",
  vibrantLight = "Vibrant Light",
  muted = "Video",
  mutedDark = "Muted Dark",
  mutedLight = "Muted Light"
}

export type ISwatch = {
  color: string;
  population: number;
};
export type ISwatchWithName = ISwatch & {
  name: string;
};

export interface IPalette {
  Muted: ISwatch;
  "Muted Dark": ISwatch;
  "Muted Light": ISwatch;
  Vibrant: ISwatch;
  "Vibrant Dark": ISwatch;
  "Vibrant Light": ISwatch;
}

const TAG = "[Palette]";
export default class Palette {
  static getNamedSwatchesFromUrl(url: string): Promise<IPalette> {
    __DEV__ && console.debug(TAG, "getNamedSwatchesFromUrl", url);
    return RNPalette.getNamedSwatchesFromUrl(url);
  }

  static getAllSwatchesFromUrl(url: string): Promise<ISwatchWithName[]> {
    __DEV__ && console.debug(TAG, "getAllSwatchesFromUrl", url);
    return RNPalette.getAllSwatchesFromUrl(url);
  }

  static getNamedSwatches(path: string): Promise<IPalette> {
    __DEV__ && console.debug(TAG, "getNamedSwatches", path);
    return RNPalette.getNamedSwatches(path);
  }

  static getAllSwatches(path: string): Promise<ISwatchWithName[]> {
    __DEV__ && console.debug(TAG, "getAllSwatches", path);
    return RNPalette.getAllSwatches(path);
  }
}
