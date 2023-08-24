import { HTMLAttributes, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Slider } from './Slider';
import { getTrimPriceRange } from '@/apis/trim';
import { Flex, Icon } from '@/components/common';
import { useSafeContext, useToggle } from '@/hooks';
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
  const { totalPrice, selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const { toggle, status: isActive } = useToggle(false);
  const [sliderInfo, setSliderInfo] = useState<SliderInfo | null>(null);
  const [priceRange, setPriceRange] = useState<PriceRange | null>(null);

  const handleChangeSliderInfo = (targetValue: number) => {
    setSliderInfo({ isOverPrice: totalPrice > targetValue, value: targetValue });
  };

  const updatePriceStaicBar = (minPrice: number, maxPrice: number) => {
    const meanPrice = (minPrice + maxPrice) / 2;

    setSliderInfo({
      isOverPrice: totalPrice > meanPrice,
      value: meanPrice,
    });

    setPriceRange({ minPrice: minPrice, maxPrice: maxPrice });
  };

  useEffect(() => {
    if (selectionInfo.priceRange) {
      updatePriceStaicBar(selectionInfo.priceRange.minPrice, selectionInfo.priceRange.maxPrice);
      return;
    }

    (async function () {
      const response = await getTrimPriceRange(DEFAULT_TRIM_IDX);
      dispatch({
        type: 'SET_PRICE_RANGE',
        payload: {
          minPrice: response.minPrice,
          maxPrice: response.maxPrice,
        },
      });
    })();
  }, [selectionInfo.priceRange]);

  useEffect(() => {
    if (sliderInfo) setSliderInfo({ isOverPrice: totalPrice > sliderInfo?.value, value: sliderInfo?.value });
  }, [totalPrice]);

  if (!sliderInfo || !priceRange) return null;

  return (
    <PriceStaticBarContainer data-testid='price-static-bar' isActive={isActive} {...restProps}>
      <PriceInfo isOverPrice={sliderInfo.isOverPrice}>
        <span className='title'>예산 범위</span>
        <span className='summary'>
          설정한 예산까지{' '}
          <span className='price'>{toSeparatedNumberFormat(Math.abs(sliderInfo.value - totalPrice))}원</span>
          {sliderInfo.isOverPrice ? ' 더 들었어요.' : ' 남았어요.'}
        </span>
        <Icon iconType='ArrowDown' color='gray50' onClick={toggle} css={IconStyle(isActive)} />
      </PriceInfo>
      {isActive && (
        <Flex flexDirection='column' justifyContent='space-between' gap={8}>
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
        </Flex>
      )}
    </PriceStaticBarContainer>
  );
}

export default PriceStaticBar;

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

const PriceInfo = styled.div<{ isOverPrice: boolean }>`
  ${({ theme }) => theme.flex.flexCenterRow};
  width: 100%;
  gap: 9px;

  .title {
    ${({ theme }) => theme.typography.HeadKRMedium14}
    color: ${({ theme }) => theme.colors.gray50};
  }

  .summary {
    ${({ theme }) => theme.typography.TextKRRegular12}
    text-align: right;
    width: 218px;
  }

  .price {
    ${({ theme }) => theme.typography.TextKRMedium12}
    color: ${({ theme, isOverPrice }) => (isOverPrice ? theme.colors.sand : theme.colors.activeBlue2)};
  }
`;

const PriceRange = styled.div`
  ${({ theme }) => theme.flex.flexBetweenRow}
  ${({ theme }) => theme.typography.TextKRMedium10}
  color: ${({ theme }) => theme.colors.primary200};
`;

const IconStyle = (isActive: boolean) => {
  return css`
    transform: ${isActive && `rotate(-180deg)`};
    transition: transform 0.3s ease-in-out;
    cursor: pointer;
  `;
};
