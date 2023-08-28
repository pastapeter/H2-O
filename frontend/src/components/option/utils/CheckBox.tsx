import { HTMLAttributes } from 'react';
import styled from '@emotion/styled';
import { Icon } from '@/components/common';

interface Props extends HTMLAttributes<HTMLButtonElement> {
  isActive: boolean;
}

function CheckBox({ isActive, ...restProps }: Props) {
  return (
    <StyleIcon isActive={isActive} {...restProps}>
      <Icon iconType='Check' size={24} color={isActive ? 'white' : 'gray500'} />
    </StyleIcon>
  );
}

export default CheckBox;

const StyleIcon = styled.button<Pick<Props, 'isActive'>>`
  ${({ theme }) => theme.flex.flexCenterCol}
  background-color: ${({ theme, isActive }) => (isActive ? theme.colors.activeBlue : theme.colors.white)};
  border-radius: 2px;
  border: ${({ theme, isActive }) => !isActive && `1px solid ${theme.colors.gray200}`};
  width: 32px;
  height: 32px;
`;
