import Portal from './Portal';
import { render, screen } from '@/tests/test-util';

describe('Portal 컴포넌트 테스트', () => {
  beforeEach(() => {
    const portalRoot = global.document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');

    const body = global.document.querySelector('body');
    if (!body) throw new Error('portal-root의 body를 찾을 수 없습니다.');
    body.appendChild(portalRoot);
  });

  it('Portal이 정상적으로 렌더링 된다.', () => {
    render(<Portal />);

    expect(document.getElementById('portal-root')).toBeInTheDocument();
  });

  it('Portal의 child가 정상적으로 렌더링 된다.', () => {
    render(
      <Portal>
        <span>Hello World</span>
      </Portal>,
    );

    expect(screen.getByText('Hello World')).toBeInTheDocument();
  });

  it('Portal 컴포넌트 스냅샷 테스트', () => {
    render(<Portal />);

    expect(document.getElementById('portal-root')).toMatchSnapshot();
  });
});
