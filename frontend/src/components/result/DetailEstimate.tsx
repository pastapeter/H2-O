import { Fragment, useEffect, useState } from 'react';
import styled from '@emotion/styled';
import BarGraph from './BarGraph';
import PriceGraph from './PriceGraph';
import { getPriceSum } from './utils';
import { QutationBody } from '@/types/interface';
import { postSalesCount, postSimilarOption } from '@/apis/quotation';
import { Divider, Flex, HMGTag, Loading, Typography } from '@/components/common';
import { EstimateAccordian as Accordian } from '@/components/result';
import { SimilarEstimationPopup } from '@/components/similarEstimation';
import { useFetcher, useSafeContext, useToggle } from '@/hooks';
import {
  type ExteriorColorInfo,
  type ExtraOptionsInfo,
  type InteriorColorInfo,
  SelectionContext,
  type SelectionInfoWithImage,
} from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

interface Props {
  carId: number;
  trimId: number;
  powerTrain: SelectionInfoWithImage;
  bodyType: SelectionInfoWithImage;
  driveTrain: SelectionInfoWithImage;
  exteriorColor: ExteriorColorInfo;
  interiorColor: InteriorColorInfo;
  extraOptions: ExtraOptionsInfo;
}

function DetailEstimate({
  carId,
  trimId,
  powerTrain,
  bodyType,
  driveTrain,
  exteriorColor,
  interiorColor,
  extraOptions,
}: Props) {
  const { status, setOff, setOn } = useToggle(false);
  const { currentSlide, setCurrentSlide } = useSafeContext(SlideContext);
  const [submit, setSubmit] = useState(false);

  const body: QutationBody = {
    carId: carId,
    externalColorId: exteriorColor.id,
    internalColorId: interiorColor.id,
    modelTypeIds: { bodytypeId: bodyType.id, drivetrainId: driveTrain.id, powertrainId: powerTrain.id },
    optionIds: extraOptions.optionList.filter((opt) => opt.isPackage === false).map((opt) => opt.id),
    packageIds: extraOptions.optionList.filter((opt) => opt.isPackage === true).map((opt) => opt.id),
    trimId: trimId,
  };

  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const handleModifyButton = (idx: number) => () => {
    setCurrentSlide(idx);
  };
  const handleDeleteButton = (idx: number) => () => {
    if (!selectionInfo.extraOptions) return;

    dispatch({
      type: 'SET_EXTRA_OPTIONS',
      payload: selectionInfo.extraOptions?.optionList.filter((item) => item.id !== idx),
    });
  };

  const { isLoading: quotationLoading, data: estimationList } = useFetcher({
    fetchFn: () => postSimilarOption(body),
    onSuccess: () => {
      setSubmit(false);
    },
    enabled: submit && currentSlide === 5,
  });

  const { isLoading: salesLoading, data: nowSalesCount } = useFetcher({
    fetchFn: () => postSalesCount(body),
    onSuccess: () => {
      setSubmit(false);
    },
    enabled: submit && currentSlide === 5,
  });

  useEffect(() => {
    setSubmit(true);
  }, [extraOptions.optionList]);

  const isLoading = quotationLoading || salesLoading;
  const isFetchData = estimationList && estimationList.length && nowSalesCount;

  return (
    <Fragment>
      <Typography as='h3' font='HeadKRMedium18' color='gray900' marginTop={20} marginBottom={12}>
        상세 견적
      </Typography>
      <Flex justifyContent='space-between' gap={70}>
        <Flex flexDirection='column'>
          <Accordian label='모델타입' totalPrice={getPriceSum(powerTrain, bodyType, driveTrain)} isExpanded>
            {powerTrain && (
              <Accordian.Detail
                type='파워트레인'
                thumbnail={powerTrain.image}
                name={powerTrain.name}
                price={powerTrain.price}
                handleClickButton={handleModifyButton(1)}
              />
            )}
            {bodyType && (
              <Accordian.Detail
                type='바디타입'
                thumbnail={bodyType.image}
                name={bodyType.name}
                price={bodyType.price}
                handleClickButton={handleModifyButton(1)}
              />
            )}
            {driveTrain && (
              <Accordian.Detail
                type='구동방식'
                thumbnail={driveTrain.image}
                name={driveTrain.name}
                price={driveTrain.price}
                handleClickButton={handleModifyButton(1)}
              />
            )}
          </Accordian>
          <Accordian
            label='색상'
            totalPrice={getPriceSum<SelectionInfoWithImage>(exteriorColor, interiorColor)}
            isExpanded
          >
            {exteriorColor && (
              <Accordian.Detail
                type='외장색상'
                colorCode={exteriorColor.colorCode}
                name={exteriorColor.name}
                price={exteriorColor.price}
                handleClickButton={handleModifyButton(2)}
              />
            )}
            {interiorColor && (
              <Accordian.Detail
                type='내장색상'
                thumbnail={interiorColor.fabricImage}
                name={interiorColor.name}
                price={interiorColor.price}
                handleClickButton={handleModifyButton(3)}
              />
            )}
          </Accordian>
          <Accordian label='추가옵션' totalPrice={extraOptions.price}>
            {extraOptions.optionList.map((opt) => (
              <Accordian.Detail
                key={opt.id}
                thumbnail={opt.image}
                name={opt.name}
                price={opt.price}
                isModify={!opt.isQuotation}
                handleClickButton={opt.isQuotation ? handleDeleteButton(opt.id) : handleModifyButton(4)}
              />
            ))}
          </Accordian>
          <Accordian label='탁송' totalPrice={0} />
          <Accordian label='할인 및 포인트' totalPrice={0} />
          <Accordian label='결제 수단' description='결제수단을 선택하고 지불조건 및 납입사항을 확인하세요.' />
          <Accordian label='면세 구분 및 등록비' description='할인/포인트 및 결제 방법 선택 후 확인 가능해요.' />
          <Accordian label='안내사항' />
        </Flex>
        <Flex flexDirection='column' gap={20}>
          <GraphContainer>
            <StyledHMGTag variant='small' />
            <Typography font='HeadKRMedium16' color='gray900' marginBottom={15}>
              르블랑으로 완성된 모든 타입의
              <br />
              <Highlight>견적 가격의 분포</Highlight>입니다.
            </Typography>
            <Divider color='gray100' length='100%' />
            <PriceGraph />
          </GraphContainer>
          <SalesBarContainer flexDirection='column'>
            <StyledHMGTag variant='small' />
            <Typography font='HeadKRMedium16' color='gray900' marginBottom={10}>
              <Highlight>내 견적과 비슷한 실제 출고 견적</Highlight>들을
              <br />
              확인하고 비교해보세요.
            </Typography>
            <Typography font='TextKRRegular14' color='gray500' marginBottom={15}>
              유사 출고 견적이란, 내 견적과 해시태그 유사도가
              <br /> 높은 다른 사람들의 실제 출고 견적이에요.
            </Typography>
            <Divider color='gray100' length='100%' />
            {isLoading ? (
              <Flex width='100%' justifyContent='center' height={170}>
                <Loading />
              </Flex>
            ) : isFetchData ? (
              <Flex flexDirection='column' justifyContent='space-between' height='100%' paddingTop={13}>
                <BarGraph
                  salesCount={nowSalesCount.salesCount}
                  quotationSalesCount={estimationList.map((item) => item.salesCount)}
                />
                <StyledButton onClick={setOn}>
                  <Typography font='HeadKRMedium14' color='primary500'>
                    유사 출고 견적 확인하기
                  </Typography>
                </StyledButton>
                {status && <SimilarEstimationPopup closeEstimationPopup={setOff} response={estimationList} />}
              </Flex>
            ) : (
              <Flex width='100%' justifyContent='center' alignItems='center' height={170}>
                <Typography color='gray300' font='HeadKRMedium14'>
                  유사견적이 없습니다.
                </Typography>
              </Flex>
            )}
          </SalesBarContainer>
        </Flex>
      </Flex>
    </Fragment>
  );
}

export default DetailEstimate;

const GraphContainer = styled.div`
  background-color: ${({ theme }) => theme.colors.blueBg};
  flex-direction: column;
  position: relative;
  width: 347px;
  height: 349px;
  padding: 40px 16px 21px 16px;
`;

const SalesBarContainer = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.gray50};
  position: relative;
  width: 347px;
  height: 385px;
  padding: 40px 16px 15px 16px;
`;

const StyledHMGTag = styled(HMGTag)`
  position: absolute;
  top: 0;
  left: 0;
`;

const Highlight = styled.span`
  color: ${({ theme }) => theme.colors.activeBlue};
`;

const StyledButton = styled.button`
  background-color: ${({ theme }) => theme.colors.skyBlueCardBg};
  border-radius: 2px;
  width: 311px;
  height: 47px;
`;
