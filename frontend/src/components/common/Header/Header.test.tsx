import Header from './Header';
import { render, screen, userEvent, waitFor } from '@/tests/test-util';

describe('Header 컴포넌트 테스트', () => {
  beforeEach(() => {
    const portalRoot = document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');
    document.body.appendChild(portalRoot);
  });

  it('Header가 정상적으로 렌더링된다.', () => {
    render(<Header />);

    expect(screen.getByTestId('header')).toBeInTheDocument();
  });

  it('로고를 클릭할 시 종료 확인 모달이 표시된다.', async () => {
    render(<Header />);
    const logo = screen.getByRole('heading', { level: 1 });

    userEvent.click(logo);

    await waitFor(() => {
      const text = screen.queryByText(/내 차 만들기를 종료하시겠습니까?/);
      expect(text).toBeInTheDocument();
    });
  });

  it('종료 버튼을 클릭할 시 종료 확인 모달이 표시된다.', async () => {
    render(<Header />);
    const closeButton = screen.getByRole('button', { name: '종료' });

    userEvent.click(closeButton);

    await waitFor(() => {
      const modalText = screen.queryByText('취소');
      expect(modalText).toBeInTheDocument();
    });
  });

  it('네비게이션 바의 탭을 클릭할 시 활성화 상태가 된다.', async () => {
    render(<Header />);
    const tab = screen.getByRole('button', { name: '타입' });

    userEvent.click(tab);

    await waitFor(() => {
      expect(tab).toHaveStyle('color: #00397B');
    });
  });

  it('Header 스냅샷 테스트', () => {
    render(<Header />);

    expect(screen.getByTestId('header')).toMatchSnapshot();
  });
});
