import type { CSSProperties, HTMLAttributes } from 'react';
import styled from '@emotion/styled';

interface Props extends HTMLAttributes<HTMLDivElement> {
  vertical?: boolean;
  length: CSSProperties['width'];
}

const Divider = styled.div<Props>(({ theme, length, vertical }) => ({
  backgroundColor: theme.colors.gray400,
  width: vertical ? '1px' : length,
  height: vertical ? length : '1px',
}));

export default Divider;
