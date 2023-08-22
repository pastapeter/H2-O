import HMGTag from './HMGTag';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('HMGTag 컴포넌트 테스트', () => {
  it('HMGTag가 정상적으로 렌더링된다.', () => {
    render(<HMGTag />);

    expect(screen.getByText(/HMG Data/)).toBeInTheDocument();
  });

  it('onClick이 정상적으로 작동한다.', async () => {
    const mockFn = vi.fn();
    render(<HMGTag onClick={mockFn} />);

    userEvent.click(screen.getByText(/HMG Data/));

    await waitFor(() => expect(mockFn).toBeCalledTimes(1));
  });

  describe('HMGTag 스냅샷 테스트', () => {
    it('variant가 default일 때', () => {
      render(<HMGTag variant='default' />);

      expect(screen.getByText(/HMG Data/)).toMatchSnapshot();
    });

    it('variant가 small일 때', () => {
      render(<HMGTag variant='small' />);

      expect(screen.getByText(/HMG Data/)).toMatchSnapshot();
    });
  });
});
