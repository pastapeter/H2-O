import Dimmed from './Dimmed';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('Dimmed 컴포넌트 테스트', () => {
  it('Dimmed가 정상적으로 렌더링된다.', () => {
    render(<Dimmed data-testid='dimmed' />);

    expect(screen.getByTestId('dimmed')).toBeInTheDocument();
  });

  it('onClick 이벤트가 정상적으로 동작한다.', async () => {
    const handleClick = vi.fn();
    render(<Dimmed data-testid='dimmed' onClick={handleClick} />);

    expect(handleClick).not.toBeCalled();
    userEvent.click(screen.getByTestId('dimmed'));

    await waitFor(() => expect(handleClick).toBeCalledTimes(1));
  });

  it('Dimmed 스냅샷 테스트', () => {
    render(<Dimmed data-testid='dimmed' />);

    expect(screen.getByTestId('dimmed')).toMatchSnapshot();
  });
});
