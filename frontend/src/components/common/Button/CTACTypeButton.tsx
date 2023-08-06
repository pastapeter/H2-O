import { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

type ButtonSize = 'small' | 'large';
type ButtonColor = 'gray' | 'primary';

interface Props extends ButtonHTMLAttributes<HTMLButtonElement> {
  size?: ButtonSize;
  color?: ButtonColor;
  border: number[];
}

function CTACTypeButton({ children, size = 'small', color = 'gray', ...restProps }: Props) {
  return (
    <StyledButton size={size} color={color} {...restProps}>
      {children}
    </StyledButton>
  );
}

export default CTACTypeButton;

const StyledButton = styled.button<Pick<Props, 'size' | 'color' | 'border'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme }) => theme.typography.HeadKRMedium16}
  background-color: ${({ theme, color }) => (color === 'gray' ? theme.colors.gray300 : theme.colors.primary700)};
  color: ${({ theme }) => theme.colors.white};

  width: ${({ size }) => (size === 'small' ? `168px` : `336px`)};
  height: 52px;
  border-radius: ${({ border }) => `${border[0]}px ${border[1]}px ${border[2]}px ${border[3]}px`};

  &:active {
    background-color: ${({ theme, color }) => (color === 'gray' ? theme.colors.gray400 : theme.colors.primary800)};
  }
`;
