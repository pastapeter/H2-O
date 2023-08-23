import type { SVGProps } from 'react';
import { ReactComponent as CircleBorder } from '@/assets/shape/circle-border.svg';
import { ReactComponent as CircleFill } from '@/assets/shape/circle-fill.svg';

interface Props extends SVGProps<SVGSVGElement> {
  type: 'fill' | 'border';
  color?: string;
  size?: number;
}

function Circle({ type, color, size, ...restProps }: Props) {
  return type === 'fill' ? (
    <CircleFill fill={color} width={size ? size : 46} height={size ? size : 46} {...restProps} />
  ) : (
    <CircleBorder stroke={color} width={size ? size : 58} height={size ? size : 58} {...restProps} />
  );
}

export default Circle;
