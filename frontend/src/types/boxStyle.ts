import type { CSSProperties } from 'react';

export interface SpaceStyle {
  marginTop?: CSSProperties['marginTop'];
  marginBottom?: CSSProperties['marginBottom'];
  marginLeft?: CSSProperties['marginLeft'];
  marginRight?: CSSProperties['marginRight'];
  paddingTop?: CSSProperties['paddingTop'];
  paddingBottom?: CSSProperties['paddingBottom'];
  paddingLeft?: CSSProperties['paddingLeft'];
  paddingRight?: CSSProperties['paddingRight'];
}

export interface BoxStyle extends SpaceStyle {
  display?: CSSProperties['display'];
  width?: CSSProperties['width'];
  height?: CSSProperties['height'];
  backgroundColor?: CSSProperties['backgroundColor'];
}

export type SpaceStyleProperties = keyof SpaceStyle;
export type BoxStyleProperties = keyof BoxStyle;
