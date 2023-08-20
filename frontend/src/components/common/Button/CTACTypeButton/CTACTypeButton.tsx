import { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

type ButtonSize = 'small' | 'large';
type ButtonColor = 'gray' | 'primary';

interface Props extends ButtonHTMLAttributes<HTMLButtonElement> {
  size?: ButtonSize;
  color?: ButtonColor;
}

function CTACTypeButton({ children, size = 'small', color = 'gray', ...restProps }: Props) {
  return (
    <StyledButton size={size} color={color} {...restProps}>
      {children}
    </StyledButton>
  );
}

export default CTACTypeButton;

const StyledButton = styled.button<Pick<Props, 'size' | 'color'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme }) => theme.typography.HeadKRMedium16}
  background-color: ${({ theme, color }) => (color === 'gray' ? theme.colors.gray300 : theme.colors.primary700)};
  color: ${({ theme }) => theme.colors.white};

  width: ${({ size }) => (size === 'small' ? `168px` : `336px`)};
  height: 52px;

  &:active {
    background-color: ${({ theme, color }) => (color === 'gray' ? theme.colors.gray400 : theme.colors.primary800)};
  }
`;
