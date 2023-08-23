import { ConfirmPopup } from '@/components/common';

const HYUNDAI_URL = 'https://www.hyundai.com';

interface Props {
  handleClickCancelButton: () => void;
}

function CloseMyCarPopup({ handleClickCancelButton }: Props) {
  const handleClickConfirmButton = () => {
    window.open(HYUNDAI_URL, '_self');
  };
  return (
    <ConfirmPopup
      hasCancelButton={true}
      confirmButtonLabel='종료'
      handleClickCancelButton={handleClickCancelButton}
      handleClickConfirmButton={handleClickConfirmButton}
    >
      내 차 만들기를 종료하시겠습니까? <br /> 지금 서비스 종료 시 저장되지 않습니다.
    </ConfirmPopup>
  );
}

export default CloseMyCarPopup;
