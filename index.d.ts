declare module 'react-native-palette-full' {
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

  export default class Palette {
    static getNamedSwatchesFromUrl(url: string): IPalette;

    static getAllSwatchesFromUrl(url: string): ISwatch[];

    static getNamedSwatches(path: string): IPalette;

    static getAllSwatches(path: string): ISwatch[];
  }
}
