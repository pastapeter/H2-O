import type { SVGProps } from 'react';
import { useTheme } from '@emotion/react';
import { Colors } from '@/styles/colors';
import { ReactComponent as MarkerIcon } from '@/assets/marker.svg';

interface Props extends SVGProps<SVGSVGElement> {
  color?: Colors;
}

function Marker({ color = 'white', ...restProps }: Props) {
  const theme = useTheme();

  return <MarkerIcon data-testid='marker' fill={theme.colors[color]} {...restProps} />;
}

export default Marker;
