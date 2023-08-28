import { useContext } from 'react';
import { render } from '@testing-library/react';
import SlideProvider, { SlideContext } from './SlideProvider';
import { screen, userEvent, waitFor } from '@/tests/test-util';

const Child = () => {
  const context = useContext(SlideContext);
  if (!context) throw new Error('SlideContext is null');

  const { currentSlide, setCurrentSlide } = context;

  const handleClick = () => {
    setCurrentSlide(currentSlide + 1);
  };

  return <button onClick={handleClick}>{`current slide is ${currentSlide}`}</button>;
};

const renderComponentWithProvider = () => {
  render(<Child />, {
    wrapper: SlideProvider,
  });
};

describe('SlideProvider 테스트', () => {
  it('SlideProvider가 children 컴포넌트를 정상적으로 렌더링 한다.', () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('SlideProvider의 children 컴포넌트가 context의 currentSlide 값을 정상적으로 참조한다.', () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toHaveTextContent('current slide is 0');
  });

  it('context의 setCurrentSlide 함수를 통해서 currentSlide의 값을 변경할 수 있다.', async () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toHaveTextContent('current slide is 0');
    userEvent.click(screen.getByRole('button'));

    await waitFor(() => expect(screen.getByRole('button')).toHaveTextContent('current slide is 1'));
  });
});
