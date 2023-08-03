import type { SVGProps } from 'react';
import { useTheme } from '@emotion/react';
import * as icons from '@/assets/icons';

const DEFAULT_SIZE = 24;

type IconType = keyof typeof icons;

interface Props extends SVGProps<SVGSVGElement> {
  iconType: IconType;
  size?: number | string;
}

function Icon({ iconType, color, size = DEFAULT_SIZE, ...restProps }: Props) {
  const theme = useTheme();
  const Icon = icons[iconType];

  return <Icon fill={color || theme.colors.gray800} width={size} height={size} {...restProps} />;
}

export default Icon;
