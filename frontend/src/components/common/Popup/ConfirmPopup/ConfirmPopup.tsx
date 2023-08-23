import { HTMLAttributes, MouseEventHandler, PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { CTACTypeButton, Popup } from '@/components/common';

export interface Props extends HTMLAttributes<HTMLDivElement> {
  hasCancelButton: boolean;
  cancelButtonLabel?: string;
  confirmButtonLabel: string;
  handleClickCancelButton: MouseEventHandler<HTMLElement>;
  handleClickConfirmButton: MouseEventHandler<HTMLButtonElement>;
}

/**
 * @example
 * ```tsx
 * ConfirmPopup hasCancelButton={true} cancelButtonLabel='취소' confirmButtonLabel='종료' handleClickCancelButton={() => setIsOpen(false)}
      handleClickConfirmButton={() => {window.open('https://www.naver.com');}}>
        내 차 만들기를 종료하시겠습니까? <br /> 지금 서비스 종료 시 저장되지 않습니다.
  </ConfirmPopup>
 * ```
 */

function ConfirmPopup({
  hasCancelButton,
  cancelButtonLabel = '취소',
  confirmButtonLabel,
  handleClickCancelButton,
  handleClickConfirmButton,
  children,
  ...restProps
}: PropsWithChildren<Props>) {
  return (
    <Popup handleClickDimmed={handleClickCancelButton} {...restProps}>
      <ConfirmPopupContainer data-testid='confirm-modal'>
        <ContentContainer>{children}</ContentContainer>
        <ButtonContainer>
          {hasCancelButton && (
            <CTACTypeButton size='small' color='gray' onClick={handleClickCancelButton}>
              {cancelButtonLabel}
            </CTACTypeButton>
          )}
          <CTACTypeButton size={hasCancelButton ? 'small' : 'large'} color='primary' onClick={handleClickConfirmButton}>
            {confirmButtonLabel}
          </CTACTypeButton>
        </ButtonContainer>
      </ConfirmPopupContainer>
    </Popup>
  );
}

export default ConfirmPopup;

const ConfirmPopupContainer = styled.div`
  ${({ theme }) => theme.flex.flexEndCol}
  width: 100%;
  height: 100%;
`;

const ContentContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterCol}
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.gray900};
  text-align: center;
  height: 100%;
`;

const ButtonContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow};
`;
