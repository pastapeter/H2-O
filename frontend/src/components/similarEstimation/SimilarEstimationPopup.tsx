import { useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import EstimationCard from './EstimationCard';
import { ConfirmClosePopup, ConfirmOptionPopup } from './Popup';
import PriceStaticBar from './SimilarEstimationPriceBar';
import { QutationResponse } from '@/types/interface';
import { CTAButton, Circle, Flex, Loading, Popup, Typography, Icon as _Icon } from '@/components/common';
import { usePagination, useToggle } from '@/hooks';
import useSetList from '@/hooks/useSetList';
import { SelectionInfoWithImage } from '@/providers/SelectionProvider';

interface Props {
  closeEstimationPopup: () => void;
  response: QutationResponse[];
}

function SimilarEstimationPopup({ closeEstimationPopup, response: estimationList }: Props) {
  const { prevPage, nextPage, currentPage, isStartPage, isEndPage } = usePagination({
    data: estimationList,
    pageSize: 1,
  });
  const { dataList, addData, removeData, hasData, isEmptyList } = useSetList<SelectionInfoWithImage>({});

  const toggleClosePopup = useToggle(false);
  const toggleConfirmPopup = useToggle(false);
  const theme = useTheme();

  if (!estimationList)
    return (
      <Popup size='large' handleClickDimmed={closeEstimationPopup}>
        <Loading />
      </Popup>
    );

  return (
    <Popup size='large' handleClickDimmed={toggleClosePopup.setOn}>
      <Flex flexDirection='column' justifyContent='space-between' height='100%' paddingTop={57}>
        <Icon iconType='Cancel' onClick={toggleClosePopup.setOn} />
        <Header justifyContent='space-between' paddingLeft={44} paddingRight={44}>
          <Flex width={367} height={119} flexDirection='column' justifyContent='space-between'>
            <Typography as='span' font='HeadKRMedium16' color='gray900'>
              <Typography as='span' color='activeBlue2'>
                내 견적과 비슷한 실제 출고 견적
              </Typography>
              들을 <br />
              확인하고 비교해보세요.
            </Typography>
            <Typography font='TextKRRegular12' color='primary500'>
              *유사 출고 견적이란,
              <br /> 내 견적과 해시태그 유사도가 높은 다른 사람들의 실제 출고 견적이에요.
            </Typography>
          </Flex>
          <PriceStaticBar estimationPrice={estimationList[currentPage].price} />
        </Header>
        <CarouselContainer>
          <EstimationCardList pageIdx={currentPage}>
            {estimationList.map((item, idx) => (
              <EstimationCard
                key={item.image + idx}
                prevPage={prevPage}
                nextPage={nextPage}
                cardIdx={idx}
                isActive={currentPage === idx}
                isStartPage={isStartPage}
                isLastPage={isEndPage}
                estimation={item}
                addData={addData}
                removeData={removeData}
                hasData={hasData}
              />
            ))}
          </EstimationCardList>
        </CarouselContainer>
        <Flex gap={8} width='100%' justifyContent='center'>
          {Array(estimationList.length)
            .fill(1)
            .map((_, idx) => (
              <Flex key={idx}>
                {idx === currentPage && <ProgressBar key={idx} pageIdx={currentPage} />}
                {idx !== currentPage && <Circle key={idx} type='fill' color={theme.colors.gray300} size={5} />}
              </Flex>
            ))}
        </Flex>
        {isEmptyList() ? (
          <CTAButton size='large' disabled>
            옵션을 선택해 추가해보세요.
          </CTAButton>
        ) : (
          <CTAButton size='large' onClick={toggleConfirmPopup.setOn}>
            <Flex flexDirection='column'>
              <Typography font='TextKRRegular12' color='gray100'>
                선택된 옵션 {dataList.length}개
              </Typography>
              <Typography>내 견적서에 추가하기</Typography>
            </Flex>
          </CTAButton>
        )}
        {/* 팝업 노출 */}
        {toggleClosePopup.status && (
          <ConfirmClosePopup
            closePopup={toggleClosePopup.setOff}
            closeSimilarEstimationPopup={closeEstimationPopup}
            isEmptyOption={isEmptyList()}
            optionCnt={dataList.length}
          />
        )}
        {toggleConfirmPopup.status && (
          <ConfirmOptionPopup
            closeSimilarEstimationPopup={closeEstimationPopup}
            closePopup={toggleConfirmPopup.setOff}
            optionList={dataList}
          />
        )}
      </Flex>
    </Popup>
  );
}

export default SimilarEstimationPopup;

const Header = styled(Flex)``;

const Icon = styled(_Icon)`
  position: absolute;
  top: 21px;
  right: 20px;
`;

const CarouselContainer = styled.div`
  width: 100%;
  overflow-x: hidden;
`;

const EstimationCardList = styled.div<{ pageIdx: number }>`
  display: flex;
  gap: 12px;
  transform: translateX(${({ pageIdx }) => pageIdx * -774 + 44}px);
  transition: transform 1s ease-in-out;
`;

const ProgressBar = styled.div<{ pageIdx: number }>`
  background-color: ${({ theme }) => theme.colors.primary500};
  border-radius: 2.5px;
  width: 15px;
  height: 5px;
`;
