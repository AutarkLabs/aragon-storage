import '@babel/polyfill';
import { of } from 'rxjs';
import AragonApi from '@aragon/api';

const api = new AragonApi();

api.store((state, event) => {
  let newState;
  console.log(state, event);
  switch (event.event) {
    default:
      return state;
  }
});
