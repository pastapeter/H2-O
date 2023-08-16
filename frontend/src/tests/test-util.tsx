import { PropsWithChildren, ReactElement } from 'react';
import { render } from '@testing-library/react';
import { SelectionProvider, SlideProvider, StyleProvider } from '@/providers';

function AllProviders({ children }: PropsWithChildren) {
  return (
    <StyleProvider>
      <SelectionProvider>
        <SlideProvider>{children}</SlideProvider>
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
