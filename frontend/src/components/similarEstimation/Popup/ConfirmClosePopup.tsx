import { css } from '@emotion/react';
import { ConfirmPopup, Flex, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { SlideContext } from '@/providers/SlideProvider';

interface Props {
  closeSimilarEstimationPopup: () => void;
  closePopup: () => void;
  isEmptyOption: boolean;
  optionCnt?: number;
}

function ConfirmClosePopup({ closePopup, closeSimilarEstimationPopup, isEmptyOption, optionCnt }: Props) {
  const { setCurrentSlide } = useSafeContext(SlideContext);

  const handleClickConfirmButton = () => {
    closePopup();
    closeSimilarEstimationPopup();
    setCurrentSlide(5);
  };

  return (
    <ConfirmPopup
      hasCancelButton={true}
      confirmButtonLabel={isEmptyOption ? '종료' : '확인'}
      handleClickCancelButton={closePopup}
      handleClickConfirmButton={handleClickConfirmButton}
      css={PopupPosition}
    >
      {isEmptyOption ? (
        '유사견적 페이지를 닫으시겠습니까?'
      ) : (
        <Flex flexDirection='column' gap={16}>
          <Typography color='primary500'>선택된 옵션 {optionCnt}개</Typography>
          <p>
            선택된 옵션이 있습니다. <br />
            지금 서비스 종료 시 저장되지 않습니다.
          </p>
        </Flex>
      )}
    </ConfirmPopup>
  );
}

export default ConfirmClosePopup;

const PopupPosition = css`
  z-index: 25;
`;
