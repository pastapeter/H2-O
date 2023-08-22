import Footer from './Footer';
import { render, screen } from '@/tests/test-util';

// TODO: 버튼 팝업 오픈 테스트 추가해야함, 이상하게 click 했음에도 팝업이 띄워지지 않아 일단 보류
describe('Footer 컴포넌트 테스트', () => {
  beforeAll(() => {
    const portalRoot = document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');
    document.body.appendChild(portalRoot);
  });

  it('Footer 정상적으로 렌더링된다.', () => {
    render(<Footer />);

    expect(screen.getByTestId('footer')).toBeInTheDocument();
  });

  it('Footer에 children이 정상적으로 렌더링된다.', () => {
    render(
      <Footer>
        <span>hi</span>
      </Footer>,
    );

    expect(screen.getByText('hi')).toBeInTheDocument();
  });

  it('Footer에 isSticky이 true일 때, position이 sticky로 설정된다.', () => {
    render(<Footer isSticky />);

    expect(screen.getByTestId('footer')).toHaveStyleRule('position', 'sticky');
  });

  it('Footer 스냅샷 테스트', () => {
    render(<Footer />);

    expect(screen.getByTestId('footer')).toMatchSnapshot();
  });
});
