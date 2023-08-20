import type { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

type Props = ButtonHTMLAttributes<HTMLButtonElement>;

function PriceSummaryButton({ children, ...restProps }: Props) {
  return <StyledButton {...restProps}>{children}</StyledButton>;
}

export default PriceSummaryButton;

const StyledButton = styled.button<Props>`
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.primary500};
  border: 1px solid ${({ theme }) => theme.colors.primary300};
  background-color: transparent;
  padding: 6px 16px;
  border-radius: 30px;

  &:hover {
    background-color: ${({ theme }) => theme.colors.skyBlueCardBg};
  }

  &:active {
    background-color: ${({ theme }) => theme.colors.primary500};
    color: white;
  }

  &:disabled {
    color: ${({ theme }) => theme.colors.gray600};
    background-color: transparent;
    border-color: ${({ theme }) => theme.colors.gray200};
    cursor: not-allowed;
  }
`;
