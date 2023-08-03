import { Icon } from '@/components/common';
import { ReactComponent as Logo } from '@/assets/logo/logo.svg';
import styled from '@emotion/styled';
import NavBar from './NavBar';

function Header() {
  return (
    <HeaderContainer>
      <LogoContainer>
        <h1>
          <Logo />
        </h1>
        <Divider />
        <ModelContainer>
          <span>팰리세이드</span>
          <Icon iconType='ArrowDown' size={12} />
        </ModelContainer>
      </LogoContainer>
      <NavBar />
      <EndContainer>
        <span>종료</span>
        <Icon iconType='Cancel' size={12} />
      </EndContainer>
    </HeaderContainer>
  );
}

export default Header;

const HeaderContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenRow}
  ${({ theme }) => theme.spacing.spaceDefault}
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.gray800};
  border-bottom: 2px solid ${({ theme }) => theme.colors.gray200};
  position: fixed;
  top: 0;
  width: 100%;
  height: 60px;
`;

const LogoContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow}
  padding-top: 28px;
  padding-bottom: 10px;
  gap: 20px;
`;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.gray400};
  width: 1px;
  height: 13px;
`;

const ModelContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow}
  gap: 4px;
`;

const EndContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterRow}
  padding-top: 28px;
  padding-bottom: 10px;
  gap: 8px;
`;
