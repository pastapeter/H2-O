import { PropsWithChildren, ReactElement } from 'react';
import { render } from '@testing-library/react';
import PriceStaticBar from './PriceStaticBar';
import { calculateTotalPrice, priceRange, selectionInfo } from '@/mocks/data';
import { render as customRender, fireEvent, screen, waitFor } from '@/tests/test-util';
import { setPriceFormat , toSeparatedNumberFormat } from '@/utils/number';
import { StyleProvider } from '@/providers';
import { SelectionContext } from '@/providers/SelectionProvider';
import { COLORS } from '@/styles/colors';

function TestProviders({ children }: PropsWithChildren) {
  const dispatch = vi.fn();
  return (
    <StyleProvider>
      <SelectionContext.Provider value={{ selectionInfo, totalPrice: calculateTotalPrice(selectionInfo), dispatch }}>
        {children}
      </SelectionContext.Provider>
    </StyleProvider>
  );
}

function testRender(ui: ReactElement, options = {}) {
  render(ui, { wrapper: TestProviders, ...options });
}

describe('PriceStaticBar 컴포넌트 테스트 ', () => {
  it('selectionInfo가 있을 경우 전역상태의 maxPrice,minPrice로 PriceStaticBar 컴포넌트가 렌더링 된다. 가격 범위는 만원단위로 나타난다.', () => {
    testRender(<PriceStaticBar />);

    fireEvent.click(screen.getByTestId('ArrowDown'));

    if (!selectionInfo.priceRange) throw new Error('가격 범위가 정의되어 있지 않습니다.');

    expect(screen.getByText(`${setPriceFormat(selectionInfo.priceRange.maxPrice)}만원`)).toBeInTheDocument();
    expect(screen.getByText(`${setPriceFormat(selectionInfo.priceRange.minPrice)}만원`)).toBeInTheDocument();
  });

  it('selectionInfo가 없을 경우 서버에서 priceRange 데이터를 받아서 상태를 업데이트 한 후 컴포넌트를 렌더링한다.', async () => {
    customRender(<PriceStaticBar />);

    expect(screen.queryByTestId('price-static-bar')).not.toBeInTheDocument();

    await waitFor(() => {
      expect(screen.getByTestId('price-static-bar')).toBeInTheDocument();
    });

    fireEvent.click(screen.getByTestId('ArrowDown'));

    expect(screen.getByText(`${setPriceFormat(priceRange.maxPrice)}만원`)).toBeInTheDocument();
    expect(screen.getByText(`${setPriceFormat(priceRange.minPrice)}만원`)).toBeInTheDocument();
  });

  it('PriceStaticBar 컴포넌트의 렌더링 직후에는 활성되어 있지 않는다. 즉, 슬라이더가 보여지지 않는다.', () => {
    testRender(<PriceStaticBar />);

    expect(screen.getByTestId('price-static-bar')).toHaveStyle('height: 40px');
    expect(screen.queryByRole('slider')).not.toBeInTheDocument();
  });

  it('arrowDown 아이콘을 통해서 PriceStaticBar 컴포넌트를 활성화 시킬 수 있다. 즉, 슬라이더가 나타난다.', () => {
    testRender(<PriceStaticBar />);

    const arrowDown = screen.getByTestId('ArrowDown');
    fireEvent.click(arrowDown);

    expect(screen.getByTestId('price-static-bar')).toHaveStyle('height: 97px');
  });

  it('slider을 움직였을 때, totalPrice보다 내가 설정한 예산 범위보다 크면 에산 범위가 얼만큼 더 남았는지 보여준다.', () => {
    testRender(<PriceStaticBar />);
    const arrowDown = screen.getByTestId('ArrowDown');
    fireEvent.click(arrowDown);

    const changeEvent = { target: { value: 42220001 } };
    const slider = screen.getByRole('slider');

    fireEvent.change(slider, changeEvent);

    const priceText = screen.getByText(
      `${toSeparatedNumberFormat(Math.abs(changeEvent.target.value - calculateTotalPrice(selectionInfo)))}원`,
    );
    expect(priceText).toBeInTheDocument();
    expect(priceText).toHaveStyle(`color: ${COLORS.activeBlue2}`);
    expect(screen.getByText(/남았어요./)).toBeInTheDocument();
  });

  it('slider을 움직였을 때, 내가 설정한 예산 범위보다 totalPrice가 크면 에산 범위가 얼만큼 더 남았는지 보여준다.', () => {
    testRender(<PriceStaticBar />);
    const arrowDown = screen.getByTestId('ArrowDown');
    fireEvent.click(arrowDown);

    const changeEvent = { target: { value: 40000000 } };
    const slider = screen.getByRole('slider');

    fireEvent.change(slider, changeEvent);

    const priceText = screen.getByText(
      `${toSeparatedNumberFormat(Math.abs(changeEvent.target.value - calculateTotalPrice(selectionInfo)))}원`,
    );
    expect(priceText).toBeInTheDocument();
    expect(priceText).toHaveStyle(`color: ${COLORS.sand}`);
    expect(screen.getByText(/더 들었어요./)).toBeInTheDocument();
  });
});
