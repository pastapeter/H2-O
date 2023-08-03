import { Icon } from '@/components/common';
import { StyleProvider } from '@/providers';

function App() {
  return (
    <StyleProvider>
      <Icon iconType='Link' size={36} />
      <Icon iconType='ArrowDown' size={36} />
      <Icon iconType='ArrowRight' size={36} />
      <Icon iconType='Plus' size={36} />
    </StyleProvider>
  );
}

export default App;
