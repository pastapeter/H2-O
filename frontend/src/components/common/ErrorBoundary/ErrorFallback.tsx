import styled from '@emotion/styled';
import Lottie from 'lottie-light-react';
import { Flex, Typography } from '@/components/common';
import errorLottie from '@/assets/lotties/error.json';

interface Props {
  error: Error;
  resetErrorBoundary: (...args: unknown[]) => void;
}

export function ErrorFallback({ error, resetErrorBoundary }: Props) {
  return (
    <Container flexDirection='column' justifyContent='center' alignItems='center' gap={12} role='alert'>
      <Lottie style={lottieStyle} animationData={errorLottie} />
      <Typography font='HeadKRMedium22'>{error.message}</Typography>
      <Button onClick={resetErrorBoundary}>다시 시도해보기</Button>
    </Container>
  );
}

const Container = styled(Flex)`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: ${({ theme }) => theme.colors.primary500};
  color: ${({ theme }) => theme.colors.white};
`;

const Button = styled.button`
  ${({ theme }) => theme.typography.TextKRMedium16}
  display: flex;
  justify-content: center;
  align-items: center;
  width: 250px;
  padding: 12px 0;
  border-radius: 4px;
  background-color: ${({ theme }) => theme.colors.white};
  color: ${({ theme }) => theme.colors.primary500};
`;

const lottieStyle = {
  height: 250,
};
