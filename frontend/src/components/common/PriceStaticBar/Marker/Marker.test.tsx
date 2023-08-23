import Marker from './Marker';
import { render, screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';

describe('Marker 컴포넌트 테스트', () => {
  it('Marker 컴포넌트가 정상적으로 렌더링된다.', () => {
    render(<Marker />);

    expect(screen.getByTestId('marker')).toBeInTheDocument();
  });

  it('Marker의 컴폰넌트의 기본 색상은 white이다.', () => {
    render(<Marker />);

    expect(screen.getByTestId('marker')).toHaveAttribute('fill', COLORS.white);
  });

  it('Marker의 color 속성을 통해서 색상을 변경할 수 있다.', () => {
    render(<Marker color='activeBlue' />);

    expect(screen.getByTestId('marker')).toHaveAttribute('fill', COLORS.activeBlue);
  });

  it('Marker 컴포넌트 스냅샷 테스트', () => {
    render(<Marker />);

    expect(screen.getByTestId('marker')).toMatchSnapshot();
  });
});
