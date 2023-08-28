import CategoryButton from './CategoryButton';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('CTAButton 컴포넌트 테스트', () => {
  it('버튼이 정상적으로 렌더링된다.', () => {
    render(<CategoryButton>버튼</CategoryButton>);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('버튼의 onClick 핸들러가 클릭시 정상적으로 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<CategoryButton onClick={mockOnClick}>버튼</CategoryButton>);

    userEvent.click(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼에 disabled 속성을 전달하면 disabled 된다.', async () => {
    const mockOnClick = vi.fn();
    render(
      <CategoryButton disabled onClick={mockOnClick}>
        버튼
      </CategoryButton>,
    );

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();
  });

  describe('CategoryButton 스냅샷 테스트', () => {
    it('isClicked속성이 false일 때 스냅샷이 일치한다.', () => {
      render(<CategoryButton isClicked={false}>버튼</CategoryButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('isClicked속성이 true일 때 스냅샷이 일치한다.', () => {
      render(<CategoryButton isClicked>버튼</CategoryButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });
  });
});
