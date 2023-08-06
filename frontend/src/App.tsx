import { Fragment } from 'react';
import styled from '@emotion/styled';
import { Pages } from '@/pages';
import { Header } from '@/components/common';

function App() {
  return (
    <Fragment>
      <Header />
      <Main>
        <Pages />
      </Main>
    </Fragment>
  );
}

export default App;

const Main = styled.main`
  padding-top: 60px;
`;
