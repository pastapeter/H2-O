import { PropsWithChildren, ReactElement } from 'react';
import { render } from '@testing-library/react';
import SummaryPopup from './SummaryPopup';
import { calculateTotalPrice, selectionInfo } from '@/mocks/data';
import { render as customRender, fireEvent, screen, waitFor } from '@/tests/test-util';
import { StyleProvider } from '@/providers';
import { SelectionContext } from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

const dispatchSelectionInfo = vi.fn();
const dispatchSlideInfo = vi.fn();

function TestProviders({ children }: PropsWithChildren) {
  return (
    <StyleProvider>
      <SlideContext.Provider value={{ currentSlide: 0, setCurrentSlide: dispatchSlideInfo }}>
        <SelectionContext.Provider
          value={{ selectionInfo, totalPrice: calculateTotalPrice(selectionInfo), dispatch: dispatchSelectionInfo }}
        >
          {children}
        </SelectionContext.Provider>
      </SlideContext.Provider>
    </StyleProvider>
  );
}

function TestProvidersWithoutExtraOptions({ children }: PropsWithChildren) {
  const newSelectionInfo = { ...selectionInfo, extraOptions: { optionList: [], price: 0 } };
  return (
    <StyleProvider>
      <SlideContext.Provider value={{ currentSlide: 0, setCurrentSlide: dispatchSlideInfo }}>
        <SelectionContext.Provider
          value={{
            selectionInfo: newSelectionInfo,
            totalPrice: calculateTotalPrice(newSelectionInfo),
            dispatch: dispatchSelectionInfo,
          }}
        >
          {children}
        </SelectionContext.Provider>
      </SlideContext.Provider>
    </StyleProvider>
  );
}

function testRender(ui: ReactElement, isExtraOption = true, options = {}) {
  isExtraOption
    ? render(ui, { wrapper: TestProviders, ...options })
    : render(ui, { wrapper: TestProvidersWithoutExtraOptions, ...options });
}

describe('SummaryPopup 컴포넌트 테스트', () => {
  beforeEach(() => {
    const portalRoot = document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');

    document.body.appendChild(portalRoot);
  });

  const handleClickCloseButton = vi.fn();

  it('SelectionInfo가 없으면 로딩 UI가 렌더링된다.', () => {
    customRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    expect(screen.getByText('데이터를 불러오는 중입니다...')).toBeInTheDocument();
  });

  it('SelectionInfo가 있으면 SummaryPopup 컴포넌트가 렌더링된다.', () => {
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    expect(screen.getByTestId('summary-modal')).toBeInTheDocument();
  });

  it('SummaryPopup 컴포넌트의 cancel 아이콘을 누르면 handleClickCloseButton이 실행된다.', () => {
    const handleClickCloseButton = vi.fn();
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    const cancelIcon = screen.getByTestId('Cancel');
    fireEvent.click(cancelIcon);

    expect(handleClickCloseButton).toBeCalledTimes(1);
  });

  it('SummaryPopup의 dimmed 영역을 클릭하면 handleClickCloseButton이 실행된다.', () => {
    const handleClickCloseButton = vi.fn();
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    const dimmed = screen.getByTestId('dimmed');
    fireEvent.click(dimmed);

    expect(handleClickCloseButton).toBeCalledTimes(1);
  });

  it('SummaryPopup의 견적 완료하기 버튼을 클릭하면 handleClickCloseButton와 setCurrentSlider가 실행된다.', () => {
    const handleClickCloseButton = vi.fn();
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    const button = screen.getByText('견적 완료하기');
    fireEvent.click(button);

    expect(handleClickCloseButton).toBeCalledTimes(1);
    expect(dispatchSlideInfo).toBeCalledTimes(1);
  });

  it('SummaryPopup에 3개의 divider로 분리되어 선택사항에 대한 정보가 표시된다.', () => {
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    expect(screen.getAllByTestId('divider')).toHaveLength(3);
  });

  it('extraOptions의 optionList가 빈 배열이면 - 를 표시한다.', () => {
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />, false);

    expect(screen.getAllByText('-')).toHaveLength(1);
  });

  it('내장 토글 버튼을 클릭하면 이미지가 외장색상에서 내장색상으로 바뀐다.', async () => {
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);
    expect(screen.getByAltText('외장색상 이미지')).toBeInTheDocument();

    const toggleButton = screen.getByText('내장');
    fireEvent.click(toggleButton);

    await waitFor(() => {
      expect(screen.getByAltText('내장색상 이미지')).toBeInTheDocument();
    });
  });

  it('SummaryPopup 스냅샷 테스트', () => {
    testRender(<SummaryPopup handleClickCloseButton={handleClickCloseButton} />);

    expect(screen.getByTestId('summary-modal')).toMatchSnapshot();
  });
});
