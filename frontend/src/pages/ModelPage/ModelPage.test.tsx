import ModelPage from './ModelPage';
import { modelType } from '@/mocks/data';
import { render, screen, userEvent, waitFor, waitForElementToBeRemoved } from '@/tests/test-util';

describe('모델타입 페이지 통합테스트', () => {
  const { powertrains, bodytypes, drivetrains } = modelType;

  it('모델타입 페이지에 진입하면 데이터를 불러오는 동안 로딩 UI가 표시된다.', async () => {
    render(<ModelPage />);

    expect(screen.getByText(/데이터를 불러오는 중입니다.../)).toBeInTheDocument();
  });

  it('데이터를 성공적으로 불러오면 배너에 첫번째 파워트레인의 정보가 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    expect(screen.getByText(powertrains[0].name, { selector: 'h2' })).toBeInTheDocument();
    expect(screen.getByText(powertrains[0].description)).toBeInTheDocument();
  });

  it('데이터를 성공적으로 불러오면 불러온 파워트레인이 카드에 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    expect(screen.getByText(powertrains[0].name, { selector: 'p' })).toBeInTheDocument();
    expect(screen.getByText(powertrains[1].name, { selector: 'p' })).toBeInTheDocument();
  });

  it('데이터를 성공적으로 불러오면 불러온 바디타입이 카드에 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    expect(screen.getByText(bodytypes[0].name, { selector: 'p' })).toBeInTheDocument();
    expect(screen.getByText(bodytypes[1].name, { selector: 'p' })).toBeInTheDocument();
  });

  it('데이터를 성공적으로 불러오면 불러온 구동방식이 카드에 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    expect(screen.getByText(drivetrains[0].name, { selector: 'p' })).toBeInTheDocument();
    expect(screen.getByText(drivetrains[1].name, { selector: 'p' })).toBeInTheDocument();
  });

  it('파워트레인 카드를 클릭하면 배너에 해당하는 파워트레인의 정보가 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    userEvent.click(screen.getByText(powertrains[1].name, { selector: 'p' }));

    await waitFor(() => {
      expect(screen.getByText(powertrains[1].name, { selector: 'h2' })).toBeInTheDocument();
    });
  });

  it('바디타입 카드를 클릭하면 배너에 해당하는 바디타입의 정보가 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    userEvent.click(screen.getByText(bodytypes[1].name, { selector: 'p' }));

    await waitFor(() => {
      expect(screen.getByText(bodytypes[1].name, { selector: 'h2' })).toBeInTheDocument();
    });
  });

  it('구동방식 카드를 클릭하면 배너에 해당하는 구동방식의 정보가 표시된다.', async () => {
    render(<ModelPage />);

    await waitForElementToBeRemoved(screen.queryByText(/데이터를 불러오는 중입니다.../));

    userEvent.click(screen.getByText(drivetrains[1].name, { selector: 'p' }));

    await waitFor(() => {
      expect(screen.getByText(drivetrains[1].name, { selector: 'h2' })).toBeInTheDocument();
    });
  });
});
