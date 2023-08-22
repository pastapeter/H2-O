import HashTag from './HashTag';
import { render, screen } from '@/tests/test-util';

describe('HashTag 컴포넌트 테스트', () => {
  it('HashTag가 정상적으로 렌더링된다.', () => {
    render(<HashTag title='해시태그' />);

    expect(screen.getByText('해시태그')).toBeInTheDocument();
  });

  it('HashTag 스냅샷 테스트', () => {
    render(<HashTag title='해시태그' />);

    expect(screen.getByText('해시태그')).toMatchSnapshot();
  });
});
