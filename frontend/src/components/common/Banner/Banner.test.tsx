import Banner from './Banner';
import { render, screen } from '@/tests/test-util';

describe('Banner 컴포넌트 테스트', () => {
  it('배너가 정상적으로 렌더링된다.', () => {
    render(<Banner />);

    expect(screen.getByRole('banner')).toBeInTheDocument();
  });

  it('title props를 전달하면 텍스트가 정상적으로 표시된다.', () => {
    render(<Banner title='배너' />);

    expect(screen.getByText('배너')).toBeInTheDocument();
  });

  it('subTitle props를 전달하면 텍스트가 정상적으로 표시된다.', () => {
    render(<Banner title='배너' subTitle='서브타이틀' />);

    expect(screen.getByText('서브타이틀')).toBeInTheDocument();
  });

  it('description props를 전달하면 텍스트가 정상적으로 표시된다.', () => {
    render(<Banner title='배너' description='설명' />);

    expect(screen.getByText('설명')).toBeInTheDocument();
  });

  it('isTitleColorWhite props를 전달하면 텍스트가 흰색으로 표시된다.', () => {
    render(<Banner title='배너' isTitleColorWhite />);

    const text = screen.getByText('배너');
    const style = getComputedStyle(text);

    expect(style.color).toBe('rgb(255, 255, 255)');
  });

  it('backgroundColor props를 전달하면 배경색이 정상적으로 표시된다.', () => {
    render(<Banner backgroundColor='black' />);

    const banner = screen.getByRole('banner');
    const style = getComputedStyle(banner);

    expect(style.backgroundColor).toBe('rgb(0, 0, 0)');
  });

  it('배너 스냅샷 테스트', () => {
    render(<Banner title='타이틀' subTitle='서브타이틀' />);

    expect(screen.getByRole('banner')).toMatchSnapshot();
  });
});
