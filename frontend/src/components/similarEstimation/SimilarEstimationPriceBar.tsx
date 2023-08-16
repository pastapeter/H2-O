import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Circle, Flex, Marker, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { setPriceFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';

// TODO: API 연결해서 가져오기
const MAX_PRICE = 53460000;
const MIN_PRICE = 38460000;

const SLIDER_WIDTH = 311;

interface Props {
  estimationPrice: number;
}

function SimilarEstimationPriceBar({ estimationPrice }: Props) {
  const theme = useTheme();
  const { totalPrice } = useSafeContext(SelectionContext);

  return (
    <PriceBarContainer>
      <Flex justifyContent='space-between'>
        <Typography color='gray50' font='HeadKRMedium14'>
          유사견적 가격
        </Typography>
        <PriceInfo>
          내 견적보다 &nbsp;<Typography color='activeBlue2'>{Math.abs(estimationPrice - totalPrice)}</Typography>원
          {estimationPrice >= totalPrice ? ' 비싸요.' : ' 저렴해요.'}
        </PriceInfo>
      </Flex>
      <Flex flexDirection='column' gap={4}>
        <PriceBar>
          <Marker color={theme.colors.activeBlue} css={StyleMarker(totalPrice, MIN_PRICE, MAX_PRICE - MIN_PRICE)} />
          <Marker color={theme.colors.white} css={StyleMarker(estimationPrice, MIN_PRICE, MAX_PRICE - MIN_PRICE)} />
        </PriceBar>
        <PriceRange justifyContent='space-between'>
          <span>{setPriceFormat(MIN_PRICE)}만원</span>
          <span>{setPriceFormat(MAX_PRICE)}만원</span>
        </PriceRange>
      </Flex>
      <Flex justifyContent='center' gap={16}>
        <Label isActiveBlue={true}>
          <Circle type='fill' size={8} color={theme.colors.activeBlue} />내 견적
        </Label>
        <Label isActiveBlue={false}>
          <Circle type='fill' size={8} color={theme.colors.white} />
          유사견적
        </Label>
      </Flex>
    </PriceBarContainer>
  );
}

export default SimilarEstimationPriceBar;

const PriceBarContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol};
  background-color: ${({ theme }) => theme.colors.primary700};
  border-radius: 10px;
  padding: 9.5px 16px 9px 16px;
  width: 343px;
  height: 119px;
  overflow: hidden;
`;

const PriceInfo = styled.span`
  ${({ theme }) => theme.flex.flexCenterRow};
  ${({ theme }) => theme.typography.TextKRMedium12};
  color: ${({ theme }) => theme.colors.gray50};
`;

const PriceBar = styled.div`
  position: relative;
  background-color: ${({ theme }) => theme.colors.primary400};
  border-radius: 4px;
  height: 6px;
  width: 311px;
`;

const PriceRange = styled(Flex)`
  ${({ theme }) => theme.typography.TextKRMedium10}
  color: ${({ theme }) => theme.colors.primary200};
`;

const Label = styled(Flex)<{ isActiveBlue: boolean }>`
  ${({ theme }) => theme.flex.flexCenterRow};
  ${({ theme }) => theme.typography.TextKRMedium10};
  color: ${({ theme, isActiveBlue }) => (isActiveBlue ? theme.colors.activeBlue : theme.colors.white)};
  gap: 4px;
`;

const StyleMarker = (nowPrice: number, minPrice: number, range: number) => {
  return css`
    position: absolute;
    top: 50%;
    transform: translateY(-60%);
    left: ${((nowPrice - minPrice) / range) * SLIDER_WIDTH}px;
    z-index: 1;
    pointer-events: none;
  `;
};
