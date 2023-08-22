import Divider from './Divider';
import { render, screen } from '@/tests/test-util';

describe('Divider 컴포넌트 테스트', () => {
  it('Divider 정상적으로 렌더링된다.', () => {
    render(<Divider data-testid='divider' length='100%' />);

    expect(screen.getByTestId('divider')).toBeInTheDocument();
  });

  describe('Divider 스냅샷 테스트', () => {
    it('horizontal 일 때', () => {
      render(<Divider data-testid='divider' length='100%' />);

      expect(screen.getByTestId('divider')).toMatchSnapshot();
    });

    it('vertical 일 때', () => {
      render(<Divider data-testid='divider' length='100%' vertical />);

      expect(screen.getByTestId('divider')).toMatchSnapshot();
    });

    it('color 가 주어졌을 때', () => {
      render(<Divider data-testid='divider' length='100%' color='activeBlue' />);

      expect(screen.getByTestId('divider')).toMatchSnapshot();
    });
  });
});
