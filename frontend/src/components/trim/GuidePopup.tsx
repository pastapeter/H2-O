import type { MouseEventHandler, PropsWithChildren } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Offsets } from '@/types';
import { Dimmed, Portal, Icon as _Icon } from '@/components/common';

interface Props {
  isOpen: boolean;
  offsets: Offsets;
  onClose: MouseEventHandler<HTMLDivElement | SVGSVGElement>;
}

function GuidePopup({ children, isOpen, offsets, onClose }: PropsWithChildren<Props>) {
  const theme = useTheme();
  const { offsetX, offsetY } = offsets;

  if (!isOpen) return null;

  return (
    <>
      <Portal>
        <Dimmed onClick={onClose} enableAnimation />
        <Container offsetX={offsetX} offsetY={offsetY}>
          {children}
          <GuideBox>
            <Title>
              {'현대자동차만이 \n제공하는 '}
              <span
                css={css`
                  color: ${theme.colors.activeBlue};
                `}
              >
                실활용 데이터
              </span>
              {'로\n합리적인 차량을 만들어보세요.'}
            </Title>
            <Divider />
            <Description>
              {
                'HMG Data 마크는 Hyundai Motor Group에서만 제공하는 데이터입니다.\n주행 중 운전자들이 실제로 얼마나 활용하는지를 추적해 수치화한 데이터 입니다.'
              }
            </Description>
            <Icon iconType='Cancel' onClick={onClose} color='gray800' />
          </GuideBox>
        </Container>
      </Portal>
    </>
  );
}

const Container = styled.div<Offsets>`
  position: fixed;
  top: ${({ offsetY }) => offsetY - 166}px;
  left: ${({ offsetX }) => offsetX + 16}px;
  z-index: 15;
`;

const Icon = styled(_Icon)`
  position: absolute;
  top: 17px;
  right: 17px;
  cursor: pointer;
`;

const GuideBox = styled.div`
  background-color: ${({ theme }) => theme.colors.skyBlue2};
  position: absolute;
  top: 166px;
  left: 100%;
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 324px;
  height: 206px;
  border-radius: 6px;
  margin: 0px 20px;
  padding: 20px;
  white-space: pre-line;
  z-index: 100;

  &::before {
    background: linear-gradient(45deg, ${({ theme }) => theme.colors.skyBlue2} 50%, transparent 50%);
    content: '';
    position: absolute;
    left: -9px;
    top: 45px;
    width: 18px;
    height: 18px;
    transform: rotate(45deg);
    border-bottom-left-radius: 4px;
  }
`;

const Title = styled.p`
  ${({ theme }) => theme.typography.HeadKRMedium14};

  & > span {
    color: ${({ theme }) => theme.colors.activeBlue};
  }
`;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.primary200};
  width: 36px;
  height: 1px;
`;

const Description = styled.p`
  ${({ theme }) => theme.typography.TextKRRegular12};
  color: ${({ theme }) => theme.colors.primary500};
`;

export default GuidePopup;
