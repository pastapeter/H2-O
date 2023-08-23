import type { PropsWithChildren } from 'react';
import { ThemeProvider } from '@emotion/react';
import GlobalStyle from '@/styles/GlobalStyles';
import { theme } from '@/styles/theme';

function StyleProvider({ children }: PropsWithChildren) {
  return (
    <>
      <GlobalStyle />
      <ThemeProvider theme={theme}>{children}</ThemeProvider>
    </>
  );
}

export default StyleProvider;
