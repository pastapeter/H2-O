import styled from '@emotion/styled';
import CloseMyCarPopup from './CloseMyCarPopup';
import { NavBar } from './NavBar';
import { Icon } from '@/components/common';
import { useToggle } from '@/hooks';
import { ReactComponent as Logo } from '@/assets/logo/logo.svg';

function Header() {
  const { status, setOff, setOn } = useToggle(false);

  return (
    <HeaderContainer data-testid='header'>
      <h1 onClick={setOn}>
        <Logo />
      </h1>
      <div>
        <HeaderLeft>
          <Divider />
          <ModelSelector>
            <span>팰리세이드</span>
            <Icon iconType='ArrowDown' size={12} />
          </ModelSelector>
        </HeaderLeft>
        <NavBar />
      </div>
      <CloseButton onClick={setOn}>
        <span>종료</span>
        <Icon iconType='Cancel' size={12} />
      </CloseButton>
      {status && <CloseMyCarPopup handleClickCancelButton={setOff} />}
    </HeaderContainer>
  );
}

export default Header;

const HeaderContainer = styled.header`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.gray800};
  background-color: white;
  border-bottom: 2px solid ${({ theme }) => theme.colors.gray200};
  padding-top: 28px;
  padding-bottom: 10px;
  position: fixed;
  top: 0;
  width: 100%;
  height: 60px;
  z-index: 5;

  & > div {
    ${({ theme }) => theme.flex.flexBetweenRow}
    width: 1024px;
  }

  h1 {
    ${({ theme }) => theme.flex.flexCenterRow}
    cursor: pointer;
    margin-right: 20px;
  }
`;

const HeaderLeft = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow}
  gap: 20px;
`;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.gray400};
  width: 1px;
  height: 13px;
`;

const ModelSelector = styled.button`
  ${({ theme }) => theme.flex.flexCenterRow}
  gap: 4px;
`;

const CloseButton = styled.button`
  ${({ theme }) => theme.flex.flexCenterRow}
  gap: 8px;
`;
