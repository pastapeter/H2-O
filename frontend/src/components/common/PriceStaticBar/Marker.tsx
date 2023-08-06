import type { SVGProps } from 'react';
import { ReactComponent as MarkerIcon } from '@/assets/marker.svg';

interface Props extends SVGProps<SVGSVGElement> {
  color: string;
}

function Marker({ color, ...restProps }: Props) {
  return <MarkerIcon fill={color} {...restProps} />;
}

export default Marker;
