import type { CSSProperties, HTMLAttributes } from 'react';
import styled from '@emotion/styled';
import { Colors } from '@/styles/colors';

interface Props extends HTMLAttributes<HTMLDivElement> {
  vertical?: boolean;
  length: CSSProperties['width'];
  color?: Colors;
}

const Divider = styled.div<Props>(({ theme, length, vertical, color }) => ({
  backgroundColor: color ? theme.colors[color] : theme.colors.gray400,
  width: vertical ? '1px' : length,
  height: vertical ? length : '1px',
}));

export default Divider;
