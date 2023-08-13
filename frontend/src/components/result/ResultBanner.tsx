import { ChangeEventHandler, useState } from 'react';
import styled from '@emotion/styled';
import { Flex, Typography, PriceStaticBar as _PriceStaticBar, Toggle as _Toggle } from '@/components/common';

interface Props {
  trimName: string;
  exteriorImage: string;
  interiorImage: string;
}

function ResultBanner({ trimName, exteriorImage, interiorImage }: Props) {
  const [isExterior, setIsExterior] = useState(true);
  const handleChangeToggle: ChangeEventHandler<HTMLInputElement> = () => {
    setIsExterior((prev) => !prev);
  };

  const carImage = isExterior ? exteriorImage : interiorImage;
  const carImageAlt = isExterior ? '차 외장 이미지' : '차 내장 이미지';

  return (
    <Container flexDirection='column' justifyContent='center' alignItems='center'>
      <DisplayText font='DisplayText' color='white'>
        {trimName}
      </DisplayText>
      {/* TODO: 생각보다 못생겨서 보류, 민주랑 얘기해봐야함 */}
      <CarImage src={carImage} alt={carImageAlt} />
      <PriceStaticBar isComplete={true} nowPrice={4100} />
      <Toggle size='large' isChecked={isExterior} handleChangeToggle={handleChangeToggle} />
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
  object-fit: contain;
  transform: translateX(-50%);
`;
