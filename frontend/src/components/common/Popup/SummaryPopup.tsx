import { Dispatch, MouseEventHandler, SetStateAction, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { CTAButton, Dimmed, Icon, Portal } from '..';
import { Toggle } from '../Toggle';
import { useSafeContext } from '@/hooks';
import { SlideContext } from '@/providers/SlideProvider';
import ExTeriorIMG from '@/assets/car-images/exterior.png';
import InTeriorIMG from '@/assets/car-images/interior.png';

interface Props {
  setIsOpenPopup: Dispatch<SetStateAction<boolean>>;
}

interface Option {
  type: string;
  name: string;
  price: number;
}

const COMPLETE_TAB_IDX = 5;
const MOCK_DATA_TRIM: Option[] = [
  { type: '모델', name: '팰리세이드', price: 3880000 },
  { type: '트림', name: '팰리세이드', price: 3880000 },
  { type: '파워트레인', name: '디젤2.2', price: 280000 },
  { type: '바디타입', name: '7인승', price: 0 },
  { type: '구동방식', name: '2WD', price: 0 },
  { type: '외장색상', name: '어비스 블랙펄', price: 150000 },
  { type: '내장색상', name: '어비스 블랙펄', price: 0 },
];

function SummaryPopup({ setIsOpenPopup }: Props) {
  const { setCurrentSlide } = useSafeContext(SlideContext);
  const [isExterior, setIsExterior] = useState(true);

  const closePopup: MouseEventHandler<HTMLDivElement | HTMLButtonElement | SVGSVGElement> = () => {
    setIsOpenPopup(false);
  };

  const handleClickButton: MouseEventHandler<HTMLButtonElement> = (e) => {
    closePopup(e);
    setCurrentSlide(COMPLETE_TAB_IDX);
  };

  return (
    <Portal>
      <Dimmed onClick={closePopup} />
      <SummaryPopupContainer>
        <HeaderContainer>
          견적요약
          <Icon iconType='Cancel' css={IconStyle} onClick={closePopup} />
        </HeaderContainer>
        <MainContainer>
          <LeftContainer>
            {isExterior ? <StyleImg src={ExTeriorIMG} /> : <StyleImg src={InTeriorIMG} />}
            <Toggle isChecked={isExterior} size='small' setIsChecked={setIsExterior} />
          </LeftContainer>
          <RightContainer>
            {MOCK_DATA_TRIM.map((opt, idx) => (
              <>
                <Option key={idx}>
                  <OptionType>{opt.type}</OptionType>
                  <OptionName>{opt.name}</OptionName>
                  <OptionPrice>{opt.price}</OptionPrice>
                </Option>
                {[1, 4, 6].includes(idx) && <Divider />}
              </>
            ))}
          </RightContainer>
        </MainContainer>
        <PriceContainer>
          <span>현재 총 가격</span>
          <Price>38,560,000 원</Price>
        </PriceContainer>
        <CTAButton size='large' onClick={handleClickButton}>
          견적 완료하기
        </CTAButton>
      </SummaryPopupContainer>
    </Portal>
  );
}

export default SummaryPopup;

const SummaryPopupContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol}
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: 8px;
  width: 850px;
  height: 520px;
  overflow: hidden;
  z-index: 20;
`;

const HeaderContainer = styled.div`
  ${({ theme }) => theme.typography.HeadKRMedium18}
  color: ${({ theme }) => theme.colors.priceSummaryHead};
  width: 100%;
  height: 53px;
  text-align: center;
  padding-top: 20px;
`;

const MainContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow};
  width: 100%;
  flex: 1;
  gap: 32px;
`;

const LeftContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterCol};
  margin-left: 40px;
  gap: 20px;
`;

const RightContainer = styled.div`
  width: 324px;
  margin-right: 36px;
`;

const PriceContainer = styled.div`
  ${({ theme }) => theme.flex.flexEndRow};
  ${({ theme }) => theme.typography.TextKRRegular12};
  align-items: center;
  color: ${({ theme }) => theme.colors.gray700};
  width: 100%;
  height: 64px;
  padding: 8px 36px 24px 0px;
  gap: 8px;
`;

const Price = styled.div`
  ${({ theme }) => theme.typography.HeadKRMedium24};
  color: ${({ theme }) => theme.colors.primary500};
`;

const IconStyle = css`
  position: absolute;
  right: 20px;
  top: 21px;
`;

const StyleImg = styled.img`
  width: 418px;
  height: 212px;
`;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.blueBg};
  margin: 16px 0px 16px 0px;
  width: 100%;
  height: 1px;
`;

const Option = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow};
  width: 100%;
  height: 22px;
  gap: 8px;
`;

const OptionType = styled.div`
  ${({ theme }) => theme.typography.TextKRRegular12};
  color: ${({ theme }) => theme.colors.gray500};
  width: 56px;
`;

const OptionName = styled.div`
  ${({ theme }) => theme.typography.TextKRMedium12};
  color: ${({ theme }) => theme.colors.gray900};
  width: 160px;
`;

const OptionPrice = styled.div`
  ${({ theme }) => theme.typography.TextKRRegular14};
  color: ${({ theme }) => theme.colors.gray900};
  width: 92px;
  text-align: end;
`;
