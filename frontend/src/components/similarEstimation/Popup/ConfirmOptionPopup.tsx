import { css } from '@emotion/react';
import { ConfirmPopup, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { SelectionContext, SelectionInfoWithImage } from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

interface Props {
  closeSimilarEstimationPopup: () => void;
  closePopup: () => void;
  optionList: SelectionInfoWithImage[];
}

function ConfirmOptionPopup({ closeSimilarEstimationPopup, closePopup, optionList }: Props) {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const { setCurrentSlide } = useSafeContext(SlideContext);

  const handleClickConfirmButton = () => {
    closePopup();
    closeSimilarEstimationPopup();
    setCurrentSlide(5);

    const newOptionList = optionList.map((item) => {
      return {
        id: item.id,
        name: item.name,
        price: item.price,
        image: item.image,
        isPackage: false,
        isQuotation: true,
      };
    });

    dispatch({
      type: 'SET_EXTRA_OPTIONS',
      payload: selectionInfo.extraOptions ? selectionInfo.extraOptions.optionList.concat(newOptionList) : newOptionList,
    });
  };

  return (
    <ConfirmPopup
      hasCancelButton={false}
      confirmButtonLabel='확인'
      handleClickCancelButton={closePopup}
      handleClickConfirmButton={handleClickConfirmButton}
      css={PopupPosition}
    >
      <Typography as='span'>
        <Typography as='span' color='primary500'>
          [{optionList[0].name}]외 {optionList.length}개
        </Typography>
        의 옵션이
        <br /> 내 견적서에 추가되었습니다.
      </Typography>
    </ConfirmPopup>
  );
}

export default ConfirmOptionPopup;

const PopupPosition = css`
  z-index: 25;
`;
