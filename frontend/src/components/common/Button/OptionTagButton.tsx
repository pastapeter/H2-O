import type { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

type Props = ButtonHTMLAttributes<HTMLButtonElement>;

function OptionTagButton({ children, ...restProps }: Props) {
  return <StyledButton {...restProps}>{children}</StyledButton>;
}

export default OptionTagButton;

const StyledButton = styled.button<Props>`
  ${({ theme }) => theme.typography.TextKRMedium14}
  background-color: ${({ theme }) => theme.colors.skyBlueCardBg};
  color: ${({ theme }) => theme.colors.primary500};
  padding: 6px 20px;
  border-radius: 20px;
  border: 1px solid ${({ theme }) => theme.colors.skyBlue};

  &:hover {
    background-color: transparent;
  }

  &:active {
    background-color: ${({ theme }) => theme.colors.primary100};
  }

  &:disabled {
    color: ${({ theme }) => theme.colors.gray600};
    background-color: transparent;
    border-color: ${({ theme }) => theme.colors.gray200};
    cursor: not-allowed;
  }
`;
