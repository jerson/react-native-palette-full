declare module 'react-native-palette-full' {
  export enum ISwatchType {
    vibrant = 'Vibrant',
    vibrantDark = 'Vibrant Dark',
    vibrantLight = 'Vibrant Light',
    muted = 'Video',
    mutedDark = 'Muted Dark',
    mutedLight = 'Muted Light',
  }

  export type ISwatch={
    color: string;
    population : number;
  }
  export type ISwatchWithName= ISwatch & {
    name:string;
  }

  export interface IPalette {
    "Muted": ISwatch,
    "Muted Dark": ISwatch,
    "Muted Light": ISwatch,
    "Vibrant": ISwatch,
    "Vibrant Dark": ISwatch,
    "Vibrant Light": ISwatch,
  }


  export default class Palette {
    static getNamedSwatchesFromUrl(url: string): Promise<IPalette>;

    static getAllSwatchesFromUrl(url: string): Promise<ISwatchWithName[]>;

    static getNamedSwatches(path: string): Promise<IPalette>;

    static getAllSwatches(path: string): Promise<ISwatchWithName[]>;
  }
}