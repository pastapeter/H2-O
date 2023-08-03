import styled from '@emotion/styled';
import Tab from './Tab';

function NavBar() {
  return (
    <NavContainer>
      <Tab state='active'>트림</Tab>
      <Tab state='complete'>타입</Tab>
      <Tab>외장</Tab>
      <Tab>내장</Tab>
      <Tab>옵션</Tab>
      <Tab>완료</Tab>
    </NavContainer>
  );
}

export default NavBar;

const NavContainer = styled.nav`
  ${({ theme }) => theme.flex.flexCenterRow}
  ${({ theme }) => theme.typography.TextKRMedium14}
  color: ${({ theme }) => theme.colors.gray200};
  position: absolute;
  left: 50%;
  transform: translate(-50%);
  padding-top: 30px;
  height: 60px;
  gap: 40px;
`;
