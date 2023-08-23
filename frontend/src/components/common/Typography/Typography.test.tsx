import Typography from './Typography';
import { render, screen } from '@/tests/test-util';
import { COLORS } from '@/styles/colors';
import { TYPOGRAPHY } from '@/styles/typography';

describe('Typography 컴포넌트 테스트', () => {
  it('Typograhpy가 정상적으로 렌더링 된다.', () => {
    render(<Typography data-testid='typography' />);

    expect(screen.getByTestId('typography')).toBeInTheDocument();
  });

  it('Typography font를 통해서 폰트를 변경할 수 있다.', () => {
    render(<Typography data-testid='typography' color='activeBlue' />);

    expect(screen.getByTestId('typography')).toHaveStyle(`color: ${COLORS.activeBlue}`);
  });

  it('Typography color를 통해서 색상을 변경할 수 있다.', () => {
    render(<Typography data-testid='typography' font='TextKRMedium14' />);

    expect(screen.getByTestId('typography')).toHaveStyle(TYPOGRAPHY.TextKRMedium14);
  });

  describe('Typography 스냅샷 테스트', () => {
    it('HeadEnBold26', () => {
      render(<Typography data-testid='typography' font='HeadEnBold26' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadENBold24', () => {
      render(<Typography data-testid='typography' font='HeadENBold24' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadENBold22', () => {
      render(<Typography data-testid='typography' font='HeadENBold22' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadENMedium20', () => {
      render(<Typography data-testid='typography' font='HeadENMedium20' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadENBold10', () => {
      render(<Typography data-testid='typography' font='HeadENBold10' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextENMedium18', () => {
      render(<Typography data-testid='typography' font='TextENMedium18' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextENMedium16', () => {
      render(<Typography data-testid='typography' font='TextENMedium16' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextENMedium14', () => {
      render(<Typography data-testid='typography' font='TextENMedium14' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('CaptionENMedium14', () => {
      render(<Typography data-testid='typography' font='CaptionENMedium14' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('CaptionENMedium12', () => {
      render(<Typography data-testid='typography' font='CaptionENMedium12' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold32', () => {
      render(<Typography data-testid='typography' font='HeadKRBold32' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold26', () => {
      render(<Typography data-testid='typography' font='HeadKRBold26' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold24', () => {
      render(<Typography data-testid='typography' font='HeadKRBold24' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold22', () => {
      render(<Typography data-testid='typography' font='HeadKRBold22' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold20', () => {
      render(<Typography data-testid='typography' font='HeadKRBold20' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold18', () => {
      render(<Typography data-testid='typography' font='HeadKRBold18' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRBold12', () => {
      render(<Typography data-testid='typography' font='HeadKRBold12' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium26', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium26' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium24', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium24' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium22', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium22' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium20', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium20' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium18', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium18' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium14', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium14' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRMedium18', () => {
      render(<Typography data-testid='typography' font='TextKRMedium18' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRMedium16', () => {
      render(<Typography data-testid='typography' font='TextKRMedium16' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRMedium14', () => {
      render(<Typography data-testid='typography' font='TextKRMedium14' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRMedium12', () => {
      render(<Typography data-testid='typography' font='TextKRMedium12' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRMedium10', () => {
      render(<Typography data-testid='typography' font='TextKRMedium10' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRMedium16', () => {
      render(<Typography data-testid='typography' font='HeadKRMedium16' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRRegular26', () => {
      render(<Typography data-testid='typography' font='HeadKRRegular26' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRRegular24', () => {
      render(<Typography data-testid='typography' font='HeadKRRegular24' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRRegular22', () => {
      render(<Typography data-testid='typography' font='HeadKRRegular22' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('HeadKRRegular20', () => {
      render(<Typography data-testid='typography' font='HeadKRRegular20' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRRegular18', () => {
      render(<Typography data-testid='typography' font='TextKRRegular18' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRRegular14', () => {
      render(<Typography data-testid='typography' font='TextKRRegular14' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRRegular12', () => {
      render(<Typography data-testid='typography' font='TextKRRegular12' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('TextKRRegular10', () => {
      render(<Typography data-testid='typography' font='TextKRRegular10' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });

    it('DisplayText', () => {
      render(<Typography data-testid='typography' font='DisplayText' />);

      expect(screen.getByTestId('typography')).toMatchSnapshot();
    });
  });
});
