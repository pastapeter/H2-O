import NavBar from './NavBar';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';
import { SlideContext } from '@/providers/SlideProvider';

describe('NavBar 컴포넌트 테스트', () => {
  it('NavBar가 정상적으로 렌더링된다.', () => {
    render(<NavBar />);

    expect(screen.getByRole('navigation')).toBeInTheDocument();
  });

  it('NavBar의 탭 버튼을 누르면 setCurrentSlide가 정상적으로 호출된다.', async () => {
    const currentSlide = 0;
    const setCurrentSlide = vi.fn();

    render(
      <SlideContext.Provider value={{ currentSlide, setCurrentSlide }}>
        <NavBar />
      </SlideContext.Provider>,
    );

    const tab = screen.getByRole('button', { name: '타입' });
    userEvent.click(tab);

    await waitFor(() => expect(setCurrentSlide).toBeCalledTimes(1));
  });
});
