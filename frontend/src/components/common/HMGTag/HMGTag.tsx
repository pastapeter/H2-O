import type { HTMLAttributes } from 'react';
import styled from '@emotion/styled';

type TagVariant = 'default' | 'small';

interface Props extends HTMLAttributes<HTMLDivElement> {
  variant?: TagVariant;
}

function HMGTag({ variant = 'default', ...restProps }: Props) {
  return (
    <Container variant={variant} {...restProps}>
      HMG Data
    </Container>
  );
}

export default HMGTag;

const Container = styled.div<Props>`
  ${({ theme }) => theme.typography.HeadENBold10}
  ${({ theme }) => theme.flex.flexCenterRow}
  background-color: ${({ theme }) => theme.colors.activeBlue2};
  color: white;
  width: 70px;
  height: 32px;

  ${({ variant }) => variant === 'small' && 'height: 20px;'}
`;
