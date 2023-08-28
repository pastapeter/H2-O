import type { HTMLAttributes } from 'react';
import { css, keyframes } from '@emotion/react';
import styled from '@emotion/styled';

interface Props extends HTMLAttributes<HTMLDivElement> {
  enableAnimation?: boolean;
}

const Dimmed = styled.div<Props>`
  background-color: ${({ theme }) => theme.colors.dimmed};
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  backdrop-filter: blur(6px);
  z-index: 10;

  ${({ enableAnimation }) =>
    enableAnimation &&
    css`
      animation: ${dimmedAnimation} 1s ease;
    `}
`;

export default Dimmed;

const dimmedAnimation = keyframes`
  from {
    opacity: 0;
  }
  to {
    opacity: 1;

  }
`;
