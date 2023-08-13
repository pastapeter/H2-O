import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.tsx';
import { SelectionProvider, SlideProvider, StyleProvider } from '@/providers';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <StyleProvider>
      <SelectionProvider>
        <SlideProvider>
          <App />
        </SlideProvider>
      </SelectionProvider>
    </StyleProvider>
  </React.StrictMode>,
);
