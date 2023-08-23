import Toggle from './Toggle';
import { fireEvent, render, screen } from '@/tests/test-util';

describe('Toggle 컴포넌트 테스트', () => {
  it('Toggle 컴포넌트가 정상적으로 렌더링된다.', () => {
    const handleChangeToggle = vi.fn();
    render(<Toggle data-testid='toggle' size='small' isChecked={true} handleChangeToggle={handleChangeToggle} />);

    expect(screen.getByTestId('toggle')).toBeInTheDocument();
  });

  it('Toggle의 onChange 이벤트가 정상적으로 호출된다.', () => {
    const handleChangeToggle = vi.fn();
    render(<Toggle size='small' isChecked={true} handleChangeToggle={handleChangeToggle} />);

    const toggleInput = screen.getByText('외장');

    fireEvent.click(toggleInput);
    expect(handleChangeToggle).toHaveBeenCalledTimes(1);
  });

  describe('Toggle 스냅샷 테스트', () => {
    it('size 속성이 small, isChecked 속성이 true일 경우', () => {
      const handleChangeToggle = vi.fn();
      render(<Toggle data-testid='toggle' size='small' isChecked={true} handleChangeToggle={handleChangeToggle} />);

      expect(screen.getByTestId('toggle')).toMatchSnapshot();
    });

    it('size 속성이 small, isChecked 속성이 false 경우', () => {
      const handleChangeToggle = vi.fn();
      render(<Toggle data-testid='toggle' size='small' isChecked={false} handleChangeToggle={handleChangeToggle} />);

      expect(screen.getByTestId('toggle')).toMatchSnapshot();
    });

    it('size 속성이 large, isChecked 속성이 true일 경우', () => {
      const handleChangeToggle = vi.fn();
      render(<Toggle data-testid='toggle' size='large' isChecked={true} handleChangeToggle={handleChangeToggle} />);

      expect(screen.getByTestId('toggle')).toMatchSnapshot();
    });

    it('size 속성이 large, isChecked 속성이 false 경우', () => {
      const handleChangeToggle = vi.fn();
      render(<Toggle data-testid='toggle' size='large' isChecked={false} handleChangeToggle={handleChangeToggle} />);

      expect(screen.getByTestId('toggle')).toMatchSnapshot();
    });
  });
});
