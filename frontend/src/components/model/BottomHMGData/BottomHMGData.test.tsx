import BottomHMGData from './BottomHMGData';
import { render, screen, waitForElementToBeRemoved } from '@/tests/test-util';

describe('BottomHMGData 컴포넌트 테스트', () => {
  const mockPowerTrain = {
    id: 1,
    name: '가솔린 2.0',
    price: 0,
    image: '',
  };

  const mockDriveTrain = {
    id: 1,
    name: '2WD',
    price: 0,
    image: '',
  };

  it('컴포넌트가 렌더링되고 데이터 fetching이 발생하면 로딩 UI가 표시된다.', () => {
    const mockFn = vi.fn();
    render(<BottomHMGData powerTrain={mockPowerTrain} driveTrain={mockDriveTrain} setTechnicalSpec={mockFn} />);

    expect(screen.getByText('데이터를 불러오는 중입니다...')).toBeInTheDocument();
  });

  it('컴포넌트가 정상적으로 렌더링된다.', async () => {
    const mockFn = vi.fn();
    render(<BottomHMGData powerTrain={mockPowerTrain} driveTrain={mockDriveTrain} setTechnicalSpec={mockFn} />);

    await waitForElementToBeRemoved(() => screen.queryByText('데이터를 불러오는 중입니다...'));
    expect(mockFn).toHaveBeenCalledTimes(1);

    expect(screen.getByText('배기량과 평균연비입니다.')).toBeInTheDocument();
  });

  it('컴포넌트에 전달된 powertrain과 drivetrain의 이름을 표시한다.', async () => {
    const mockFn = vi.fn();
    render(<BottomHMGData powerTrain={mockPowerTrain} driveTrain={mockDriveTrain} setTechnicalSpec={mockFn} />);

    await waitForElementToBeRemoved(() => screen.queryByText('데이터를 불러오는 중입니다...'));
    expect(mockFn).toHaveBeenCalledTimes(1);

    expect(screen.getByText('가솔린 2.0')).toBeInTheDocument();
    expect(screen.getByText('2WD')).toBeInTheDocument();
  });

  it('컴포넌트에 전달된 powertrain과 drivetrain에 따른 배기량과 연비정보를 표시한다.', async () => {
    const mockFn = vi.fn();
    render(<BottomHMGData powerTrain={mockPowerTrain} driveTrain={mockDriveTrain} setTechnicalSpec={mockFn} />);

    await waitForElementToBeRemoved(() => screen.queryByText('데이터를 불러오는 중입니다...'));
    expect(mockFn).toHaveBeenCalledTimes(1);

    expect(screen.getByText('3,778cc')).toBeInTheDocument();
    expect(screen.getByText('9.23km/L')).toBeInTheDocument();
  });
});
