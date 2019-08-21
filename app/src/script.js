import '@babel/polyfill';
import { of } from 'rxjs';
import AragonApi from '@aragon/api';

const api = new AragonApi();

api.store(async (state, event) => {
  let newState;
  switch (event.event) {
    default:
      return state;
  }
});
