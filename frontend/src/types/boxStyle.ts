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
  position?: CSSProperties['position'];
  display?: CSSProperties['display'];
  width?: CSSProperties['width'];
  height?: CSSProperties['height'];
}

export type SpaceStyleProperties = keyof SpaceStyle;
export type BoxStyleProperties = keyof BoxStyle;
