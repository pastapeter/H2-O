import InteriorCard from './InteriorCard';
import { interiors } from '@/mocks/data';
import { render, screen } from '@/tests/test-util';

describe('InteriorCard 컴포넌트 테스트', () => {
  const { name, price, choiceRatio, fabricImage: image } = interiors[0];
  const props = {
    choiceRatio,
    name,
    price,
    image,
  };

  it('InteriorCard 컴포넌트가 정상적으로 렌더링 된다.', () => {
    render(<InteriorCard data-testid='card' {...props} />);

    expect(screen.getByTestId('card')).toBeInTheDocument();
  });

  it('props에 따라 카드에 나타나는 텍스트가 달라집니다.', () => {
    render(<InteriorCard data-testid='card' {...props} />);
    const card = screen.getByTestId('card');

    expect(card).toHaveTextContent(`${choiceRatio}%가 선택했어요`);
    expect(card).toHaveTextContent(`${name}`);
    expect(card).toHaveTextContent(`+0 원`);
  });

  describe('InteriorCard 스냅샷 테스트', () => {
    it('isSelected가 false일 때', () => {
      render(<InteriorCard data-testid='card' {...props} />);

      expect(screen.getByTestId('card')).toMatchSnapshot();
    });

    it('isSelected가 true일 때', () => {
      render(<InteriorCard data-testid='card' isSelected {...props} />);

      expect(screen.getByTestId('card')).toMatchSnapshot();
    });
  });
});
