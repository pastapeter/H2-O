import { ChangeEventHandler, Dispatch, SetStateAction } from 'react';
import styled from '@emotion/styled';

interface Props {
  isChecked: boolean;
  size: 'small' | 'large';
  setIsChecked: Dispatch<SetStateAction<boolean>>;
}
function Toggle({ isChecked, size, setIsChecked }: Props) {
  const handleOnChange: ChangeEventHandler<HTMLInputElement> = () => {
    setIsChecked((prev) => !prev);
  };

  return (
    <ToggleContainer size={size}>
      <ToggleCheckBox type='checkbox' id='toggleButton' onChange={handleOnChange} />
      <ToggleLabel htmlFor='toggleButton' isChecked={isChecked} size={size} />
      <ToggleItem isChecked={isChecked} size={size}>
        외장
      </ToggleItem>
      <ToggleItem isChecked={!isChecked} size={size}>
        내장
      </ToggleItem>
    </ToggleContainer>
  );
}

export default Toggle;

const ToggleContainer = styled.div<Pick<Props, 'size'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  width: ${({ size }) => (size === 'small' ? 154 : 213)}px;
  height: ${({ size }) => (size === 'small' ? 44 : 48)}px;
  border-radius: ${({ size }) => (size === 'small' ? 22 : 24)}px;
  border: 1px solid ${({ theme }) => theme.colors.gray100};
  background-color: ${({ theme }) => theme.colors.white};
  position: relative;
`;

const ToggleCheckBox = styled.input`
  display: none;
`;

const ToggleLabel = styled.label<Pick<Props, 'size' | 'isChecked'>>`
  ::before {
    position: absolute;
    top: 3px;
    left: 4px;
    background: ${({ theme }) => theme.colors.white};
    border-radius: 20px;
    width: ${({ size }) => (size === 'small' ? 72 : 101)}px;
    height: ${({ size }) => (size === 'small' ? 36 : 40)}px;
    content: '';
  }

  ::after {
    position: absolute;
    top: 3px;
    right: 4px;
    background-color: ${({ theme }) => theme.colors.primary500};
    border-radius: 20px;
    width: ${({ size }) => (size === 'small' ? 72 : 101)}px;
    height: ${({ size }) => (size === 'small' ? 36 : 40)}px;
    content: '';
    pointer-events: ${({ isChecked }) => !isChecked && `none`};
  }

  &::before {
    background-color: ${({ theme, isChecked }) => isChecked && theme.colors.primary500};
    pointer-events: ${({ isChecked }) => isChecked && `none`};
  }
  &::after {
    background-color: ${({ theme, isChecked }) => isChecked && theme.colors.white};
  }
`;

const ToggleItem = styled.div<Pick<Props, 'size' | 'isChecked'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme, isChecked }) => (isChecked ? theme.typography.TextKRMedium14 : theme.typography.TextKRRegular14)}
  color: ${({ theme, isChecked }) => (isChecked ? theme.colors.blueBg : theme.colors.gray400)};
  width: ${({ size }) => (size === 'small' ? 72 : 101)}px;
  height: ${({ size }) => (size === 'small' ? 36 : 40)}px;
  z-index: 1;
  pointer-events: none;
`;
