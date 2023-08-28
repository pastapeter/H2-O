import type { ButtonHTMLAttributes, MouseEventHandler } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';

type ButtonSize = 'small' | 'medium' | 'large';

interface Props extends ButtonHTMLAttributes<HTMLButtonElement> {
  isFull?: boolean;
  size?: ButtonSize;
}

function CTAButton({ children, size = 'medium', onClick, ...restProps }: Props) {
  const handleClick: MouseEventHandler<HTMLButtonElement> = (e) => {
    onClick?.(e);
    const target = e.currentTarget;
    target.style.pointerEvents = 'none';

    setTimeout(() => {
      target.style.pointerEvents = 'auto';
    }, 500);
  };

  return (
    <StyledButton size={size} onClick={handleClick} {...restProps}>
      {children}
    </StyledButton>
  );
}

export default CTAButton;

const StyledButton = styled.button<Pick<Props, 'size' | 'isFull'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme }) => theme.typography.TextKRMedium16}
  background-color: ${({ theme }) => theme.colors.primary700};
  color: ${({ theme }) => theme.colors.white};
  border-radius: 4px;

  ${({ theme, size }) => {
    switch (size) {
      case 'small':
        return css`
          width: 220px;
          height: 36px;
        `;
      case 'medium':
        return css`
          ${theme.typography.HeadKRMedium16}
          width: 340px;
          height: 44px;
        `;
      case 'large':
        return css`
          width: 850px;
          height: 52px;
        `;
    }
  }}

  ${({ isFull }) =>
    isFull &&
    css`
      width: 100%;
    `}

  &:hover {
    background-color: ${({ theme }) => theme.colors.primary500};
  }

  &:active {
    background-color: ${({ theme }) => theme.colors.primary800};
  }

  &:disabled {
    background-color: ${({ theme }) => theme.colors.gray300};
    cursor: not-allowed;
  }
`;
