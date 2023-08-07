import type { HTMLAttributes } from 'react';
import styled from '@emotion/styled';

type Props = HTMLAttributes<HTMLDivElement>;

const Dimmed = styled.div<Props>`
  background-color: ${({ theme }) => theme.colors.dimmed};
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  backdrop-filter: blur(6px);
  z-index: 10;
`;

export default Dimmed;
