import { HTMLAttributes } from 'react';
import { useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Icon } from '@/components/common';

interface Props extends HTMLAttributes<HTMLButtonElement> {
  isActive: boolean;
}

function CheckIcon({ isActive, ...restProps }: Props) {
  const theme = useTheme();
  return (
    <StyleIcon isActive={isActive} {...restProps}>
      <Icon iconType='Check' size={24} color={isActive ? theme.colors.white : theme.colors.gray500} />
    </StyleIcon>
  );
}

export default CheckIcon;

const StyleIcon = styled.button<Pick<Props, 'isActive'>>`
  ${({ theme }) => theme.flex.flexCenterCol}
  background-color: ${({ theme, isActive }) => (isActive ? theme.colors.activeBlue : theme.colors.white)};
  border-radius: 2px;
  border: ${({ theme, isActive }) => !isActive && `1px solid ${theme.colors.gray200}`};
  width: 32px;
  height: 32px;
`;
