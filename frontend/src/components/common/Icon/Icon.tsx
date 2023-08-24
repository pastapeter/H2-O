import type { SVGProps } from 'react';
import { useTheme } from '@emotion/react';
import { Colors } from '@/styles/colors';
import * as icons from '@/assets/icons';

const DEFAULT_SIZE = 24;

type IconType = keyof typeof icons;

interface Props extends SVGProps<SVGSVGElement> {
  iconType: IconType;
  size?: number | string;
  color?: Colors;
}

function Icon({ iconType, color = 'gray800', size = DEFAULT_SIZE, ...restProps }: Props) {
  const { colors } = useTheme();
  const Icon = icons[iconType];

  return <Icon data-testid={iconType} fill={colors[color]} width={size} height={size} {...restProps} />;
}

export default Icon;
