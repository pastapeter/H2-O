import Popup from './Popup';
import { fireEvent, render, screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';

describe('Popup 컴포넌트 테스트', () => {
  beforeEach(() => {
    const portalRoot = global.document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');

    const body = global.document.querySelector('body');
    if (!body) throw new Error('portal-root의 body를 찾을 수 없습니다.');
    body.appendChild(portalRoot);
  });

  const handleClickedDimmend = vi.fn();

  it('Popup 컴포넌트가 정상적으로 렌더링 된다.', () => {
    render(<Popup size='small' handleClickDimmed={handleClickedDimmend} />);

    const portalRoot = document.getElementById('portal-root');
    expect(portalRoot).toBeInTheDocument();
  });

  it('Popup 컴포넌트를 렌더링하면 기본적으로 dimmmed와 작은 흰색 팝업창이 생성된다.', () => {
    render(<Popup size='small' handleClickDimmed={handleClickedDimmend} />);

    expect(screen.getByTestId('dimmed')).toBeInTheDocument();
    expect(screen.getByRole('dialog')).toBeInTheDocument();
    expect(screen.getByRole('dialog')).toHaveStyle(`background:${COLORS.white}`);
    expect(screen.getByRole('dialog')).toHaveStyle('border-radius:4px; width: 336px; height:200px;');
  });

  it('Popup size 속성을 통해서 흰색 팝업창의 크기를 조절할 수 있다.', () => {
    render(<Popup size='large' handleClickDimmed={handleClickedDimmend} />);

    expect(screen.getByRole('dialog')).toBeInTheDocument();
    expect(screen.getByRole('dialog')).toHaveStyle(`background:${COLORS.white}`);
    expect(screen.getByRole('dialog')).toHaveStyle('border-radius:8px; width: 850px; height:520px;');
  });

  it('Popup의 Dimmed 영역을 클릭하면 클릭 이벤트가 실행된다.', () => {
    render(<Popup size='large' handleClickDimmed={handleClickedDimmend} />);

    const dimmedElement = screen.getByTestId('dimmed');
    fireEvent.click(dimmedElement);

    expect(handleClickedDimmend).toBeCalledTimes(1);
  });

  describe('Popup 컴포넌트 스냅샷 테스트', () => {
    it('Popup 컴포넌트 size가 small인 컴포넌트 스냅샷', () => {
      render(<Popup size='small' handleClickDimmed={handleClickedDimmend} />);

      expect(document.getElementById('portal-root')).toMatchSnapshot();
    });

    it('Popup 컴포넌트 size가 large인 컴포넌트 스냅샷', () => {
      render(<Popup size='large' handleClickDimmed={handleClickedDimmend} />);

      expect(document.getElementById('portal-root')).toMatchSnapshot();
    });
  });
});
