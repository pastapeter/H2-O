import { ChangeEventHandler, HTMLAttributes, useId } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';

interface Props extends HTMLAttributes<HTMLDivElement> {
  isChecked: boolean;
  size: 'small' | 'large';
  handleChangeToggle: ChangeEventHandler<HTMLInputElement>;
}

function Toggle({ isChecked, size, handleChangeToggle, ...restProps }: Props) {
  const id = useId();

  return (
    <ToggleContainer size={size} {...restProps}>
      <input
        type='checkbox'
        id={id}
        onChange={handleChangeToggle}
        css={css`
          display: none;
        `}
      />
      <ToggleLabel htmlFor={id} isChecked={isChecked} size={size}>
        <ToggleSwitch isChecked={isChecked} size={size} />
        <ToggleItem isChecked={isChecked} size={size}>
          외장
        </ToggleItem>
        <ToggleItem isChecked={!isChecked} size={size}>
          내장
        </ToggleItem>
      </ToggleLabel>
    </ToggleContainer>
  );
}

export default Toggle;

const ToggleContainer = styled.div<Pick<Props, 'size'>>`
  ${({ theme }) => theme.flex.flexCenterRow};
  position: relative;
  background-color: ${({ theme }) => theme.colors.white};
  border: 1px solid ${({ theme }) => theme.colors.gray100};
  border-radius: ${({ size }) => (size === 'small' ? 22 : 24)}px;
  width: ${({ size }) => (size === 'small' ? 154 : 213)}px;
  height: ${({ size }) => (size === 'small' ? 44 : 48)}px;
  pointer-events: none;
`;

const ToggleLabel = styled.label<Pick<Props, 'size' | 'isChecked'>>`
  ${({ theme }) => theme.flex.flexCenterRow};
  position: relative;
  overflow: hidden;
  cursor: pointer;
`;

const ToggleSwitch = styled.span<Pick<Props, 'size' | 'isChecked'>>`
  position: absolute;
  left: ${({ isChecked, size }) => (isChecked ? 0 : size === 'small' ? 72 : 101)}px;
  background: ${({ theme }) => theme.colors.primary500};
  border-radius: 20px;
  width: ${({ size }) => (size === 'small' ? 72 : 101)}px;
  height: ${({ size }) => (size === 'small' ? 36 : 40)}px;
  transition: all 0.2s ease-in-out;
`;

const ToggleItem = styled.div<Pick<Props, 'size' | 'isChecked'>>`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme, isChecked }) => (isChecked ? theme.typography.TextKRMedium14 : theme.typography.TextKRRegular14)}
  color: ${({ theme, isChecked }) => (isChecked ? theme.colors.blueBg : theme.colors.gray400)};
  width: ${({ size }) => (size === 'small' ? 72 : 101)}px;
  height: ${({ size }) => (size === 'small' ? 36 : 40)}px;
  z-index: 1;
  transition: all 0.2s ease-in-out;
  pointer-events: ${({ isChecked }) => (isChecked ? 'none' : 'fill')};
`;
