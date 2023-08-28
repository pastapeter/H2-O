import type { ChangeEventHandler, HTMLAttributes } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { SLIDER_WIDTH, STEP_SIZE } from './constants';
import '@/components/common/';
import { Marker } from '@/components/common/PriceStaticBar';

interface SliderInfo {
  value: number;
  isOverPrice: boolean;
}

interface Props extends HTMLAttributes<HTMLDivElement> {
  sliderInfo: SliderInfo;
  minPrice: number;
  maxPrice: number;
  totalPrice: number;
  isComplete: boolean;
  handleChangeSliderInfo: (targetValue: number) => void;
}

function Slider({
  sliderInfo,
  minPrice,
  maxPrice,
  totalPrice,
  isComplete,
  handleChangeSliderInfo,
  ...restProps
}: Props) {
  const handleChange: ChangeEventHandler<HTMLInputElement> = (e) => {
    const targetValue = Number(e.target.value);
    handleChangeSliderInfo(targetValue);
  };

  const preventEventDefault: ChangeEventHandler<HTMLInputElement> = (e) => {
    e.preventDefault();
  };

  return (
    <SliderContainer {...restProps}>
      <StyledSlider
        role='slider'
        type='range'
        percent={((sliderInfo.value - minPrice) / (maxPrice - minPrice)) * 100}
        isOverPrice={sliderInfo.isOverPrice}
        isComplete={isComplete}
        min={minPrice}
        max={maxPrice}
        step={STEP_SIZE}
        onChange={isComplete ? preventEventDefault : handleChange}
        value={sliderInfo.value}
        readOnly
      />
      <Marker
        color={sliderInfo.isOverPrice ? 'sand' : 'activeBlue'}
        css={MarkerStyle({ totalPrice, minPrice, maxPrice })}
      />
    </SliderContainer>
  );
}

export default Slider;

const SliderContainer = styled.div`
  ${({ theme }) => theme.flex.flexEndRow}
  align-items: center;
  position: relative;
`;

const StyledSlider = styled.input<{ percent: number; isOverPrice: boolean; isComplete: boolean }>`
  -webkit-appearance: none;

  width: ${SLIDER_WIDTH}px;
  height: 6px;
  border-radius: 4px;

  background-image: ${({ percent, theme }) =>
    `linear-gradient(90deg, ${theme.colors.white} ${percent}%, ${theme.colors.primary800} ${percent}% 100%)`};

  &::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: ${({ isComplete }) => (isComplete ? 0 : 21)}px;
    height: ${({ isComplete }) => (isComplete ? 0 : 20)}px;
    // border-radius
    background-image: ${({ isOverPrice }) =>
      isOverPrice ? `  url('/slider-thumb-over.svg')` : `  url('/slider-thumb-under.svg')`};
    cursor: pointer;
  }
`;

const MarkerStyle = ({ totalPrice, minPrice, maxPrice }: Pick<Props, 'totalPrice' | 'minPrice' | 'maxPrice'>) => {
  const range = maxPrice - minPrice;
  const leftPosition = ((totalPrice - minPrice) / range) * SLIDER_WIDTH;

  return css`
    position: absolute;
    top: 50%;
    transform: translateY(-60%);
    left: ${leftPosition}px;
    transition: left 0.3s ease-in-out;
    z-index: 1;
    pointer-events: none;
  `;
};
