import { PropsWithChildren, ReactElement } from 'react';
import { render } from '@testing-library/react';
import { ErrorBoundary } from '@/components/common';
import { SelectionProvider, SlideProvider, StyleProvider } from '@/providers';

function AllProviders({ children }: PropsWithChildren) {
  return (
    <StyleProvider>
      <SelectionProvider>
        <SlideProvider>
          <ErrorBoundary>{children}</ErrorBoundary>
        </SlideProvider>
      </SelectionProvider>
    </StyleProvider>
  );
}

function customRender(ui: ReactElement, options = {}) {
  render(ui, { wrapper: AllProviders, ...options });
}

// eslint-disable-next-line import/export
export * from '@testing-library/react';
// eslint-disable-next-line import/export
export { customRender as render };
export { default as userEvent } from '@testing-library/user-event';
