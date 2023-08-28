import Slider from './Slider';
import { SLIDER_WIDTH } from './constants';
import { fireEvent, render, screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';

describe('Slider 컴포넌트 테스트', () => {
  const props = {
    sliderInfo: { value: 0, isOverPrice: true },
    minPrice: 0,
    maxPrice: 100000,
    totalPrice: 50,
    isComplete: true,
    handleChangeSliderInfo: vi.fn(),
  };

  it('Slider 컴포넌트가 정상적으로 렌더링 된다.', () => {
    render(<Slider data-testid='slider-container' {...props} />);

    expect(screen.getByTestId('slider-container')).toBeInTheDocument();
  });

  /* slider input */
  describe('Slider 컴포넌트의 input(slider) 컴포넌트 테스트', () => {
    it('Slider 컴포넌트의 input(slider) 컴포넌트가 정상적으로 렌더링 된다.', () => {
      render(<Slider data-testid='slider-container' {...props} />);

      expect(screen.getByRole('slider')).toBeInTheDocument();
    });

    it('Slider 속성 중 isComplete의 값이 true이면 input(slider)컴포넌트의 onChange이벤트가 방지된다.', () => {
      render(<Slider data-testid='slider-container' {...props} />);
      const sliderElement = screen.getByRole('slider') as HTMLInputElement;

      const changeEvent = { target: { value: 10 }, preventDefault: vi.fn() };
      fireEvent.change(sliderElement, changeEvent);

      expect(Number(sliderElement.value)).not.toBe(changeEvent.target.value);
      expect(Number(sliderElement.value)).toBe(props.sliderInfo.value);
    });

    it('Slider 속성 중 isComplete의 값이 false이면 input(slider)컴포넌트의 Slider 속성 중 handleChangeSliderInfo가 실행된다.', () => {
      const newProps = { ...props, isComplete: false };
      render(<Slider data-testid='slider-container' {...newProps} />);
      const sliderElement = screen.getByRole('slider') as HTMLInputElement;

      const changeEvent = { target: { value: 10 }, preventDefault: vi.fn() };
      fireEvent.change(sliderElement, changeEvent);

      expect(props.handleChangeSliderInfo).toBeCalled();
    });

    it('Slider 속성 중 isComplete의 값이 false이면 input(slider)컴포넌트의 Slider 속성 중 handleChangeSliderInfo가 실행된다.', () => {
      const newProps = { ...props, isComplete: false };
      render(<Slider data-testid='slider-container' {...newProps} />);
      const sliderElement = screen.getByRole('slider') as HTMLInputElement;

      const changeEvent = { target: { value: 10 }, preventDefault: vi.fn() };
      fireEvent.change(sliderElement, changeEvent);

      expect(props.handleChangeSliderInfo).toBeCalled();
    });

    it('Slider 속성 중 isComplete의 값이 false이면 input(slider)컴포넌트의 Slider 속성 중 handleChangeSliderInfo가 실행된다.', () => {
      const newProps = { ...props, isComplete: false };
      render(<Slider data-testid='slider-container' {...newProps} />);
      const sliderElement = screen.getByRole('slider') as HTMLInputElement;

      const changeEvent = { target: { value: 10 }, preventDefault: vi.fn() };
      fireEvent.change(sliderElement, changeEvent);

      expect(props.handleChangeSliderInfo).toBeCalled();
    });
  });

  /* slider marker */
  describe('Slider 컴포넌트의 Marker(marker) 컴포넌트 테스트', () => {
    it('Slider 컴포넌트의 Marker가 정상적으로 렌더링 된다.', () => {
      render(<Slider data-testid='slider-container' {...props} />);

      expect(screen.getByTestId('marker')).toBeInTheDocument();
    });

    it('Slider 속성 중 sliderInfo의 isOverPrice 값이 true이면 Marker의 색상이 sand로 바뀐다.', () => {
      render(<Slider data-testid='slider-container' {...props} />);

      expect(screen.getByTestId('marker')).toHaveAttribute('fill', COLORS.sand);
    });

    it('Slider 속성 중 sliderInfo의 isOverPrice 값이 false이면 Marker의 색상이 activeBlue로 바뀐다.', () => {
      const newProps = { ...props, sliderInfo: { ...props.sliderInfo, isOverPrice: false } };
      render(<Slider data-testid='slider-container' {...newProps} />);

      expect(screen.getByTestId('marker')).toHaveAttribute('fill', COLORS.activeBlue);
    });

    it('Slider 속성 중 totalPrice, minPrice, maxPrice에 따라 Marker의 위치가 달라진다.', () => {
      const { totalPrice, minPrice, maxPrice } = props;
      const range = maxPrice - minPrice;
      const leftPosition = ((totalPrice - minPrice) / range) * SLIDER_WIDTH;

      render(<Slider data-testid='slider-container' {...props} />);

      expect(screen.getByTestId('marker')).toHaveStyle(`left: ${leftPosition}px`);
    });
  });
});
