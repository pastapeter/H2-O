import { HTMLAttributes, PropsWithChildren, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import HMGDetail from './utils/HMGDetail';
import type { GeneralOptionResponse, PackageOptionResponse } from '@/types/interface';
import {
  Divider,
  Flex,
  Icon,
  ImageButton,
  Typography,
  Banner as _Banner,
  PriceStaticBar as _PriceStaticBar,
} from '@/components/common';
import { usePagination } from '@/hooks';

interface Props extends HTMLAttributes<HTMLDivElement> {
  subTitle: string;
  title: string;
  imgUrl?: string;
}

function OptionBanner({ children, subTitle, title, imgUrl, ...restProps }: PropsWithChildren<Props>) {
  const [isShowImg, setIsShowImg] = useState(false); // 이미지 버튼 상태 여부
  const handleClickShowImgButton = () => {
    setIsShowImg((prev) => !prev);
  };

  return (
    <Banner isShowImg={isShowImg} {...restProps}>
      <MainContainer className='content'>
        <Typography as='h3' font='TextKRRegular14' color='gray900'>
          {subTitle}
        </Typography>
        <Typography as='h2' font='HeadKRBold32' color='primary700' className='title'>
          {title}
        </Typography>
        {children}
      </MainContainer>
      {imgUrl && <MainImg src={imgUrl} />}
      <ShowImageButton onClick={handleClickShowImgButton}>{isShowImg ? '이미지 접기' : '이미지 확인'}</ShowImageButton>
      <PriceStaticBar />
    </Banner>
  );
}

function GeneralOption({ optionInfo }: { optionInfo: GeneralOptionResponse }) {
  return (
    <OptionBanner subTitle={optionInfo.category} title={optionInfo.name} imgUrl={optionInfo.image}>
      <Typography font='TextKRRegular12' color='gray800' marginTop={8} className='description'>
        {optionInfo.description}
      </Typography>
      {optionInfo.hmgData && (
        <HMGDetail
          overHalf={optionInfo.hmgData.overHalf}
          choiceCount={optionInfo.hmgData.choiceCount}
          useCount={optionInfo.hmgData.useCount}
        />
      )}
    </OptionBanner>
  );
}

function PackageOption({ optionInfo }: { optionInfo: PackageOptionResponse }) {
  const { colors } = useTheme();
  const [componentIdx, setComponentIdx] = useState(0);

  const handleClickComponent = (idx: number) => () => {
    setComponentIdx(idx);
  };

  const pagingButtonStyle = (isLast: boolean) => css`
    fill: ${isLast ? colors.gray200 : colors.gray600};
    cursor: ${isLast ? 'not-allowed' : 'pointer'};
  `;
  const { currentSlice, isStartPage, isEndPage, startIdx, prevPage, nextPage } = usePagination({
    data: optionInfo.components?.sort((a, b) => a.name.localeCompare(b.name)) || [],
  });

  if (!optionInfo.components) return <OptionBanner subTitle={optionInfo.category} title={optionInfo.name} />;

  return (
    <OptionBanner
      subTitle={optionInfo.category}
      title={optionInfo.name}
      imgUrl={optionInfo.components[componentIdx].image}
    >
      {/* 패키지 옵션 확인 페이지네이션 */}
      <Flex gap={8} marginTop={10} alignItems='center'>
        <Icon iconType='ArrowLeft' size={24} onClick={prevPage} css={pagingButtonStyle(isStartPage)} />
        <Flex gap={16}>
          {currentSlice.map((component, idx) => (
            <StyledOptionButton
              key={startIdx + idx}
              isClicked={startIdx + idx === componentIdx}
              onClick={handleClickComponent(startIdx + idx)}
            >
              <span>{component.name}</span>
              <StyleDivder length={58} color='gray800' isClicked={startIdx + idx === componentIdx} />
            </StyledOptionButton>
          ))}
        </Flex>
        <Icon iconType='ArrowRight' size={24} onClick={nextPage} css={pagingButtonStyle(isEndPage)} />
      </Flex>
      {/* 패키지 옵션 설명 */}
      <Typography font='TextKRRegular12' color='gray800' marginTop={8} className='description'>
        {optionInfo.components[componentIdx].description}
      </Typography>
      <HMGDetail
        overHalf={optionInfo.isOverHalf}
        choiceCount={optionInfo.choiceCount}
        useCount={optionInfo.components[componentIdx].useCount}
      />
      <Typography font='TextKRRegular12' color='gray800' marginTop={8}></Typography>
    </OptionBanner>
  );
}

OptionBanner.GeneralOption = GeneralOption;
OptionBanner.PackageOption = PackageOption;
export default OptionBanner;

const Banner = styled(_Banner)<{ isShowImg: boolean }>`
  position: sticky;
  top: ${({ isShowImg }) => (isShowImg ? 0 : -250)}px;
  z-index: 10;
  background-color: ${({ theme }) => theme.colors.blueBg};
`;

const MainImg = styled.img`
  position: absolute;
  right: 0px;
  width: 632px;
  height: 360px;
  object-fit: cover;
`;

const ShowImageButton = styled(ImageButton)`
  position: absolute;
  bottom: 18px;
  left: 50%;
  transform: translateX(-50%);
`;

const PriceStaticBar = styled(_PriceStaticBar)`
  position: absolute;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
`;

const MainContainer = styled.div`
  position: relative;
  top: 72px;
  left: 0;
  width: 490px;
  height: max-content;

  .description {
    height: 36px;
    overflow: scroll;
  }
  &::-webkit-scrollbar {
    display: block;
    width: 2px;
  }

  .title {
    max-width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
`;

const StyledOptionButton = styled.div<{ isClicked: boolean }>`
  ${({ theme }) => theme.flex.flexCenterCol}
  ${({ theme, isClicked }) => (isClicked ? theme.typography.TextKRMedium14 : theme.typography.TextKRRegular14)}
  color: ${({ theme, isClicked }) => (isClicked ? theme.colors.gray800 : theme.colors.gray400)};

  span {
    max-width: 100px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
`;

const StyleDivder = styled(Divider)<{ isClicked: boolean }>`
  display: ${({ isClicked }) => !isClicked && 'none'};
  height: 2px;
`;
