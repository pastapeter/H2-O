import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.tsx';
import { ErrorBoundary } from '@/components/common';
import { SelectionProvider, SlideProvider, StyleProvider } from '@/providers';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <StyleProvider>
      <SelectionProvider>
        <SlideProvider>
          <ErrorBoundary>
            <App />
          </ErrorBoundary>
        </SlideProvider>
      </SelectionProvider>
    </StyleProvider>
  </React.StrictMode>,
);
