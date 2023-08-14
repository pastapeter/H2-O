import { HTMLAttributes, MouseEventHandler, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import Slider from './Slider';
import { Icon } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { setPriceFormat, toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';

// TODO: API 연결해서 가져오기
const MAX_PRICE = 53460000;
const MIN_PRICE = 38460000;

interface SliderInfo {
  value: number;
  isOverPrice: boolean;
}

interface PriceStaticBarProps extends HTMLAttributes<HTMLDivElement> {
  isComplete?: boolean;
}

// 사용법: <PriceStaticBar isComplete={true} nowPrice={4100} />

function PriceStaticBar({ isComplete = false, ...restProps }: PriceStaticBarProps) {
  const theme = useTheme();

  const { totalPrice } = useSafeContext(SelectionContext);

  const [isActive, setIsActive] = useState(false);
  const [sliderInfo, setSliderInfo] = useState<SliderInfo>({
    isOverPrice: totalPrice > (MIN_PRICE + MAX_PRICE) / 2,
    value: (MIN_PRICE + MAX_PRICE) / 2,
  });

  const handleClick: MouseEventHandler<SVGSVGElement> = () => {
    setIsActive((state) => !state);
  };

  return (
    <PriceStaticBarContainer isActive={isActive} {...restProps}>
      <PriceInfo>
        <Title>예산 범위</Title>
        <Summary>
          설정한 예산까지 &nbsp;
          <Price isOverPrice={sliderInfo.isOverPrice}>
            {toSeparatedNumberFormat(Math.abs(sliderInfo.value - totalPrice))}원
          </Price>
          &nbsp;{sliderInfo.isOverPrice ? '더 들었어요.' : '남았어요.'}
        </Summary>
        <Icon
          iconType='ArrowDown'
          color={theme.colors.gray50}
          onClick={handleClick}
          css={css`
            cursor: pointer;
            transform: ${isActive && `rotate(-180deg)`};
          `}
        />
      </PriceInfo>
      {isActive && (
        <StyledActive>
          <Slider
            sliderInfo={sliderInfo}
            minPrice={MIN_PRICE}
            maxPrice={MAX_PRICE}
            totalPrice={totalPrice}
            isComplete={isComplete}
            setSliderInfo={setSliderInfo}
          />
          <PriceRange>
            <span>{setPriceFormat(MIN_PRICE)}만원</span>
            <span>{setPriceFormat(MAX_PRICE)}만원</span>
          </PriceRange>
        </StyledActive>
      )}
    </PriceStaticBarContainer>
  );
}

const PriceStaticBarContainer = styled.div<{ isActive: boolean }>`
  ${({ theme }) => theme.flex.flexBetweenCol};
  background-color: ${({ theme }) => theme.colors.primary700};
  color: ${({ theme }) => theme.colors.gray50};
  border-radius: 10px;
  padding: ${({ isActive }) => (isActive ? `8.5px 16px 14px 16px` : `8.5px 16px 7.5px 16px`)};
  width: 343px;
  height: ${({ isActive }) => (isActive ? 97 : 40)}px;
  overflow: hidden;
`;

const PriceInfo = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow};
  width: 100%;
  gap: 9px;
`;

const Title = styled.span`
  ${({ theme }) => theme.typography.HeadKRMedium14}
  color: ${({ theme }) => theme.colors.gray50};
`;

const Summary = styled.span`
  ${({ theme }) => theme.typography.TextKRRegular12}
  text-align: right;
  width: 218px;
`;

const Price = styled.span<Pick<SliderInfo, 'isOverPrice'>>`
  ${({ theme }) => theme.typography.TextKRMedium12}
  color: ${({ theme, isOverPrice }) => (isOverPrice ? theme.colors.sand : theme.colors.activeBlue2)};
`;

const StyledActive = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol}
  gap:4px;
`;

const PriceRange = styled.div`
  ${({ theme }) => theme.flex.flexBetweenRow}
  ${({ theme }) => theme.typography.TextKRMedium10}
  color: ${({ theme }) => theme.colors.primary200};
`;

export default PriceStaticBar;
