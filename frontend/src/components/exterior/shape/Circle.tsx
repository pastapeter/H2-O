import type { SVGProps } from 'react';
import { ReactComponent as CircleBorder } from '@/assets/shape/circle-border.svg';
import { ReactComponent as CircleFill } from '@/assets/shape/circle-fill.svg';

interface Props extends SVGProps<SVGSVGElement> {
  type: 'fill' | 'border';
  color: string;
}

function Circle({ type, color, ...restProps }: Props) {
  return type === 'fill' ? <CircleFill fill={color} {...restProps} /> : <CircleBorder stroke={color} {...restProps} />;
}

export default Circle;
