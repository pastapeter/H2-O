import { ChangeEventHandler, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Flex, Toggle, Typography } from '@/components/common';

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

  const interiorImageStyle =
    !isExterior &&
    css`
      background-image: url(${carImage});
      background-size: cover;
    `;

  return (
    <Container css={interiorImageStyle} flexDirection='column' justifyContent='space-between' alignItems='center'>
      <Typography font='DisplayText' color='white'>
        {trimName}
      </Typography>
      {isExterior && <CarImage src={carImage} alt={carImageAlt} />}
      <Toggle size='large' isChecked={isExterior} handleChangeToggle={handleChangeToggle} />
    </Container>
  );
}

export default ResultBanner;

const Container = styled(Flex)`
  position: relative;
  width: 100%;
  height: 640px;
  padding-top: 72px;
  padding-bottom: 20px;
  background: linear-gradient(
    180deg,
    rgba(156, 202, 255, 0.9) 0%,
    rgba(201, 226, 255, 0.9) 0.01%,
    rgba(255, 255, 255, 0) 100%
  );
  transform: translateX(0);
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
