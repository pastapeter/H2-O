import { HTMLAttributes, MouseEventHandler, PropsWithChildren, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import HMGDetail from './utils/HMGDetail';
import type { DetailedOptionResponse, DetailedPackageOptionResponse } from '@/types/interface';
import { Banner, Divider, Flex, Icon, ImageButton, PriceStaticBar, Typography } from '@/components/common';
import { usePagination } from '@/hooks';

interface Props extends HTMLAttributes<HTMLDivElement> {
  optionInfo: DetailedOptionResponse | DetailedPackageOptionResponse;
  hasHMGData: boolean;
}

const isPackageOption = (
  optionInfo: DetailedOptionResponse | DetailedPackageOptionResponse,
): optionInfo is DetailedPackageOptionResponse => {
  return typeof optionInfo === 'object' && Object.prototype.hasOwnProperty.call(optionInfo, 'components');
};

function OptionBanner({ optionInfo, hasHMGData, ...restProps }: PropsWithChildren<Props>) {
  const [isCheckImg, setIsCheckImg] = useState(false);
  const [packageIdx, setPackageIdx] = useState(0);
  const { colors } = useTheme();
  const pagingButtonStyle = (isLast: boolean) => css`
    fill: ${isLast ? colors.gray200 : colors.gray600};
    cursor: ${isLast ? 'not-allowed' : 'pointer'};
  `;
  const { currentSlice, isStartPage, isEndPage, startIdx, prevPage, nextPage } = usePagination({
    data: isPackageOption(optionInfo) ? optionInfo.components : [],
  });

  const handleClickButton: MouseEventHandler<HTMLButtonElement> = () => {
    setIsCheckImg((prev) => !prev);
  };
  const handlePackageOption = (idx: number) => () => {
    setPackageIdx(idx);
  };

  return (
    <StyledOptionBanner isCheckImg={isCheckImg} {...restProps}>
      <Flex position='absolute' display='flex' justifyContent='flex-end' width={`100%`}>
        <MainContainer>
          <Typography as='h3' font='TextKRRegular14' color='gray900'>
            {optionInfo.category}
          </Typography>
          <Typography as='h2' font='HeadKRBold32' color='primary700'>
            {optionInfo.name}
          </Typography>
          {isPackageOption(optionInfo) && (
            // 패키지 옵션일 경우 옵션 버튼
            <Flex gap={8} marginTop={10} alignItems='center'>
              <Icon iconType='ArrowLeft' size={24} onClick={prevPage} css={pagingButtonStyle(isStartPage)} />
              <Flex gap={16}>
                {currentSlice.map((packageOption, idx) => (
                  <StyledOptionButton
                    key={startIdx + idx}
                    isClicked={startIdx + idx === packageIdx}
                    onClick={handlePackageOption(startIdx + idx)}
                  >
                    {packageOption.name}
                    <StyleDivder length={58} color='gray800' isClicked={startIdx + idx === packageIdx} />
                  </StyledOptionButton>
                ))}
              </Flex>
              <Icon iconType='ArrowRight' size={24} onClick={nextPage} css={pagingButtonStyle(isEndPage)} />
            </Flex>
          )}
          <Typography font='TextKRRegular12' color='gray800' marginTop={8}>
            {isPackageOption(optionInfo) ? optionInfo.components[packageIdx].description : optionInfo.description}
          </Typography>
          {hasHMGData && isPackageOption(optionInfo) && <HMGDetail {...optionInfo.components[packageIdx].hmgData} />}
          {hasHMGData && !isPackageOption(optionInfo) && <HMGDetail {...optionInfo.hmgData} />}
        </MainContainer>
      </Flex>
      <MainImg src={isPackageOption(optionInfo) ? optionInfo.components[packageIdx].image : optionInfo.image} />
      <StyledImageButton onClick={handleClickButton}>{isCheckImg ? '이미지 접기' : '이미지 확인'}</StyledImageButton>
      <StyledPriceStaticBar isComplete={false} nowPrice={4100} isCheckImg={isCheckImg} />
    </StyledOptionBanner>
  );
}

export default OptionBanner;

const StyledOptionBanner = styled(Banner)<{ isCheckImg: boolean }>`
  position: sticky;
  top: ${({ isCheckImg }) => (isCheckImg ? 0 : -250)}px;
  z-index: 10;
  background-color: ${({ theme }) => theme.colors.blueBg};
`;

const MainImg = styled.img`
  position: absolute;
  right: -128px;
  width: 632px;
  height: 360px;
  object-fit: cover;
`;

const StyledImageButton = styled(ImageButton)`
  position: absolute;
  bottom: 18px;
  left: 50%;
  transform: translateX(-50%);
`;

const StyledPriceStaticBar = styled(PriceStaticBar)<{ isCheckImg: boolean }>`
  position: absolute;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
`;

const MainContainer = styled.div`
  position: absolute;
  top: 72px;
  left: 0;
  width: 490px;
`;

const StyledOptionButton = styled.div<{ isClicked: boolean }>`
  ${({ theme }) => theme.flex.flexCenterCol}
  ${({ theme, isClicked }) => (isClicked ? theme.typography.TextKRMedium14 : theme.typography.TextKRRegular14)}
  color: ${({ theme, isClicked }) => (isClicked ? theme.colors.gray800 : theme.colors.gray400)};
`;

const StyleDivder = styled(Divider)<{ isClicked: boolean }>`
  display: ${({ isClicked }) => !isClicked && 'none'};
  height: 2px;
`;
