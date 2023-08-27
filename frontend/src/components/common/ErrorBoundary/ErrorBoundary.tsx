import { PropsWithChildren, lazy } from 'react';
import { ErrorBoundary as _ErrorBoundary } from 'react-error-boundary';

const ErrorFallback = lazy(() => import('./ErrorFallback').then(({ ErrorFallback }) => ({ default: ErrorFallback })));

function ErrorBoundary({ children }: PropsWithChildren) {
  return <_ErrorBoundary FallbackComponent={ErrorFallback}>{children}</_ErrorBoundary>;
}

export default ErrorBoundary;
