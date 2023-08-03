import { StyleProvider } from '@/providers';
import { Header } from '@/components/common';

function App() {
  return (
    <StyleProvider>
      <Header />
    </StyleProvider>
  );
}

export default App;
