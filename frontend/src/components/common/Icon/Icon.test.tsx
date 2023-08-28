import Icon from './Icon';
import { render, screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';

describe('Icon 컴포넌트 테스트', () => {
  it('Icon이 정상적으로 렌더링된다.', () => {
    render(<Icon data-testid='icon' iconType='ArrowBack' />);

    expect(screen.getByTestId('icon')).toBeInTheDocument();
  });

  it('size props로 크기를 조절할 수 있다.', () => {
    render(<Icon data-testid='icon' iconType='ArrowBack' size='16px' />);

    const icon = screen.getByTestId('icon');
    expect(icon).toHaveAttribute('width', '16px');
    expect(icon).toHaveAttribute('height', '16px');
  });

  it('color props로 색상을 조절할 수 있다.', () => {
    render(<Icon data-testid='icon' iconType='ArrowBack' color='activeBlue' />);

    expect(screen.getByTestId('icon')).toHaveAttribute('fill', COLORS.activeBlue);
  });

  describe('Icon 컴포넌트 스냅샷 테스트', () => {
    it('ArrowBack 아이콘', () => {
      render(<Icon data-testid='icon' iconType='ArrowBack' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('ArrowDown 아이콘', () => {
      render(<Icon data-testid='icon' iconType='ArrowDown' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('ArrowLeft 아이콘', () => {
      render(<Icon data-testid='icon' iconType='ArrowLeft' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('ArrowRight 아이콘', () => {
      render(<Icon data-testid='icon' iconType='ArrowRight' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('Cancel 아이콘', () => {
      render(<Icon data-testid='icon' iconType='Cancel' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('CarbonSearch 아이콘', () => {
      render(<Icon data-testid='icon' iconType='CarbonSearch' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('Check 아이콘', () => {
      render(<Icon data-testid='icon' iconType='Check' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('InfoOutline 아이콘', () => {
      render(<Icon data-testid='icon' iconType='InfoOutline' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('Link 아이콘', () => {
      render(<Icon data-testid='icon' iconType='Link' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });

    it('Plus 아이콘', () => {
      render(<Icon data-testid='icon' iconType='Plus' />);

      expect(screen.getByTestId('icon')).toMatchSnapshot();
    });
  });
});
