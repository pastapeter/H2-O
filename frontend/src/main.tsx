import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.tsx';
import { SlideProvider, StyleProvider } from '@/providers';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <StyleProvider>
      <SlideProvider>
        <App />
      </SlideProvider>
    </StyleProvider>
  </React.StrictMode>,
);
