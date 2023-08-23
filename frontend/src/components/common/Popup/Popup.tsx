import { HTMLAttributes, MouseEventHandler, PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { Dimmed, Portal } from '@/components/common';

interface Props extends HTMLAttributes<HTMLDivElement> {
  size?: 'small' | 'large';
  handleClickDimmed: MouseEventHandler<HTMLDivElement>;
}

function Popup({ children, size = 'small', handleClickDimmed, ...restProps }: PropsWithChildren<Props>) {
  return (
    <Portal>
      <Dimmed data-testid='dimmed' onClick={handleClickDimmed} {...restProps} />
      <PopupContainer role='dialog' size={size} {...restProps}>
        {children}
      </PopupContainer>
    </Portal>
  );
}

export default Popup;

export const PopupContainer = styled.div<Pick<Props, 'size'>>`
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: ${({ theme }) => theme.colors.white};
  border-radius: ${({ size }) => (size === 'small' ? 4 : 8)}px;
  width: ${({ size }) => (size === 'small' ? 336 : 850)}px;
  height: ${({ size }) => (size === 'small' ? 200 : 520)}px;
  overflow: hidden;
  z-index: 20;
`;
