import type { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

interface Props extends ButtonHTMLAttributes<HTMLButtonElement> {
  isClicked?: boolean;
}

function CategoryButton({ children, isClicked = false, ...restProps }: Props) {
  return (
    <StyledButton isClicked={isClicked} {...restProps}>
      {children}
    </StyledButton>
  );
}

export default CategoryButton;

const StyledButton = styled.button<Props>`
  ${({ theme }) => theme.typography.TextKRMedium14}
  background-color: ${({ theme, isClicked }) => (isClicked ? theme.colors.skyBlueCardBg : theme.colors.white)};
  color: ${({ theme, isClicked }) => (isClicked ? theme.colors.primary500 : theme.colors.gray600)};
  padding: 6px 20px;
  border: 1px solid ${({ theme, isClicked }) => (isClicked ? theme.colors.skyBlue : theme.colors.gray200)};
  border-radius: 20px;

  &:hover {
    color: ${({ theme }) => theme.colors.primary500};
    border: 1px solid ${({ theme }) => theme.colors.skyBlue};
    background-color: ${({ theme, isClicked }) => !isClicked && theme.colors.white};
  }

  &:active {
    background-color: ${({ theme }) => theme.colors.primary100};
  }
`;
