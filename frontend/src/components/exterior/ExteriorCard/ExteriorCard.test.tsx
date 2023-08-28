import ExteriorCard from './ExteriorCard';
import { render, screen } from '@/tests/test-util';
import { toPriceFormatString } from '@/utils/string';
import { COLORS } from '@/styles/colors';

describe('Exterior Card 컴포넌트 테스트', () => {
  const props = {
    colorName: '어비스 블랙 펄',
    colorHexCode: '#121212',
    choiceRatio: 21,
    price: 0,
    isClicked: true,
  };

  it('외장 색상 카드가 정상적으로 렌더링된다.', () => {
    render(<ExteriorCard data-testid='card' {...props} />);

    expect(screen.getByTestId('card')).toBeInTheDocument();
  });

  it('카드의 속성 중 colorHexCode로 카드 작은 원의 색상이 채워지고, isClicked가 true이면 큰 원의 테두리 색이 primary500, false이면 gray50이다.', () => {
    render(<ExteriorCard data-testid='cardIsClicked' {...props} />);
    const circlesIsClicked = screen.getByTestId('cardIsClicked').getElementsByClassName('circle');

    const newProps = { ...props, isClicked: false };
    render(<ExteriorCard data-testid='cardIsNotClicked' {...newProps} />);
    const circlesIsNotClicked = screen.getByTestId('cardIsNotClicked').getElementsByClassName('circle');

    expect(circlesIsClicked).toHaveLength(2);
    expect(circlesIsClicked[0]).toHaveAttribute('stroke', COLORS.primary500);
    expect(circlesIsClicked[1]).toHaveAttribute('fill', props.colorHexCode);

    expect(circlesIsNotClicked).toHaveLength(2);
    expect(circlesIsNotClicked[0]).toHaveAttribute('stroke', COLORS.gray50);
    expect(circlesIsNotClicked[1]).toHaveAttribute('fill', newProps.colorHexCode);
  });

  it('카드의 속성 중 choiceRatio, colorName, price에 따라 카드에 나타나는 text가 달라진다.', () => {
    render(<ExteriorCard data-testid='card' {...props} />);
    const card = screen.getByTestId('card');

    expect(card).toHaveTextContent(`${props.choiceRatio}%가 선택했어요`);
    expect(card).toHaveTextContent(`${props.colorName}`);
    expect(card).toHaveTextContent(`${toPriceFormatString(props.price)} 원`);
  });

  it('카드의 속성 중 텍스트 색상이 속성 isClicked에 따라 달라진다. (isClicked가 true일 경우)', () => {
    const newProps = { ...props, isClicked: false };
    render(<ExteriorCard data-testid='card' {...newProps} />);

    expect(document.getElementsByClassName('ratio')[0]).toHaveStyle(`color: ${COLORS.gray600}`);
    expect(document.getElementsByClassName('ratio')[0].getElementsByTagName('span')[0]).toHaveStyle(
      `color: ${COLORS.gray600}`,
    );
    expect(document.getElementsByClassName('name')[0]).toHaveStyle(`color: ${COLORS.gray500}`);
    expect(document.getElementsByClassName('price')[0]).toHaveStyle(`color: ${COLORS.gray600}`);
  });

  it('카드의 속성 중 텍스트 색상이 속성 isClicked에 따라 달라진다. (isClicked가 false일 경우)', () => {
    render(<ExteriorCard data-testid='card' {...props} />);

    expect(document.getElementsByClassName('ratio')[0]).toHaveStyle(`color: ${COLORS.gray700}`);
    expect(document.getElementsByClassName('ratio')[0].getElementsByTagName('span')[0]).toHaveStyle(
      `color: ${COLORS.activeBlue}`,
    );
    expect(document.getElementsByClassName('name')[0]).toHaveStyle(`color: ${COLORS.gray900}`);
    expect(document.getElementsByClassName('price')[0]).toHaveStyle(`color: ${COLORS.gray900}`);
  });

  it('카드의 속성 중 isClicked가 true이면 배경색이 cardBg, border 색상이 activeBlue이다. 또한 체크 아이콘 색상이 activeBlue이다.', () => {
    render(<ExteriorCard data-testid='card' {...props} />);
    const card = screen.getByTestId('card');

    expect(card).toHaveStyleRule('background-color', COLORS.cardBg);
    expect(card).toHaveStyleRule('border-color', COLORS.activeBlue);
    expect(screen.getByTestId('Check')).toHaveAttribute('fill', COLORS.activeBlue);
  });

  it('카드의 속성 중 isClicked가 false이면 배경색이 white이고 호버할 경우 배경색이 hoverBg로 바뀐다. 또한 체크 아이콘 색상이 gray200이다.', () => {
    const newProps = { ...props, isClicked: false };
    render(<ExteriorCard data-testid='card' {...newProps} />);
    const card = screen.getByTestId('card');

    expect(card).toHaveStyleRule('background-color', COLORS.white);
    expect(card).toHaveStyleRule('background-color', COLORS.hoverBg, { target: ':hover' });
    expect(screen.getByTestId('Check')).toHaveAttribute('fill', COLORS.gray200);
  });
});
