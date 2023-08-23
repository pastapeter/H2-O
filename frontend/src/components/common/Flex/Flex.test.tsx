import Flex from './Flex';
import { render, screen } from '@/tests/test-util';

describe('Flex 컴포넌트 테스트', () => {
  it('Flex가 정상적으로 렌더링 된다.', () => {
    render(<Flex>Flex</Flex>);

    expect(screen.getByText('Flex')).toBeInTheDocument();
  });

  it('Flex가 display flex속성을 가지고 있다.', () => {
    render(<Flex>Flex</Flex>);

    expect(screen.getByText('Flex')).toHaveStyleRule('display', 'flex');
  });

  it('Flex 스냅샷 테스트', () => {
    render(<Flex>Flex</Flex>);

    expect(screen.getByText('Flex')).toMatchSnapshot();
  });
});
