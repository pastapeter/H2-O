import { MouseEventHandler, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { CTAButton, Icon, Popup, Toggle } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { toPriceFormatString } from '@/utils/string';
import { SlideContext } from '@/providers/SlideProvider';

interface Props {
  handleClickCloseButton: MouseEventHandler<HTMLElement | SVGSVGElement>;
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
  { type: '파워트레인', name: '디젤2.2', price: -280000 },
  { type: '바디타입', name: '7인승', price: 0 },
  { type: '구동방식', name: '2WD', price: 0 },
  { type: '외장색상', name: '어비스 블랙펄', price: 150000 },
  { type: '내장색상', name: '어비스 블랙펄', price: 0 },
];
const MOCK_DATA_OPTION: Option[] = [{ type: '옵션', name: '팰리세이드', price: 3880000 }];
const NOW_PRICE = 38560000;
const exteriorIMG = '/images/exterior2.png';
const interiorIMG = '/images/interior.png';

/**
 *
 * @example
 * ```tsx
 *  <SummaryPopup handleClickCloseButton={() => setIsOpen(false)} />
 * ```
 */
function SummaryPopup({ handleClickCloseButton }: Props) {
  const { setCurrentSlide } = useSafeContext(SlideContext);
  const [isExterior, setIsExterior] = useState(true);

  const handleCompleteButton: MouseEventHandler<HTMLButtonElement> = (e) => {
    handleClickCloseButton(e);
    setCurrentSlide(COMPLETE_TAB_IDX);
  };

  return (
    <Popup size='large' handleClickDimmed={handleClickCloseButton}>
      <SummaryPopupContainer>
        <HeaderContainer>
          견적요약
          <Icon iconType='Cancel' css={IconStyle} onClick={handleClickCloseButton} />
        </HeaderContainer>
        <MainContainer>
          <LeftContainer>
            {isExterior ? <StyleImg src={exteriorIMG} /> : <StyleImg src={interiorIMG} />}
            <Toggle isChecked={isExterior} size='small' setIsChecked={setIsExterior} />
          </LeftContainer>
          <RightContainer>
            {MOCK_DATA_TRIM.map(({ type, name, price }, idx) => (
              <div key={idx}>
                <Option>
                  <span className='type'>{type}</span>
                  <span className='name'>{name}</span>
                  <span className='price'>{toPriceFormatString(price)}</span>
                </Option>
                {[1, 4, 6].includes(idx) && <Divider />}
              </div>
            ))}
            {MOCK_DATA_OPTION.length ? (
              MOCK_DATA_OPTION.map(({ type, name, price }, idx) => (
                <Option key={idx}>
                  <span className='type'>{type}</span>
                  <span className='name'>{name}</span>
                  <span className='price'>{toPriceFormatString(price)}</span>
                </Option>
              ))
            ) : (
              <>
                <Option>
                  <span className='type'>옵션</span>
                  <span className='name'>-</span>
                  <span className='price'>{toPriceFormatString(0)}</span>
                </Option>
              </>
            )}
          </RightContainer>
        </MainContainer>
        <PriceContainer>
          <span>현재 총 가격</span>
          <Price>{toSeparatedNumberFormat(NOW_PRICE)} 원</Price>
        </PriceContainer>
        <CTAButton size='large' onClick={handleCompleteButton}>
          견적 완료하기
        </CTAButton>
      </SummaryPopupContainer>
    </Popup>
  );
}

export default SummaryPopup;

const SummaryPopupContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol};
  width: 100%;
  height: 100%;
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
  padding-top: 62px;
  margin-left: 40px;
  gap: 20px;
`;

const RightContainer = styled.div`
  width: 324px;
  height: 304px;
  margin-right: 36px;
  overflow: scroll;
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

  .type {
    ${({ theme }) => theme.typography.TextKRRegular12};
    color: ${({ theme }) => theme.colors.gray500};
    width: 56px;
  }

  .name {
    ${({ theme }) => theme.typography.TextKRMedium12};
    color: ${({ theme }) => theme.colors.gray900};
    width: 160px;
  }

  .price {
    ${({ theme }) => theme.typography.TextKRRegular14};
    color: ${({ theme }) => theme.colors.gray900};
    width: 92px;
    text-align: end;
  }
`;
