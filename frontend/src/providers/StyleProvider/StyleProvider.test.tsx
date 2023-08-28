import { css, useTheme } from '@emotion/react';
import { render } from '@testing-library/react';
import StyleProvider from './StyleProvider';
import { screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';
import { TYPOGRAPHY } from '@/styles/typography';

const Child = () => {
  const theme = useTheme();

  return (
    <button
      css={css`
        ${theme.typography.CaptionENMedium12}
        color: ${theme.colors.activeBlue};
      `}
    >
      버튼
    </button>
  );
};

const renderComponentWithProvider = () => {
  render(<Child />, {
    wrapper: StyleProvider,
  });
};

describe('StyleProvider 테스트', () => {
  it('StyleProvider가 children 컴포넌트를 정상적으로 렌더링 한다.', () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('StyleProvider의 children 컴포넌트가 theme의 color값을 사용할 수 있다.', () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toHaveStyleRule('color', COLORS.activeBlue);
  });

  it('StyleProvider의 children 컴포넌트가 theme의 typography값을 사용할 수 있다.', () => {
    renderComponentWithProvider();

    const button = screen.getByRole('button');
    const { fontFamily, fontSize, fontWeight, lineHeight, letterSpacing } = TYPOGRAPHY['CaptionENMedium12'];

    expect(button).toHaveStyleRule('font-family', fontFamily);
    expect(button).toHaveStyleRule('font-size', fontSize);
    expect(button).toHaveStyleRule('font-weight', String(fontWeight));
    expect(button).toHaveStyleRule('line-height', lineHeight);
    expect(button).toHaveStyleRule('letter-spacing', letterSpacing);
  });

  it('StyleProvider의 children 컴포넌트는 GlobalStyle의 전역스타일을 상속받는다.', async () => {
    renderComponentWithProvider();

    expect(screen.getByRole('button')).toHaveStyle('cursor: pointer');
  });
});
