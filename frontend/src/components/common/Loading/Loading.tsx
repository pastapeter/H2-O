import { HTMLAttributes } from 'react';
import { css, keyframes } from '@emotion/react';
import styled from '@emotion/styled';
import { Dimmed, Portal, Typography } from '@/components/common';

interface Props extends HTMLAttributes<HTMLDivElement> {
  fullPage?: boolean;
}

function Loading({ fullPage = false, ...restProps }: Props) {
  if (!fullPage)
    return (
      <Container {...restProps}>
        <Spinner />
        <Typography font='TextKRMedium12' color='primary500'>
          데이터를 불러오는 중입니다...
        </Typography>
      </Container>
    );

  return (
    <Portal>
      <Dimmed />
      <Container fullPage={fullPage} {...restProps}>
        <Spinner />
        <Typography font='TextKRMedium12' color='lightSand'>
          데이터를 불러오는 중입니다...
        </Typography>
      </Container>
    </Portal>
  );
}

function Spinner() {
  return (
    <svg
      css={css`
        animation: ${rotate} 0.75s linear infinite;
      `}
      width='35'
      height='35'
      viewBox='0 0 35 35'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
    >
      <circle cx='17.5' cy='17.5' r='16.5' stroke='#DADCDD' strokeWidth='2' />
      <path
        d='M17.5001 20.8002C19.3226 20.8002 20.8001 19.3227 20.8001 17.5002C20.8001 15.6777 19.3226 14.2002 17.5001 14.2002C15.6775 14.2002 14.2001 15.6777 14.2001 17.5002C14.2001 19.3227 15.6775 20.8002 17.5001 20.8002Z'
        stroke='#DADCDD'
        strokeWidth='2'
      />
      <path
        d='M9.25 3.20772C11.7572 1.75721 14.6034 0.995556 17.5 1.00002C26.6129 1.00002 34 8.38707 34 17.5'
        stroke='#00AAD2'
        strokeWidth='2'
        strokeLinecap='round'
      />
      <path
        d='M7.6001 17.5002H14.2001M20.8001 17.5002H27.4001M12.5501 26.0736L15.8501 20.358M19.1501 14.6424L22.4501 8.92676M22.4501 26.0736L19.1501 20.358M15.8501 14.6424L12.5501 8.92676'
        stroke='#DADCDD'
        strokeWidth='2'
        strokeLinecap='round'
      />
      <path
        d='M22.45 26.0757C20.3699 27.2764 17.9242 27.6799 15.5687 27.2112C13.2131 26.7425 11.1083 25.4334 9.64633 23.5279C8.18435 21.6224 7.46491 19.2504 7.62206 16.8538C7.7792 14.4572 8.8022 12.1995 10.5005 10.5012C12.1988 8.80294 14.4565 7.77993 16.8531 7.62279C19.2497 7.46565 21.6217 8.18508 23.5272 9.64707C25.4327 11.109 26.7417 13.2139 27.2105 15.5694C27.6792 17.925 27.2757 20.3706 26.075 22.4507'
        stroke='#DADCDD'
        strokeWidth='2'
        strokeLinecap='round'
      />
    </svg>
  );
}

export default Loading;

const Container = styled.div<Props>`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 8px;

  z-index: 15;

  ${({ fullPage }) =>
    fullPage &&
    css`
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    `}
`;

const rotate = keyframes`
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
`;
