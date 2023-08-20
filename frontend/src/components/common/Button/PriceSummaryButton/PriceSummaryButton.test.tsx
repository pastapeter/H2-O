import PriceSummaryButton from './PriceSummaryButton';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('PriceSummaryButton 컴포넌트 테스트', () => {
  it('버튼이 정상적으로 렌더링된다.', () => {
    render(<PriceSummaryButton>버튼</PriceSummaryButton>);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('버튼의 onClick 핸들러가 클릭시 정상적으로 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<PriceSummaryButton onClick={mockOnClick}>버튼</PriceSummaryButton>);

    userEvent.click(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼이 disabled인 경우 클릭할 수 없다.', async () => {
    const mockOnClick = vi.fn();
    render(
      <PriceSummaryButton disabled onClick={mockOnClick}>
        버튼
      </PriceSummaryButton>,
    );

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();

    userEvent.click(button);
    await waitFor(() => expect(mockOnClick).not.toBeCalled());
  });

  describe('PriceSummaryButton 스냅샷 테스트', () => {
    it('버튼의 스냅샷이 일치한다.', () => {
      render(<PriceSummaryButton>버튼</PriceSummaryButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });
  });
});
