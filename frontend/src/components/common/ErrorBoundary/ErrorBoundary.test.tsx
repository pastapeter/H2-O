import ErrorBoundary from './ErrorBoundary';
import { render, screen, waitFor } from '@/tests/test-util';

describe('ErrorBoundary 컴포넌트 테스트', () => {
  const ThrowErrorChild = () => {
    throw Error('오류 발생');
  };

  it('children에서 오류가 발생하면 fallback UI를 렌더링한다.', async () => {
    render(
      <ErrorBoundary>
        <ThrowErrorChild />
      </ErrorBoundary>,
    );

    await waitFor(() => {
      expect(screen.getByText('오류 발생')).toBeInTheDocument();
    });
  });

  it('children에서 오류가 발생하지 않으면 fallback UI를 렌더링하지 않는다', () => {
    render(
      <ErrorBoundary>
        <div>오류 발생하지 않음</div>
      </ErrorBoundary>,
    );

    expect(screen.queryByText('오류 발생')).not.toBeInTheDocument();
  });
});
