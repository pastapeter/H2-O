import type { ButtonHTMLAttributes } from 'react';
import styled from '@emotion/styled';

type Props = ButtonHTMLAttributes<HTMLButtonElement>;

function ImageButton({ children, ...restProps }: Props) {
  return <StyledButton {...restProps}>{children}</StyledButton>;
}

export default ImageButton;

const StyledButton = styled.button<Props>`
  ${({ theme }) => theme.typography.TextKRMedium12}
  color: white;
  background-color: #757575;
  border-radius: 20px;
  opacity: 0.5;
  width: 76px;
  height: 28px;
`;
