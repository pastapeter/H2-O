import { ChangeEventHandler, MouseEventHandler, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { CTAButton, Flex, Icon, Popup, Toggle, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { toPriceFormatString } from '@/utils/string';
import { SelectionContext } from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

interface SummaryPopupProps {
  handleClickCloseButton: MouseEventHandler<HTMLElement | SVGSVGElement>;
}

interface OptionSummaryProps {
  type: string;
  name: string;
  price: number;
}

const COMPLETE_TAB_IDX = 5;

/**
 *
 * @example
 * ```tsx
 *  <SummaryPopup handleClickCloseButton={() => setIsOpen(false)} />
 * ```
 */
function SummaryPopup({ handleClickCloseButton }: SummaryPopupProps) {
  const { selectionInfo, totalPrice } = useSafeContext(SelectionContext);
  const { setCurrentSlide } = useSafeContext(SlideContext);
  const [isExterior, setIsExterior] = useState(true);

  const handleCompleteButton: MouseEventHandler<HTMLButtonElement> = (e) => {
    handleClickCloseButton(e);
    setCurrentSlide(COMPLETE_TAB_IDX);
  };
  const handleChangeToggle: ChangeEventHandler<HTMLInputElement> = () => {
    setIsExterior((prev) => !prev);
  };

  const { trim, powerTrain, bodyType, driveTrain, exteriorColor, interiorColor, extraOptions } = selectionInfo;

  if (!trim || !powerTrain || !bodyType || !driveTrain || !exteriorColor || !interiorColor || !extraOptions)
    return <div>로딩중...</div>;

  return (
    <Popup size='large' handleClickDimmed={handleClickCloseButton}>
      <SummaryPopupContainer>
        <HeaderContainer>
          견적요약
          <CancelIcon iconType='Cancel' onClick={handleClickCloseButton} />
        </HeaderContainer>
        <MainContainer>
          <LeftContainer>
            {isExterior ? <StyleImg src={exteriorColor.image} /> : <StyleImg src={interiorColor.image} />}
            <Toggle isChecked={isExterior} size='small' handleChangeToggle={handleChangeToggle} />
          </LeftContainer>
          <RightContainer>
            <OptionSummary type='모델' name='팰리세이드' price={0} />
            {trim && <OptionSummary type='트림' name={trim.name} price={trim.price} />}
            <Divider />
            {powerTrain && <OptionSummary type='파워트레인' name={powerTrain.name} price={powerTrain.price} />}
            {bodyType && <OptionSummary type='바디타입' name={bodyType.name} price={bodyType.price} />}
            {driveTrain && <OptionSummary type='구동방식' name={driveTrain.name} price={driveTrain.price} />}
            <Divider />
            {interiorColor && <OptionSummary type='외장색상' name={exteriorColor.name} price={exteriorColor.price} />}
            {exteriorColor && <OptionSummary type='내장색상' name={interiorColor.name} price={interiorColor.price} />}
            <Divider />
            {extraOptions.optionList.length ? (
              extraOptions.optionList.map((option) => (
                <OptionSummary key={option.id} type='옵션' name={option.name} price={option.price} />
              ))
            ) : (
              <OptionSummary type='옵션' name={'-'} price={0} />
            )}
          </RightContainer>
        </MainContainer>
        <PriceContainer>
          <span>현재 총 가격</span>
          <Price>{toSeparatedNumberFormat(totalPrice)} 원</Price>
        </PriceContainer>
        <CTAButton size='large' onClick={handleCompleteButton}>
          견적 완료하기
        </CTAButton>
      </SummaryPopupContainer>
    </Popup>
  );
}

function OptionSummary({ type, name, price }: OptionSummaryProps) {
  return (
    <Flex alignItems='center' width='100%' height='22px' gap={8}>
      <Typography
        css={css`
          width: 56px;
          flex-shrink: 0;
        `}
        as='span'
        font='TextKRRegular12'
        color='gray500'
      >
        {type}
      </Typography>
      <Flex justifyContent='space-between' alignItems='center' width='100%' height='100%'>
        <Typography
          as='span'
          font='TextKRMedium12'
          color='gray900'
          css={css`
            width: 160px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          `}
        >
          {name}
        </Typography>
        <Typography as='span' font='TextKRRegular14' color='gray900'>
          {toPriceFormatString(price)}원
        </Typography>
      </Flex>
    </Flex>
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

const CancelIcon = styled(Icon)`
  position: absolute;
  right: 20px;
  top: 21px;
  cursor: pointer;
`;

const StyleImg = styled.img`
  width: 418px;
  height: 212px;
  object-fit: cover;
`;

const Divider = styled.div(
  {
    width: '100%',
    height: '1px',
    margin: '16px 0px',
  },
  ({ theme }) => ({
    backgroundColor: theme.colors.blueBg,
  }),
);
