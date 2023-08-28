import MainSelector from './MainSelector';
import { render, screen } from '@/tests/test-util';

describe('MainSelector 컴포넌트 테스트', () => {
  it('MainSelector가 정상적으로 렌더링된다.', () => {
    render(<MainSelector data-testid='main' />);

    expect(screen.getByTestId('main')).toBeInTheDocument();
  });

  it('title props를 전달하면 타이틀 텍스트가 정상적으로 렌더링된다.', () => {
    render(<MainSelector data-testid='main' title='타이틀' />);

    expect(screen.getByText('타이틀')).toBeInTheDocument();
  });

  it('MainSelector 스냅샷 테스트', () => {
    render(<MainSelector data-testid='main' />);

    expect(screen.getByTestId('main')).toMatchSnapshot();
  });
});
