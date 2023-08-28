import CTAButton from './CTAButton';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('CTAButton 컴포넌트 테스트', () => {
  it('버튼이 정상적으로 렌더링된다.', () => {
    render(<CTAButton>버튼</CTAButton>);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('버튼의 onClick 핸들러가 클릭시 정상적으로 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<CTAButton onClick={mockOnClick}>버튼</CTAButton>);

    userEvent.click(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼을 다중 클릭할 시 핸들러가 한번만 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<CTAButton onClick={mockOnClick}>버튼</CTAButton>);

    userEvent.tripleClick(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼이 disabled인 경우 클릭할 수 없다.', async () => {
    const mockOnClick = vi.fn();
    render(
      <CTAButton disabled onClick={mockOnClick}>
        버튼
      </CTAButton>,
    );

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();

    userEvent.click(button);
    await waitFor(() => expect(mockOnClick).not.toBeCalled());
  });

  it('버튼의 isFull 속성이 true일 경우 width가 100%이다.', () => {
    render(<CTAButton isFull>버튼</CTAButton>);

    expect(screen.getByRole('button')).toHaveStyle('width: 100%');
  });

  describe('CTAButton 스냅샷 테스트', () => {
    it('size 속성이 small일 때 스냅샷이 일치한다.', () => {
      render(<CTAButton size='small'>버튼</CTAButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('size 속성이 medium일 때 스냅샷이 일치한다.', () => {
      render(<CTAButton size='medium'>버튼</CTAButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('size 속성이 large일 때 스냅샷이 일치한다.', () => {
      render(<CTAButton size='large'>버튼</CTAButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });
  });
});
