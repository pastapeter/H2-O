import { HTMLAttributes, MouseEventHandler, useEffect, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import Slider from './Slider';
import { getTrimPriceRange } from '@/apis/trim';
import { Icon, Loading } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { setPriceFormat, toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';

interface SliderInfo {
  value: number;
  isOverPrice: boolean;
}

interface PriceRange {
  minPrice: number;
  maxPrice: number;
}

interface PriceStaticBarProps extends HTMLAttributes<HTMLDivElement> {
  isComplete?: boolean;
}

const DEFAULT_TRIM_IDX = 2;

function PriceStaticBar({ isComplete = false, ...restProps }: PriceStaticBarProps) {
  const theme = useTheme();

  const { totalPrice, selectionInfo, dispatch } = useSafeContext(SelectionContext);

  const [isActive, setIsActive] = useState(false);
  const [sliderInfo, setSliderInfo] = useState<SliderInfo | null>(null);
  const [priceRange, setPriceRange] = useState<PriceRange | null>(null);

  const handleClick: MouseEventHandler<SVGSVGElement> = () => {
    setIsActive((state) => !state);
  };

  const handleChangeSliderInfo = (targetValue: number) => {
    setSliderInfo({ isOverPrice: totalPrice > targetValue, value: targetValue });
  };

  useEffect(() => {
    if (!selectionInfo.priceRange) {
      (async function () {
        const response = await getTrimPriceRange(DEFAULT_TRIM_IDX);
        dispatch({
          type: 'SET_PRICE_RANGE',
          payload: { minPrice: response.minPrice, maxPrice: response.maxPrice },
        });

        const mean = (response.minPrice + response.maxPrice) / 2;
        setSliderInfo({
          isOverPrice: totalPrice > mean,
          value: mean,
        });

        setPriceRange({ minPrice: response.minPrice, maxPrice: response.maxPrice });
      })();

      return;
    }

    const { minPrice, maxPrice } = selectionInfo.priceRange;
    const mean = (minPrice + maxPrice) / 2;

    setSliderInfo({
      isOverPrice: totalPrice > mean,
      value: mean,
    });

    setPriceRange({ minPrice: minPrice, maxPrice: maxPrice });
  }, [selectionInfo.priceRange]);

  if (!sliderInfo || !priceRange)
    return (
      <PriceStaticBarContainer isActive={isActive}>
        <Loading />
      </PriceStaticBarContainer>
    );

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
            minPrice={priceRange.minPrice}
            maxPrice={priceRange.maxPrice}
            totalPrice={totalPrice}
            isComplete={isComplete}
            handleChangeSliderInfo={handleChangeSliderInfo}
          />
          <PriceRange>
            <span>{setPriceFormat(priceRange.minPrice)}만원</span>
            <span>{setPriceFormat(priceRange.maxPrice)}만원</span>
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
