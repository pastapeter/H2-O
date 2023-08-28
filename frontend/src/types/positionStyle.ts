import { CSSProperties } from 'react';

export interface PositionStyle {
  position?: CSSProperties['position'];
  top?: CSSProperties['top'];
  bottom?: CSSProperties['bottom'];
  left?: CSSProperties['left'];
  right?: CSSProperties['right'];
}

export type PositionStyleProperties = keyof PositionStyle;
