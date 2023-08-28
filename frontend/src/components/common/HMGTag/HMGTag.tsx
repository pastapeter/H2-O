import type { HTMLAttributes } from 'react';
import styled from '@emotion/styled';
import { Flex } from '@/components/common';

type TagVariant = 'default' | 'small';

interface Props extends HTMLAttributes<HTMLDivElement> {
  variant?: TagVariant;
}

function HMGTag({ variant = 'default', ...restProps }: Props) {
  return (
    <Container alignItems='center' justifyContent='center' variant={variant} {...restProps}>
      HMG Data
    </Container>
  );
}

export default HMGTag;

const Container = styled(Flex)<Props>`
  ${({ theme }) => theme.typography.HeadENBold10}
  background-color: ${({ theme }) => theme.colors.activeBlue2};
  color: ${({ theme }) => theme.colors.white};
  width: 70px;
  height: ${({ variant }) => (variant === 'small' ? 20 : 32)}px;
`;
