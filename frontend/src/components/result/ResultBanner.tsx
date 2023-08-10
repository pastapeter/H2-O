import { useState } from 'react';
import styled from '@emotion/styled';
import { Flex, Typography, PriceStaticBar as _PriceStaticBar, Toggle as _Toggle } from '@/components/common';

function ResultBanner() {
  const [isExterior, setIsExterior] = useState(true);

  return (
    <Container flexDirection='column' justifyContent='center' alignItems='center'>
      <DisplayText font='DisplayText' color='white'>
        Le Blanc
      </DisplayText>
      <CarImage src='/images/result-external.png' alt='차 외장 이미지' />
      <PriceStaticBar isComplete={true} nowPrice={4100} />
      <Toggle size='large' isChecked={isExterior} setIsChecked={setIsExterior} />
    </Container>
  );
}

export default ResultBanner;

const Container = styled(Flex)`
  position: relative;
  width: 100%;
  height: 640px;
  background: linear-gradient(
    180deg,
    rgba(156, 202, 255, 0.9) 0%,
    rgba(201, 226, 255, 0.9) 0.01%,
    rgba(255, 255, 255, 0) 100%
  );
  transform: translateX(0);
`;

const PriceStaticBar = styled(_PriceStaticBar)`
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
`;

const Toggle = styled(_Toggle)`
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
`;

const DisplayText = styled(Typography)`
  position: absolute;
  top: 72px;
  left: 50%;
  transform: translateX(-50%);
`;

const CarImage = styled.img`
  position: absolute;
  top: 203px;
  left: 50%;
  width: 764px;
  height: 360px;
  transform: translateX(-50%);
`;
