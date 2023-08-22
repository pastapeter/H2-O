import Card from './Card';
import { render, screen } from '@/tests/test-util';

describe('Card 컴포넌트 테스트', () => {
  it('카드가 정상적으로 렌더링된다.', () => {
    render(<Card>카드</Card>);

    expect(screen.getByText('카드')).toBeInTheDocument();
  });

  describe('Card 스냅샷 테스트', () => {
    it('카드 스냅샷 테스트', () => {
      render(<Card>카드</Card>);

      expect(screen.getByText('카드')).toMatchSnapshot();
    });

    it('isSelected가 true일 때 스냅샷 테스트', () => {
      render(<Card isSelected>카드</Card>);

      expect(screen.getByText('카드')).toMatchSnapshot();
    });
  });
});
