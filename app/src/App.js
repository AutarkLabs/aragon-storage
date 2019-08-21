import React from 'react';
import { useAragonApi } from '@aragon/api-react';
import { Main, Button } from '@aragon/ui';
import styled from 'styled-components';

import { ipfs } from './ipfs';

function App() {
  const { api, appState, connectedAccount } = useAragonApi();
  const { syncing } = appState;

  console.log(appState);
  return (
    <Main>
      <BaseLayout>
        {syncing && <Syncing />}
        <Button
          onClick={() => {
            api.registerData('0x42', 'value').toPromise();
          }}
        >
          yo
        </Button>
      </BaseLayout>
    </Main>
  );
}

const BaseLayout = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  flex-direction: column;
`;

const Buttons = styled.div`
  display: grid;
  grid-auto-flow: column;
  grid-gap: 40px;
  margin-top: 20px;
`;

const Syncing = styled.div.attrs({ children: 'Syncing…' })`
  position: absolute;
  top: 15px;
  right: 20px;
`;

export default App;
