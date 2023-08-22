import Loading from './Loading';
import { render, screen } from '@/tests/test-util';

describe('Loading 컴포넌트 테스트', () => {
  beforeAll(() => {
    const portalRoot = document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');
    document.body.appendChild(portalRoot);
  });

  afterAll(() => {
    const portalRoot = document.getElementById('portal-root');
    if (portalRoot) {
      document.body.removeChild(portalRoot);
    }
  });

  it('로딩이 정상적으로 렌더링된다.', () => {
    render(<Loading data-testid='loading' />);

    expect(screen.getByTestId('loading')).toBeInTheDocument();
  });

  it('fullPage 로딩이 정상적으로 렌더링된다.', async () => {
    render(<Loading data-testid='loading' fullPage />);

    expect(screen.getByTestId('loading')).toBeInTheDocument();
  });

  describe('Loading 스냅샷 테스트', () => {
    it('default 일 때', () => {
      render(<Loading data-testid='loading' />);

      expect(screen.getByTestId('loading')).toMatchSnapshot();
    });

    it('fullPage 일 때', () => {
      render(<Loading data-testid='loading' fullPage />);

      expect(screen.getByTestId('loading')).toMatchSnapshot();
    });
  });
});
