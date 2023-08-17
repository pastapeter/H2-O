import type { ChangeEventHandler } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import Marker from './Marker';

const SLIDER_WIDTH = 311;
const STEP_SIZE = 100000;

interface SliderInfo {
  value: number;
  isOverPrice: boolean;
}

interface Props {
  sliderInfo: SliderInfo;
  minPrice: number;
  maxPrice: number;
  totalPrice: number;
  isComplete: boolean;
  handleChangeSliderInfo: (targetValue: number) => void;
}

function Slider({ sliderInfo, minPrice, maxPrice, totalPrice, isComplete, handleChangeSliderInfo }: Props) {
  const RANGE = maxPrice - minPrice;
  const theme = useTheme();

  const handleChange: ChangeEventHandler<HTMLInputElement> = (e) => {
    const targetValue = Number(e.target.value);
    handleChangeSliderInfo(targetValue);
  };

  const preventEventDefault: ChangeEventHandler<HTMLInputElement> = (e) => {
    e.preventDefault();
  };

  return (
    <SliderContainer>
      <StyledSlider
        type='range'
        percent={((sliderInfo.value - minPrice) / RANGE) * 100}
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
        color={sliderInfo.isOverPrice ? theme.colors.sand : theme.colors.activeBlue}
        css={css`
          position: absolute;
          top: 50%;
          transform: translateY(-60%);
          left: ${((totalPrice - minPrice) / RANGE) * SLIDER_WIDTH}px;
          z-index: 1;
          pointer-events: none;
        `}
      />
    </SliderContainer>
  );
}

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
    background-image: ${({ isOverPrice }) =>
      isOverPrice ? `  url('/slider-thumb-over.svg')` : `  url('/slider-thumb-under.svg')`};
    cursor: pointer;
  }
`;

export default Slider;
