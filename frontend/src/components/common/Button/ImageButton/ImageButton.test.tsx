import ImageButton from './ImageButton';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('CTAButton 컴포넌트 테스트', () => {
  it('버튼이 정상적으로 렌더링된다.', () => {
    render(<ImageButton>버튼</ImageButton>);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('버튼의 onClick 핸들러가 클릭시 정상적으로 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<ImageButton onClick={mockOnClick}>버튼</ImageButton>);

    userEvent.click(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼에 disabled 속성을 전달하면 disabled 된다.', async () => {
    const mockOnClick = vi.fn();
    render(
      <ImageButton disabled onClick={mockOnClick}>
        버튼
      </ImageButton>,
    );

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();

    userEvent.click(button);
    await waitFor(() => expect(mockOnClick).not.toBeCalled());
  });

  describe('ImageButton 스냅샷 테스트', () => {
    it('버튼의 스냅샷이 일치한다.', () => {
      render(<ImageButton>버튼</ImageButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });
  });
});
