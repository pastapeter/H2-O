import { PropsWithChildren } from 'react';
import { ErrorBoundary as _ErrorBoundary } from 'react-error-boundary';
import { ErrorFallback } from './ErrorFallback';

function ErrorBoundary({ children }: PropsWithChildren) {
  return <_ErrorBoundary FallbackComponent={ErrorFallback}>{children}</_ErrorBoundary>;
}

export default ErrorBoundary;
