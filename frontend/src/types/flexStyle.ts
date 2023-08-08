import { CSSProperties } from 'react';

export interface FlexStyle {
  flexDirection?: CSSProperties['flexDirection'];
  justifyContent?: CSSProperties['justifyContent'];
  alignItems?: CSSProperties['alignItems'];
  flexWrap?: CSSProperties['flexWrap'];
  alignContent?: CSSProperties['alignContent'];
  gap?: CSSProperties['gap'];
}

export type FlexStyleProperties = keyof FlexStyle;
