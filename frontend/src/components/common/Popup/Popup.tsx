import { Dispatch, HTMLAttributes, MouseEventHandler, PropsWithChildren, SetStateAction } from 'react';
import styled from '@emotion/styled';
import { CTACTypeButton, Dimmed, Portal } from '@/components/common';

export interface Props extends HTMLAttributes<HTMLDivElement> {
  hasCancelButton: boolean;
  buttonLabel: string;
  setIsOpenPopup: Dispatch<SetStateAction<boolean>>;
  handleOnClickButton: MouseEventHandler<HTMLButtonElement>;
}

/**
 * @example
 * ```tsx
 * <Popup hasCancelButton={true} buttonLabel='이동' setIsOpenPopup={setIsOpenPopup} handleOnClickButton={() => { window.open('https://www.naver.com');}}
    >내 차 만들기를 종료하시겠습니까?<br/>지금 서비스 종료 시 저장되지 않습니다.</Popup>
 * ```
 */
function Popup({
  hasCancelButton,
  buttonLabel,
  setIsOpenPopup,
  handleOnClickButton,
  children,
  ...restProps
}: PropsWithChildren<Props>) {
  const closePopup: MouseEventHandler<HTMLButtonElement | HTMLDivElement> = () => {
    setIsOpenPopup(false);
  };

  return (
    <Portal>
      <Dimmed onClick={closePopup} />
      <PopupContainer {...restProps}>
        <ContentContainer>{children}</ContentContainer>
        {hasCancelButton ? (
          <ButtonContainer>
            <CTACTypeButton size='small' color='gray' onClick={closePopup}>
              취소
            </CTACTypeButton>
            <CTACTypeButton size='small' color='primary' onClick={handleOnClickButton}>
              {buttonLabel}
            </CTACTypeButton>
          </ButtonContainer>
        ) : (
          <ButtonContainer>
            <CTACTypeButton size='large' color='primary' onClick={handleOnClickButton}>
              {buttonLabel}
            </CTACTypeButton>
          </ButtonContainer>
        )}
      </PopupContainer>
    </Portal>
  );
}

export default Popup;

export const PopupContainer = styled.div`
  ${({ theme }) => theme.flex.flexEndCol};
  position: fixed;
  z-index: 20;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: ${({ theme }) => theme.colors.white};
  border-radius: 4px;
  width: 336px;
  height: 200px;
  overflow: hidden;
`;

export const ContentContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterCol}
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.gray900};
  text-align: center;
  height: 100%;
`;

export const ButtonContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow};
`;
