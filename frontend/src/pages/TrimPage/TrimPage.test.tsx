import { fireEvent, render, screen, waitFor, waitForElementToBeRemoved } from '@/tests/test-util';
import { TrimPage } from '@/pages/TrimPage';

describe('트림페이지 통합 테스트', () => {
  beforeEach(() => {
    const portalRoot = document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');
    document.body.appendChild(portalRoot);
  });

  afterEach(() => {
    const portalRoot = document.getElementById('portal-root');
    if (portalRoot) {
      document.body.removeChild(portalRoot);
    }
  });

  it('트림 페이지에 초기 진입하면 데이터를 불러오는 동안 로딩 UI가 표시된다.', async () => {
    render(<TrimPage />);

    expect(screen.getByText(/데이터를 불러오는 중입니다.../)).toBeInTheDocument();
  });

  it('트림 페이지에 진입하면 불러온 데이터들의 트림정보들이 카드로 표시된다.', async () => {
    render(<TrimPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    expect(screen.getByRole('heading', { name: 'Le Blanc', level: 3 })).toBeInTheDocument();
    expect(screen.getByRole('heading', { name: 'Exclusive', level: 3 })).toBeInTheDocument();
    expect(screen.getByRole('heading', { name: 'Prestige', level: 3 })).toBeInTheDocument();
    expect(screen.getByRole('heading', { name: 'Calligraphy', level: 3 })).toBeInTheDocument();
  });

  it('트림 페이지에서 트림을 클릭하면 해당 트림의 이름이 배너에 표시된다.', async () => {
    render(<TrimPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    fireEvent.click(screen.getByRole('heading', { name: 'Exclusive', level: 3 }));

    await waitFor(() => {
      expect(screen.getByRole('heading', { name: 'Exclusive', level: 2 })).toBeInTheDocument();
    });
  });

  it('배너에 표시되는 트림의 외장,내장,휠 사진 중 접혀진 사진을 클릭하면 좌우로 펼쳐진다.', async () => {
    render(<TrimPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    const image = screen.getByAltText('이미지 1');
    fireEvent.click(image);
    expect(image).toHaveStyle('width: 504px');
  });
});
