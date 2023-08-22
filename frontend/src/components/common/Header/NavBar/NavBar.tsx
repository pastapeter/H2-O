import styled from '@emotion/styled';
import Tab from './Tab';
import { useSafeContext } from '@/hooks';
import { SlideContext } from '@/providers/SlideProvider';

const TAB_LIST = ['트림', '타입', '외장', '내장', '옵션', '완료'];

function NavBar() {
  const { currentSlide, setCurrentSlide } = useSafeContext(SlideContext);

  const handleClickTab = (tabIdx: number) => {
    setCurrentSlide(tabIdx);
  };

  return (
    <NavContainer role='navigation'>
      {TAB_LIST.map((tab, idx) => (
        <Tab key={tab} state={getTabState(currentSlide, idx)} onClick={() => handleClickTab(idx)}>
          {tab}
        </Tab>
      ))}
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
  bottom: -2px;
  transform: translate(-50%);
  padding-top: 30px;
  height: 60px;
  gap: 40px;
`;

function getTabState(currentSlide: number, tabIdx: number) {
  if (currentSlide === tabIdx) {
    return 'active';
  }

  if (currentSlide > tabIdx) {
    return 'complete';
  }

  return 'inactive';
}
