import CTACTypeButton from './CTACTypeButton';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('CTAButton 컴포넌트 테스트', () => {
  it('버튼이 정상적으로 렌더링된다.', () => {
    render(<CTACTypeButton>버튼</CTACTypeButton>);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('버튼의 onClick 핸들러가 클릭시 정상적으로 호출된다.', async () => {
    const mockOnClick = vi.fn();
    render(<CTACTypeButton onClick={mockOnClick}>버튼</CTACTypeButton>);

    userEvent.click(screen.getByRole('button'));
    await waitFor(() => expect(mockOnClick).toBeCalledTimes(1));
  });

  it('버튼에 disabled 속성을 전달하면 disabled 된다.', async () => {
    const mockOnClick = vi.fn();
    render(
      <CTACTypeButton disabled onClick={mockOnClick}>
        버튼
      </CTACTypeButton>,
    );

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();

    userEvent.click(button);
    await waitFor(() => expect(mockOnClick).not.toBeCalled());
  });

  describe('CTACTypeButton 스냅샷 테스트', () => {
    it('size 속성이 small일 때 스냅샷이 일치한다.', () => {
      render(<CTACTypeButton size='small'>버튼</CTACTypeButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('size 속성이 large일 때 스냅샷이 일치한다.', () => {
      render(<CTACTypeButton size='large'>버튼</CTACTypeButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('color 속성이 gray일 때 스냅샷이 일치한다.', () => {
      render(<CTACTypeButton color='gray'>버튼</CTACTypeButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });

    it('color 속성이 primary 일 때 스냅샷이 일치한다.', () => {
      render(<CTACTypeButton color='primary'>버튼</CTACTypeButton>);

      expect(screen.getByRole('button')).toMatchSnapshot();
    });
  });
});
